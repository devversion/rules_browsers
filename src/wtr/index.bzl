load("@npm_rules_browsers//:@web/test-runner/package_json.bzl", wtr = "bin")

def wtr_test(name, deps):
    wtr.wtr_test(
        name = name,
        data = deps + [
            "@rules_browsers//src/wtr:wtr_config",
            "@rules_browsers//:node_modules/web-test-runner-jasmine",
            "@rules_browsers//:node_modules/@web/test-runner-core",
            "@rules_browsers//:node_modules/@web/test-runner-puppeteer",
            "@rules_browsers//src/browsers/chromium",
        ],
        env = {
            "CHROMIUM_BIN": "$(CHROMIUM)",
            "CHROMEDRIVER_BIN": "$(CHROMEDRIVER)",
        },
        toolchains = ["@rules_browsers//src/browsers/chromium:toolchain_alias"],
        args = [
            "--config=../rules_browsers/src/wtr/wtr.config.mjs",
            "%s/**/*.spec.js" % native.package_name(),
            "%s/**/*.spec.mjs" % native.package_name(),
            "%s/**/*.spec.cjs" % native.package_name(),
            "%s/**/*_spec.js" % native.package_name(),
            "%s/**/*_spec.mjs" % native.package_name(),
            "%s/**/*_spec.cjs" % native.package_name(),
        ],
    )
