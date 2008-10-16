Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F764A5.4080406@domain.hid>
Message-Id: <20081016154622.273542440@domain.hid>
Date: Thu, 16 Oct 2008 17:46:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081016154620.320953568@domain.hid>
Content-Disposition: inline; filename=make-smp-default.patch
Subject: [Xenomai-core] [PATCH 12/12] Enable SMP support for user libs by
	default
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

With fast xnsynch/mutex support in place, the importance of getting the
user space library configuration right increases significantly. If the
user fails to provide --enable-smp, (s)he risks to break the mutex fast
path in a very subtle way. Thus, it is better to assume SMP by default
(as far as the arch bothers at all) and let the user switch it off for
intentional optimization for UP-only targets.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 README.INSTALL |    2 +-
 configure.in   |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: b/configure.in
===================================================================
--- a/configure.in
+++ b/configure.in
@@ -132,12 +132,12 @@ AC_ARG_ENABLE(debug,
 	esac])
 AC_MSG_RESULT(${debug_symbols:-no})
 
-dnl SMP support (default: off)
+dnl SMP support (default: on)
 
-CONFIG_SMP=
+CONFIG_SMP=y
 AC_MSG_CHECKING(for SMP support)
 AC_ARG_ENABLE(smp,
-	AS_HELP_STRING([--enable-smp], [Enable SMP support]),
+	AS_HELP_STRING([--disable-smp], [Disable SMP support (if the target supports it at all)]),
 	[case "$enableval" in
 	y | yes) CONFIG_SMP=y ;;
 	*) unset CONFIG_SMP ;;
Index: b/README.INSTALL
===================================================================
--- a/README.INSTALL
+++ b/README.INSTALL
@@ -143,7 +143,7 @@ NAME                 DESCRIPTION
 
 --prefix             Installation directory          /usr/xenomai
 --enable-debug       Enable debug symbols (-g)       disabled
---enable-smp         Enable SMP support              weak,disabled
+--disable-smp        Disable SMP support             weak,enabled
 
 1.3.3 Arch-specific configure options
 -------------------------------------


