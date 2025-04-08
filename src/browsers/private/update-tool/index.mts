/**
 * @license
 * Copyright Google LLC
 *
 * Use of this source code is governed by an MIT-style license that can be
 * found in the LICENSE file at https://angular.io/license
 */

import {
  resolveBuildId as resolveChromeBuildId,
  relativeExecutablePath as relativeChromeExecutablePath,
} from '@puppeteer/browsers/browser-data/chrome';
import {
  FirefoxChannel,
  resolveBuildId as resolveFirefoxBuildId,
  relativeExecutablePath as relativeFirefoxExecutablePath,
} from '@puppeteer/browsers/browser-data/firefox';
import {
  Browser,
  BrowserPlatform,
  ChromeReleaseChannel,
} from '@puppeteer/browsers/browser-data/types';
import {mkdtemp} from 'node:fs/promises';
import os from 'node:os';
import path from 'node:path';
import {downloadAndHashBinariesForBrowser} from './download.mjs';
import {generateRepositorySetupBzlFile} from './generation.mjs';
import fs from 'node:fs/promises';
import {extraChromeBuildFileContent} from './extra_chrome_build_content.mjs';

main().catch(e => {
  console.error(e);
  process.exitCode = 1;
});

async function main() {
  const tmpDir = await mkdtemp(path.join(os.tmpdir(), 'rules_browsers_tmp-'));

  const [chromeBuildId, firefoxBuildId] = await Promise.all([
    resolveChromeBuildId(ChromeReleaseChannel.STABLE),
    resolveFirefoxBuildId(FirefoxChannel.STABLE),
  ]);

  const [chromeBinaries, firefoxBinaries] = await Promise.all([
    downloadAndHashBinariesForBrowser(
      tmpDir,
      Browser.CHROME,
      chromeBuildId,
      platform => relativeChromeExecutablePath(platform, chromeBuildId),
      {},
      {
        // Exclude log files that chromium writes to each run, causing remote cache misses.
        [BrowserPlatform.LINUX]: ['chrome-linux/chrome_debug.log'],
        [BrowserPlatform.MAC]: [
          'chrome-mac/Chromium.app/Contents/Frameworks/Chromium Framework.framework/Versions/*/chrome_debug.log',
        ],
        [BrowserPlatform.MAC_ARM]: [
          'chrome-mac/Chromium.app/Contents/Frameworks/Chromium Framework.framework/Versions/*/chrome_debug.log',
        ],
      }
    ),
    downloadAndHashBinariesForBrowser(tmpDir, Browser.FIREFOX, firefoxBuildId, platform =>
      relativeFirefoxExecutablePath(platform, firefoxBuildId)
    ),
  ]);

  const chromeBzl = generateRepositorySetupBzlFile(
    Browser.CHROME,
    chromeBinaries,
    extraChromeBuildFileContent
  );
  const firefoxBzl = generateRepositorySetupBzlFile(Browser.FIREFOX, firefoxBinaries, '');

  // Write results to `bzl` files.
  const workspaceRoot = process.env['BUILD_WORKING_DIRECTORY']!;
  await fs.writeFile(path.join(workspaceRoot, 'src/browsers/chromium/chromium.bzl'), chromeBzl);
  await fs.writeFile(path.join(workspaceRoot, 'src/browsers/firefox/firefox.bzl'), firefoxBzl);

  await fs.rm(tmpDir, {recursive: true, maxRetries: 2});
}
