
load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_chromedriver_repositories():
    
  browser_repo(
      name = "rules_browsers_chromedriver_linux",
      sha256 = "6cf7127c91d8d16fdf1273048aff2e44fd5ea0edbdf27a462ad3b1105e96ce5b",
      # 135.0.7049.84
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.84/linux64/chromedriver-linux64.zip"],
      named_files = {"CHROMEDRIVER":"chromedriver-linux64/chromedriver"},
      exclude_patterns = [],
      exports_files = ["chromedriver-linux64/chromedriver"],
  )
  
  
  browser_repo(
      name = "rules_browsers_chromedriver_mac",
      sha256 = "9f8c1d5b86d34c3fa392a651075977050a8f31a583ce10160d92946e56f3f197",
      # 135.0.7049.84
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.84/mac-x64/chromedriver-mac-x64.zip"],
      named_files = {"CHROMEDRIVER":"chromedriver-mac-x64/chromedriver"},
      exclude_patterns = [],
      exports_files = ["chromedriver-mac-x64/chromedriver"],
  )
  
  
  browser_repo(
      name = "rules_browsers_chromedriver_mac_arm",
      sha256 = "50fb2da54c81d407da1157317d57a9d168cadcca9c042bf672355944b865264e",
      # 135.0.7049.84
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.84/mac-arm64/chromedriver-mac-arm64.zip"],
      named_files = {"CHROMEDRIVER":"chromedriver-mac-arm64/chromedriver"},
      exclude_patterns = [],
      exports_files = ["chromedriver-mac-arm64/chromedriver"],
  )
  

    
  