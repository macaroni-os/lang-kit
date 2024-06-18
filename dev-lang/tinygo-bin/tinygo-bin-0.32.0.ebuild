# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=${PN/-bin/}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="Go compiler for small places. Microcontrollers, WebAssembly (WASM/WASI), and command-line tools. Based on LLVM."
HOMEPAGE="https://github.com/tinygo-org/tinygo https://tinygo.org/"
SRC_URI="amd64? (
  https://github.com/tinygo-org/tinygo/releases/download/v0.32.0/tinygo0.32.0.linux-amd64.tar.gz -> tinygo0.32.0.linux-amd64.tar.gz
)
arm64? (
  https://github.com/tinygo-org/tinygo/releases/download/v0.32.0/tinygo0.32.0.linux-arm64.tar.gz -> tinygo0.32.0.linux-arm64.tar.gz
)
"

LICENSE="Apache License v2.0 LLVM"
SLOT="0"
KEYWORDS="-* amd64 arm64"
IUSE="amd64 arm64"

# https://bugs.funtoo.org/browse/FL-12258
# A major dependency of TinyGo is LLVM
# Even though the upstream pre-compiled binaries are statically linked
# TinyGo uses components of an LLVM toolchain for certain compile targets
# Such as WebAssembly: https://tinygo.org/docs/guides/webassembly/
# Wasm compilations are currently broken because we need a correctly versioned wasm-ld
# wasm-ld is the WebAssembly linker that ships with LLVM
# TinyGo requires the latest LLVM 17.0.1 as of TinyGo version 0.31.2
# Once we have this in the Funtoo package tree we can
# safely add a new DEPEND for the correct LLVM package
DEPEND=">=dev-lang/go-1.22.0"
RDEPEND="${DEPEND}"

QA_PREBUILT="
	usr/bin/tinygo
	lib/wasi-libc/sysroot/lib/wasm32-wasi/*
"

QA_FLAGS_IGNORED="usr/lib/tinygo/pkg/*/*"

QA_PRESTRIPPED="lib/wasi-libc/sysroot/lib/wasm32-wasi/*"

post_src_unpack() {
	if [ ! -d "${S}" ] ; then
	mv "${WORKDIR}"/${MY_PN} "${S}" || die
	fi
}

src_install() {
	dobin bin/tinygo

	insinto /usr/lib/${MY_PN}
	doins -r lib pkg src targets

	# We need to globally set TINYGOROOT env var for tinygo to work properly
	cat <<-_EOF_ > "${T}/50${P}"
	TINYGOROOT="/usr/lib64/tinygo"
	_EOF_
	doenvd "${T}/50${P}"
}

pkg_postinst(){
	elog "To enure tinygo is configuerd properly TINYGOROOT needs to be in the global env"
	elog "If you wish to run tinygo right now, please run:"
	elog "source /etc/profile"
	elog ""
	elog "Afterwards, to verify tinygo is ready to use, please run:"
	elog "tinygo env"
	elog "This command should return no errors"
}