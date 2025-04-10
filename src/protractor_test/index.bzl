load("@npm_rules_browsers//:protractor/package_json.bzl", protractor = "bin")
load("@rules_browsers//src/server_test:index.bzl", "server_test")

def protractor_test(name, server, deps, **kwargs):
    protractor.protractor_test(
        name = "%s_protractor" % name,
        fixed_args = [
            "../rules_browsers/src/protractor_test/config.cjs",
            "--specs=%s" % ",".join([
                "%s/**/*.spec.js" % native.package_name(),
                "%s/**/*.spec.mjs" % native.package_name(),
                "%s/**/*.spec.cjs" % native.package_name(),
                "%s/**/*_spec.js" % native.package_name(),
                "%s/**/*_spec.mjs" % native.package_name(),
                "%s/**/*_spec.cjs" % native.package_name(),
            ]),
        ],
        data = deps + [
            "@rules_browsers//src/browsers/chromium",
            "@rules_browsers//src/protractor_test:config",
        ],
        env = {
            "CHROME_HEADLESS_BIN": "$(CHROME-HEADLESS-SHELL)",
            "CHROMEDRIVER_BIN": "$(CHROMEDRIVER)",
        },
        toolchains = ["@rules_browsers//src/browsers/chromium:toolchain_alias"],
        tags = ["manual"],
    )

    server_test(
        name = name,
        server = server,
        test = ":%s_protractor" % name,
        **kwargs
    )
