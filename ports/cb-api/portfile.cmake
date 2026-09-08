# cb-api — Community Behaviors' public API surface, built API-only (no SKSE plugin / converter /
# CommonLibSSE / havok-core). Consumers: find_package(cb-api) -> cb::CB-API (one header <CB-API.h>).

# NOTE — do NOT publish this registry for third-party consumption yet. Community-Behaviors is public
# (so the fetch below works) but its LICENSE is All Rights Reserved, not an open-source license. This
# port is for the copyright holder's own / authorized use until CB is released under GPL-3.0 + a linking
# exception, at which point set the vcpkg.json license and enable vcpkg_install_copyright below.
# (SHA512 is GitHub's source archive for the tag; if GitHub ever regenerates it, recompute:
#   curl -sL https://github.com/Cassieandstuff/Community-Behaviors/archive/refs/tags/v0.4.1.tar.gz | sha512sum )
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Cassieandstuff/Community-Behaviors
    REF  v0.4.1
    SHA512 924688071d810e2033f768c5d49f1f0eb1168231928a96b13268d84850344fd9fce1b44dcb4fb1aff534d4cef56e9af4131c109664ec61eaddd1eef48cadf50c
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS -DCB_API_ONLY=ON   # build ONLY the cb-api surface (CB is top-level under vcpkg)
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME cb-api CONFIG_PATH share/cb-api)

# Header-only facade + static engine libs: no debug/ headers, no bin.
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include"
                    "${CURRENT_PACKAGES_DIR}/debug/share")

# GPL-3.0 — enable once CB ships a LICENSE file:
# vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
