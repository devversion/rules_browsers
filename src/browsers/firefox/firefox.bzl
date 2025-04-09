
load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_firefox_repositories():
    
  browser_repo(
      name = "rules_browsers_firefox_linux",
      sha256 = "0f3150b63b0230aad39270cbd7099d6bb0b24f9295b45c4ae159e20caa52f140",
      # stable_137.0.1
      urls = ["https://archive.mozilla.org/pub/firefox/releases/137.0.1/linux-x86_64/en-US/firefox-137.0.1.tar.xz"],
      named_files = {"FIREFOX":"firefox/firefox"},
      exclude_patterns = [],
      exports_files = ["firefox/firefox"],
  )
  
  
  browser_repo(
      name = "rules_browsers_firefox_mac",
      sha256 = "0a7b63ff8894506d3884b3c067ca0a6ceb38d8b6aa412585c3018d3f46c38213",
      # stable_137.0.1
      urls = ["https://archive.mozilla.org/pub/firefox/releases/137.0.1/mac/en-US/Firefox%20137.0.1.dmg"],
      named_files = {"FIREFOX":"Firefox.app/Contents/MacOS/firefox"},
      exclude_patterns = [],
      exports_files = ["Firefox.app/Contents/MacOS/firefox"],
  )
  
  
  browser_repo(
      name = "rules_browsers_firefox_mac_arm",
      sha256 = "0a7b63ff8894506d3884b3c067ca0a6ceb38d8b6aa412585c3018d3f46c38213",
      # stable_137.0.1
      urls = ["https://archive.mozilla.org/pub/firefox/releases/137.0.1/mac/en-US/Firefox%20137.0.1.dmg"],
      named_files = {"FIREFOX":"Firefox.app/Contents/MacOS/firefox"},
      exclude_patterns = [],
      exports_files = ["Firefox.app/Contents/MacOS/firefox"],
  )
  

    
  