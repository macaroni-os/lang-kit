# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="General-purpose programming language for robust, optimal, and reusable software"
SRC_URI="
	amd64? ( https://ziglang.org/builds/zig-linux-x86_64-0.12.0-dev.3597+d979df585.tar.xz -> zig-linux-x86_64-0.12.0-dev.3597+d979df585.tar.xz )
	arm? ( https://ziglang.org/builds/zig-linux-armv7a-0.12.0-dev.3597+d979df585.tar.xz -> zig-linux-armv7a-0.12.0-dev.3597+d979df585.tar.xz )
	arm64? ( https://ziglang.org/builds/zig-linux-aarch64-0.12.0-dev.3597+d979df585.tar.xz -> zig-linux-aarch64-0.12.0-dev.3597+d979df585.tar.xz )
	riscv64? ( https://ziglang.org/builds/zig-linux-riscv64-0.12.0-dev.3597+d979df585.tar.xz -> zig-linux-riscv64-0.12.0-dev.3597+d979df585.tar.xz )"
HOMEPAGE="https://ziglang.org/"
SLOT="0"
LICENSE="MIT"
IUSE="+doc"

DEPEND="app-arch/tar"
RDEPEND="!dev-lang/zig"

src_unpack() {
	unpack ${A}

	mv "${WORKDIR}/"* "${S}"
}

src_install() {
	use doc || rm -rf "${S}"/doc

	dodir /opt
	mv "${S}" "${ED}"opt/ || die

	dodir /usr/bin
	dosym "${ED}"opt/${PN}-${PV}/zig /usr/bin/zig
	fperms 0755 /usr/bin/zig
}