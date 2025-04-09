import {Browser} from '@puppeteer/browsers';
import {BrowserBinaryInfo} from './download.mjs';

export function generateRepositorySetupBzlFile(
  browser: Browser,
  binaries: BrowserBinaryInfo[],
  extraMacroContent: string = ''
): string {
  const repositoryDefs: string[] = [];

  for (const binary of binaries) {
    repositoryDefs.push(`
browser_repo(
    name = "rules_browsers_${browser}_${binary.platform}",
    sha256 = "${binary.sha256}",
    # ${binary.buildId}
    urls = ["${binary.url}"],
    named_files = ${JSON.stringify(binary.namedFiles)},
    exclude_patterns = ${JSON.stringify(binary.excludeFilesForPerformance)},
    exports_files = ${JSON.stringify(Object.values(binary.namedFiles))},
)
`);
  }

  return `
load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_${browser}_repositories():
  ${repositoryDefs.join(`\n`).replace(/^/gm, '  ')}

  ${extraMacroContent.replace(/^/gm, '  ')}
  `;
}
