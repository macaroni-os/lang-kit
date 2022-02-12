# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="General-purpose programming language for robust, optimal, and reusable software"
SRC_URI="${SRC_URI}
    ? ( https://ziglang.org/builds/zig-linux-x86_64-0.10.0-dev.675+beb275b37.tar.xz )
    ? ( https://ziglang.org/builds/zig-linux-aarch64-0.10.0-dev.675+beb275b37.tar.xz )"
HOMEPAGE="https://ziglang.org/"
SLOT="0"
LICENSE="MIT"
IUSE="+doc"

DEPEND="app-arch/tar"

src_unpack() {
	unpack ${A}

	mv "${WORKDIR}/"* "${WORKDIR}/${PN}-${PV}"
}

src_install() {
	use doc || rm -rf "${S}"/doc

	dodir /opt
	mv "${S}" "${ED}"opt/ || die

	dodir /usr/bin
	dosym "${ED}"opt/${PN}-${PV}/zig /usr/bin/zig
	fperms 0755 /usr/bin/zig
}