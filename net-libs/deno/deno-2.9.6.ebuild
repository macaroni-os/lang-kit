# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://deno.com"
SRC_URI="
https://api.github.com/repos/denoland/deno/tarball/v2.9.6 -> deno-2.9.6-e518fbd.tar.gz
mirror://macaroni/deno-2.9.6-mark-rust-bundle-e518fbd.tar.xz -> deno-2.9.6-mark-rust-bundle-e518fbd.tar.xz"
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
src_configure() {
	export MAKEOPTS="-j1"
	cargo_gen_config
}
src_compile() {
	export CARGO_BUILD_JOBS=1
	export CARGO_INCREMENTAL=0
	export CARGO_PROFILE_RELEASE_CODEGEN_UNITS=1
	export NINJAFLAGS="-j1"
	cargo build --release || die "cargo build failed"
}
src_install() {
	# Install the binary directly, cargo install doesn't work on workspaces
	dobin target/release/deno
}


# vim: filetype=ebuild
