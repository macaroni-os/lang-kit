# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit toolchain-funcs flag-o-matic

DESCRIPTION="A modifiable assembler for the x86 instruction set"
HOMEPAGE="https://yasm.tortall.net/"
SRC_URI="https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz -> yasm-1.3.0.tar.gz"
LICENSE="BSD-2 BSD || ( Artistic GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="*"
IUSE="nls"
BDEPEND="nls? ( sys-devel/gettext )
	
"
RDEPEND="${DEPEND}
"
DEPEND="nls? ( virtual/libintl )
	
"
src_prepare() {
		default
		# C23 (default since gcc-15) makes 'true'/'false' reserved keywords,
		# while libyasm/bitvect.h still uses them as enumeration constants.
		# Pin the C standard until upstream (inactive since 1.3.0/2014) or a
		# FreeBSD-yasm-style rename patch lands. macaroni-os/mark-issues#830
		append-flags -std=gnu17
}

src_configure() {
		local myconf=(
				CC_FOR_BUILD="$(tc-getBUILD_CC)"
				CCLD_FOR_BUILD="$(tc-getBUILD_CC)"
				--disable-warnerror
				--disable-python
				--disable-python-bindings
				$(use_enable nls)
		)

		econf "${myconf[@]}"
}

src_test() {
		# https://bugs.gentoo.org/718870
		emake -j1 check
}


# vim: filetype=ebuild
