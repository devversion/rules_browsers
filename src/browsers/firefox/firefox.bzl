"""
  Defines repositories for Firefox that can be used inside Karma unit tests
  and Protractor e2e tests with Bazel.
"""

load("@rules_browsers//src/browsers/private:browser_repo.bzl", "browser_repo")

def define_firefox_repositories():
    browser_repo(
        name = "org_mozilla_firefox_linux_x64",
        licenses = ["reciprocal"],  # MPL 2.0
        sha256 = "5222f51caacfccaf0f0cf795117f0ad37422fe9d413ef18f2c171e1622b9455a",
        urls = [
            "https://ftp.mozilla.org/pub/firefox/releases/136.0/linux-x86_64/en-US/firefox-136.0.tar.xz",
            "https://storage.googleapis.com/dev-infra-mirror/firefox%2F136.0%2Flinux_x64%2Fbrowser-bin.tar.xz",
        ],
        named_files = {
            "FIREFOX": "firefox/firefox",
        },
    )

    browser_repo(
        # Firefox has a launcher that conditionally starts x64/arm64
        name = "org_mozilla_firefox_macos",
        licenses = ["reciprocal"],  # MPL 2.0
        sha256 = "078559a33491b7c5ef5dcde62fe3c812835aae98b63a7e32b3bf7e33cb33fcc8",
        urls = [
            "https://ftp.mozilla.org/pub/firefox/releases/136.0/mac/en-US/Firefox 136.0.dmg",
            "https://storage.googleapis.com/dev-infra-mirror/firefox%2F136.0%2Fmac_x64%2Fbrowser-bin.dmg",
        ],
        named_files = {
            "FIREFOX": "Firefox.app/Contents/MacOS/firefox",
        },
    )

    browser_repo(
        name = "org_mozilla_geckodriver_linux_x64",
        licenses = ["reciprocal"],  # MPL 2.0
        sha256 = "0bde38707eb0a686a20c6bd50f4adcc7d60d4f73c60eb83ee9e0db8f65823e04",
        urls = [
            "https://github.com/mozilla/geckodriver/releases/download/v0.36.0/geckodriver-v0.36.0-linux64.tar.gz",
            "https://storage.googleapis.com/dev-infra-mirror/firefox%2F136.0%2Flinux_x64%2Fdriver-bin.tar.gz",
        ],
        named_files = {
            "GECKODRIVER": "geckodriver",
        },
    )

    browser_repo(
        name = "org_mozilla_geckodriver_macos_x64",
        licenses = ["reciprocal"],  # MPL 2.0
        sha256 = "b5627bfc29801b8752c9f1e7699018963c39c076aab6576dc14fcb1ce7a256f6",
        urls = [
            "https://github.com/mozilla/geckodriver/releases/download/v0.34.0/geckodriver-v0.34.0-macos.tar.gz",
            "https://storage.googleapis.com/dev-infra-mirror/firefox/125.0.1/mac_x64/driver-bin.tar.gz",
        ],
        named_files = {
            "GECKODRIVER": "geckodriver",
        },
    )

    browser_repo(
        name = "org_mozilla_geckodriver_macos_arm64",
        licenses = ["reciprocal"],  # MPL 2.0
        sha256 = "c045c8c0d859e6045defbb1c31b37ebeb3c942fc61daaf11e21fc634f2d71c52",
        # Geckodriver v0.34.0
        urls = [
            "https://github.com/mozilla/geckodriver/releases/download/v0.36.0/geckodriver-v0.36.0-macos.tar.gz",
            "https://storage.googleapis.com/dev-infra-mirror/firefox%2F136.0%2Fmac_x64%2Fdriver-bin.tar.gz",
        ],
        named_files = {
            "GECKODRIVER": "geckodriver",
        },
    )
