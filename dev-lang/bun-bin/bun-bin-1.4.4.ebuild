# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
QA_PREBUILT="*"

DESCRIPTION="Incredibly fast JavaScript runtime, bundler, test runner and package manager (upstream binary)"
HOMEPAGE="https://bun.sh"
SRC_URI="
amd64? ( https://github.com/oven-sh/bun/releases/download/bun-v1.4.4/bun-linux-x64.zip -> bun-bin-1.4.4-amd64-linux.zip )
arm64? ( https://github.com/oven-sh/bun/releases/download/bun-v1.4.4/bun-linux-aarch64.zip -> bun-bin-1.4.4-arm64-linux.zip )"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="amd64 arm64"
RESTRICT="strip"
BDEPEND="app-arch/unzip
	
"
post_src_unpack() {
	# The glibc zip unpacks into a single bun-linux-<arch>/ dir that
	# holds just the ELF binary. Point S at it when the unpacker
	# single-directory heuristic did not do it for us.
	if [ ! -d "${S}" ] ; then
		mv "${WORKDIR}"/bun-linux-* "${S}" || die
	fi
}
src_configure() { :; }
src_compile() { :; }
src_install() {
	newbin "${S}"/bun bun
}


# vim: filetype=ebuild
