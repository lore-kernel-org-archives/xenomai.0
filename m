Message-ID: <4F79B863.1010108@domain.hid>
Date: Mon, 02 Apr 2012 16:32:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 2.6] Add regression test for mprotect on
	pinned memory
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This tests both the original issue of mprotect reintroducing COW pages
to Xenomai processes as well as the recently fixed zero page corruption.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 src/testsuite/regression/native/Makefile.am |    2 +-
 src/testsuite/regression/native/Makefile.in |   16 +++-
 src/testsuite/regression/native/mprotect.c  |  128 +++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 4 deletions(-)
 create mode 100644 src/testsuite/regression/native/mprotect.c

diff --git a/src/testsuite/regression/native/Makefile.am b/src/testsuite/regression/native/Makefile.am
index ce53834..afd2f43 100644
--- a/src/testsuite/regression/native/Makefile.am
+++ b/src/testsuite/regression/native/Makefile.am
@@ -2,7 +2,7 @@ tstdir = @XENO_TEST_DIR@/regression/native
 
 noinst_HEADERS = check.h
 
-tst_PROGRAMS = leaks tsc heap sigdebug
+tst_PROGRAMS = leaks tsc heap sigdebug mprotect
 
 CPPFLAGS = $(XENO_USER_CFLAGS) \
 	-I$(top_srcdir)/include
diff --git a/src/testsuite/regression/native/Makefile.in b/src/testsuite/regression/native/Makefile.in
index 3d5a0ce..b2ae93a 100644
--- a/src/testsuite/regression/native/Makefile.in
+++ b/src/testsuite/regression/native/Makefile.in
@@ -37,7 +37,7 @@ build_triplet = @build@
 host_triplet = @host@
 target_triplet = @target@
 tst_PROGRAMS = leaks$(EXEEXT) tsc$(EXEEXT) heap$(EXEEXT) \
-	sigdebug$(EXEEXT)
+	sigdebug$(EXEEXT) mprotect$(EXEEXT)
 subdir = src/testsuite/regression/native
 DIST_COMMON = $(noinst_HEADERS) $(srcdir)/Makefile.am \
 	$(srcdir)/Makefile.in
@@ -70,6 +70,12 @@ leaks_LDADD = $(LDADD)
 leaks_DEPENDENCIES = ../../../skins/native/libnative.la \
 	../../../skins/rtdm/librtdm.la \
 	../../../skins/common/libxenomai.la
+mprotect_SOURCES = mprotect.c
+mprotect_OBJECTS = mprotect.$(OBJEXT)
+mprotect_LDADD = $(LDADD)
+mprotect_DEPENDENCIES = ../../../skins/native/libnative.la \
+	../../../skins/rtdm/librtdm.la \
+	../../../skins/common/libxenomai.la
 sigdebug_SOURCES = sigdebug.c
 sigdebug_OBJECTS = sigdebug.$(OBJEXT)
 sigdebug_LDADD = $(LDADD)
@@ -95,8 +101,8 @@ CCLD = $(CC)
 LINK = $(LIBTOOL) --tag=CC $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) \
 	--mode=link $(CCLD) $(AM_CFLAGS) $(CFLAGS) $(AM_LDFLAGS) \
 	$(LDFLAGS) -o $@
-SOURCES = heap.c leaks.c sigdebug.c tsc.c
-DIST_SOURCES = heap.c leaks.c sigdebug.c tsc.c
+SOURCES = heap.c leaks.c mprotect.c sigdebug.c tsc.c
+DIST_SOURCES = heap.c leaks.c mprotect.c sigdebug.c tsc.c
 HEADERS = $(noinst_HEADERS)
 ETAGS = etags
 CTAGS = ctags
@@ -348,6 +354,9 @@ heap$(EXEEXT): $(heap_OBJECTS) $(heap_DEPENDENCIES)
 leaks$(EXEEXT): $(leaks_OBJECTS) $(leaks_DEPENDENCIES) 
 	@rm -f leaks$(EXEEXT)
 	$(LINK) $(leaks_OBJECTS) $(leaks_LDADD) $(LIBS)
+mprotect$(EXEEXT): $(mprotect_OBJECTS) $(mprotect_DEPENDENCIES) 
+	@rm -f mprotect$(EXEEXT)
+	$(LINK) $(mprotect_OBJECTS) $(mprotect_LDADD) $(LIBS)
 sigdebug$(EXEEXT): $(sigdebug_OBJECTS) $(sigdebug_DEPENDENCIES) 
 	@rm -f sigdebug$(EXEEXT)
 	$(LINK) $(sigdebug_OBJECTS) $(sigdebug_LDADD) $(LIBS)
@@ -363,6 +372,7 @@ distclean-compile:
 
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
+@AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
 
diff --git a/src/testsuite/regression/native/mprotect.c b/src/testsuite/regression/native/mprotect.c
new file mode 100644
index 0000000..7d66e34
--- /dev/null
+++ b/src/testsuite/regression/native/mprotect.c
@@ -0,0 +1,128 @@
+/*
+ * Test if implicit pinning of memory via mprotect works.
+ *
+ * Copyright (C) Jan Kiszka  <jan.kiszka@domain.hid>
+ *
+ * Released under the terms of GPLv2.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <rtdk.h>
+#include <native/task.h>
+
+#define MEMSIZE 0x10000
+
+static void check_inner(const char *fn, int line, const char *msg,
+			int status, int expected)
+{
+	if (status == expected)
+		return;
+
+	rt_task_set_mode(T_WARNSW, 0, NULL);
+	rt_print_flush_buffers();
+	fprintf(stderr, "FAILURE %s:%d: %s returned %d instead of %d - %s\n",
+		fn, line, msg, status, expected, strerror(-status));
+	exit(EXIT_FAILURE);
+}
+
+#define check_no_error(msg, status) ({					\
+	int __status = status;						\
+	check_inner(__FUNCTION__, __LINE__, msg,			\
+		    __status < 0 ? __status : 0, 0);			\
+	__status;							\
+})
+
+static void check_value_inner(const char *fn, int line, const char *msg,
+			      int value, int expected)
+{
+	if (value == expected)
+		return;
+
+	rt_task_set_mode(T_WARNSW, 0, NULL);
+	rt_print_flush_buffers();
+	fprintf(stderr,
+		"FAILURE %s:%d: %s returned %u instead of %u\n",
+		fn, line, msg, value, expected);
+	exit(EXIT_FAILURE);
+}
+
+#define check_value(msg, value, expected) do {				\
+	int __value = value;						\
+	check_value_inner(__FUNCTION__, __LINE__, msg, __value, 	\
+			  expected);					\
+} while (0)
+
+void sigdebug_handler(int sig, siginfo_t *si, void *context)
+{
+	unsigned int reason = si->si_value.sival_int;
+
+	rt_print_flush_buffers();
+	fprintf(stderr, "FAILURE: sigdebug_handler triggered, reason %d\n",
+		reason);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned char *zero_mem, *test1_mem, *test2_mem;
+	RT_TASK main_task;
+	struct sigaction sa;
+	int err;
+
+	rt_print_auto_init(1);
+
+	errno = 0;
+	zero_mem = mmap(0, MEMSIZE, PROT_READ,
+			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	check_no_error("mmap", -errno);
+	test1_mem = mmap(0, MEMSIZE, PROT_READ,
+			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	check_no_error("mmap", -errno);
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_sigaction = sigdebug_handler;
+	sa.sa_flags = SA_SIGINFO;
+	sigaction(SIGDEBUG, &sa, NULL);
+
+	mlockall(MCL_CURRENT | MCL_FUTURE);
+
+	err = rt_task_shadow(&main_task, "main_task", 1, T_WARNSW);
+	check_no_error("rt_task_shadow", err);
+
+	rt_printf("memory read\n");
+	check_value("read mem", test1_mem[0], 0);
+
+	rt_task_set_mode(T_WARNSW, 0, NULL);
+	errno = 0;
+	test2_mem = mmap(0, MEMSIZE, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	check_no_error("mmap", -errno);
+	mprotect(test2_mem, MEMSIZE, PROT_READ | PROT_WRITE | PROT_EXEC);
+	check_no_error("mprotect", -errno);
+
+	rt_task_sleep(0);
+	rt_task_set_mode(0, T_WARNSW, NULL);
+
+	rt_printf("memory write after exec enable\n");
+	test2_mem[0] = 0xff;
+
+	rt_task_set_mode(T_WARNSW, 0, NULL);
+	err = mprotect(test1_mem, MEMSIZE, PROT_READ | PROT_WRITE);
+	check_no_error("mprotect", err);
+
+	rt_task_sleep(0);
+	rt_task_set_mode(0, T_WARNSW, NULL);
+
+	rt_printf("memory write after write enable\n");
+	test1_mem[0] = 0xff;
+	check_value("read zero", zero_mem[0], 0);
+
+	rt_task_set_mode(T_WARNSW, 0, NULL);
+	rt_print_flush_buffers();
+	fprintf(stderr, "Test OK\n");
+
+	return 0;
+}
-- 
1.7.3.4

