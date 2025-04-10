import {Config} from 'protractor';
import * as path from 'path';
import * as assert from 'assert';

const chromedriverBin = process.env['CHROMEDRIVER_BIN'];
const chromeHeadlessBin = process.env['CHROME_HEADLESS_BIN'];
const testServerPort = process.env['TEST_SERVER_PORT'];

assert(chromedriverBin, 'No chromedriver path specified.');
assert(chromeHeadlessBin, 'No chrome headless path specified.');
assert(testServerPort, 'No test server port specified');

// Browser artifacts are short paths from a different repository, so
// we need to join them with the current workspace root in the runfiles tree.
const workspaceRoot = path.resolve(__dirname, '../../');
const chromedriverPath = path.join(workspaceRoot, chromedriverBin);
const chromeHeadlessPath = path.join(workspaceRoot, chromeHeadlessBin);

export const config: Config = {
  framework: 'jasmine',
  directConnect: true,
  chromeDriver: chromedriverPath,
  baseUrl: `http://localhost:${testServerPort}`,
  capabilities: {
    browserName: 'chrome',
    chromeOptions: {
      binary: chromeHeadlessPath,
      args: ['--headless', '--disable-gpu', '--disable-dev-shm-usage'],
    },
  },
};
