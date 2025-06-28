
load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_chrome_repositories():
    
  browser_repo(
      name = "rules_browsers_chrome_linux",
      sha256 = "142c7bce7a6f717c41c4c76f53a0db4f6ab72f2e0955eec7b2d8c9995c6c2668",
      # 138.0.7204.49
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.49/linux64/chrome-headless-shell-linux64.zip"],
      named_files = {"CHROME-HEADLESS-SHELL":"chrome-headless-shell-linux64/chrome-headless-shell"},
      exclude_patterns = ["**/*.log"],
      exports_files = ["chrome-headless-shell-linux64/chrome-headless-shell"],
  )
  
  
  browser_repo(
      name = "rules_browsers_chrome_mac",
      sha256 = "5aa26c327efbfa6b88fb9beeb26701307dae99cbf77929a2bf241f4ddc97f8fc",
      # 138.0.7204.49
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.49/mac-x64/chrome-headless-shell-mac-x64.zip"],
      named_files = {"CHROME-HEADLESS-SHELL":"chrome-headless-shell-mac-x64/chrome-headless-shell"},
      exclude_patterns = ["**/*.log"],
      exports_files = ["chrome-headless-shell-mac-x64/chrome-headless-shell"],
  )
  
  
  browser_repo(
      name = "rules_browsers_chrome_mac_arm",
      sha256 = "e8759d758b2e709bbe241d7b6828d8f531a115010bd476d13a3912967ce72336",
      # 138.0.7204.49
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.49/mac-arm64/chrome-headless-shell-mac-arm64.zip"],
      named_files = {"CHROME-HEADLESS-SHELL":"chrome-headless-shell-mac-arm64/chrome-headless-shell"},
      exclude_patterns = ["**/*.log"],
      exports_files = ["chrome-headless-shell-mac-arm64/chrome-headless-shell"],
  )
  

    
  