From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 1/2] demo/posix/cobalt: App of gpio loopback benchmark
Date: Fri,  3 Jul 2020 14:37:31 +0800
Message-Id: <1593758251-9233-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: chensong <chensong@kylinos.cn>

From: chensong <chensong@kylinos.cn>

It's a tool to benchmark the latency of GPIO driver
It consists of 2 parts:

1,driver:
1) request 2 gpio ports, one is output, the other is interrupt
   connect them with a cable, once there is a signal in output,
   an interrupt will be raised
2) an interrupt handler
3) write_rt, read_rt for app to get timestamp
4) record timestamp in write_rt and interrupt handler respectively,
   it's the latency in kernel space(inner_loop)

2, app:
1) open dev
2) write_rt to send a signal from output
3) read_rt to get timestamps recorded in driver (inner loop)
4) also record timespace in user space(outer_loop)
   outer_loop is inner_loop plus syscall overhead
5) ftrace enable/disable

Signed-off-by: chensong <chensong@kylinos.cn>
---
 demo/posix/cobalt/Makefile.am |   6 +
 demo/posix/cobalt/gpioloop.c  | 516 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 522 insertions(+)
 create mode 100644 demo/posix/cobalt/gpioloop.c

diff --git a/demo/posix/cobalt/Makefile.am b/demo/posix/cobalt/Makefile.am
index 2a22967..3bfa358 100644
--- a/demo/posix/cobalt/Makefile.am
+++ b/demo/posix/cobalt/Makefile.am
@@ -3,6 +3,7 @@ demodir = @XENO_DEMO_DIR@
 CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 
 demo_PROGRAMS = 	\
+	gpioloop		\
 	gpiopwm		\
 	bufp-label	\
 	bufp-readwrite	\
@@ -25,6 +26,11 @@ ldadd = 					\
 	 @XENO_USER_LDADD@			\
 	-lpthread -lrt
 
+gpioloop_SOURCES = gpioloop.c
+gpioloop_CPPFLAGS = $(cppflags) -I$(top_srcdir)/include/rtdm/uapi
+gpioloop_LDFLAGS = $(ldflags)
+gpioloop_LDADD = $(ldadd)
+
 gpiopwm_SOURCES = gpiopwm.c
 gpiopwm_CPPFLAGS = $(cppflags) -I$(top_srcdir)/include/rtdm/uapi
 gpiopwm_LDFLAGS = $(ldflags)
diff --git a/demo/posix/cobalt/gpioloop.c b/demo/posix/cobalt/gpioloop.c
new file mode 100644
index 0000000..c8c59eb
--- /dev/null
+++ b/demo/posix/cobalt/gpioloop.c
@@ -0,0 +1,516 @@
+/*
+ * Copyright (C) 2020 Song Chen <chensong@tj.kylinos.cn>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining
+ * a copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include <stdlib.h>
+#include <math.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <error.h>
+#include <signal.h>
+#include <sched.h>
+#include <time.h>
+#include <sys/time.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <semaphore.h>
+#include <sys/timerfd.h>
+#include <xeno_config.h>
+#include <rtdm/testing.h>
+#include <rtdm/gpio.h>
+#include <boilerplate/trace.h>
+#include <xenomai/init.h>
+#include <sys/mman.h>
+
+#define NS_PER_MS (1000000)
+#define NS_PER_S (1000000000)
+
+#define DEFAULT_PRIO 99
+#define VERSION_STRING "0.1"
+#define GPIO_HIGH 1
+#define GPIO_LOW  0
+#define MAX_HIST		1000
+#define MAX_CYCLES 1000000
+#define DEFAULT_LIMIT 1000
+
+#define DEVICE_NAME "/dev/rtdm/gpiobench"
+#define TRACING_ON  "/sys/kernel/debug/tracing/tracing_on"
+#define TRACING_EVENTS  "/sys/kernel/debug/tracing/events/enable"
+#define TRACE_MARKER  "/sys/kernel/debug/tracing/trace_marker"
+#define ON  "1"
+#define OFF "0"
+
+/* Struct for statistics */
+struct test_stat {
+	long inner_min;
+	long inner_max;
+	double inner_avg;
+	long *inner_hist_array;
+	long inner_hist_overflow;
+
+	long outer_min;
+	long outer_max;
+	double outer_avg;
+	long *outer_hist_array;
+	long outer_hist_overflow;
+};
+
+/* Struct for information */
+struct test_info {
+	unsigned long max_cycles;
+	unsigned long total_cycles;
+	unsigned long max_histogram;
+	int prio;
+	int quiet;
+	int tracelimit;
+	int fd_dev;
+	pthread_t gpioloop_task;
+	int gpio_intr;
+	int gpio_out;
+	struct test_stat ts;
+};
+
+struct rt_timing_info {
+	uint64_t time_gpio_output;
+	uint64_t time_gpio_irq;
+
+};
+
+struct test_info ti;
+/* Print usage information */
+static void display_help(void)
+{
+	printf("gpioloop V %s\n", VERSION_STRING);
+	printf("Usage:\n"
+	       "gpioloop <options>\n\n"
+
+	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
+	       "                           (with same priority about many threads)\n"
+	       "                           US is the max time to be be tracked in microseconds\n"
+	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+	       "-p PRIO  --prio=PRIO       priority of highest prio thread (defaults to 99)\n"
+	       "-q       --quiet           print only a summary on exit\n"
+		   "-o       --output          gpio port number for output\n"
+		   "-i       --interrupt       gpio port number as an interrupt\n"
+		);
+}
+
+static void process_options(int argc, char *argv[])
+{
+	int c = 0;
+
+	while ((c = getopt(argc, argv, "h:p:l:b:i:o:q")) != EOF) {
+		switch (c) {
+		case 'h':
+			ti.max_histogram = atoi(optarg);
+			break;
+
+		case 'p':
+			ti.prio = atoi(optarg);
+			break;
+
+		case 'l':
+			ti.max_cycles = atoi(optarg);
+			break;
+
+		case 'q':
+			ti.quiet = 1;
+			break;
+
+		case 'b':
+			ti.tracelimit = atoi(optarg);
+			break;
+
+		case 'i':
+			ti.gpio_intr = atoi(optarg);
+			break;
+
+		case 'o':
+			ti.gpio_out = atoi(optarg);
+			break;
+
+		default:
+			display_help();
+			exit(2);
+		}
+	}
+
+	ti.prio = ti.prio > DEFAULT_PRIO ? DEFAULT_PRIO : ti.prio;
+	ti.max_cycles = ti.max_cycles > MAX_CYCLES ? MAX_CYCLES : ti.max_cycles;
+
+	ti.max_histogram = ti.max_histogram > MAX_HIST ?
+		MAX_HIST : ti.max_histogram;
+	ti.ts.inner_hist_array = calloc(ti.max_histogram, sizeof(long));
+	ti.ts.outer_hist_array = calloc(ti.max_histogram, sizeof(long));
+}
+
+static int thread_msleep(unsigned int ms)
+{
+	struct timespec ts = {
+		.tv_sec = (ms * NS_PER_MS) / NS_PER_S,
+		.tv_nsec = (ms * NS_PER_MS) % NS_PER_S,
+	};
+
+	return -nanosleep(&ts, NULL);
+}
+
+static inline int64_t calc_us(struct timespec t)
+{
+	return (t.tv_sec * NS_PER_S + t.tv_nsec);
+}
+
+static int setevent(char *event, char *val)
+{
+	int fd;
+	int ret;
+
+	fd = open(event, O_WRONLY);
+	if (fd < 0) {
+		printf("unable to open %s\n", event);
+		return -1;
+	}
+
+	ret = write(fd, val, strlen(val));
+	if (ret < 0) {
+		printf("unable to write %s to %s\n", val, event);
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+	return 0;
+}
+
+static void tracing(char *enable)
+{
+	setevent(TRACING_EVENTS, enable);
+	setevent(TRACING_ON, enable);
+}
+
+#define write_check(__fd, __buf, __len)			\
+	do {						\
+		int __ret = write(__fd, __buf, __len);	\
+		(void)__ret;				\
+	} while (0)
+
+#define TRACEBUFSIZ 1024
+static __thread char tracebuf[TRACEBUFSIZ];
+
+static void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
+static void tracemark(char *fmt, ...)
+{
+	va_list ap;
+	int len;
+	int tracemark_fd;
+
+	tracemark_fd = open(TRACE_MARKER, O_WRONLY);
+	if (tracemark_fd == -1) {
+		printf("unable to open trace_marker file: %s\n", TRACE_MARKER);
+		return;
+	}
+
+	/* bail out if we're not tracing */
+	/* or if the kernel doesn't support trace_mark */
+	if (tracemark_fd < 0)
+		return;
+
+	va_start(ap, fmt);
+	len = vsnprintf(tracebuf, TRACEBUFSIZ, fmt, ap);
+	va_end(ap);
+	write_check(tracemark_fd, tracebuf, len);
+
+	close(tracemark_fd);
+}
+
+static int rw_gpio(int value, int index)
+{
+	int ret;
+	struct timespec timestamp;
+	struct rt_timing_info inner_loop, outer_loop;
+	uint64_t inner_diff, outer_diff;
+
+	clock_gettime(CLOCK_MONOTONIC, &timestamp);
+	outer_loop.time_gpio_output = calc_us(timestamp);
+
+	ret = write(ti.fd_dev, &value, sizeof(value));
+	if (ret < 0) {
+		error(1, ret, "write GPIO");
+		return ret;
+	}
+
+	ret = read(ti.fd_dev, &inner_loop, sizeof(struct rt_timing_info));
+	if (ret < 0) {
+		error(1, ret, "read GPIO");
+		return ret;
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &timestamp);
+	outer_loop.time_gpio_irq = calc_us(timestamp);
+
+	inner_diff = (inner_loop.time_gpio_irq - inner_loop.time_gpio_output)
+				/ 1000;
+	outer_diff = (outer_loop.time_gpio_irq - outer_loop.time_gpio_output)
+				/ 1000;
+
+	if (inner_diff < ti.ts.inner_min)
+		ti.ts.inner_min = inner_diff;
+	if (inner_diff > ti.ts.inner_max)
+		ti.ts.inner_max = inner_diff;
+	ti.ts.inner_avg += (double) inner_diff;
+	if (inner_diff >= ti.max_histogram)
+		ti.ts.inner_hist_overflow++;
+	else
+		ti.ts.inner_hist_array[inner_diff]++;
+
+	if (outer_diff < ti.ts.outer_min)
+		ti.ts.outer_min = outer_diff;
+	if (inner_diff > ti.ts.outer_max)
+		ti.ts.outer_max = outer_diff;
+	ti.ts.outer_avg += (double) outer_diff;
+	if (outer_diff >= ti.max_histogram)
+		ti.ts.outer_hist_overflow++;
+	else
+		ti.ts.outer_hist_array[outer_diff]++;
+
+	if (ti.quiet == 0)
+		printf("index: %d, inner_diff: %8ld, outer_diff: %8ld\n",
+					index, inner_diff, outer_diff);
+
+	return outer_diff;
+}
+
+static void *run_gpioloop(void *cookie)
+{
+	int i, ret;
+
+	printf("----rt task, test run----\n");
+
+	for (i = 0; i < ti.max_cycles; i++) {
+		ti.total_cycles = i;
+		/*output 1 from gpio*/
+		ret = rw_gpio(GPIO_HIGH, i);
+		if (ret < 0) {
+			error(1, ret, "RW GPIO");
+			break;
+		} else if (ret > ti.tracelimit) {
+			tracemark("hit latency threshold (%d > %d), index: %d",
+						ret, ti.tracelimit, i);
+			break;
+		}
+
+		/*take a break, nanosleep here will not jeopardize the latency*/
+		thread_msleep(10);
+
+		/*output 0 from gpio*/
+		ret = rw_gpio(GPIO_LOW, i);
+		if (ret < 0) {
+			error(1, ret, "RW GPIO");
+			break;
+		} else if (ti.tracelimit && ret > ti.tracelimit) {
+			tracemark("hit latency threshold (%d > %d), index: %d",
+						ret, ti.tracelimit, i);
+			break;
+		}
+
+		/*take a break, nanosleep here will not jeopardize the latency*/
+		thread_msleep(10);
+	}
+
+	ti.ts.inner_avg /= (ti.total_cycles * 2);
+	ti.ts.outer_avg /= (ti.total_cycles * 2);
+	return NULL;
+}
+
+
+static void setup_sched_parameters(pthread_attr_t *attr, int prio)
+{
+	struct sched_param p;
+	int ret;
+
+	ret = pthread_attr_init(attr);
+	if (ret)
+		error(1, ret, "pthread_attr_init()");
+
+	ret = pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED);
+	if (ret)
+		error(1, ret, "pthread_attr_setinheritsched()");
+
+	ret = pthread_attr_setschedpolicy(attr,
+				prio ? SCHED_FIFO : SCHED_OTHER);
+	if (ret)
+		error(1, ret, "pthread_attr_setschedpolicy()");
+
+	p.sched_priority = prio;
+	ret = pthread_attr_setschedparam(attr, &p);
+	if (ret)
+		error(1, ret, "pthread_attr_setschedparam()");
+}
+
+static void init_ti(void)
+{
+	memset(&ti, 0, sizeof(struct test_info));
+	ti.prio = DEFAULT_PRIO;
+	ti.max_cycles = MAX_CYCLES;
+	ti.total_cycles = MAX_CYCLES;
+	ti.max_histogram = MAX_HIST;
+	ti.tracelimit = DEFAULT_LIMIT;
+	ti.quiet = 0;
+	ti.gpio_out = 0;
+	ti.gpio_intr = 0;
+
+	ti.ts.inner_min = ti.ts.outer_min = DEFAULT_LIMIT;
+	ti.ts.inner_max = ti.ts.outer_max = 0;
+	ti.ts.inner_avg = ti.ts.outer_avg = 0.0;
+}
+
+static void print_hist(void)
+{
+	int i;
+
+	printf("\n");
+	/*inner loop*/
+	printf("# Inner Loop Histogram\n");
+	printf("# Inner Loop latency is the latency in kernel space\n"
+		   "# between gpio_set_value and irq handler\n");
+
+	for (i = 0; i < ti.max_histogram; i++) {
+		unsigned long curr_latency = ti.ts.inner_hist_array[i];
+
+		printf("%06d ", i);
+		printf("%06lu\n", curr_latency);
+	}
+
+	printf("# Total:");
+	printf(" %09lu", ti.total_cycles);
+	printf("\n");
+
+	printf("# Min Latencies:");
+	printf(" %05lu", ti.ts.inner_min);
+	printf("\n");
+	printf("# Avg Latencies:");
+	printf(" %05lf", ti.ts.inner_avg);
+	printf("\n");
+	printf("# Max Latencies:");
+	printf(" %05lu", ti.ts.inner_max);
+	printf("\n");
+
+	printf("\n");
+	printf("\n");
+	/*outer loop*/
+	printf("# Outer Loop Histogram\n");
+	printf("# Outer Loop latency is the latency in user space\n"
+		   "# between write and read\n"
+		   "# Technically, outer loop latency is inner loop latercy\n"
+		   "# plus overhead of syscall\n");
+
+	for (i = 0; i < ti.max_histogram; i++) {
+		unsigned long curr_latency = ti.ts.outer_hist_array[i];
+
+		printf("%06d ", i);
+		printf("%06lu\n", curr_latency);
+	}
+
+	printf("# Total:");
+	printf(" %09lu", ti.total_cycles);
+	printf("\n");
+
+	printf("# Min Latencies:");
+	printf(" %05lu", ti.ts.outer_min);
+	printf("\n");
+	printf("# Avg Latencies:");
+	printf(" %05lf", ti.ts.outer_avg);
+	printf("\n");
+	printf("# Max Latencies:");
+	printf(" %05lu", ti.ts.outer_max);
+	printf("\n");
+}
+
+static void cleanup(void)
+{
+	int ret;
+
+	if (ti.tracelimit < DEFAULT_LIMIT)
+		tracing(OFF);
+
+	ret = close(ti.fd_dev);
+	if (ret < 0)
+		error(1, EINVAL, "can't close");
+
+	print_hist();
+
+}
+
+static void cleanup_and_exit(int sig)
+{
+	printf("Signal %d received\n", sig);
+	cleanup();
+	exit(0);
+}
+
+int main(int argc, char **argv)
+{
+	struct sigaction sa __attribute__((unused));
+	int ret = 0;
+	pthread_attr_t tattr;
+
+	init_ti();
+
+	process_options(argc, argv);
+
+	ret = mlockall(MCL_CURRENT|MCL_FUTURE);
+	if (ret)
+		error(1, ret, "mlockall");
+
+	ti.fd_dev = open(DEVICE_NAME, O_RDWR);
+	if (ti.fd_dev < 0)
+		error(1, EINVAL, "can't open %s", DEVICE_NAME);
+
+	if (ti.gpio_out) {
+		ret = ioctl(ti.fd_dev, GPIO_RTIOC_DIR_OUT, &ti.gpio_out);
+		if (ret)
+			error(1, ret, "ioctl gpio port output");
+	}
+
+	if (ti.gpio_intr) {
+		ret = ioctl(ti.fd_dev, GPIO_RTIOC_IRQEN, &ti.gpio_intr);
+		if (ret)
+			error(1, ret, "ioctl gpio port interrupt");
+	}
+
+	if (ti.tracelimit < DEFAULT_LIMIT)
+		tracing(ON);
+
+	signal(SIGTERM, cleanup_and_exit);
+	signal(SIGINT, cleanup_and_exit);
+	setup_sched_parameters(&tattr, ti.prio);
+
+	ret = pthread_create(&ti.gpioloop_task, &tattr, run_gpioloop, NULL);
+	if (ret)
+		error(1, ret, "pthread_create(gpioloop)");
+
+	pthread_join(ti.gpioloop_task, NULL);
+	pthread_attr_destroy(&tattr);
+
+	cleanup();
+	return 0;
+}
-- 
2.7.4




