load("@npm_rules_browsers//:@web/test-runner/package_json.bzl", wtr = "bin")

def _base_wtr_test(
        name,
        deps,
        env = {},
        tags = [],
        **kwargs):
    base_env = {
        "CI": "1",
        "FORCE_COLOR": "1",
    }
    base_env.update(env)

    # Sandbox is very slow, and it seems like modern browsers end up being
    # much stricter at this point. Back with Karma it was possible to run with
    # sandbox, but with a proper runfiles directory the risk here is low, and
    # it also solves some launch problems where e.g. Firefox access `HOME`.
    extra_tags = ["no-sandbox"]

    wtr.wtr_test(
        name = name,
        data = deps + [
            Label("//:node_modules/@web/test-runner-core"),
            Label("//:node_modules/@web/test-runner-puppeteer"),
            Label("//:node_modules/get-port"),
            Label("//:node_modules/web-test-runner-jasmine"),
            Label("//:node_modules/@web/dev-server-rollup"),
            Label("//:node_modules/@rollup/plugin-virtual"),
            "@rules_browsers//wtr:wtr_config",
        ],
        tags = tags + extra_tags,
        env = env,
        fixed_args = [
            "--config=$(rootpath @rules_browsers//wtr:wtr_config)",
            "%s/**/*.spec.js" % native.package_name(),
            "%s/**/*.spec.mjs" % native.package_name(),
            "%s/**/*.spec.cjs" % native.package_name(),
            "%s/**/*_spec.js" % native.package_name(),
            "%s/**/*_spec.mjs" % native.package_name(),
            "%s/**/*_spec.cjs" % native.package_name(),
        ],
        **kwargs
    )

def wtr_test(name, deps, firefox, chromium, tags = [], env = {}, **kwargs):
    tests = []
    if firefox:
        firefox_env = {"FIREFOX_BIN": "$(FIREFOX)"}
        firefox_env.update(env)
        _base_wtr_test(
            name = "%s_firefox" % name,
            deps = deps + [firefox],
            tags = tags,
            env = firefox_env,
            **kwargs
        )
        tests.append(":%s_firefox" % name)
    if chromium:
        chromium_env = {"CHROME_HEADLESS_BIN": "$(CHROME-HEADLESS-SHELL)"}
        chromium_env.update(env)
        _base_wtr_test(
            name = "%s_chromium" % name,
            deps = deps + [chromium],
            tags = tags,
            env = chromium_env,
            **kwargs
        )
        tests.append(":%s_chromium" % name)

    manual_env = {"MANUAL_MODE": "1"}
    manual_env.update(env)
    _base_wtr_test(
        name = "%s_debug" % name,
        deps = deps,
        tags = ["requires-network", "manual"] + tags,
        env = manual_env,
        **kwargs
    )

    if len(tests) == 0:
        fail("A least one of `chromium` or `firefox` must be enabled")

    native.test_suite(
        name = name,
        tests = tests,
    )
