export const extraChromeBuildFileContent = `
browser_repo(
  name = "rules_browsers_chromedriver_linux_x64",
  sha256 = "3bd1ed0fee4153ab78eb61109c73657a965f6eabbbba8d0895626967b068beaa",
  urls = [
      "https://storage.googleapis.com/chromium-browser-snapshots/Linux_x64/1263141/chromedriver_linux64.zip",
      "https://storage.googleapis.com/dev-infra-mirror/chromium/1263141/linux_x64/driver-bin.zip",
  ],
  named_files = {
      "CHROMEDRIVER": "chromedriver_linux64/chromedriver",
  },
)

browser_repo(
  name = "rules_browsers_chromedriver_macos_x64",
  sha256 = "1a08bdfb06bd395caafbbb5fe9be982edf5c3c5d07e8082b06f0cf416389a5af",
  urls = [
      "https://storage.googleapis.com/chromium-browser-snapshots/Mac/1263141/chromedriver_mac64.zip",
      "https://storage.googleapis.com/dev-infra-mirror/chromium/1263141/mac_x64/driver-bin.zip",
  ],
  named_files = {
      "CHROMEDRIVER": "chromedriver_mac64/chromedriver",
  },
)

browser_repo(
  name = "rules_browsers_chromedriver_macos_arm64",
  sha256 = "0548bc04cd7d3a9016002034bc30b1df18283612fe99bb7cf1811a60258d60a0",
  urls = [
      "https://storage.googleapis.com/chromium-browser-snapshots/Mac_Arm/1263141/chromedriver_mac64.zip",
      "https://storage.googleapis.com/dev-infra-mirror/chromium/1263141/mac_arm64/driver-bin.zip",
  ],
  named_files = {
      "CHROMEDRIVER": "chromedriver_mac64/chromedriver",
  },
)
`;
