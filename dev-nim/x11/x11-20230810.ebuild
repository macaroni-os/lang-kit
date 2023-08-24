# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Nim Wrapper for X11"
HOMEPAGE="https://github.com/nim-lang/x11"
SRC_URI="https://github.com/nim-lang/x11/archive/10f1c2f42759839f5e25f32c52e9f01103b64f59.tar.gz -> x11-20230810.tar.gz"

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
