export const extraChromeBuildFileContent = `
browser_repo(
  name = "rules_browsers_chromedriver_linux_x64",
  sha256 = "f684e5e39adcba8b0d968c0131d0348f5edf1365bfb176ef7857e32c7d3ebdbf",
  urls = [
      "https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.42/linux64/chromedriver-linux64.zip",
  ],
  named_files = {
      "CHROMEDRIVER": "chromedriver-linux64/chromedriver",
  },
)

browser_repo(
  name = "rules_browsers_chromedriver_macos_x64",
  sha256 = "dadf62fb94b9407db5e93ee7710ad4afb6b987f061d1b41847c478c78f744e2f",
  urls = [
      "https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.42/mac-x64/chromedriver-mac-x64.zip",
  ],
  named_files = {
      "CHROMEDRIVER": "chromedriver-mac-x64/chromedriver",
  },
)

browser_repo(
  name = "rules_browsers_chromedriver_macos_arm64",
  sha256 = "a072a9dba97ad4402da0899523d32596632b5f01374d893c9006ca8cb95a9979",
  urls = [
      "https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.42/mac-arm64/chromedriver-mac-arm64.zip"
  ],
  named_files = {
      "CHROMEDRIVER": "chromedriver-mac-arm64/chromedriver",
  },
)
`;
