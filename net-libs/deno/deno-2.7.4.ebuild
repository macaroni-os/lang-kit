# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://deno.com"
SRC_URI="
https://api.github.com/repos/denoland/deno/tarball/v2.7.4 -> deno-2.7.4-8274bf7.tar.gz
mirror://macaroni/deno-2.7.4-mark-rust-bundle-8274bf7.tar.xz -> deno-2.7.4-mark-rust-bundle-8274bf7.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
RESTRICT="network-sandbox"
BDEPEND="sys-devel/llvm
	sys-devel/clang
	sys-devel/lld
	dev-util/gn
	virtual/rust
	
"
post_src_unpack() {
	rm -rf "${S}" || true
	mv denoland-deno-* "${S}"
}
src_compile() {
	# Don't try to fetch prebuilt V8, build it instead
	export V8_FROM_SOURCE=1
	cargo_src_compile
}
src_install() {
	# Install the binary directly, cargo install doesn't work on workspaces
	dobin target/release/deno
}


# vim: filetype=ebuild
