# CB-loader — vcpkg registry for Community Behaviors

A custom [vcpkg registry](https://learn.microsoft.com/vcpkg/produce/publish-to-a-git-registry) that
publishes **`cb-resolve`** — the [Community Behaviors](https://github.com/Cassieandstuff/Community-Behaviors)
load-order resolution + `.hky` document API — so any tool can `find_package(cb-resolve)` and resolve a
load order identically to the CB compiler.

## Status: scaffold (not yet usable)

Two things must land before this registry works end-to-end:

1. **Community-Behaviors must be reachable to vcpkg.** It's currently private; `vcpkg_from_github` needs
   the repo public or a `GITHUB_TOKEN`. Until then the portfile's `SHA512` can't be finalized (it's a
   placeholder). See `ports/cb-resolve/portfile.cmake`.
2. **CB's license.** CB is currently **All Rights Reserved** (unreleased/proprietary), so the port's
   `license` is `null` and this registry must not be published for third-party consumption yet. On
   release CB becomes GPL-3.0 (+ a linking exception); at that point set the port `license` to the
   matching SPDX id and enable `vcpkg_install_copyright`.

Right now the port itself is complete and pinned to CB **v0.3.2** (the first version with install/export
rules). Once #1/#2 land: fill the SHA512, then `vcpkg x-add-version cb-resolve` to generate the
`versions/` database that makes this a real registry.

## Consuming it (once finalized)

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

If you have repo access, you don't need this registry yet — consume CB directly (see
CB's `docs/consuming-cb-resolve.md`):
```cmake
FetchContent_Declare(community_behaviors
    GIT_REPOSITORY https://github.com/Cassieandstuff/Community-Behaviors.git
    GIT_TAG v0.3.2)
FetchContent_MakeAvailable(community_behaviors)
target_link_libraries(you PRIVATE cb::cb-resolve)
```
