# cb-resolve — the Community Behaviors load-order resolution surface, built resolve-only
# (no SKSE plugin / converter / CommonLibSSE). Consumers: find_package(cb-resolve) -> cb::cb-resolve.

# NOTE — do NOT publish this registry for third-party consumption yet. Community-Behaviors is public
# (so the fetch below works) but its LICENSE is All Rights Reserved, not an open-source license. This
# port is for the copyright holder's own / authorized use until CB is released under GPL-3.0 + a linking
# exception, at which point set the vcpkg.json license and enable vcpkg_install_copyright below.
# (SHA512 is GitHub's source archive for the tag; if GitHub ever regenerates it, recompute:
#   curl -sL .../archive/refs/tags/v0.3.2.tar.gz | sha512sum )
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Cassieandstuff/Community-Behaviors
    REF  v0.3.2
    SHA512 ded39fe18eae3b9b6f643b9bed5e0e2399b13704381492f7364454e8f5e52aa34a2bca2ea3b973d3a834d26e15966650985bc5ddfc08818e0c977a98631cf5e9
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
