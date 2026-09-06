# CB-loader — vcpkg registry for Community Behaviors

A custom [vcpkg registry](https://learn.microsoft.com/vcpkg/produce/publish-to-a-git-registry) that
publishes **`cb-resolve`** — the [Community Behaviors](https://github.com/Cassieandstuff/Community-Behaviors)
load-order resolution + `.hky` document API — so any tool can `find_package(cb-resolve)` and resolve a
load order identically to the CB compiler.

## Status: scaffold (not yet usable)

Community-Behaviors is now **public**, so the port builds: it's pinned to CB **v0.3.2** (first version
with install/export rules) with a real `vcpkg_from_github` SHA512. `find_package(cb-resolve)` →
`cb::cb-resolve`.

**One constraint remains — do NOT publish this registry for third-party consumption.** Public ≠ open
source: CB's LICENSE is **All Rights Reserved** (source-visible, no usage rights granted). This port is
for the copyright holder's own / authorized use only. When CB is released under GPL-3.0 (+ a linking
exception), set the port `license` to the matching SPDX id, enable `vcpkg_install_copyright` in the
portfile, and only then promote this for open consumption.

To make it a real versioned registry (rather than an overlay), run `vcpkg x-add-version cb-resolve`
after committing the port, which generates the `versions/` database.

## Consuming it (via vcpkg, once the versions DB exists)

`vcpkg-configuration.json` in the consumer:
```json
{
  "registries": [
    { "kind": "git",
      "repository": "https://github.com/Cassieandstuff/CB-loader",
      "baseline": "<commit>",
      "packages": [ "cb-resolve" ] }
  ]
}
```
`vcpkg.json`: add `"cb-resolve"` to dependencies. Then `find_package(cb-resolve CONFIG REQUIRED)` +
`target_link_libraries(you PRIVATE cb::cb-resolve)`.

## Meanwhile: FetchContent works today

You don't need this registry yet — consume CB directly (CB is public; see
CB's `docs/consuming-cb-resolve.md`). Note the All-Rights-Reserved license still applies:
```cmake
FetchContent_Declare(community_behaviors
    GIT_REPOSITORY https://github.com/Cassieandstuff/Community-Behaviors.git
    GIT_TAG v0.3.2)
FetchContent_MakeAvailable(community_behaviors)
target_link_libraries(you PRIVATE cb::cb-resolve)
```
