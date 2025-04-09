/**
 * @license
 * Copyright Google LLC
 *
 * Use of this source code is governed by an MIT-style license that can be
 * found in the LICENSE file at https://angular.io/license
 */

import {
  resolveBuildId,
  computeExecutablePath,
  Browser,
  BrowserPlatform,
  BrowserTag,
} from '@puppeteer/browsers';
import {mkdtemp} from 'node:fs/promises';
import os from 'node:os';
import path from 'node:path';
import {downloadAndHashBinariesForBrowser} from './download.mjs';
import {generateRepositorySetupBzlFile} from './generation.mjs';
import fs from 'node:fs/promises';

main().catch(e => {
  console.error(e);
  process.exitCode = 1;
});

async function main() {
  const tmpDir = await mkdtemp(path.join(os.tmpdir(), 'rules_browsers_tmp-'));

  const [chromeBuildId, firefoxBuildId, chromedriverBuildId] = await Promise.all([
    resolveBuildId(Browser.CHROMEHEADLESSSHELL, null!, BrowserTag.STABLE),
    resolveBuildId(Browser.FIREFOX, null!, BrowserTag.STABLE),
    resolveBuildId(Browser.CHROMEDRIVER, null!, BrowserTag.STABLE),
  ]);

  const [chromeBinaries, chromedriverBinaries, firefoxBinaries] = await Promise.all([
    downloadAndHashBinariesForBrowser(
      tmpDir,
      // Puppeteer team suggests headless shell as it's more lightweight and faster.
      Browser.CHROMEHEADLESSSHELL,
      chromeBuildId,
      {},
      {
        // Exclude log files that Chrome might write to— causing remote cache misses.
        [BrowserPlatform.LINUX]: ['**/*.log'],
        [BrowserPlatform.MAC]: ['**/*.log'],
        [BrowserPlatform.MAC_ARM]: ['**/*.log'],
      }
    ),
    downloadAndHashBinariesForBrowser(tmpDir, Browser.CHROMEDRIVER, chromedriverBuildId),
    downloadAndHashBinariesForBrowser(tmpDir, Browser.FIREFOX, firefoxBuildId),
  ]);

  const chromeBzl = generateRepositorySetupBzlFile(Browser.CHROME, chromeBinaries);
  const chromedriverBzl = generateRepositorySetupBzlFile(
    Browser.CHROMEDRIVER,
    chromedriverBinaries
  );
  const firefoxBzl = generateRepositorySetupBzlFile(Browser.FIREFOX, firefoxBinaries, '');

  // Write results to `bzl` files.
  const workspaceRoot = process.env['BUILD_WORKING_DIRECTORY']!;
  await fs.writeFile(path.join(workspaceRoot, 'src/browsers/chromium/chromium.bzl'), chromeBzl);
  await fs.writeFile(
    path.join(workspaceRoot, 'src/browsers/chromium/chromedriver.bzl'),
    chromedriverBzl
  );
  await fs.writeFile(path.join(workspaceRoot, 'src/browsers/firefox/firefox.bzl'), firefoxBzl);

  await fs.rm(tmpDir, {recursive: true, maxRetries: 2});
}
