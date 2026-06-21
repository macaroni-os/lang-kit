# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Virtual for Rust language compiler"
HOMEPAGE="https://www.rust-lang.org"
LICENSE="|| ( MIT Apache-2.0 ) BSD-1 BSD-2 BSD-4 UoI-NCSA"
SLOT="0"
KEYWORDS="*"
RDEPEND="|| (
	  ~dev-lang/rust-bin-1.96.0
	  ~dev-lang/rust-1.96.0
	)
	
"
DEPEND="${RDEPEND}
"

# vim: filetype=ebuild
