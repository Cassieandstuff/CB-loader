# cb-resolve — the Community Behaviors load-order resolution surface, built resolve-only
# (no SKSE plugin / converter / CommonLibSSE). Consumers: find_package(cb-resolve) -> cb::cb-resolve.

# ── BLOCKED until Community-Behaviors is reachable to vcpkg ─────────────────────────────────────
#   • The repo is currently PRIVATE: vcpkg_from_github fetches the source TARBALL over HTTPS, which
#     needs the repo public OR a GITHUB_TOKEN configured. The SHA512 below is a placeholder — fill it
#     once the tag archive is fetchable:
#         curl -sL https://github.com/Cassieandstuff/Community-Behaviors/archive/refs/tags/v0.3.2.tar.gz \
#           | sha512sum
#     (or run vcpkg once with SHA512 0 and copy the "Actual hash" it prints).
#   • The CB repo has no LICENSE file yet; vcpkg_install_copyright (below) needs one. Add a GPL-3.0
#     LICENSE to CB first (and settle the publishing exception).
# ────────────────────────────────────────────────────────────────────────────────────────────────
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Cassieandstuff/Community-Behaviors
    REF  v0.3.2
    SHA512 0   # <-- PLACEHOLDER, see above
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS -DCB_RESOLVE_ONLY=ON   # build ONLY the cb-resolve surface (CB is top-level under vcpkg)
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME cb-resolve CONFIG_PATH share/cb-resolve)

# Header-only interface + static engine libs: no debug/ headers, no bin.
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include"
                    "${CURRENT_PACKAGES_DIR}/debug/share")

# GPL-3.0 — enable once CB ships a LICENSE file:
# vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
