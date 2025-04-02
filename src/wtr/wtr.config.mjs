import {puppeteerLauncher} from '@web/test-runner-puppeteer';
import {jasmineTestRunnerConfig} from 'web-test-runner-jasmine';
import findAvailablePort from 'get-port';

const chromiumBin = process.env.CHROMIUM_BIN;
const firefoxBin = process.env.FIREFOX_BIN;
const manualMode = process.env.MANUAL_MODE === '1';

if (!chromiumBin && !firefoxBin && !manualMode) {
  throw new Error('No browser/mode detected.');
}

export default {
  ...jasmineTestRunnerConfig(),
  watch: false,
  nodeResolve: true,
  debug: process.env['DEBUG'] === '1',
  manual: manualMode,
  port: await findAvailablePort(),
  browsers: [puppeteerLauncher({
    launchOptions: {
      browser: firefoxBin ? 'firefox' : 'chrome',
      executablePath: firefoxBin ?? chromiumBin,
      args: chromiumBin ? ["--no-sandbox"]: ["--disable-sandbox"],
      headless: true,
      devtools: true,
      env: {
        // Needed as otherwise Firefox would try write/read from sandbox protected HOME directory.
        'HOME': process.env.TEST_TMPDIR,
      }
    },
  })],
}
