import {puppeteerLauncher} from '@web/test-runner-puppeteer';
import {jasmineTestRunnerConfig} from 'web-test-runner-jasmine';

export default {
  ...jasmineTestRunnerConfig(),
  watch: false,
  nodeResolve: true,
  browsers: [puppeteerLauncher({

    launchOptions: {
      executablePath: process.env.CHROMIUM_BIN,
      args: ["--no-sandbox"],
      headless: true,
      devtools: true,
    },
  })],
}
