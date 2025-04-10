load("@bazel_skylib//rules:write_file.bzl", "write_file")
load("@npm_rules_browsers//:protractor/package_json.bzl", protractor = "bin")
load("@rules_browsers//src/server_test:index.bzl", "server_test")

def protractor_test(name, server, deps, extra_config = {}, data = [], **kwargs):
    write_file(
        name = "%s_protractor_extra_config" % name,
        out = "%s_protractor_extra_config.json" % name,
        content = [json.encode(extra_config)],
    )

    protractor.protractor_test(
        name = "%s_protractor" % name,
        fixed_args = ["../rules_browsers/src/protractor_test/config.cjs"],
        data = data + deps + [
            ":%s_protractor_extra_config" % name,
            "@rules_browsers//src/browsers/chromium",
            "@rules_browsers//src/protractor_test:config",
        ],
        env = {
            "CHROME_HEADLESS_BIN": "$(CHROME-HEADLESS-SHELL)",
            "CHROMEDRIVER_BIN": "$(CHROMEDRIVER)",
            "TEST_PACKAGE": native.package_name(),
            "CONFIG_PATH": "$(rootpath :%s_protractor_extra_config)" % name,
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
