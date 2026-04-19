# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
NPM_NO_DEPS=1
inherit npmv1

DESCRIPTION="TypeScript is a superset of JavaScript that compiles to clean JavaScript output."
HOMEPAGE="https://www.typescriptlang.org"
SRC_URI="https://github.com/microsoft/TypeScript/releases/download/v6.0.3/typescript-6.0.3.tgz -> typescript-6.0.3.tgz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
RDEPEND="${DEPEND}
"
S="${WORKDIR}/package"

# vim: filetype=ebuild
