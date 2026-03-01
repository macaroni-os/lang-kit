# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit python-any-r1

DESCRIPTION="Node.js JavaScript runtime ✨🐢🚀✨"
HOMEPAGE="https://nodejs.org"
SRC_URI="https://api.github.com/repos/nodejs/node/tarball/refs/tags/v24.14.0 -> nodejs-24.14.0-f657bb8.tar.gz"
LICENSE="Apache-1.1 Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="${PYTHON_DEPS}
	
"

post_src_unpack() {
	mv nodejs-node-* ${S}
}


src_configure() {
	configure_options=(
	  # By default, prefix is /usr/local, which is outside of PATH,
	  # set it to /usr instead:
	  --prefix="${EPREFIX}"/usr
	)
	# NOTE: `econf` default flags appear to trip up the configure process,
	#       directly call the ./configure script instead.
	./configure "${configure_options[@]}"
}



# vim: filetype=ebuild
