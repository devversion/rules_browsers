
load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_firefox_repositories():
    
  browser_repo(
      name = "rules_browsers_firefox_mac_x64",
      sha256 = "aee326a2adc52696fc10952e27b4a3a708a8eff131c1204fe905f6eec3ceeb97",
      urls = ["https://cdn.playwright.dev/dbazure/download/playwright/builds/firefox/1475/firefox-mac.zip","https://playwright.download.prss.microsoft.com/dbazure/download/playwright/builds/firefox/1475/firefox-mac.zip","https://cdn.playwright.dev/builds/firefox/1475/firefox-mac.zip"],
      named_files = {"FIREFOX":"firefox/Nightly.app/Contents/MacOS/firefox"},
      exclude_patterns = [],
      exports_files = ["firefox/Nightly.app/Contents/MacOS/firefox"],
  )
  
  
  browser_repo(
      name = "rules_browsers_firefox_mac_arm",
      sha256 = "4d2bbf8e38944532502c1cb7d074bfbe47fe7716ebd8833be9e93d4b5546e83b",
      urls = ["https://cdn.playwright.dev/dbazure/download/playwright/builds/firefox/1475/firefox-mac-arm64.zip","https://playwright.download.prss.microsoft.com/dbazure/download/playwright/builds/firefox/1475/firefox-mac-arm64.zip","https://cdn.playwright.dev/builds/firefox/1475/firefox-mac-arm64.zip"],
      named_files = {"FIREFOX":"firefox/Nightly.app/Contents/MacOS/firefox"},
      exclude_patterns = [],
      exports_files = ["firefox/Nightly.app/Contents/MacOS/firefox"],
  )
  
  
  browser_repo(
      name = "rules_browsers_firefox_linux_x64",
      sha256 = "4c48bea86ff2cf9f6e0ac1a3986b70085f5ea956ca3b8321085b47caab9c52b3",
      urls = ["https://cdn.playwright.dev/dbazure/download/playwright/builds/firefox/1475/firefox-debian-12.zip","https://playwright.download.prss.microsoft.com/dbazure/download/playwright/builds/firefox/1475/firefox-debian-12.zip","https://cdn.playwright.dev/builds/firefox/1475/firefox-debian-12.zip"],
      named_files = {"FIREFOX":"firefox/firefox"},
      exclude_patterns = [],
      exports_files = ["firefox/firefox"],
  )
  

    
  