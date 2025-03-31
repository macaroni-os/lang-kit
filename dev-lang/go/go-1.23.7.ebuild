# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=""
SRC_URI="
https://go.dev/dl/go1.23.7.src.tar.gz -> go1.23.7.src.tar.gz
amd64? ( https://go.dev/dl/go1.23.7.linux-amd64.tar.gz -> go1.23.7-bootstrap.linux-amd64.tar.gz )
arm64? ( https://go.dev/dl/go1.23.7.linux-arm64.tar.gz -> go1.23.7-bootstrap.linux-arm64.tar.gz )
armv6? ( https://go.dev/dl/go1.23.7.linux-armv6l.tar.gz -> go1.23.7-bootstrap.linux-armv6l.tar.gz )"
SLOT="0"
KEYWORDS="*"

# vim: filetype=ebuild
