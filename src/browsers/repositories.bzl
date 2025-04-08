"""Pinned browser versions."""

load("@rules_browsers//src/browsers/chromium:chromium.bzl", "define_chrome_repositories")
load("@rules_browsers//src/browsers/firefox:firefox.bzl", "define_firefox_repositories")

def rules_browsers_repositories():
    """Load pinned browser versions."""

    define_chrome_repositories()
    define_firefox_repositories()
