load("@aspect_rules_js//npm:repositories.bzl", "npm_translate_lock")
load("@rules_browsers//src/browsers:repositories.bzl", "rules_browsers_repositories")

def rules_browsers_setup_1():
    npm_translate_lock(
        name = "npm_rules_browsers",
        data = [
            "@rules_browsers//:package.json",
            "@rules_browsers//:pnpm-workspace.yaml",
            "@rules_browsers//:patches/web-test-runner-jasmine-0.0.7.tgz",
        ],
        npmrc = "@rules_browsers//:.npmrc",
        pnpm_lock = "@rules_browsers//:pnpm-lock.yaml",
        verify_node_modules_ignored = "@rules_browsers//:.bazelignore",
    )

    rules_browsers_repositories()
