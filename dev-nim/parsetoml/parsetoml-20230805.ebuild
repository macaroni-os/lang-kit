# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Nim library to parse TOML files"
HOMEPAGE="https://github.com/NimParsers/parsetoml"
SRC_URI="https://github.com/NimParsers/parsetoml/archive/6e5e16179fa2db60f2f37d8b1af4128aaa9c8aaf.tar.gz -> parsetoml-20230805.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND=">=dev-lang/nim-0.18.0"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/parsetoml-* "${S}" || die
}

src_prepare() {
	default
	rm -rf .gitignore LICENSE .github
}

src_install() {
	insinto /opt/nimble/pkgs/${P}
	doins -r *
	dodir /opt/nimble/pkgs/${P}
	dosym ./src/parsetoml.nim /opt/nimble/pkgs/${P}/parsetoml.nim
}