load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_firefox_repositories():
    browser_repo(
        name = "rules_browsers_firefox_linux",
        sha256 = "6fcc1a2f95a6b232af82b4b7644566638c5df349e3095c65b7c18d1a63412d3d",
        # stable_135.0
        urls = ["https://archive.mozilla.org/pub/firefox/releases/135.0/linux-x86_64/en-US/firefox-135.0.tar.xz"],
        named_files = {"FIREFOX": "firefox/firefox"},
        exclude_patterns = [],
        exports_files = ["firefox/firefox"],
    )

    browser_repo(
        name = "rules_browsers_firefox_mac",
        sha256 = "e55e24e6b2a4980f4b9091900835977b282f599dcdd5e38b753d95bad8a11da9",
        # stable_135.0
        urls = ["https://archive.mozilla.org/pub/firefox/releases/135.0/mac/en-US/Firefox%20135.0.dmg"],
        named_files = {"FIREFOX": "Firefox.app/Contents/MacOS/firefox"},
        exclude_patterns = [],
        exports_files = ["Firefox.app/Contents/MacOS/firefox"],
    )

    browser_repo(
        name = "rules_browsers_firefox_mac_arm",
        sha256 = "e55e24e6b2a4980f4b9091900835977b282f599dcdd5e38b753d95bad8a11da9",
        # stable_135.0
        urls = ["https://archive.mozilla.org/pub/firefox/releases/135.0/mac/en-US/Firefox%20135.0.dmg"],
        named_files = {"FIREFOX": "Firefox.app/Contents/MacOS/firefox"},
        exclude_patterns = [],
        exports_files = ["Firefox.app/Contents/MacOS/firefox"],
    )

    browser_repo(
        name = "rules_browsers_firefox_win64",
        sha256 = "f46d3cb68caa4d4366b942c225d256e0fc15a189263cd9efe29eff0dbfe02685",
        # stable_135.0
        urls = ["https://archive.mozilla.org/pub/firefox/releases/135.0/win64/en-US/Firefox%20Setup%20135.0.exe"],
        named_files = {"FIREFOX": "core/firefox.exe"},
        exclude_patterns = [],
        exports_files = ["core/firefox.exe"],
    )
