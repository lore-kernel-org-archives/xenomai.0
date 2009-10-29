Message-ID: <4AE97D76.4080804@domain.hid>
Date: Thu, 29 Oct 2009 12:33:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AE9711A.6030904@domain.hid>
In-Reply-To: <4AE9711A.6030904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2] build system: Fix shared libs generation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>, Gernot Hillier <gernot.hillier@domain.hid>

This fixes a regression of dbbd33f50d: There must be no
AC_DISABLE_SHARED without AS_ENABLE_SHARED for the cases where it shall
remain enabled.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 configure.in |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

v2: properly rebased against head

diff --git a/configure.in b/configure.in
index 40683fe..9cce885 100644
--- a/configure.in
+++ b/configure.in
@@ -117,7 +117,6 @@ case "$build_for" in
         XENO_LINUX_ARCH=nios2
 	XENO_LINUX_INSTALL_TARGET=install
 	CONFIG_XENO_DEFAULT_PERIOD=10000000
-	AC_DISABLE_SHARED
         ;;
  *) echo ""
    echo "*******************************************"
@@ -128,9 +127,18 @@ case "$build_for" in
 esac
 
 AC_MSG_RESULT([$XENO_TARGET_ARCH])
-AC_PROG_LIBTOOL
 AM_CONDITIONAL(XENO_LINUX_ARCH_I386,[test $XENO_LINUX_ARCH = i386])
 
+case "$XENO_TARGET_ARCH" in
+ nios2)
+	AC_DISABLE_SHARED
+	;;
+ *)
+	AC_ENABLE_SHARED
+	;;
+esac
+AC_PROG_LIBTOOL
+
 dnl
 dnl Parse options
 dnl
-- 
1.6.0.2

