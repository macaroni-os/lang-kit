# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="General-purpose programming language for robust, optimal, and reusable software (upstream build)"
HOMEPAGE="https://ziglang.org/"
SRC_URI="
amd64? ( https://ziglang.org/download/0.16.0/zig-x86_64-linux-0.16.0.tar.xz -> zig-bin-x86_64-linux-0.16.0.tar.xz )
arm? ( https://ziglang.org/download/0.16.0/zig-arm-linux-0.16.0.tar.xz -> zig-bin-arm-linux-0.16.0.tar.xz )
arm64? ( https://ziglang.org/download/0.16.0/zig-aarch64-linux-0.16.0.tar.xz -> zig-bin-aarch64-linux-0.16.0.tar.xz )
riscv64? ( https://ziglang.org/download/0.16.0/zig-riscv64-linux-0.16.0.tar.xz -> zig-bin-riscv64-linux-0.16.0.tar.xz )"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="doc amd64 arm arm64 riscv64"
RDEPEND="!dev-lang/zig
	
"
DEPEND="app-arch/tar
"
src_unpack() {
	default
	mv "${WORKDIR}/"* "${S}"
}
src_install() {
	use doc || rm -rf "${S}"/doc
	dodir /opt
	mv "${S}" "${ED}"/opt/ || die
	dodir /usr/bin
	dosym "${ED}"/opt/${P}/zig /usr/bin/zig
	fperms 0755 /usr/bin/zig
}


# vim: filetype=ebuild
