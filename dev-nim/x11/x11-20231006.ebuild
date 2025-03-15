# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Nim Wrapper for X11"
HOMEPAGE="https://github.com/nim-lang/x11"
SRC_URI="https://github.com/nim-lang/x11/archive/29aca5e519ebf5d833f63a6a2769e62ec7bfb83a.tar.gz -> x11-20231006.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="
	>=dev-lang/nim-0.9.2
	x11-libs/libX11
"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/x11-* "${S}" || die
}

src_prepare() {
	default
	rm -rf .gitignore LICENSE .github
}

src_install() {
	insinto /opt/nimble/pkgs/${P}
	doins -r *
}
