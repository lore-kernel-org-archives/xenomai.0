From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH 7/7] testsuite/smokey: gdb-based debugging test
Date: Fri, 30 Nov 2018 21:03:21 +0100
Message-Id: <d9b29081c142596641391fe25ad9df4f3623416d.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Add a test case for advanced gdb-based debugging of real-time processes.
It currently checks three aspects:
 - Do we resume an RT thread in primary mode after hitting a breakpoint
   in that mode?
 - Do we stop all RT threads immediately when one process thread hits a
   breakpoint?
 - Do we resume all threads then synchronously (at when running on the
   same CPU) when the program continues?

The test first forks a gdb instance that will start the test application
again, but with different command line options so that the second run
executes the inner test logic. The original instance controls gdb via
local pipes and evaluates the debugger output.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac                     |   1 +
 testsuite/smokey/Makefile.am     |   1 +
 testsuite/smokey/gdb/Makefile.am |  13 ++
 testsuite/smokey/gdb/gdb.c       | 310 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 325 insertions(+)
 create mode 100644 testsuite/smokey/gdb/Makefile.am
 create mode 100644 testsuite/smokey/gdb/gdb.c

diff --git a/configure.ac b/configure.ac
index e2a2d47cfa..0aa46a2e5e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -973,6 +973,7 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/net_packet_raw/Makefile \
 	testsuite/smokey/net_common/Makefile \
 	testsuite/smokey/cpu-affinity/Makefile \
+	testsuite/smokey/gdb/Makefile \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
 	utils/Makefile \
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index 4faf55b0ba..b35b00d82d 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -14,6 +14,7 @@ COBALT_SUBDIRS = 	\
 	bufp		\
 	cpu-affinity	\
 	fpu-stress	\
+	gdb		\
 	iddp		\
 	leaks		\
 	memory-coreheap	\
diff --git a/testsuite/smokey/gdb/Makefile.am b/testsuite/smokey/gdb/Makefile.am
new file mode 100644
index 0000000000..987d6ee2d5
--- /dev/null
+++ b/testsuite/smokey/gdb/Makefile.am
@@ -0,0 +1,13 @@
+
+noinst_LIBRARIES = libgdb.a
+
+libgdb_a_SOURCES = gdb.c
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+libgdb_a_CPPFLAGS = 		\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)		\
+	-I$(top_srcdir)/include
+
+libgdb_a_CXXFLAGS = -g -O0
diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
new file mode 100644
index 0000000000..a0308d9b2e
--- /dev/null
+++ b/testsuite/smokey/gdb/gdb.c
@@ -0,0 +1,310 @@
+/*
+ * gdb test.
+ *
+ * Copyright (C) Siemens AG, 2015
+ *
+ * Authors.
+ *  Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * Released under the terms of GPLv2.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <error.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <semaphore.h>
+#include <sys/wait.h>
+#include <xeno_config.h>
+#include <boilerplate/libc.h>
+#include <smokey/smokey.h>
+#include "lib/cobalt/current.h"
+
+static void send_command(const char *string, int wait_for_prompt);
+
+static void check_inner(const char *fn, int line, const char *msg,
+			int status, int expected, int exp_flag)
+{
+	if (exp_flag) {
+		if (status == expected)
+			return;
+	}
+	else if (status != -1)
+			return;
+
+	rt_print_flush_buffers();
+	if (exp_flag)
+		fprintf(stderr, "FAILURE %s:%d: %s returned %d instead of %d - %s\n",
+				fn, line, msg, status, expected, strerror(status));
+	else
+		fprintf(stderr, "FAILURE %s:%d: %s returned %d [errno=%d] - %s\n",
+				fn, line, msg, status, expected, strerror(expected));
+	send_command("q\n", 0);
+	exit(EXIT_FAILURE);
+}
+
+#define check(msg, status, expected) ({					\
+int __status = status;						\
+check_inner(__FUNCTION__, __LINE__, msg, __status, expected, 1);	\
+__status;							\
+})
+
+#define check_no_error(msg, status) ({					\
+int __status = status;						\
+check_inner(__FUNCTION__, __LINE__, msg,			\
+__status < 0 ? errno : __status, 0, 1);			\
+__status;							\
+})
+
+smokey_test_plugin(gdb,
+		   SMOKEY_ARGLIST(
+			   SMOKEY_BOOL(run_target),
+		   ),
+		   "Check gdb-based debugging of application."
+);
+
+#ifdef HAVE_FORK
+#define do_fork fork
+#else
+#define do_fork vfork
+#endif
+
+static int pipe_in[2], pipe_out[2];
+static volatile unsigned long long thread_loops, expected_loops;
+static volatile int primary_mode;
+static volatile int terminate;
+static int child_terminated;
+static sem_t kickoff_lo;
+
+static void handle_sigchld(int signum)
+{
+	int status;
+
+	wait(&status);
+	check("gdb execution", WEXITSTATUS(status), 0);
+	child_terminated = 1;
+}
+
+static void wait_for_pattern(const char *string)
+{
+	const char *match = string;
+	char c;
+
+	while (*match != 0 && read(pipe_out[0], &c, 1) == 1) {
+		if (*match == c)
+			match++;
+		else
+			match = string;
+		if (smokey_verbose_mode > 2)
+			putc(c, stdout);
+	}
+}
+
+static void send_command(const char *string, int wait_for_prompt)
+{
+	write(pipe_in[1], string, strlen(string));
+	if (wait_for_prompt)
+		wait_for_pattern("(gdb) ");
+}
+
+static void check_output(const char *fn, int line, const char *expression,
+			 const char *pattern)
+{
+	char *read_string = malloc(strlen(pattern) + 1);
+	const char *match = pattern;
+	int pos = 0;
+
+	while (*match != 0 && read(pipe_out[0], &read_string[pos], 1) == 1) {
+		if (*match != read_string[pos]) {
+			rt_print_flush_buffers();
+			read_string[pos + 1] = 0;
+			fprintf(stderr, "FAILURE %s:%d: checking expression "
+				"\"%s\", expected \"%s\", found \"%s\"\n",
+				fn, line, expression, pattern, read_string);
+			send_command("q\n", 0);
+			exit(EXIT_FAILURE);
+		}
+		if (smokey_verbose_mode > 2)
+			putc(read_string[pos], stdout);
+		match++;
+		pos++;
+	}
+	free(read_string);
+}
+
+#define eval_expression(expression, expected_value)			\
+	eval_expression_inner(__FUNCTION__, __LINE__, expression,	\
+			      expected_value)
+
+static void eval_expression_inner(const char *fn, int line,
+				  const char *expression,
+				  const char *expected_value)
+{
+	write(pipe_in[1], "p ", 2);
+	write(pipe_in[1], expression, strlen(expression));
+	send_command("\n", 0);
+
+	check_output(fn, line, expression, "$");
+	wait_for_pattern(" = ");
+	check_output(fn, line, expression, expected_value);
+	check_output(fn, line, expression, "\n(gdb) ");
+}
+
+static void __attribute__((noinline)) spin_lo_prio(void)
+{
+	int err;
+
+	err = sem_wait(&kickoff_lo);
+	check_no_error("sem_wait", err);
+
+	while (!terminate)
+		thread_loops++;
+}
+
+static void __attribute__((noinline)) breakpoint_target(void)
+{
+	asm volatile("" ::: "memory");
+}
+
+static void *thread_hi_func(void *arg)
+{
+	struct timespec ts = {0, 1000000};
+	int err;
+
+	pthread_setname_np(pthread_self(), "hi-thread");
+
+	err = sem_post(&kickoff_lo);
+	check_no_error("sem_post", err);
+
+	nanosleep(&ts, NULL);
+
+	/* 1st breakpoint: synchronous stop */
+	expected_loops = thread_loops;
+	breakpoint_target();
+
+	/* 2nd bp: synchronous continue */
+	expected_loops = thread_loops;
+	breakpoint_target();
+	terminate = 1;
+
+	return NULL;
+}
+
+static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
+{
+	struct sched_param params;
+	pthread_t thread_hi;
+	pthread_attr_t attr;
+	char run_param[32];
+	cpu_set_t cpu_set;
+	int err;
+
+	smokey_parse_args(t, argc, argv);
+
+	if (SMOKEY_ARG_ISSET(gdb, run_target) &&
+            SMOKEY_ARG_BOOL(gdb, run_target)) {
+		/* we are the to-be-debugged target */
+
+		CPU_ZERO(&cpu_set);
+		CPU_SET(0, &cpu_set);
+		err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set),
+					     &cpu_set);
+		check_no_error("pthread_setaffinity_np", err);
+		params.sched_priority = 1;
+		err = pthread_setschedparam(pthread_self(), SCHED_FIFO,
+					    &params);
+		check_no_error("pthread_setschedparam", err);
+
+		check("is primary", cobalt_get_current_mode() & XNRELAX, 0);
+		breakpoint_target();
+		primary_mode = !(cobalt_get_current_mode() & XNRELAX);
+		breakpoint_target();
+
+		err = sem_init(&kickoff_lo, 0, 0);
+		check_no_error("sem_init", err);
+
+		err = pthread_attr_init(&attr);
+		check_no_error("pthread_attr_init", err);
+		err = pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
+		check_no_error("pthread_attr_setinheritsched", err);
+		err = pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
+		check_no_error("pthread_attr_setschedpolicy", err);
+		err = pthread_attr_setaffinity_np(&attr, sizeof(cpu_set), &cpu_set);
+		check_no_error("pthread_attr_setaffinity_np", err);
+
+		params.sched_priority = 2;
+		err = pthread_attr_setschedparam(&attr, &params);
+		check_no_error("pthread_attr_setschedparam", err);
+		err = pthread_create(&thread_hi, &attr, thread_hi_func, NULL);
+		check_no_error("pthread_create", err);
+
+		spin_lo_prio();
+
+		pthread_join(thread_hi, NULL);
+	} else {
+		/* we are the gdb controller */
+
+		signal(SIGCHLD, handle_sigchld);
+
+		err = pipe(pipe_in);
+		check_no_error("pipe_in", err);
+
+		err = pipe(pipe_out);
+		check_no_error("pipe_out", err);
+
+		switch (do_fork()) {
+		case -1:
+			error(1, errno, "fork/vfork");
+
+		case 0:
+			/* redirect input */
+			close(0);
+			dup(pipe_in[0]);
+
+			/* redirect output and stderr */
+			close(1);
+			dup(pipe_out[1]);
+			close(2);
+			dup(1);
+
+			snprintf(run_param, sizeof(run_param), "--run=%d",
+				 t->__reserved.id);
+			execl("/usr/bin/gdb", "gdb", "--args",
+			      CONFIG_XENO_PREFIX "/bin/smokey", run_param,
+			      "run_target", NULL);
+			_exit(ESRCH);
+
+		default:
+			wait_for_pattern("(gdb) ");
+			send_command("b breakpoint_target\n", 1);
+			send_command("r\n", 1);
+
+			smokey_trace("resume in primary");
+			send_command("c\n", 1);
+			eval_expression("primary_mode", "1");
+			send_command("c\n", 1);
+
+			smokey_trace("synchronous stop");
+			eval_expression("thread_loops==expected_loops", "1");
+			send_command("c\n", 1);
+
+			smokey_trace("synchronous continue");
+			eval_expression("thread_loops==expected_loops", "1");
+
+			send_command("q\n", 0);
+			pause();
+
+			if (!child_terminated) {
+				fprintf(stderr,
+					"FAILURE: gdb still running?!\n");
+				exit(1);
+			}
+		}
+
+		signal(SIGCHLD, SIG_DFL);
+	}
+
+	return 0;
+}
-- 
2.16.4


