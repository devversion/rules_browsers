load("//browsers/private:browser_repo.bzl", "browser_repo")

def define_chrome_repositories():
    browser_repo(
        name = "rules_browsers_chrome_linux",
        sha256 = "14086c6c0844122d4066a5e3a846b963259648945d7fb6c51b520f2105edd597",
        # 139.0.7258.68
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/139.0.7258.68/linux64/chrome-headless-shell-linux64.zip"],
        named_files = {"CHROME-HEADLESS-SHELL": "chrome-headless-shell-linux64/chrome-headless-shell"},
        exclude_patterns = ["**/*.log"],
        exports_files = ["chrome-headless-shell-linux64/chrome-headless-shell"],
    )

    browser_repo(
        name = "rules_browsers_chrome_mac",
        sha256 = "fa2ff20c870e289511cdde481d069f167e403d289b91b1d9d063dd7b2f77ed6e",
        # 139.0.7258.68
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/139.0.7258.68/mac-x64/chrome-headless-shell-mac-x64.zip"],
        named_files = {"CHROME-HEADLESS-SHELL": "chrome-headless-shell-mac-x64/chrome-headless-shell"},
        exclude_patterns = ["**/*.log"],
        exports_files = ["chrome-headless-shell-mac-x64/chrome-headless-shell"],
    )

    browser_repo(
        name = "rules_browsers_chrome_mac_arm",
        sha256 = "cbb938bd24ed648280e3654592c46f7eb8e2e184ca331f2138816bd59fcaed32",
        # 139.0.7258.68
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/139.0.7258.68/mac-arm64/chrome-headless-shell-mac-arm64.zip"],
        named_files = {"CHROME-HEADLESS-SHELL": "chrome-headless-shell-mac-arm64/chrome-headless-shell"},
        exclude_patterns = ["**/*.log"],
        exports_files = ["chrome-headless-shell-mac-arm64/chrome-headless-shell"],
    )

    browser_repo(
        name = "rules_browsers_chrome_win64",
        sha256 = "68bf73ab78647e697bf7b81e8329f23c1331d8792af6e2ab66553aeb9ede9cd3",
        # 139.0.7258.68
        urls = ["https://storage.googleapis.com/chrome-for-testing-public/139.0.7258.68/win64/chrome-headless-shell-win64.zip"],
        named_files = {"CHROME-HEADLESS-SHELL": "chrome-headless-shell-win64/chrome-headless-shell.exe"},
        exclude_patterns = ["**/*.log"],
        exports_files = ["chrome-headless-shell-win64/chrome-headless-shell.exe"],
    )
