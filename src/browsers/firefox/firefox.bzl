
load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_firefox_repositories():
    
  browser_repo(
      name = "rules_browsers_firefox_linux",
      sha256 = "4d2d0a64a11f8aab7a1be583e1e4cddfaf2671967212b369a87489f3c11c3ac9",
      # stable_137.0
      urls = ["https://archive.mozilla.org/pub/firefox/releases/137.0/linux-x86_64/en-US/firefox-137.0.tar.xz"],
      named_files = {"FIREFOX":"firefox/firefox"},
      exclude_patterns = [],
      exports_files = ["firefox/firefox"],
  )
  
  
  browser_repo(
      name = "rules_browsers_firefox_mac",
      sha256 = "bd9bff96ae3701f9c4957675ff3990fcb8306cbb2f6554fb81ad2427b1ec8464",
      # stable_137.0
      urls = ["https://archive.mozilla.org/pub/firefox/releases/137.0/mac/en-US/Firefox%20137.0.dmg"],
      named_files = {"FIREFOX":"Firefox.app/Contents/MacOS/firefox"},
      exclude_patterns = [],
      exports_files = ["Firefox.app/Contents/MacOS/firefox"],
  )
  
  
  browser_repo(
      name = "rules_browsers_firefox_mac_arm",
      sha256 = "bd9bff96ae3701f9c4957675ff3990fcb8306cbb2f6554fb81ad2427b1ec8464",
      # stable_137.0
      urls = ["https://archive.mozilla.org/pub/firefox/releases/137.0/mac/en-US/Firefox%20137.0.dmg"],
      named_files = {"FIREFOX":"Firefox.app/Contents/MacOS/firefox"},
      exclude_patterns = [],
      exports_files = ["Firefox.app/Contents/MacOS/firefox"],
  )
  

    
  