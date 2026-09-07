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
    REF  v0.3.3
    SHA512 dc3bd10dca0a7f7b441f84e15474e0cb9884e151a534339ce8b84208f06da5a666c35f90083f1e5557a49b3d98c91255e6ca47e713035fc0b483f971a6d7545e
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
