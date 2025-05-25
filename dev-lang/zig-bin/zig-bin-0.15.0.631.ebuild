# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="General-purpose programming language for robust, optimal, and reusable software"
SRC_URI="
	amd64? ( https://ziglang.org/builds/zig-x86_64-linux-0.15.0-dev.631+9a3540d61.tar.xz -> zig-x86_64-linux-0.15.0-dev.631+9a3540d61.tar.xz )
	arm? ( https://ziglang.org/builds/zig-armv7a-linux-0.15.0-dev.631+9a3540d61.tar.xz -> zig-armv7a-linux-0.15.0-dev.631+9a3540d61.tar.xz )
	arm64? ( https://ziglang.org/builds/zig-aarch64-linux-0.15.0-dev.631+9a3540d61.tar.xz -> zig-aarch64-linux-0.15.0-dev.631+9a3540d61.tar.xz )
	riscv64? ( https://ziglang.org/builds/zig-riscv64-linux-0.15.0-dev.631+9a3540d61.tar.xz -> zig-riscv64-linux-0.15.0-dev.631+9a3540d61.tar.xz )"
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