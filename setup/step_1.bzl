load("@aspect_rules_js//npm:repositories.bzl", "npm_translate_lock")
load("@rules_browsers//src/browsers:repositories.bzl", "rules_browsers_repositories")

def rules_browsers_setup_1():
    npm_translate_lock(
        name = "npm_rules_browsers",
        data = [
            "//:package.json",
            "//:pnpm-workspace.yaml",
        ],
        npmrc = "//:.npmrc",
        pnpm_lock = "//:pnpm-lock.yaml",
        verify_node_modules_ignored = "//:.bazelignore",
    )

    rules_browsers_repositories()
