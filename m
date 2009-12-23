From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Wed, 23 Dec 2009 10:25:52 +0100
Message-Id: <1261560352-9120-3-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1261560352-9120-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1261560352-9120-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 2/2] Testcase for the xnvdso mechanism
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

This testcase checks if the value in xnvdso->features matches the
value of XNVDSO_FEATURES, that is, if the information is correctly
transferred from kernel to userland.

Notice that the approach will fail once configurations are supported
that know of multiple features and implement only some of them.
In this case, the testcase needs to be extended accordingly
to check that only the expected features are present.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 src/testsuite/unit/Makefile.am |   15 +++++++++++++-
 src/testsuite/unit/runinfo.in  |    1 +
 src/testsuite/unit/xnvdso.c    |   43 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletions(-)
 create mode 100644 src/testsuite/unit/xnvdso.c

diff --git a/src/testsuite/unit/Makefile.am b/src/testsuite/unit/Makefile.am
index 24d077a..c77cc54 100644
--- a/src/testsuite/unit/Makefile.am
+++ b/src/testsuite/unit/Makefile.am
@@ -2,7 +2,8 @@ testdir = $(exec_prefix)/share/xenomai/testsuite/unit
 
 CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 
-bin_PROGRAMS = arith wakeup-time mutex-torture-posix mutex-torture-native
+bin_PROGRAMS = arith wakeup-time mutex-torture-posix mutex-torture-native \
+               xnvdso
 
 arith_SOURCES = arith.c arith-noinline.c arith-noinline.h
 
@@ -53,6 +54,18 @@ mutex_torture_native_LDADD = \
 	../../skins/native/libnative.la \
 	-lpthread -lm
 
+xnvdso_SOURCES = xnvdso.c
+
+xnvdso_CPPFLAGS = \
+	@XENO_USER_CFLAGS@ \
+	-I$(top_srcdir)/include
+
+xnvdso_LDFLAGS = @XENO_USER_LDFLAGS@
+
+xnvdso_LDADD = \
+	../../skins/native/libnative.la \
+	-lpthread -lm
+
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DESTDIR)$(testdir)/.runinfo
diff --git a/src/testsuite/unit/runinfo.in b/src/testsuite/unit/runinfo.in
index f4cd208..a22afc0 100644
--- a/src/testsuite/unit/runinfo.in
+++ b/src/testsuite/unit/runinfo.in
@@ -2,3 +2,4 @@ arith:native:!@exec_prefix@domain.hid
 wakeup-time:native:!@exec_prefix@domain.hid
 mutex-torture-posix:posix:!@exec_prefix@domain.hid
 mutex-torture-native:native:!@exec_prefix@domain.hid
+xnvdso:native:!@exec_prefix@domain.hid
diff --git a/src/testsuite/unit/xnvdso.c b/src/testsuite/unit/xnvdso.c
new file mode 100644
index 0000000..6d7d8e1
--- /dev/null
+++ b/src/testsuite/unit/xnvdso.c
@@ -0,0 +1,43 @@
+/*
+ * VDSO feature set testcase
+ * by Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
+ */
+
+#include <stdio.h>
+#include <asm/xenomai/syscall.h>
+#include <nucleus/xnvdso.h>
+
+extern unsigned long xeno_sem_heap[2];
+
+int main(int argc, char **argv)
+{
+	int err;
+	xnsysinfo_t sysinfo;
+	struct xnvdso *xnvdso;
+
+	if (!xeno_sem_heap[1]) {
+		fprintf(stderr, "Could not determine position of the "
+			"global semaphore heap\n");
+		return 1;
+	}
+
+	/* The muxid is irrelevant for this test as long as it's valid */
+	err = XENOMAI_SYSCALL2(__xn_sys_info, 1, &sysinfo);
+	if (err < 0) {
+		fprintf(stderr, "sys_sys_info failed: %d\n", err);
+		return 1;
+	}
+
+	printf("Address of the global semaphore heap: 0x%lx\n",
+	       xeno_sem_heap[1]);
+	printf("Offset of xnvdso: %lu\n", sysinfo.xnvdso_off);
+
+	xnvdso = (struct xnvdso *)(xeno_sem_heap[1] + sysinfo.xnvdso_off);
+	printf("Contents of the features flag: %llu\n", xnvdso->features);
+
+	if (xnvdso->features == XNVDSO_FEATURES)
+		return 0;
+
+	fprintf(stderr, "error: xnvdso->features != XNVDSO_FEATURES\n");
+	return 1;
+}
-- 
1.6.4


