
load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_chrome_repositories():
    
  browser_repo(
      name = "rules_browsers_chrome_linux",
      sha256 = "47349b3a8191a2db0572ff815a99117af7d226cf79ced863192143f263758249",
      # 135.0.7049.42
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.42/linux64/chrome-linux64.zip"],
      named_files = {"CHROME":"chrome-linux64/chrome"},
      exclude_patterns = ["chrome-linux/chrome_debug.log"],
      exports_files = ["chrome-linux64/chrome"],
  )
  
  
  browser_repo(
      name = "rules_browsers_chrome_mac",
      sha256 = "b1e0350c25bd05e6bfb2f63e72f601700b9f56d6fd7d32737e9e74d53566bb13",
      # 135.0.7049.42
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.42/mac-x64/chrome-mac-x64.zip"],
      named_files = {"CHROME":"chrome-mac-x64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing"},
      exclude_patterns = ["chrome-mac/Chromium.app/Contents/Frameworks/Chromium Framework.framework/Versions/*/chrome_debug.log"],
      exports_files = ["chrome-mac-x64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing"],
  )
  
  
  browser_repo(
      name = "rules_browsers_chrome_mac_arm",
      sha256 = "687406447d13731f6cfd7ff2f25481623e287fbda1b5f58b59d9233327dc2b6b",
      # 135.0.7049.42
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.42/mac-arm64/chrome-mac-arm64.zip"],
      named_files = {"CHROME":"chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing"},
      exclude_patterns = ["chrome-mac/Chromium.app/Contents/Frameworks/Chromium Framework.framework/Versions/*/chrome_debug.log"],
      exports_files = ["chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing"],
  )
  

    
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
  
  