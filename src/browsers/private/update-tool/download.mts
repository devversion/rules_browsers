import {Browser, BrowserPlatform} from '@puppeteer/browsers/browser-data/types';
import {getDownloadUrl} from '@puppeteer/browsers/install';
import path from 'node:path';

import {platforms} from './platforms.mjs';
import {downloadFileThroughStreaming, sha256} from './download_helpers.mjs';

export interface BrowserBinaryInfo {
  browser: Browser;
  platform: BrowserPlatform;
  buildId: string;
  url: URL;
  sha256: string;
  namedFiles: Record<string, string>;
  excludeFilesForPerformance: string[];
}

export async function downloadAndHashBinariesForBrowser(
  tmpDir: string,
  browser: Browser,
  buildId: string,
  relativeExecutablePathFn: (platform: BrowserPlatform) => string,
  namedFiles: {[key in BrowserPlatform]?: Record<string, string>} = {},
  excludeFilesForPerformance: {[key in BrowserPlatform]?: string[]} = {}
): Promise<BrowserBinaryInfo[]> {
  const downloadAndHashTasks: Promise<BrowserBinaryInfo>[] = [];

  for (const platform of platforms) {
    const url = getDownloadUrl(browser, platform, buildId);
    const destination = path.join(tmpDir, `${browser}-${platform}-${buildId}`);

    const platformNamedFiles = namedFiles[platform] ?? {};
    const platformExcludePatterns = excludeFilesForPerformance[platform] ?? [];
    platformNamedFiles[browser.toUpperCase()] = relativeExecutablePathFn(platform);

    downloadAndHashTasks.push(
      (async () => {
        await downloadFileThroughStreaming(url, destination);
        return {
          browser,
          platform,
          buildId,
          url,
          sha256: await sha256(destination),
          excludeFilesForPerformance: platformExcludePatterns,
          namedFiles: platformNamedFiles,
        };
      })()
    );
  }

  return await Promise.all(downloadAndHashTasks);
}
