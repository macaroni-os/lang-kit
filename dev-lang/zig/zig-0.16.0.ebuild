# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
BUILD_DIR="${S}/build"
CMAKE_BUILD_TYPE=Release
inherit cmake

DESCRIPTION="General-purpose programming language for robust, optimal, and reusable software"
HOMEPAGE="https://ziglang.org/"
SRC_URI="https://ziglang.org/download/0.16.0/zig-0.16.0.tar.xz -> zig-0.16.0.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="+clang"

ALL_LLVM_TARGET_FLAGS=(
	llvm_targets_AArch64
	llvm_targets_AMDGPU
	llvm_targets_ARM
	llvm_targets_AVR
	llvm_targets_BPF
	llvm_targets_Hexagon
	llvm_targets_Lanai
	llvm_targets_Mips
	llvm_targets_MSP430
	llvm_targets_NVPTX
	llvm_targets_PowerPC
	llvm_targets_RISCV
	llvm_targets_SystemZ
	llvm_targets_Sparc
	llvm_targets_SPIRV
	llvm_targets_VE
	llvm_targets_WebAssembly
	llvm_targets_X86
	llvm_targets_XCore
	llvm_targets_LoongArch
)
IUSE+="
	+llvm_targets_AArch64
	+llvm_targets_AMDGPU
	+llvm_targets_ARM
	+llvm_targets_AVR
	+llvm_targets_BPF
	+llvm_targets_Hexagon
	+llvm_targets_Lanai
	+llvm_targets_Mips
	+llvm_targets_MSP430
	+llvm_targets_NVPTX
	+llvm_targets_PowerPC
	+llvm_targets_RISCV
	+llvm_targets_SystemZ
	+llvm_targets_Sparc
	+llvm_targets_SPIRV
	+llvm_targets_VE
	+llvm_targets_WebAssembly
	+llvm_targets_X86
	+llvm_targets_XCore
	+llvm_targets_LoongArch
"

REQUIRED_USE+=" ${ALL_LLVM_TARGET_FLAGS[*]}"
RDEPEND="
	llvm_targets_AArch64? ( sys-devel/llvm[llvm_targets_AArch64] )
	llvm_targets_AMDGPU? ( sys-devel/llvm[llvm_targets_AMDGPU] )
	llvm_targets_ARM? ( sys-devel/llvm[llvm_targets_ARM] )
	llvm_targets_AVR? ( sys-devel/llvm[llvm_targets_AVR] )
	llvm_targets_BPF? ( sys-devel/llvm[llvm_targets_BPF] )
	llvm_targets_Hexagon? ( sys-devel/llvm[llvm_targets_Hexagon] )
	llvm_targets_Lanai? ( sys-devel/llvm[llvm_targets_Lanai] )
	llvm_targets_Mips? ( sys-devel/llvm[llvm_targets_Mips] )
	llvm_targets_MSP430? ( sys-devel/llvm[llvm_targets_MSP430] )
	llvm_targets_NVPTX? ( sys-devel/llvm[llvm_targets_NVPTX] )
	llvm_targets_PowerPC? ( sys-devel/llvm[llvm_targets_PowerPC] )
	llvm_targets_RISCV? ( sys-devel/llvm[llvm_targets_RISCV] )
	llvm_targets_SystemZ? ( sys-devel/llvm[llvm_targets_SystemZ] )
	llvm_targets_Sparc? ( sys-devel/llvm[llvm_targets_Sparc] )
	llvm_targets_SPIRV? ( sys-devel/llvm[llvm_targets_SPIRV] )
	llvm_targets_VE? ( sys-devel/llvm[llvm_targets_VE] )
	llvm_targets_WebAssembly? ( sys-devel/llvm[llvm_targets_WebAssembly] )
	llvm_targets_X86? ( sys-devel/llvm[llvm_targets_X86] )
	llvm_targets_XCore? ( sys-devel/llvm[llvm_targets_XCore] )
	llvm_targets_LoongArch? ( sys-devel/llvm[llvm_targets_LoongArch] )
	sys-devel/clang
	sys-devel/lld
	sys-devel/llvm
	!dev-lang/zig-bin
"
DEPEND="${RDEPEND}"
src_configure() {
	local llvm_version=$(clang --version  | grep version  | cut -d' ' -f 4 | cut -d'.' -f1)
	if use clang; then
	  local -x CC=${CHOST}-clang
	  local -x CXX=${CHOST}-clang++
	fi
	einfo "Using LLVM Targets: ${LLVM_TARGETS// /;}"
	local mycmakeargs=(
	  -DZIG_SHARED_LLVM=ON
	  -DCMAKE_INSTALL_PREFIX=/usr
	  -DCMAKE_PREFIX_PATH=/usr
	  -DCMAKE_VERBOSE_MAKEFILE=ON
	  -DZIG_VERSION="${PV}"
	  -DCLANG_INCLUDE_DIRS=/usr/lib/llvm/${llvm_version}/include
	)
	cmake_src_configure
}


# vim: filetype=ebuild
