
load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_firefox_repositories():
  # Note: currently we're using Firefox 135, because newer versions crash with
  # `TargetCloseError: Protocol error (session.new): Target closed` when running with RBE.
  # At the time of writing, version 135 to 140 had this issue.

  browser_repo(
      name = "rules_browsers_firefox_linux",
      sha256 = "6fcc1a2f95a6b232af82b4b7644566638c5df349e3095c65b7c18d1a63412d3d",
      # stable_135.0
      urls = ["https://archive.mozilla.org/pub/firefox/releases/135.0/linux-x86_64/en-US/firefox-135.0.tar.xz"],
      named_files = {"FIREFOX":"firefox/firefox"},
      exclude_patterns = [],
      exports_files = ["firefox/firefox"],
  )


  browser_repo(
      name = "rules_browsers_firefox_mac",
      sha256 = "77f1098dcff6410aca644d729171329c74b1b2d7e525e3873bb9d21eaf8865c6",
      # stable_135.0
      urls = ["https://archive.mozilla.org/pub/firefox/releases/135.0/mac/en-US/Firefox%20135.0.dmg"],
      named_files = {"FIREFOX":"Firefox.app/Contents/MacOS/firefox"},
      exclude_patterns = [],
      exports_files = ["Firefox.app/Contents/MacOS/firefox"],
  )


  browser_repo(
      name = "rules_browsers_firefox_mac_arm",
      sha256 = "77f1098dcff6410aca644d729171329c74b1b2d7e525e3873bb9d21eaf8865c6",
      # stable_135.0
      urls = ["https://archive.mozilla.org/pub/firefox/releases/135.0/mac/en-US/Firefox%20135.0.dmg"],
      named_files = {"FIREFOX":"Firefox.app/Contents/MacOS/firefox"},
      exclude_patterns = [],
      exports_files = ["Firefox.app/Contents/MacOS/firefox"],
  )
