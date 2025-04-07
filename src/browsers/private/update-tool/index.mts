/**
 * @license
 * Copyright Google LLC
 *
 * Use of this source code is governed by an MIT-style license that can be
 * found in the LICENSE file at https://angular.io/license
 */

import {mkdtemp} from 'node:fs/promises';
import os from 'node:os';
import path from 'node:path';
import {downloadAndHashBinariesForBrowser, ExecutableForPlatform} from './download.mjs';
import {generateRepositorySetupBzlFile} from './generation.mjs';
import fs from 'node:fs/promises';
import {extraChromeBuildFileContent} from './extra_chrome_build_content.mjs';
import {getDownloadUrlsForPlatform} from './playwright-download-urls.mjs';
import {Browser, Platform} from './browsers.mjs';

main().catch(e => {
  console.error(e);
  process.exitCode = 1;
});

async function main() {
  const tmpDir = await mkdtemp(path.join(os.tmpdir(), 'rules_browsers_tmp-'));
  const binariesWithPlatform = (
    await Promise.all([
      getDownloadUrlsForPlatform(Platform.MAC64, 'darwin'),
      getDownloadUrlsForPlatform(Platform.MACARM, 'darwin'),
      getDownloadUrlsForPlatform(Platform.LINUX64, 'linux'),
    ])
  ).flat();

  const chromeDownloadBinaries: ExecutableForPlatform[] = [];
  const firefoxDownloadBinaries: ExecutableForPlatform[] = [];

  for (const binary of binariesWithPlatform) {
    for (const executable of binary.executables) {
      if (executable.name === 'chromium') {
        chromeDownloadBinaries.push({executable, platform: binary.platform});
      } else if (executable.name === 'firefox') {
        firefoxDownloadBinaries.push({executable, platform: binary.platform});
      } else {
        throw new Error('Unexpected executable.');
      }
    }
  }

  const [chromeBinaries, firefoxBinaries] = await Promise.all([
    downloadAndHashBinariesForBrowser(
      tmpDir,
      Browser.CHROMIUM,
      chromeDownloadBinaries,
      {},
      {
        // Exclude log files that chromium writes to each run, causing remote cache misses.
        [Platform.LINUX64]: ['chrome-linux/chrome_debug.log'],
        [Platform.MAC64]: [
          'chrome-mac/Chromium.app/Contents/Frameworks/Chromium Framework.framework/Versions/*/chrome_debug.log',
        ],
        [Platform.MACARM]: [
          'chrome-mac/Chromium.app/Contents/Frameworks/Chromium Framework.framework/Versions/*/chrome_debug.log',
        ],
      }
    ),
    downloadAndHashBinariesForBrowser(tmpDir, Browser.FIREFOX, firefoxDownloadBinaries),
  ]);

  const chromeBzl = generateRepositorySetupBzlFile(
    Browser.CHROMIUM,
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
