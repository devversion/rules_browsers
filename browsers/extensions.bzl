"""Extension that allows loading browser repositories."""

load("//browsers/chromium:chromedriver.bzl", "define_chromedriver_repositories")
load("//browsers/chromium:chromium.bzl", "define_chrome_repositories")
load("//browsers/firefox:firefox.bzl", "define_firefox_repositories")
load("//browsers/private/versions:chromedriver.bzl", CHROMEDRIVER_DEFAULT_VERSION = "DEFAULT_VERSION")
load("//browsers/private/versions:chromium.bzl", CHROMIUM_DEFAULT_VERSION = "DEFAULT_VERSION")
load("//browsers/private/versions:firefox.bzl", FIREFOX_DEFAULT_VERSION = "DEFAULT_VERSION")

def _resolve_latest_version(name, versions):
    if len(versions) == 1:
        return versions.pop()

    use_version = sorted(versions, reverse = True)[0]

    # buildifier: disable=print
    print("NOTE: browser {} has multiple versions {}. Decided to use: {}".format(name, versions, use_version))

    # This is not SemVer aware and might sort incorrectly. If multiple versions end up on the graph,
    # this will at the very least be deterministic across runs though.
    return use_version

def _browsers_impl(ctx):
    chrome_versions = []
    chromedriver_versions = []
    firefox_versions = []

    for mod in ctx.modules:
        for tag in mod.tags.chrome:
            if tag.version not in chrome_versions:
                chrome_versions.append(tag.version)

        for tag in mod.tags.chromedriver:
            if tag.version not in chromedriver_versions:
                chromedriver_versions.append(tag.version)

        for tag in mod.tags.firefox:
            if tag.version not in firefox_versions:
                firefox_versions.append(tag.version)

    if len(chrome_versions) > 0:
        define_chrome_repositories(_resolve_latest_version("Chrome", chrome_versions))

    if len(chromedriver_versions) > 0:
        define_chromedriver_repositories(_resolve_latest_version("Chromedriver", chromedriver_versions))

    if len(firefox_versions) > 0:
        define_firefox_repositories(_resolve_latest_version("Firefox", firefox_versions))

browsers = module_extension(
    implementation = _browsers_impl,
    tag_classes = {
        "chrome": tag_class(attrs = {
            "version": attr.string(
                default = CHROMIUM_DEFAULT_VERSION,
            ),
        }),
        "chromedriver": tag_class(attrs = {
            "version": attr.string(
                default = CHROMEDRIVER_DEFAULT_VERSION,
            ),
        }),
        "firefox": tag_class(attrs = {
            "version": attr.string(
                default = FIREFOX_DEFAULT_VERSION,
            ),
        }),
    },
)
