load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_chromium_repositories():
    browser_repo(
        name = "rules_browsers_chromium_mac_x64",
        sha256 = "9a88fb96bbe89d5d0af4d71b168d3441d2ebb43ecf579618e5c53cb79584a3b2",
        urls = ["https://cdn.playwright.dev/dbazure/download/playwright/builds/chromium/1161/chromium-mac.zip", "https://playwright.download.prss.microsoft.com/dbazure/download/playwright/builds/chromium/1161/chromium-mac.zip", "https://cdn.playwright.dev/builds/chromium/1161/chromium-mac.zip"],
        named_files = {"CHROMIUM": "chrome-mac/Chromium.app/Contents/MacOS/Chromium"},
        exclude_patterns = ["chrome-mac/Chromium.app/Contents/Frameworks/Chromium Framework.framework/Versions/*/chrome_debug.log"],
        exports_files = ["chrome-mac/Chromium.app/Contents/MacOS/Chromium"],
    )

    browser_repo(
        name = "rules_browsers_chromium_mac_arm",
        sha256 = "8ad59288a14ad2a74b8279376f6b00a2224a77537517c61e62e34e08f214ecaa",
        urls = ["https://cdn.playwright.dev/dbazure/download/playwright/builds/chromium/1161/chromium-mac-arm64.zip", "https://playwright.download.prss.microsoft.com/dbazure/download/playwright/builds/chromium/1161/chromium-mac-arm64.zip", "https://cdn.playwright.dev/builds/chromium/1161/chromium-mac-arm64.zip"],
        named_files = {"CHROMIUM": "chrome-mac/Chromium.app/Contents/MacOS/Chromium"},
        exclude_patterns = ["chrome-mac/Chromium.app/Contents/Frameworks/Chromium Framework.framework/Versions/*/chrome_debug.log"],
        exports_files = ["chrome-mac/Chromium.app/Contents/MacOS/Chromium"],
    )

    browser_repo(
        name = "rules_browsers_chromium_linux_x64",
        sha256 = "25db802cce762a2c5c082b115671b8c37f8ef87c2d08e367d216d56e955e2496",
        urls = ["https://cdn.playwright.dev/dbazure/download/playwright/builds/chromium/1161/chromium-linux.zip", "https://playwright.download.prss.microsoft.com/dbazure/download/playwright/builds/chromium/1161/chromium-linux.zip", "https://cdn.playwright.dev/builds/chromium/1161/chromium-linux.zip"],
        named_files = {"CHROMIUM": "chrome-linux/chrome"},
        exclude_patterns = ["chrome-linux/chrome_debug.log"],
        exports_files = ["chrome-linux/chrome"],
    )

    browser_repo(
        name = "rules_browsers_chromedriver_linux_x64",
        sha256 = "b820be8f77e9b03eda7c68ee85263f58109b631f8e12e6e5d4fb580aeb1578dc",
        urls = [
            "https://storage.googleapis.com/chrome-for-testing-public/134.0.6998.35/linux64/chromedriver-linux64.zip",
        ],
        named_files = {
            "CHROMEDRIVER": "chromedriver-linux64/chromedriver",
        },
    )

    browser_repo(
        name = "rules_browsers_chromedriver_macos_x64",
        sha256 = "c7110fda39d2f1fea7d7471742a4078fa3f97c54415c410e57afb1c97c8fc93c",
        urls = [
            "https://storage.googleapis.com/chrome-for-testing-public/134.0.6998.35/mac-x64/chromedriver-mac-x64.zip",
        ],
        named_files = {
            "CHROMEDRIVER": "chromedriver-mac-x64/chromedriver",
        },
    )

    browser_repo(
        name = "rules_browsers_chromedriver_macos_arm64",
        sha256 = "561e5082d6763293b15cd3366efaca191ddce96878526388ccfb47d5a8ddc6d7",
        urls = [
            "https://storage.googleapis.com/chrome-for-testing-public/134.0.6998.35/mac-arm64/chromedriver-mac-arm64.zip",
        ],
        named_files = {
            "CHROMEDRIVER": "chromedriver-mac-arm64/chromedriver",
        },
    )
