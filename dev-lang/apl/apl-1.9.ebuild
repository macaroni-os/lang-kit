# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A free implementation of APL/2 (ISO 13751) w/extensions"
HOMEPAGE="https://www.gnu.org/software/apl/"
SRC_URI="https://ftp.gnu.org/gnu/apl/apl-1.9.tar.gz -> apl-1.9.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"

RDEPEND="sys-libs/ncurses:="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

post_src_unpack() {
	default
}

src_prepare() {
	default
}

src_configure() {
	eautoreconf

	local myeconfargs=(
		--exec-prefix=/usr
		--with-ctrld_del
		--with-sqlite3
		--with-gtk3
		--with-pcre
		RATIONAL_NUMBERS_WANTED=yes
		CORE_COUNT_WANTED=4
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	make DESTDIR="${D}" install
}