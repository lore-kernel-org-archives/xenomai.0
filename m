Message-ID: <48AEBA77.2040608@domain.hid>
Date: Fri, 22 Aug 2008 15:09:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] userspace: Make CONFIG_SMP default
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Disabling SMP (on platforms where this isn't off by design already) is
an optimization. In contrast, not enabling it by default is doomed to
cause problems for users that run ./configure without looking into each
and every switch - now that CONFIG_SMP is very important for all the
fast locking stuff. Or would the feature check prevent that Xenomai
threads of a non-SMP application are scheduled on multiple CPUs?

However, to improve user experience, let's invert the default.

---
 ChangeLog      |    4 ++++
 README.INSTALL |    2 +-
 configure.in   |    6 +++---
 3 files changed, 8 insertions(+), 4 deletions(-)

Index: b/ChangeLog
===================================================================
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2008-08-22  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* configure.in: Enable SMP support by default.
+
 2008-08-21  Philippe Gerum  <rpm@xenomai.org>
 
 	* ksrc/nucleus/pipe.c (xnpipe_write): Fix inverted O_SYNC
Index: b/configure.in
===================================================================
--- a/configure.in
+++ b/configure.in
@@ -131,12 +131,12 @@ AC_ARG_ENABLE(debug,
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

