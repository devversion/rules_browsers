import {playwrightLauncher} from '@web/test-runner-playwright';
import {jasmineTestRunnerConfig} from 'wtr-jasmine';
import findAvailablePort from 'get-port';
import {fromRollup} from '@web/dev-server-rollup';
import rollupVirtual from '@rollup/plugin-virtual';
import fs from 'node:fs/promises';

const chromiumBin = process.env.CHROMIUM_BIN;
const firefoxBin = process.env.FIREFOX_BIN;
const manualMode = process.env.MANUAL_MODE === '1';

if (!chromiumBin && !firefoxBin && !manualMode) {
  throw new Error('No browser/mode detected.');
}

const virtual = fromRollup(rollupVirtual);

/** @type {import("@web/test-runner").TestRunnerConfig} */
export default {
  ...jasmineTestRunnerConfig(),
  watch: false,
  nodeResolve: false,
  concurrency: 1,
  concurrentBrowsers: 1,
  staticLogging: true,
  debug: process.env['DEBUG'] !== undefined,
  manual: manualMode,
  port: manualMode ? 9876 : await findAvailablePort(),
  plugins: [
    virtual({
      '@web/test-runner-core/browser/session.js': await fs.readFile(
        '../rules_browsers/node_modules/@web/test-runner-core/browser/session.js',
        'utf8'
      ),
    }),
  ],
  browsers: [
    playwrightLauncher({
      concurrency: 1,
      product: firefoxBin ? 'firefox' : 'chromium',
      launchOptions: {
        executablePath: firefoxBin ?? chromiumBin,
        args: chromiumBin
          ? [
              '--no-sandbox',
              '--no-default-browser-check',
              '--no-first-run',
              '--disable-default-apps',
              '--disable-popup-blocking',
              '--disable-translate',
              '--disable-background-timer-throttling',
            ]
          : ['--disable-sandbox', '--no-remote'],
        headless: true,
        env: {
          // Needed as otherwise Firefox would try write/read from sandbox protected HOME directory.
          HOME: process.env.TEST_TMPDIR,
          PROFILE: process.env.TEST_TMPDIR,
        },
      },
    }),
  ],
};
