
load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_chrome_repositories():
    
  browser_repo(
      name = "rules_browsers_chrome_linux",
      sha256 = "496dd0223b408d9ea654150004161e65abafce15a698c02df4166192d4d33443",
      # 135.0.7049.84
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.84/linux64/chrome-headless-shell-linux64.zip"],
      named_files = {"CHROME-HEADLESS-SHELL":"chrome-headless-shell-linux64/chrome-headless-shell"},
      exclude_patterns = ["**/*.log"],
      exports_files = ["chrome-headless-shell-linux64/chrome-headless-shell"],
  )
  
  
  browser_repo(
      name = "rules_browsers_chrome_mac",
      sha256 = "2f0e54cb41407173cf80f5ec31193d23da112695ab00e793e6ff043e5080b492",
      # 135.0.7049.84
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.84/mac-x64/chrome-headless-shell-mac-x64.zip"],
      named_files = {"CHROME-HEADLESS-SHELL":"chrome-headless-shell-mac-x64/chrome-headless-shell"},
      exclude_patterns = ["**/*.log"],
      exports_files = ["chrome-headless-shell-mac-x64/chrome-headless-shell"],
  )
  
  
  browser_repo(
      name = "rules_browsers_chrome_mac_arm",
      sha256 = "ea286d83bb28e4178dd376f208b85ed1ef325f731472dc32e4e3d44e9f366f5e",
      # 135.0.7049.84
      urls = ["https://storage.googleapis.com/chrome-for-testing-public/135.0.7049.84/mac-arm64/chrome-headless-shell-mac-arm64.zip"],
      named_files = {"CHROME-HEADLESS-SHELL":"chrome-headless-shell-mac-arm64/chrome-headless-shell"},
      exclude_patterns = ["**/*.log"],
      exports_files = ["chrome-headless-shell-mac-arm64/chrome-headless-shell"],
  )
  

    
  