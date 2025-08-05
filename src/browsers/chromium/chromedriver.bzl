load("//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_chromedriver_repositories():
    browser_repo(
        name = "rules_browsers_chromedriver_linux",
        sha256 = "0ef562acf7a87733a77cf51f52e3841cf7fb63c17d618b6ccb45a9a53ca89017",
        # 138.0.7204.49
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.49/linux64/chromedriver-linux64.zip"],
        named_files = {"CHROMEDRIVER": "chromedriver-linux64/chromedriver"},
        exclude_patterns = [],
        exports_files = ["chromedriver-linux64/chromedriver"],
    )

    browser_repo(
        name = "rules_browsers_chromedriver_mac",
        sha256 = "bff1fc6075912698a1699a8d0979da3fdc576775a3fe78e6ae68338459c8882f",
        # 138.0.7204.49
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.49/mac-x64/chromedriver-mac-x64.zip"],
        named_files = {"CHROMEDRIVER": "chromedriver-mac-x64/chromedriver"},
        exclude_patterns = [],
        exports_files = ["chromedriver-mac-x64/chromedriver"],
    )

    browser_repo(
        name = "rules_browsers_chromedriver_mac_arm",
        sha256 = "dc64ab4843ea298f02cd69e2995b7441544d4132b74ac97e14a596eaaf1cd697",
        # 138.0.7204.49
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.49/mac-arm64/chromedriver-mac-arm64.zip"],
        named_files = {"CHROMEDRIVER": "chromedriver-mac-arm64/chromedriver"},
        exclude_patterns = [],
        exports_files = ["chromedriver-mac-arm64/chromedriver"],
    )
