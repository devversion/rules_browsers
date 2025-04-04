load("@npm_rules_browsers//:@web/test-runner/package_json.bzl", wtr = "bin")

def _base_wtr_test(name, mode, deps, tags = [], **kwargs):
    is_firefox = mode == "firefox"
    is_chromium = mode == "chromium"

    browser_deps = []
    toolchains = []
    env = {}
    extra_tags = []

    if is_firefox:
        browser_deps.append("@rules_browsers//src/browsers/firefox")
        toolchains.append("@rules_browsers//src/browsers/firefox:toolchain_alias")
        env = {"FIREFOX_BIN": "$(FIREFOX)"}
    elif is_chromium:
        browser_deps.append("@rules_browsers//src/browsers/chromium")
        toolchains.append("@rules_browsers//src/browsers/chromium:toolchain_alias")
        env = {"CHROMIUM_BIN": "$(CHROMIUM)"}
    else:
        env = {"MANUAL_MODE": "1"}
        extra_tags = ["requires-network", "manual"]

    wtr.wtr_test(
        name = name,
        data = browser_deps + deps + [
            "@rules_browsers//:node_modules/@web/test-runner-core",
            "@rules_browsers//:node_modules/@web/test-runner-puppeteer",
            "@rules_browsers//:node_modules/get-port",
            "@rules_browsers//:node_modules/web-test-runner-jasmine",
            "@rules_browsers//src/wtr:wtr_config",
        ],
        tags = tags + extra_tags,
        env = env,
        toolchains = toolchains,
        args = [
            "--config=../rules_browsers/src/wtr/wtr.config.mjs",
            "%s/**/*.spec.js" % native.package_name(),
            "%s/**/*.spec.mjs" % native.package_name(),
            "%s/**/*.spec.cjs" % native.package_name(),
            "%s/**/*_spec.js" % native.package_name(),
            "%s/**/*_spec.mjs" % native.package_name(),
            "%s/**/*_spec.cjs" % native.package_name(),
        ],
        **kwargs
    )

def wtr_test(name, deps, **kwargs):
    _base_wtr_test("%s_firefox" % name, deps = deps, mode = "firefox", **kwargs)
    _base_wtr_test("%s_chromium" % name, deps = deps, mode = "chromium", **kwargs)
    _base_wtr_test("%s_debug" % name, deps = deps, mode = "manual", **kwargs)

    native.test_suite(
        name = name,
        tests = [
            ":%s_firefox" % name,
            "%s_chromium" % name,
        ],
    )
