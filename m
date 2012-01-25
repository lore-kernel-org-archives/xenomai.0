Message-ID: <4F202C11.70908@domain.hid>
Date: Wed, 25 Jan 2012 17:21:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Add sigdebug unit test
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

We had two regressions in this code recently. So test all 6 possible
SIGDEBUG reasons, or 5 if the watchdog is not available.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 src/testsuite/unit/Makefile.am |   16 +++-
 src/testsuite/unit/sigdebug.c  |  233 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 248 insertions(+), 1 deletions(-)
 create mode 100644 src/testsuite/unit/sigdebug.c

diff --git a/src/testsuite/unit/Makefile.am b/src/testsuite/unit/Makefile.am
index 1bf5d8d..6e8203d 100644
--- a/src/testsuite/unit/Makefile.am
+++ b/src/testsuite/unit/Makefile.am
@@ -11,7 +11,8 @@ test_PROGRAMS = \
 	cond-torture-posix \
 	cond-torture-native \
 	check-vdso \
-	rtdm
+	rtdm \
+	sigdebug
 
 arith_SOURCES = arith.c arith-noinline.c arith-noinline.h
 
@@ -119,3 +120,16 @@ rtdm_LDADD = \
 	../../skins/native/libnative.la \
 	../../skins/common/libxenomai.la \
 	-lpthread -lrt -lm
+
+sigdebug_SOURCES = sigdebug.c
+
+sigdebug_CPPFLAGS = \
+	@XENO_USER_CFLAGS@ \
+	-I$(top_srcdir)/include
+
+sigdebug_LDFLAGS = @XENO_USER_LDFLAGS@
+
+sigdebug_LDADD = \
+	../../skins/native/libnative.la \
+	../../skins/common/libxenomai.la \
+	-lpthread -lm
diff --git a/src/testsuite/unit/sigdebug.c b/src/testsuite/unit/sigdebug.c
new file mode 100644
index 0000000..57d9beb
--- /dev/null
+++ b/src/testsuite/unit/sigdebug.c
@@ -0,0 +1,233 @@
+/*
+ * Functional testing of unwanted domain switch debugging mechanism.
+ *
+ * Copyright (C) Jan Kiszka  <jan.kiszka@domain.hid>
+ *
+ * Released under the terms of GPLv2.
+ */
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <pthread.h>
+#include <rtdk.h>
+#include <native/task.h>
+#include <native/mutex.h>
+#include <native/sem.h>
+#include <native/timer.h>
+
+#define WRITE_TEST_SIZE		(4*1024)
+
+unsigned int expected_reason;
+bool sigdebug_received;
+pthread_t rt_task_thread;
+RT_MUTEX prio_invert;
+RT_SEM send_signal;
+char *mem;
+FILE *wd;
+
+static void setup_checkdebug(unsigned int reason)
+{
+	sigdebug_received = false;
+	expected_reason = reason;
+}
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
+static void check_sigdebug_inner(const char *fn, int line, const char *reason)
+{
+	if (sigdebug_received)
+		return;
+
+	rt_task_set_mode(T_WARNSW, 0, NULL);
+	rt_print_flush_buffers();
+	fprintf(stderr, "FAILURE %s:%d: no %s received\n", fn, line, reason);
+	exit(EXIT_FAILURE);
+}
+
+#define check(msg, status, expected) ({					\
+	int __status = status;						\
+	check_inner(__FUNCTION__, __LINE__, msg, __status, expected);	\
+	__status;							\
+})
+
+#define check_no_error(msg, status) ({					\
+	int __status = status;						\
+	check_inner(__FUNCTION__, __LINE__, msg,			\
+		    __status < 0 ? __status : 0, 0);			\
+	__status;							\
+})
+
+#define check_sigdebug_received(reason) do {				\
+	const char *__reason = reason;					\
+	check_sigdebug_inner(__FUNCTION__, __LINE__, __reason);		\
+} while (0)
+
+void rt_task_body(void *cookie)
+{
+	RTIME end;
+	int err;
+
+	rt_task_thread = pthread_self();
+
+	rt_printf("syscall\n");
+	setup_checkdebug(SIGDEBUG_MIGRATE_SYSCALL);
+	syscall(-1);
+	check_sigdebug_received("SIGDEBUG_MIGRATE_SYSCALL");
+
+	rt_printf("signal\n");
+	setup_checkdebug(SIGDEBUG_MIGRATE_SIGNAL);
+	err = rt_sem_v(&send_signal);
+	check_no_error("rt_sem_v", err);
+	rt_task_sleep(10000000LL);
+	check_sigdebug_received("SIGDEBUG_MIGRATE_SIGNAL");
+
+	rt_printf("relaxed mutex owner\n");
+	setup_checkdebug(SIGDEBUG_MIGRATE_PRIOINV);
+	err = rt_mutex_acquire(&prio_invert, TM_INFINITE);
+	check("rt_mutex_acquire", err, -EINTR);
+	check_sigdebug_received("SIGDEBUG_MIGRATE_PRIOINV");
+
+
+	rt_printf("page fault\n");
+	setup_checkdebug(SIGDEBUG_MIGRATE_FAULT);
+	rt_task_sleep(0);
+	*mem ^= 0xFF;
+	check_sigdebug_received("SIGDEBUG_MIGRATE_FAULT");
+
+	if (wd) {
+		rt_printf("watchdog\n");
+		rt_print_flush_buffers();
+		setup_checkdebug(SIGDEBUG_WATCHDOG);
+		end = rt_timer_tsc() + rt_timer_ns2tsc(2100000000ULL);
+		rt_task_sleep(0);
+		while (rt_timer_tsc() < end && !sigdebug_received)
+			/* busy loop */;
+		check_sigdebug_received("SIGDEBUG_WATCHDOG");
+	} else
+		rt_printf("note: watchdog not available\n");
+}
+
+void sigdebug_handler(int sig, siginfo_t *si, void *context)
+{
+	unsigned int reason = si->si_value.sival_int;
+
+	if (reason != expected_reason) {
+		rt_print_flush_buffers();
+		fprintf(stderr, "FAILURE: sigdebug_handler expected reason %d,"
+			" received %d\n", expected_reason, reason);
+		exit(EXIT_FAILURE);
+	}
+	sigdebug_received = true;
+}
+
+void dummy_handler(int sig, siginfo_t *si, void *context)
+{
+}
+
+int main(int argc, char **argv)
+{
+	char tempname[] = "/tmp/sigdebug-XXXXXX";
+	RT_TASK main_task, rt_task;
+	struct sigaction sa;
+	int old_wd_value;
+	int tmp_fd;
+	int err;
+
+	rt_print_auto_init(1);
+
+	wd = fopen("/sys/module/xeno_nucleus/parameters/watchdog_timeout",
+		   "w+");
+	if (wd) {
+		err = fscanf(wd, "%d", &old_wd_value);
+		check("get watchdog", err, 1);
+		err = fprintf(wd, "2");
+		check("set watchdog", err, 1);
+		fflush(wd);
+	}
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_sigaction = sigdebug_handler;
+	sa.sa_flags = SA_SIGINFO;
+	sigaction(SIGDEBUG, &sa, NULL);
+
+	sa.sa_sigaction = dummy_handler;
+	sigaction(SIGUSR1, &sa, NULL);
+
+	printf("mlockall\n");
+	setup_checkdebug(SIGDEBUG_NOMLOCK);
+	err = rt_task_shadow(&main_task, "main_task", 0, 0);
+	check("rt_task_shadow", err, -EINTR);
+	check_sigdebug_received("SIGDEBUG_NOMLOCK");
+
+	mlockall(MCL_CURRENT | MCL_FUTURE);
+
+	errno = 0;
+	tmp_fd = mkstemp(tempname);
+	check_no_error("mkstemp", -errno);
+	unlink(tempname);
+	check_no_error("unlink", -errno);
+	mem = mmap(NULL, 1, PROT_READ | PROT_WRITE, MAP_SHARED, tmp_fd, 0);
+	check_no_error("mmap", -errno);
+	err = write(tmp_fd, "X", 1);
+	check("write", err, 1);
+
+	err = rt_task_shadow(&main_task, "main_task", 0, 0);
+	check_no_error("rt_task_shadow", err);
+
+	err = rt_mutex_create(&prio_invert, "prio_invert");
+	check_no_error("rt_mutex_create", err);
+
+	err = rt_mutex_acquire(&prio_invert, TM_INFINITE);
+	check_no_error("rt_mutex_acquire", err);
+
+	err = rt_sem_create(&send_signal, "send_signal", 0, S_PRIO);
+	check_no_error("rt_sem_create", err);
+
+	err = rt_task_spawn(&rt_task, "rt_task", 0, 1, T_WARNSW | T_JOINABLE,
+			    rt_task_body, NULL);
+	check_no_error("rt_task_spawn", err);
+
+	err = rt_sem_p(&send_signal, TM_INFINITE);
+	check_no_error("rt_sem_signal", err);
+	pthread_kill(rt_task_thread, SIGUSR1);
+
+	rt_task_sleep(20000000);
+
+	err = rt_mutex_release(&prio_invert);
+	check_no_error("rt_mutex_release", err);
+
+	err = rt_task_join(&rt_task);
+	check_no_error("rt_task_join", err);
+
+	err = rt_mutex_delete(&prio_invert);
+	check_no_error("rt_mutex_delete", err);
+
+	err = rt_sem_delete(&send_signal);
+	check_no_error("rt_sem_delete", err);
+
+	if (wd) {
+		fprintf(wd, "%d", old_wd_value);
+		fclose(wd);
+	}
+
+	fprintf(stderr, "Test OK\n");
+
+	return 0;
+}
-- 
1.7.3.4

