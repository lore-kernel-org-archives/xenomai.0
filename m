Message-ID: <5058F5F6.2060708@xenomai.org>
Date: Wed, 19 Sep 2012 00:30:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50483A49.5090100@ebus.com> <504C7797.8040201@xenomai.org>
In-Reply-To: <504C7797.8040201@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Queue corruption from XDDP in Xenomai 2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Doug Brunner <dbrunner@ebus.com>, xenomai@xenomai.org

On 09/09/2012 01:03 PM, Philippe Gerum wrote:

> On 09/06/2012 07:53 AM, Doug Brunner wrote:
>> It looks like the bug I wrote about back in June still exists in Xenomai
>> 2.6.1 (with Linux 3.2.21). I ran the same test case (an RT thread opens
>> an XDDP socket, then a Linux thread opens its end of the pipe, then the
>> RT thread stops, then with the Linux thread still holding its end of the
>> pipe another RT thread tries to open an XDDP socket with the same minor
>> number). With Xenomai queue and I-pipe debugging enabled, I got a report
>> of a corrupted queue. I've attached my config, test case, and serial
>> console log.
>>
>> So far I haven't found anything in the XDDP or underlying xnpipe_* code
>> that would suggest why this is happening. However something is
>> definitely going wrong, since xnpipe_minor_free should not be called
>> until my Linux task closes its end of the pipe, so the call by the
>> second RT thread to open the pipe should fail with -EBUSY. Any thoughts
>> on why this might be happening?
>>
> 
> Yes, please have a look at the commit log there:
> http://git.xenomai.org/?p=xenomai-2.6.git;a=commit;h=283c5f6eae1d1d7c65073e2f30fd40abdcf2c1ca
> 
> This patch should fix the issue raised by the test case you sent
> (actually, it does, it was very useful to spot the problem - thanks for
> this).


Hi Philippe, 

I am using a test case which should be about the same as Doug's, however when running the test
case twice, the second test fails at bind with EADDRINUSE.

The testcase (as a patch to be compiled as part of the regression suite):

diff --git a/src/testsuite/regression/posix/Makefile.am b/src/testsuite/regression/posix/Makefile.am
index 2107482..bd3c1cf 100644
--- a/src/testsuite/regression/posix/Makefile.am
+++ b/src/testsuite/regression/posix/Makefile.am
@@ -4,7 +4,7 @@ noinst_HEADERS = check.h
 
 CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 
-tst_PROGRAMS = leaks shm mprotect nano_test
+tst_PROGRAMS = leaks shm mprotect nano_test xddp_test
 
 CPPFLAGS = $(XENO_USER_CFLAGS) \
 	-I$(top_srcdir)/include/posix \
diff --git a/src/testsuite/regression/posix/Makefile.in b/src/testsuite/regression/posix/Makefile.in
index 9f77e38..da24e2f 100644
--- a/src/testsuite/regression/posix/Makefile.in
+++ b/src/testsuite/regression/posix/Makefile.in
@@ -37,7 +37,7 @@ build_triplet = @build@
 host_triplet = @host@
 target_triplet = @target@
 tst_PROGRAMS = leaks$(EXEEXT) shm$(EXEEXT) mprotect$(EXEEXT) \
-	nano_test$(EXEEXT)
+	nano_test$(EXEEXT) xddp_test$(EXEEXT)
 subdir = src/testsuite/regression/posix
 DIST_COMMON = $(noinst_HEADERS) $(srcdir)/Makefile.am \
 	$(srcdir)/Makefile.in
@@ -78,6 +78,11 @@ shm_OBJECTS = shm.$(OBJEXT)
 shm_LDADD = $(LDADD)
 shm_DEPENDENCIES = ../../../skins/posix/libpthread_rt.la \
 	../../../skins/common/libxenomai.la
+xddp_test_SOURCES = xddp_test.c
+xddp_test_OBJECTS = xddp_test.$(OBJEXT)
+xddp_test_LDADD = $(LDADD)
+xddp_test_DEPENDENCIES = ../../../skins/posix/libpthread_rt.la \
+	../../../skins/common/libxenomai.la
 DEFAULT_INCLUDES = -I.@am__isrc@ -I$(top_builddir)/src/include
 depcomp = $(SHELL) $(top_srcdir)/config/depcomp
 am__depfiles_maybe = depfiles
@@ -90,8 +95,8 @@ LTCOMPILE = $(LIBTOOL) --tag=CC $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) \
 LINK = $(LIBTOOL) --tag=CC $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) \
 	--mode=link $(CCLD) $(AM_CFLAGS) $(CFLAGS) $(AM_LDFLAGS) \
 	$(LDFLAGS) -o $@
-SOURCES = leaks.c mprotect.c nano_test.c shm.c
-DIST_SOURCES = leaks.c mprotect.c nano_test.c shm.c
+SOURCES = leaks.c mprotect.c nano_test.c shm.c xddp_test.c
+DIST_SOURCES = leaks.c mprotect.c nano_test.c shm.c xddp_test.c
 HEADERS = $(noinst_HEADERS)
 ETAGS = etags
 CTAGS = ctags
@@ -358,6 +363,9 @@ nano_test$(EXEEXT): $(nano_test_OBJECTS) $(nano_test_DEPENDENCIES)
 shm$(EXEEXT): $(shm_OBJECTS) $(shm_DEPENDENCIES) 
 	@rm -f shm$(EXEEXT)
 	$(LINK) $(shm_OBJECTS) $(shm_LDADD) $(LIBS)
+xddp_test$(EXEEXT): $(xddp_test_OBJECTS) $(xddp_test_DEPENDENCIES) 
+	@rm -f xddp_test$(EXEEXT)
+	$(LINK) $(xddp_test_OBJECTS) $(xddp_test_LDADD) $(LIBS)
 
 mostlyclean-compile:
 	-rm -f *.$(OBJEXT)
@@ -369,6 +377,7 @@ distclean-compile:
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/mprotect.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/nano_test.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/shm.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/xddp_test.Po@am__quote@
 
 .c.o:
 @am__fastdepCC_TRUE@	$(COMPILE) -MT $@ -MD -MP -MF $(DEPDIR)/$*.Tpo -c -o $@ $<
diff --git a/src/testsuite/regression/posix/check.h b/src/testsuite/regression/posix/check.h
index 63dc4a3..5530e8a 100644
--- a/src/testsuite/regression/posix/check.h
+++ b/src/testsuite/regression/posix/check.h
@@ -10,7 +10,7 @@
 	({                                                              \
 		int rc = (expr);                                        \
 		if (rc > 0) {                                           \
-			fprintf(stderr, "FAILURE %s:%d: "#expr ": %s\n", __FILE__, __LINE__, strerror(rc)); \
+			fprintf(stderr, "FAILURE %s:%d: %s: %s\n", __FILE__, __LINE__, #expr, strerror(rc)); \
 			exit(EXIT_FAILURE);				\
 		}                                                       \
 		rc;                                                     \
@@ -20,7 +20,7 @@
 	({                                                              \
 		int rc = (expr);                                        \
 		if (rc < 0) {                                           \
-			fprintf(stderr, "FAILURE %s:%d: "#expr ": %s\n", __FILE__, __LINE__, strerror(errno)); \
+			fprintf(stderr, "FAILURE %s:%d: %s: %s\n", __FILE__, __LINE__, #expr, strerror(errno)); \
 			exit(EXIT_FAILURE);				\
 		}                                                       \
 		rc;                                                     \
@@ -30,7 +30,7 @@
 	({                                                              \
 		void *rc = (expr);					\
 		if (rc == MAP_FAILED) {					\
-			fprintf(stderr, "FAILURE %s:%d: "#expr ": %s\n", __FILE__, __LINE__, strerror(errno)); \
+			fprintf(stderr, "FAILURE %s:%d: %s: %s\n", __FILE__, __LINE__, #expr, strerror(errno)); \
 			exit(EXIT_FAILURE);				\
 		}                                                       \
 		rc;                                                     \
diff --git a/src/testsuite/regression/posix/xddp_test.c b/src/testsuite/regression/posix/xddp_test.c
new file mode 100644
index 0000000..1c9389f
--- /dev/null
+++ b/src/testsuite/regression/posix/xddp_test.c
@@ -0,0 +1,156 @@
+/*
+ * XDDP-based RT/NRT threads regression test.
+ *
+ * Original author: Doug Brunner
+ *
+ * This test causes a crash with Xenomai 2.6.1 and earlier versions.
+ */
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <string.h>
+#include <malloc.h>
+#include <pthread.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <rtdk.h>
+#include <rtdm/rtipc.h>
+#include "check.h"
+
+pthread_t rt, nrt;
+
+#define XDDP_PORT 0	/* [0..CONFIG-XENO_OPT_PIPE_NRDEV - 1] */
+
+void *realtime_thread(void *arg)
+{
+	unsigned long count = (unsigned long)arg;
+	struct sockaddr_ipc saddr;
+	struct timespec ts;
+	size_t poolsz;
+	int ret, s;
+
+	/*
+	 * Get a datagram socket to bind to the RT endpoint. Each
+	 * endpoint is represented by a port number within the XDDP
+	 * protocol namespace.
+	 */
+	s = check_unix(socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP));
+
+	/*
+	 * Set a local 16k pool for the RT endpoint. Memory needed to
+	 * convey datagrams will be pulled from this pool, instead of
+	 * Xenomai's system pool.
+	 */
+	poolsz = 16384; /* bytes */
+	ret = check_unix(setsockopt(s, SOL_XDDP, XDDP_POOLSZ,
+				    &poolsz, sizeof(poolsz)));
+
+	/*
+	 * Bind the socket to the port, to setup a proxy to channel
+	 * traffic to/from the Linux domain.
+	 *
+	 * saddr.sipc_port specifies the port number to use.
+	 */
+	memset(&saddr, 0, sizeof(saddr));
+	saddr.sipc_family = AF_RTIPC;
+	saddr.sipc_port = XDDP_PORT;
+	ret = bind(s, (struct sockaddr *)&saddr, sizeof(saddr));
+	if (ret == 0 && errno == EADDRINUSE && count == 1) {
+		fprintf(stderr, "Success.\n");
+		exit(EXIT_SUCCESS);
+	} else if (ret < 0) {
+		fprintf(stderr, "bind: %m\n");
+		exit(EXIT_FAILURE);
+	}
+
+	ts.tv_sec = 0;
+	ts.tv_nsec = 500000000; /* 500 ms */
+	check_unix(clock_nanosleep(CLOCK_REALTIME, 0, &ts, NULL));
+
+	check_unix(close(s));
+
+	return NULL;
+}
+
+void *regular_thread(void *arg)
+{
+	char buf[128], *devname;
+	int fd, ret;
+
+	check_unix(asprintf(&devname, "/dev/rtp%d", XDDP_PORT));
+
+	fd = check_unix(open(devname, O_RDWR));
+	free(devname);
+
+	for (;;) {
+		/* Get the next message from realtime_thread. */
+		ret = read(fd, buf, sizeof(buf));
+
+		usleep(10000);
+	}
+
+	return NULL;
+}
+
+void cleanup_upon_sig(int sig)
+{
+	pthread_cancel(rt);
+	pthread_cancel(nrt);
+	signal(sig, SIG_DFL);
+	pthread_join(rt, NULL);
+	pthread_join(nrt, NULL);
+	raise(sig);
+}
+
+int main(int argc, char **argv)
+{
+	struct sched_param rtparam = { .sched_priority = 42 };
+	pthread_attr_t rtattr, regattr;
+	sigset_t mask, oldmask;
+
+	mlockall(MCL_CURRENT | MCL_FUTURE);
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	signal(SIGINT, cleanup_upon_sig);
+	sigaddset(&mask, SIGTERM);
+	signal(SIGTERM, cleanup_upon_sig);
+	sigaddset(&mask, SIGHUP);
+	signal(SIGHUP, cleanup_upon_sig);
+	pthread_sigmask(SIG_BLOCK, &mask, &oldmask);
+
+	pthread_attr_init(&rtattr);
+	pthread_attr_setdetachstate(&rtattr, PTHREAD_CREATE_JOINABLE);
+	pthread_attr_setinheritsched(&rtattr, PTHREAD_EXPLICIT_SCHED);
+	pthread_attr_setschedpolicy(&rtattr, SCHED_FIFO);
+	pthread_attr_setschedparam(&rtattr, &rtparam);
+
+	check_pthread(pthread_create(&rt, &rtattr, &realtime_thread, NULL));
+	pthread_attr_destroy(&rtattr);
+
+	pthread_attr_init(&regattr);
+	pthread_attr_setdetachstate(&regattr, PTHREAD_CREATE_JOINABLE);
+	pthread_attr_setinheritsched(&regattr, PTHREAD_EXPLICIT_SCHED);
+	pthread_attr_setschedpolicy(&regattr, SCHED_OTHER);
+
+	check_pthread(pthread_create(&nrt, &regattr, &regular_thread, NULL));
+	pthread_attr_destroy(&regattr);
+
+	sleep(1);	// after this call returns the RT thread will have ended
+
+	pthread_attr_init(&rtattr);	// start another RT thread to cause the crash
+	pthread_attr_setdetachstate(&rtattr, PTHREAD_CREATE_JOINABLE);
+	pthread_attr_setinheritsched(&rtattr, PTHREAD_EXPLICIT_SCHED);
+	pthread_attr_setschedpolicy(&rtattr, SCHED_FIFO);
+	pthread_attr_setschedparam(&rtattr, &rtparam);
+
+	check_pthread(pthread_create(&rt, &rtattr,
+&realtime_thread, (void *)1UL));
+	pthread_attr_destroy(&rtattr);
+
+	sigsuspend(&oldmask);
+
+	return 0;
+}


-- 
                                                                Gilles.

