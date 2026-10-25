# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
QA_PREBUILT="*"

DESCRIPTION="The Julia Programming Language"
HOMEPAGE="https://julialang.org/"
SRC_URI="
amd64? ( https://julialang-s3.julialang.org/bin/linux/x64/1.12/julia-1.12.7-linux-x86_64.tar.gz -> julia-bin-1.12.7-6d172b0-x86_64.tar.gz )
arm64? ( https://julialang-s3.julialang.org/bin/linux/aarch64/1.12/julia-1.12.7-linux-aarch64.tar.gz -> julia-bin-1.12.7-6d172b0-arm64.tar.gz )"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="amd64 arm64"
RESTRICT="strip"
S="${WORKDIR}/julia-1.12.7"

src_install() {
	insinto "/usr/$(get_libdir)/julia-1.12.7/"
	exeinto "/usr/$(get_libdir)/julia-1.12.7/bin"

	doins -r ./etc
	doins -r ./include
	doins -r ./lib
	doins -r ./share

	doexe bin/julia
	dosym "../$(get_libdir)/julia-1.12.7/bin/julia" \
		"/usr/bin/julia1.12"

	{
		echo "PATH=\"/usr/$(get_libdir)/julia-1.12.7/bin\""
	} > "${T}"/99julia
	doenvd "${T}"/99julia
}


# vim: filetype=ebuild
