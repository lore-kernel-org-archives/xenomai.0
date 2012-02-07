Message-ID: <4F3146AA.5070902@domain.hid>
Date: Tue, 07 Feb 2012 16:43:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH forge] Fix build for relative invocations of
	configure
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This fixes build setups like '../configure'.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 configure.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.in b/configure.in
index c0a7d17..0bdced8 100644
--- a/configure.in
+++ b/configure.in
@@ -547,7 +547,7 @@ LD_FILE_OPTION=$ac_cv_ld_file_option
 AC_SUBST(LD_FILE_OPTION)
 
 if test x$rtcore_type = xcobalt; then
-   XENO_USER_CFLAGS="-I$srcdir/include/cobalt $XENO_USER_CFLAGS"
+   XENO_USER_CFLAGS="-I`cd $srcdir && pwd`/include/cobalt $XENO_USER_CFLAGS"
    if [[ $ac_cv_ld_file_option = yes ]]; then
 	XENO_POSIX_WRAPPERS="-Wl,@`cd $srcdir && pwd`/lib/cobalt/posix.wrappers"
    else
-- 
1.7.3.4

