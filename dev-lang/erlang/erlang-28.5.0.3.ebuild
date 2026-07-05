# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic java-pkg-opt-2 systemd user toolchain-funcs wxwidgets

DESCRIPTION="Erlang/OTP"
HOMEPAGE="http://erlang.org"
SRC_URI="
https://github.com/erlang/otp/releases/download/OTP-28.5.0.3/otp_src_28.5.0.3.tar.gz -> erlang-28.5.0.3.tar.gz
https://github.com/erlang/otp/releases/download/OTP-28.5.0.3/otp_doc_man_28.5.0.3.tar.gz -> erlang-28.5.0.3-doc-man.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="java +kpoll odbc sctp ssl systemd tk wxwidgets"
# Commons depends
CDEPEND="sys-libs/ncurses:0
	sys-libs/zlib
	java? (
	  virtual/jdk:*
	)
	odbc? (
	  dev-db/unixODBC
	)
	sctp? (
	  net-misc/lksctp-tools
	)
	ssl? (
	  dev-libs/openssl:=
	)
	wxwidgets? (
	  dev-libs/glib
	  x11-libs/wxGTK:3.2-gtk3[X,opengl]
	)
	systemd? (
	  sys-apps/systemd
	)
	
"
RDEPEND="${CDEPEND}
"
DEPEND="${CDEPEND}
	dev-lang/perl
	
"
S="${WORKDIR}/otp_src_28.5.0.3"
src_prepare() {
	default
	tc-export AR CPP CXX LD
	append-flags -fno-strict-aliasing
	 ./otp_build autoconf || die
}
src_configure() {
	use wxwidgets && setup-wxwidgets
	 local myconf=(
	  --disable-builtin-zlib
	  --with-ssl-zlib=no
	   $(use_enable kpoll kernel-poll)
	  $(use_with java javac)
	  $(use_with odbc)
	  $(use_enable sctp)
	  $(use_with ssl ssl "/usr")
	  $(use_enable ssl dynamic-ssl-lib)
	  $(usex wxwidgets "--with-wx-config=${WX_CONFIG}" "--with-wxdir=/dev/null")
	)
	econf "${myconf[@]}"
}
src_compile() {
	emake
}
extract_version() {
	local path="$1"
	local var_name="$2"
	sed -n -e "/^${var_name} = \(.*\)$/s::\1:p" "${S}/${path}/vsn.mk" || die "extract_version() failed"
}
src_install() {
	local erl_libdir_rel="$(get_libdir)/erlang"
	local erl_libdir="/usr/${erl_libdir_rel}"
	local erl_interface_ver="$(extract_version lib/erl_interface EI_VSN)"
	local erl_erts_ver="$(extract_version erts VSN)"
	local my_manpath="/usr/share/${PN}/man"
	 [[ -z "${erl_erts_ver}" ]] && die "Couldn't determine erts version"
	[[ -z "${erl_interface_ver}" ]] && die "Couldn't determine interface version"
	 emake INSTALL_PREFIX="${D}" install
	 local DOCS=("README.md")
	einstalldocs
	 dosym "../${erl_libdir_rel}/bin/erl" /usr/bin/erl
	dosym "../${erl_libdir_rel}/bin/erlc" /usr/bin/erlc
	dosym "../${erl_libdir_rel}/bin/escript" /usr/bin/escript
	dosym "../${erl_libdir_rel}/lib/erl_interface-${erl_interface_ver}/bin/erl_call" /usr/bin/erl_call
	dosym "../${erl_libdir_rel}/erts-${erl_erts_ver}/bin/beam.smp" /usr/bin/beam.smp
	 ## Clean up the no longer needed files
	rm "${ED}/${erl_libdir}/Install" || die
	 insinto "${my_manpath}"
	doins -r "${WORKDIR}"/man/*
	newenvd "${FILESDIR}/90erlang.envd" "90erlang"
	 if use systemd ; then
	  systemd_newunit "${FILESDIR}"/epmd.service-r1 epmd.service
	else
	  newinitd "${FILESDIR}"/epmd.init-r2 epmd
	fi
	newconfd "${FILESDIR}"/epmd.confd-r2 epmd
}
pkg_preinst() {
	enewgroup epmd 335
	enewuser epmd 335 -1 /dev/null epmd
}


# vim: filetype=ebuild
