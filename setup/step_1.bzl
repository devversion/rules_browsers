load("@aspect_rules_js//npm:repositories.bzl", "npm_translate_lock")
load("@rules_browsers//src/browsers:repositories.bzl", "rules_browsers_repositories")

def rules_browsers_setup_1():
    npm_translate_lock(
        name = "npm_rules_browsers",
        data = [
            "@rules_browsers//:package.json",
            "@rules_browsers//:pnpm-workspace.yaml",
            "@rules_browsers//:patches/@web__config-loader.patch",
        ],
        npmrc = "//:.npmrc",
        pnpm_lock = "//:pnpm-lock.yaml",
        verify_node_modules_ignored = "//:.bazelignore",
    )

    rules_browsers_repositories()
