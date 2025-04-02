load("@rules_browsers//src/browsers/private:browser_artifact.bzl", "NamedFilesInfo")

def _browser_group_impl(ctx):
    named_files = {}
    file_depsets = []

    for dep in ctx.attr.deps:
        file_depsets.append(dep[DefaultInfo].files)

        for key, value in dep[NamedFilesInfo]:
            named_files[key] = value

    return [
        DefaultInfo(files = depset([], transitive = file_depsets)),
        NamedFilesInfo(value = named_files),
    ]

browser_group = rule(
    implementation = _browser_group_impl,
    doc = "Groups multiple `browser_artifact` into a single target",
    attrs = {
        "deps": attr.label_list(mandatory = True),
    },
)
