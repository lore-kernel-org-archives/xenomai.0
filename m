Message-ID: <4B31EADB.8040305@domain.hid>
Date: Wed, 23 Dec 2009 11:03:07 +0100
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <1261560352-9120-1-git-send-email-wolfgang.mauerer@domain.hid>
	<1261560352-9120-3-git-send-email-wolfgang.mauerer@domain.hid>
	<4B31E503.8030208@domain.hid>
In-Reply-To: <4B31E503.8030208@domain.hid>
Content-Type: multipart/mixed; boundary="------------000107050509090700080008"
Subject: Re: [Xenomai-core] [PATCH 2/2] Testcase for the xnvdso mechanism
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------000107050509090700080008
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Wolfgang Mauerer wrote:
>> This testcase checks if the value in xnvdso->features matches the
>> value of XNVDSO_FEATURES, that is, if the information is correctly
>> transferred from kernel to userland.
>>
>> Notice that the approach will fail once configurations are supported
>> that know of multiple features and implement only some of them.
>> In this case, the testcase needs to be extended accordingly
>> to check that only the expected features are present.
> 
> Please allow to pass the value we want to check on the test command line.

here you go. I suppose keeping XNVDSO_FEATURES as default value
unless something different is specified is okay?

Cheers,

Wolfgang

--------------000107050509090700080008
Content-Type: text/x-patch;
 name="testcase.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="testcase.diff"

commit 0f31dc5c50f7034dddbac67c22e53823f1be72d3
Author: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date:   Tue Dec 22 23:11:31 2009 +0100

    Testcase for the xnvdso mechanism
    
    This testcase checks if the value in xnvdso->features matches the
    feature set specified on the command line. When no explicit
    feature test set is given, XNVDSO_FEATURES (i.e., the set
    of all features known to the current Xenomai revision) is used.
    
    Notice that the default approach will naturally fail once
    configurations are supported that know of multiple features and
    implement only some of them.
    
    Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
    Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

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
index 0000000..69305c2
--- /dev/null
+++ b/src/testsuite/unit/xnvdso.c
@@ -0,0 +1,52 @@
+/*
+ * VDSO feature set testcase
+ * by Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
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
+	unsigned long long test_features;
+
+	if (argc != 2) {
+		printf("No specific feature(s) given, using XNVDSO_FEATURE\n");
+		test_features = XNVDSO_FEATURES;
+	} else {
+		test_features = strtoull(argv[1], NULL, 0);
+	}
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
+	if (xnvdso->features == test_features)
+		return 0;
+
+	fprintf(stderr, "error: xnvdso->features != %llu\n", test_features);
+	return 1;
+}

--------------000107050509090700080008--

