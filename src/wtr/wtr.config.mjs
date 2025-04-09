import {puppeteerLauncher} from '@web/test-runner-puppeteer';
import {jasmineTestRunnerConfig} from 'web-test-runner-jasmine';
import findAvailablePort from 'get-port';
import {fromRollup} from '@web/dev-server-rollup';
import rollupVirtual from '@rollup/plugin-virtual';
import fs from 'node:fs/promises';

const chromeHeadlessBin = process.env.CHROME_HEADLESS_BIN;
const firefoxBin = process.env.FIREFOX_BIN;
const manualMode = process.env.MANUAL_MODE === '1';

if (!chromeHeadlessBin && !firefoxBin && !manualMode) {
  throw new Error('No browser/mode detected.');
}

const virtual = fromRollup(rollupVirtual);

/** @type {import("@web/test-runner").TestRunnerConfig} */
export default {
  ...jasmineTestRunnerConfig(),
  watch: false,
  testsFinishTimeout: 1000 * 60 * 5,
  nodeResolve: false,
  concurrency: 1,
  concurrentBrowsers: 1,
  staticLogging: true,
  debug: process.env['DEBUG'] !== undefined,
  manual: manualMode,
  port: await findAvailablePort({port: 9876}),
  plugins: [
    virtual({
      '@web/test-runner-core/browser/session.js': await fs.readFile(
        '../rules_browsers/node_modules/@web/test-runner-core/browser/session.js',
        'utf8'
      ),
    }),
  ],
  browsers: [
    puppeteerLauncher({
      concurrency: 1,
      launchOptions: {
        executablePath: firefoxBin ?? chromeHeadlessBin,
        browser: firefoxBin ? 'firefox' : 'chrome',
        args: chromeHeadlessBin
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
        headless: chromeHeadlessBin ? 'shell' : true,
        env: {
          // Needed as otherwise Firefox would try write/read from sandbox protected HOME directory.
          HOME: process.env.TEST_TMPDIR,
          PROFILE: process.env.TEST_TMPDIR,
        },
      },
    }),
  ],
};
