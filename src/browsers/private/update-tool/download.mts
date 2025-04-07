import path from 'node:path';

import {Browser, Platform} from './browsers.mjs';
import {downloadFileThroughStreaming, sha256} from './download_helpers.mjs';
import {Executable} from 'playwright-core/lib/server';
import {SerializableExecutable} from './playwright-download-worker.mjs';

export interface BrowserBinaryInfo {
  browser: Browser;
  platform: Platform;
  urls: string[];
  sha256: string;
  namedFiles: Record<string, string>;
  excludeFilesForPerformance: string[];
}

export interface ExecutableForPlatform {
  platform: Platform;
  executable: SerializableExecutable;
}

export async function downloadAndHashBinariesForBrowser(
  tmpDir: string,
  browser: Browser,
  binaries: ExecutableForPlatform[],
  namedFiles: {[key in Platform]?: Record<string, string>} = {},
  excludeFilesForPerformance: {[key in Platform]?: string[]} = {}
): Promise<BrowserBinaryInfo[]> {
  const downloadAndHashTasks: Promise<BrowserBinaryInfo>[] = [];

  for (const binary of binaries) {
    const urls = binary.executable.downloadURLs;
    if (!urls || urls.length === 0) {
      throw new Error(`Missing download URLs for: ${browser} @ ${binary.platform}`);
    }

    const destination = path.join(tmpDir, `${browser}-${binary.platform}`);

    const platformNamedFiles = namedFiles[binary.platform] ?? {};
    const platformExcludePatterns = excludeFilesForPerformance[binary.platform] ?? [];

    platformNamedFiles[browser.toUpperCase()] = binary.executable.executablePath;

    downloadAndHashTasks.push(
      (async () => {
        await downloadFileThroughStreaming(urls[0], destination);
        return {
          browser,
          platform: binary.platform,
          urls,
          sha256: await sha256(destination),
          excludeFilesForPerformance: platformExcludePatterns,
          namedFiles: platformNamedFiles,
        };
      })()
    );
  }

  return await Promise.all(downloadAndHashTasks);
}
