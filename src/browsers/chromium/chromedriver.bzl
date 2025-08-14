load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_chromedriver_repositories():
    browser_repo(
        name = "rules_browsers_chromedriver_linux",
        sha256 = "ec29104132a6ff1ae5f2ffe7b27b7ff675a58ab9b1ef616badcbdd35577b31b3",
        # 139.0.7258.68
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/139.0.7258.68/linux64/chromedriver-linux64.zip"],
        named_files = {"CHROMEDRIVER": "chromedriver-linux64/chromedriver"},
        exclude_patterns = [],
        exports_files = ["chromedriver-linux64/chromedriver"],
    )

    browser_repo(
        name = "rules_browsers_chromedriver_mac",
        sha256 = "2b9787f5f758c9f3e3888ac23270f8de47b168679718a4440bd1cea2b3cc57e9",
        # 139.0.7258.68
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/139.0.7258.68/mac-x64/chromedriver-mac-x64.zip"],
        named_files = {"CHROMEDRIVER": "chromedriver-mac-x64/chromedriver"},
        exclude_patterns = [],
        exports_files = ["chromedriver-mac-x64/chromedriver"],
    )

    browser_repo(
        name = "rules_browsers_chromedriver_mac_arm",
        sha256 = "6da850508d250c00c10b09dcac00c97a58d51346047972c2c47d3e3b850d4662",
        # 139.0.7258.68
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/139.0.7258.68/mac-arm64/chromedriver-mac-arm64.zip"],
        named_files = {"CHROMEDRIVER": "chromedriver-mac-arm64/chromedriver"},
        exclude_patterns = [],
        exports_files = ["chromedriver-mac-arm64/chromedriver"],
    )

    browser_repo(
        name = "rules_browsers_chromedriver_win64",
        sha256 = "d4af3e6c8f3a7ceb50ff298e43ff07efcad46c1d6ceb0d894eeb2d593db7e522",
        # 139.0.7258.68
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/139.0.7258.68/win64/chromedriver-win64.zip"],
        named_files = {"CHROMEDRIVER": "chromedriver-win64/chromedriver.exe"},
        exclude_patterns = [],
        exports_files = ["chromedriver-win64/chromedriver.exe"],
    )
