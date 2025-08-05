"""Extension that allows loading browser repositories."""

load("//browsers/chromium:chromedriver.bzl", "define_chromedriver_repositories")
load("//browsers/chromium:chromium.bzl", "define_chrome_repositories")
load("//browsers/firefox:firefox.bzl", "define_firefox_repositories")

def _browsers_impl(ctx):
    for mod in ctx.modules:
        for _ in mod.tags.chrome:
            define_chrome_repositories()
        for _ in mod.tags.chromedriver:
            define_chromedriver_repositories()
        for _ in mod.tags.firefox:
            define_firefox_repositories()

browsers = module_extension(
    implementation = _browsers_impl,
    tag_classes = {
        "chrome": tag_class(attrs = {}),
        "chromedriver": tag_class(attrs = {}),
        "firefox": tag_class(attrs = {}),
    },
)
