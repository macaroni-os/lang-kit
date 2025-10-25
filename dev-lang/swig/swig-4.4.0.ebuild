# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"
SRC_URI="https://download.sourceforge.net/swig/swig-4.4.0.tar.gz -> swig-4.4.0.tar.gz"
LICENSE="GPL-3+ BSD BSD-2"
SLOT="0"
KEYWORDS="*"
DOCS=(
	ANNOUNCE
	CHANGES
	CHANGES.current
	README
	TODO
)
IUSE="ccache pcre"
RDEPEND="pcre? ( dev-libs/libpcre )
	ccache? ( sys-libs/zlib )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	econf \
	  $(use_enable ccache) \
	  $(use_with pcre)
}


# vim: filetype=ebuild
