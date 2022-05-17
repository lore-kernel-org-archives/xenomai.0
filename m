From: Zqiang <qiang1.zhang@intel.com>
Subject: [PATCH 4/4] testsuite/tgpiotest: introduce TGPIO smokey testcase
Date: Tue, 17 May 2022 09:51:52 +0800
Message-Id: <20220517015152.697886-5-qiang1.zhang@intel.com>
In-Reply-To: <20220517015152.697886-1-qiang1.zhang@intel.com>
References: <20220517015152.697886-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org, jan.kiszka@siemens.com
Cc: hongzhan.chen@intel.com, xenomai@xenomai.org

The TGPIO testcase includes the following contents:
1. tgpio_info: get a report of available TGPIO capabilities for a
   specified device.
2. tgpio_oneshot_output: demonstrating a TGPIO single-shot output
   scenario. the sample demonstrates how to trigger a TGPIO pin at
   the specific timestamp. in this sample, this timestamp is specified
   as an offset from the Base time
3. tgpio_periodic_output: demonstrating how to set a TGPIO pin to
   periodic output mode the sample generates a signal based on the
   specified period (1 second, for example). the sample generates a
   voltage change on the output pin at the specific timestamp.
4. tgpio_input: prints a timestamp when an edge is detected, indicating
   a change in the TGPIO input pin state.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 configure.ac                    |   1 +
 include/rtdm/rt_ptp_clock.h     |  24 ++
 include/smokey/smokey.h         |  10 +
 lib/smokey/helpers.c            |  19 +
 testsuite/Makefile.am           |   2 +
 testsuite/tgpiotest/Makefile.am |  19 +
 testsuite/tgpiotest/tgpiotest.c | 591 ++++++++++++++++++++++++++++++++
 7 files changed, 666 insertions(+)
 create mode 100644 include/rtdm/rt_ptp_clock.h
 create mode 100644 testsuite/tgpiotest/Makefile.am
 create mode 100644 testsuite/tgpiotest/tgpiotest.c

diff --git a/configure.ac b/configure.ac
index e7a1701..8a5b27b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -971,6 +971,7 @@ AC_CONFIG_FILES([ \
 	testsuite/switchtest/Makefile \
 	testsuite/gpiotest/Makefile \
 	testsuite/gpiobench/Makefile \
+	testsuite/tgpiotest/Makefile \
 	testsuite/spitest/Makefile \
 	testsuite/smokey/Makefile \
 	testsuite/smokey/arith/Makefile \
diff --git a/include/rtdm/rt_ptp_clock.h b/include/rtdm/rt_ptp_clock.h
new file mode 100644
index 0000000..8cf8383
--- /dev/null
+++ b/include/rtdm/rt_ptp_clock.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2022 Zqiang <qiang1.zhang@intel.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ */
+#ifndef _RTDM_PTP_H
+#define _RTDM_PTP_H
+
+#include <rtdm/rtdm.h>
+#include <rtdm/uapi/rt_ptp_clock.h>
+
+#endif
diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
index 185fd3a..9576cfc 100644
--- a/include/smokey/smokey.h
+++ b/include/smokey/smokey.h
@@ -31,6 +31,12 @@
 #define do_fork vfork
 #endif
 
+#define SMOKEY_ULONG(__name) {		\
+	.name = # __name,		\
+	.parser = smokey_ulong,		\
+	.matched = 0,			\
+	}
+
 #define SMOKEY_INT(__name) {		\
 	 .name = # __name,		\
 	 .parser = smokey_int,		\
@@ -65,6 +71,7 @@ struct smokey_arg {
 		      struct smokey_arg *arg);
 	union {
 		int n_val;
+		unsigned long long ln_val;
 		char *s_val;
 		size_t l_val;
 	} u;
@@ -112,6 +119,7 @@ struct smokey_test {
 #define SMOKEY_ARG_BOOL(__plugin, __arg)   (!!SMOKEY_ARG_INT(__plugin, __arg))
 #define SMOKEY_ARG_STRING(__plugin, __arg) (SMOKEY_ARG(__plugin, __arg)->u.s_val)
 #define SMOKEY_ARG_SIZE(__plugin, __arg)   (SMOKEY_ARG(__plugin, __arg)->u.l_val)
+#define SMOKEY_ARG_ULONG(__plugin, __arg)  (SMOKEY_ARG(__plugin, __arg)->u.ln_val)
 
 #define smokey_arg_isset(__t, __name)      (smokey_lookup_arg(__t, __name)->matched)
 #define smokey_arg_int(__t, __name)	   (smokey_lookup_arg(__t, __name)->u.n_val)
@@ -221,6 +229,8 @@ void smokey_register_plugin(struct smokey_test *t);
 
 int smokey_int(const char *s, struct smokey_arg *arg);
 
+int smokey_ulong(const char *s, struct smokey_arg *arg);
+
 int smokey_bool(const char *s, struct smokey_arg *arg);
 
 int smokey_string(const char *s, struct smokey_arg *arg);
diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index da84c86..4ba3a48 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -47,6 +47,25 @@ int smokey_int(const char *s, struct smokey_arg *arg)
 	return ret;
 }
 
+int smokey_ulong(const char *s, struct smokey_arg *arg)
+{
+	char *name, *p;
+	int ret;
+
+	ret = sscanf(s, "%m[_a-z]=%m[^\n]", &name, &p);
+	if (ret != 2 || !(isdigit(*p) || *p == '-'))
+		return 0;
+
+	ret = !strcmp(name, arg->name);
+	if (ret)
+		arg->u.ln_val = strtoull(p, NULL, 10);
+
+	free(p);
+	free(name);
+
+	return ret;
+}
+
 int smokey_bool(const char *s, struct smokey_arg *arg)
 {
 	int ret;
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index 4932f6d..6829f20 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -7,6 +7,7 @@ SUBDIRS += 		\
 	gpiotest	\
 	spitest		\
 	switchtest	\
+	tgpiotest	\
 	xeno-test
 endif
 
@@ -18,4 +19,5 @@ DIST_SUBDIRS =		\
 	smokey		\
 	spitest		\
 	switchtest	\
+	tgpiotest	\
 	xeno-test
diff --git a/testsuite/tgpiotest/Makefile.am b/testsuite/tgpiotest/Makefile.am
new file mode 100644
index 0000000..0a5b15c
--- /dev/null
+++ b/testsuite/tgpiotest/Makefile.am
@@ -0,0 +1,19 @@
+testdir = @XENO_TEST_DIR@
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = tgpiotest
+
+tgpiotest_SOURCES = tgpiotest.c
+
+tgpiotest_CPPFLAGS = 		\
+	$(XENO_USER_CFLAGS)	\
+	-I$(top_srcdir)/include
+
+tgpiotest_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
+
+tgpiotest_LDADD =			\
+	../../lib/smokey/libsmokey@CORE@.la	\
+	@XENO_CORE_LDADD@		\
+	@XENO_USER_LDADD@		\
+	-lpthread -lrt
diff --git a/testsuite/tgpiotest/tgpiotest.c b/testsuite/tgpiotest/tgpiotest.c
new file mode 100644
index 0000000..d577cfe
--- /dev/null
+++ b/testsuite/tgpiotest/tgpiotest.c
@@ -0,0 +1,591 @@
+/*
+ * Copyright (C) 2022 Zqiang <qiang1.zhang@intel.com>
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
+#include <stdio.h>
+#include <error.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <smokey/smokey.h>
+#include <rtdm/rt_ptp_clock.h>
+#include <stdint.h>
+#include <signal.h>
+
+void signal_handler(int);
+int running;
+sem_t send_signal;
+void signal_send(int);
+
+#define TIME_VAL (1000000)
+#define TCC_NSEC_PER_SEC (1000000000U)
+#define SLEEP_TIME_USEC (100)
+#define SLEEP_TIME_SEC  (20)
+#define CROSSTIMESTAMP_SLEEP_TIME_USEC (1000)
+#define TIME_BUFFER_SIZE (1024)
+
+static const char* functions[] = {"None", "External timestamp",
+						"Periodic signal"};
+
+struct settings_t
+{
+	int pin;
+	int channel;
+	uint64_t start;
+	uint64_t period;
+};
+
+smokey_test_plugin(tgpio_oneshot_output,
+			SMOKEY_ARGLIST(
+				SMOKEY_STRING(device),
+				SMOKEY_INT(pin),
+				SMOKEY_INT(channel),
+				SMOKEY_ULONG(start),
+			),
+	"TGPIO ONESHOT OUTPUT.\n"
+	"\tdevice=<device-path>.\n"
+	"\tpin=Specify the output pin index. Default: 0.\n"
+	"\tchannel=Specify the channel for the output pin. Default: 0.\n"
+	"\tstart=Specify the output delay in nanoseconds. Default: 1ms\n"
+);
+
+
+smokey_test_plugin(tgpio_periodic_output,
+			SMOKEY_ARGLIST(
+				SMOKEY_STRING(device),
+				SMOKEY_INT(pin),
+				SMOKEY_INT(channel),
+				SMOKEY_ULONG(period),
+			),
+	"TGPIO PERIODIC OUTPUT.\n"
+	"\tdevice=<device-path>.\n"
+	"\tpin=Specify the output pin index. Default: 0.\n"
+	"\tchannel=Specify the channel for the output pin. Default: 0.\n"
+	"\tperiod=Specify the output period in nanoseconds. Default: 1ms\n"
+);
+
+smokey_test_plugin(tgpio_input,
+			SMOKEY_ARGLIST(
+				SMOKEY_STRING(device),
+				SMOKEY_INT(pin),
+				SMOKEY_INT(channel),
+				SMOKEY_INT(mode),
+			),
+	"TGPIO INPUT.\n"
+	"\tdevice=<device-path>.\n"
+	"\tpin=Specify the input pin index. Default: 0.\n"
+	"\tchannel=Specify the channel for the output pin. Default: 0.\n"
+	"\tmode=Specify interrupt or poll mode. 0:poll 1:interrupt.\n"
+	"\tnote: only pse-tgpio support interrupt mode.\n"
+);
+
+smokey_test_plugin(tgpio_info,
+			SMOKEY_ARGLIST(
+				SMOKEY_STRING(device),
+			),
+	"Get TGPIO info.\n"
+	"\tdevice=<device-path>."
+);
+
+static uint64_t ptptime2ns(struct rt_ptp_clock_time time)
+{
+	return time.sec * TCC_NSEC_PER_SEC + time.nsec;
+}
+
+static struct rt_ptp_clock_time ns2ptptime(uint64_t nsec)
+{
+	return (struct rt_ptp_clock_time) {
+		nsec / TCC_NSEC_PER_SEC,                  // seconds
+		(unsigned int)(nsec % TCC_NSEC_PER_SEC),  // nanoseconds
+		0                                         // reserved
+	};
+}
+
+static int run_tgpio_oneshot_output(struct smokey_test *t, int argc,
+				char *const argv[])
+{
+	struct rt_ptp_sys_offset_precise cur_offset = {0};
+	int fd, ret = 0;
+	const char *device = NULL;
+
+	smokey_parse_args(t, argc, argv);
+	struct settings_t sample_setting = {.pin = 0, .channel = 0,
+							.start = TIME_VAL};
+
+	if (!SMOKEY_ARG_ISSET(tgpio_oneshot_output, device)) {
+		smokey_warning("missing device= specification");
+		return -EINVAL;
+        }
+
+	device = SMOKEY_ARG_STRING(tgpio_oneshot_output, device);
+	fd = open(device, O_RDONLY|O_NONBLOCK);
+	if (fd < 0) {
+		ret = -errno;
+		smokey_warning("cannot open device %s [%s]",
+						device, symerror(ret));
+		return ret;
+	}
+
+	if (SMOKEY_ARG_ISSET(tgpio_oneshot_output, pin))
+		sample_setting.pin = SMOKEY_ARG_INT(tgpio_oneshot_output, pin);
+
+	if (SMOKEY_ARG_ISSET(tgpio_oneshot_output, channel))
+		sample_setting.channel = SMOKEY_ARG_INT(tgpio_oneshot_output,
+								channel);
+
+	if (SMOKEY_ARG_ISSET(tgpio_oneshot_output, start))
+		sample_setting.start = SMOKEY_ARG_ULONG(tgpio_oneshot_output,
+								start);
+
+	struct rt_ptp_pin_desc desc = {0};
+	desc.index = sample_setting.pin;
+	desc.func = 2;
+	desc.chan = sample_setting.channel;
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_PIN_SETFUNC2, &desc));
+	if (ret < 0)
+		goto end;
+
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_SYS_OFFSET_PRECISE2,
+						&cur_offset));
+	if (ret < 0)
+		goto end;
+
+	uint64_t art_cur_ns = ptptime2ns(cur_offset.device);
+
+	/* Set up oneshot for this channel */
+	struct rt_ptp_perout_request request = {0};
+	request.start = ns2ptptime(art_cur_ns + sample_setting.start);
+	request.index = sample_setting.channel;
+	request.flags = RT_PTP_PEROUT_ONE_SHOT;  // Set mode flag to one shot
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_PEROUT_REQUEST2, &request));
+	if (ret < 0)
+		goto end;
+
+	smokey_warning("Single shot output requested on:\n"
+			"Pin %d, channel %d, delay %ld nsec\n",
+			sample_setting.pin,
+			sample_setting.channel,
+			sample_setting.start);
+end:
+	request.start.sec = 0;
+	request.start.nsec = 0;
+	request.flags = 0;
+	ioctl(fd, RT_PTP_PEROUT_REQUEST2, &request);
+	desc.func = 0;
+	ioctl(fd, RT_PTP_PIN_SETFUNC2, &desc);
+	close(fd);
+	return ret;
+}
+
+void signal_send(int dummy)
+{
+	sem_post(&send_signal);
+}
+
+static int run_tgpio_periodic_output(struct smokey_test *t, int argc,
+					char * const argv[])
+{
+	int fd, ret = 0;
+	const char *device = NULL;
+	struct rt_ptp_sys_offset_precise prev_offset = {};
+	struct rt_ptp_sys_offset_precise cur_offset = {};
+
+	smokey_parse_args(t, argc, argv);
+	struct settings_t sample_setting = {.pin = 0, .channel = 0,
+							.period = TIME_VAL};
+
+	if (!SMOKEY_ARG_ISSET(tgpio_periodic_output, device)) {
+		smokey_warning("missing device= specification");
+		return -EINVAL;
+	}
+
+	device = SMOKEY_ARG_STRING(tgpio_periodic_output, device);
+	fd = open(device, O_RDONLY|O_NONBLOCK);
+	if (fd < 0) {
+		ret = -errno;
+		smokey_warning("cannot open device %s [%s]",
+				device, symerror(ret));
+		return ret;
+	}
+
+	if (SMOKEY_ARG_ISSET(tgpio_periodic_output, pin))
+		sample_setting.pin = SMOKEY_ARG_INT(tgpio_periodic_output, pin);
+
+	if (SMOKEY_ARG_ISSET(tgpio_periodic_output, channel))
+		sample_setting.channel = SMOKEY_ARG_INT(tgpio_periodic_output,
+								channel);
+
+	if (SMOKEY_ARG_ISSET(tgpio_periodic_output, period))
+		sample_setting.period = SMOKEY_ARG_ULONG(tgpio_periodic_output,
+								period);
+
+	/* Set up pin's channel and output mode */
+	struct rt_ptp_pin_desc desc = {0};
+	desc.index = sample_setting.pin;
+	desc.func = 2;
+	desc.chan = sample_setting.channel;
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_PIN_SETFUNC2, &desc));
+	if (ret < 0)
+		goto end;
+
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_SYS_OFFSET_PRECISE2,
+						&prev_offset));
+	if (ret < 0)
+		goto end;
+	usleep(CROSSTIMESTAMP_SLEEP_TIME_USEC);
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_SYS_OFFSET_PRECISE2,
+						&cur_offset));
+	if (ret < 0)
+		goto end;
+
+	uint64_t art_cur_ns = ptptime2ns(cur_offset.device);
+	uint64_t tsc_cur_ns = ptptime2ns(cur_offset.sys_realtime);
+	long double art_to_tsc_ratio = (long double)(art_cur_ns -
+					ptptime2ns(prev_offset.device)) /
+			(tsc_cur_ns - ptptime2ns(prev_offset.sys_realtime));
+
+	/* Base time */
+	/* Measure offsets from the beginning of the current second + 2,
+	i.e., zero nanoseconds */
+	uint64_t tsc_basetime = (cur_offset.sys_realtime.sec + 2) *
+							TCC_NSEC_PER_SEC;
+	int64_t delta = tsc_basetime - tsc_cur_ns;
+	uint64_t art_basetime = art_cur_ns + delta * art_to_tsc_ratio;
+
+	/* Set up signal generation (period and start) for this channel
+	* Note: TGPIO PTP API sets the half-period of the signal */
+	struct rt_ptp_perout_request request = {0};
+	request.index = sample_setting.channel;
+	request.period = ns2ptptime(sample_setting.period);
+	request.start = ns2ptptime(art_basetime);
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_PEROUT_REQUEST2, &request));
+	if (ret < 0 )
+		goto end;
+
+	smokey_warning("Start periodic output.\n"
+			"Pin %d, channel %d, period %ld nsec\n"
+			"To interrupt, use Ctrl+C\n",
+			sample_setting.pin,
+			sample_setting.channel,
+			sample_setting.period);
+
+	sem_init(&send_signal, 0, 0);
+	signal(SIGINT, signal_send);
+
+	sem_wait(&send_signal);
+
+	smokey_warning("\nDone\n");
+	sem_destroy(&send_signal);
+end:
+	/* Shut down TGPIO pin */
+	request.start.sec = 0;
+	request.start.nsec = 0;
+	request.period.sec = 0;
+	request.period.nsec = 0;
+	ioctl(fd, RT_PTP_PEROUT_REQUEST2, &request);
+	desc.func = 0;
+	ioctl(fd, RT_PTP_PIN_SETFUNC2, &desc);
+	close(fd);
+	return ret;
+}
+
+
+static char* convert_to_human_readable(time_t seconds)
+{
+	static char time_string[TIME_BUFFER_SIZE] = {0};
+
+	struct tm* hr_time = localtime(&seconds);
+	strftime(time_string, TIME_BUFFER_SIZE, "%X", hr_time);
+	return time_string;
+}
+
+void signal_handler(int dummy)
+{
+	running = 0;
+}
+
+static int run_tgpio_input(struct smokey_test *t, int argc, char * const argv[])
+{
+	const char *device = NULL;
+	int fd, ret = 0;
+	smokey_parse_args(t, argc, argv);
+	struct settings_t sample_setting = {.pin = 0, .channel = 0};
+	struct rt_ptp_sys_offset_precise initial_offset = {0};
+	struct rt_ptp_sys_offset_precise current_offset = {0};
+	struct rt_ptp_event_count_tstamp events = {0};
+	running = 1;
+	int mode_interrupt = 0;
+	struct rt_ptp_extts_event event;
+
+	if (!SMOKEY_ARG_ISSET(tgpio_input, device)) {
+		smokey_warning("missing device= specification");
+		return -EINVAL;
+	}
+
+	device = SMOKEY_ARG_STRING(tgpio_input, device);
+	fd = open(device, O_RDONLY|O_NONBLOCK);
+	if (fd < 0) {
+		ret = -errno;
+		smokey_warning("cannot open device %s [%s]",
+				device, symerror(ret));
+		return ret;
+	}
+
+	if (SMOKEY_ARG_ISSET(tgpio_input, pin))
+		sample_setting.pin = SMOKEY_ARG_INT(tgpio_input, pin);
+
+	if (SMOKEY_ARG_ISSET(tgpio_input, channel))
+		sample_setting.channel = SMOKEY_ARG_INT(tgpio_input, channel);
+
+	if (SMOKEY_ARG_ISSET(tgpio_input, mode))
+		mode_interrupt = SMOKEY_ARG_INT(tgpio_input, mode);
+
+	if (!mode_interrupt)
+		signal(SIGINT, signal_handler);
+
+	struct rt_ptp_pin_desc desc = {0};
+	desc.index = sample_setting.pin;
+	desc.func = 1; /* Set external timestamp auxiliary function */
+	desc.chan = sample_setting.channel;
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_PIN_SETFUNC2, &desc));
+	if (ret < 0)
+		goto end;
+
+	/* Enable external timestamp (input) mode */
+	struct rt_ptp_extts_request request = {0};
+	request.index = sample_setting.channel;
+	/* Detects both rising and falling edges */
+	request.flags = RT_PTP_ENABLE_FEATURE | RT_PTP_EXTTS_EDGES;
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_EXTTS_REQUEST2, &request));
+	if (ret < 0)
+		goto end;
+
+	/* Set up channel for event count*/
+	events.index = sample_setting.channel;
+
+	/* Get current ART and TSC timestamp using HW cross-timestamping to
+	calculate relation between clocks */
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_SYS_OFFSET_PRECISE2,
+						&initial_offset));
+	if (ret < 0)
+		goto end;
+
+	smokey_warning("Start input sample.\n"
+			"Pin %d, channel %d\n"
+			"To interrupt, use Ctrl+C\n",
+			sample_setting.pin,
+			sample_setting.channel);
+
+	/* Update the event counter */
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_EVENT_COUNT_TSTAMP2, &events));
+	if (ret < 0)
+		goto end;
+
+	uint64_t previous_count = events.event_count;
+
+	while(running) {
+		if (!mode_interrupt) {
+			ret = smokey_check_errno(ioctl(fd,
+					RT_PTP_EVENT_COUNT_TSTAMP2, &events));
+			if (ret < 0)
+				goto end;
+			/* When the event count has changed from the original
+			value */
+			if (events.event_count != previous_count) {
+				/* We should convert ART timestamp read from
+				TGPIO to display correct timestamps for captured
+				edges. We use hardware cross-timestamping to read
+				ART and TSC clocks simultaneously. Two cross-
+				timestamps with some delay between allow to
+				calculate the clocks' speed ratio and convert
+				timestamps from one to another */
+
+				/* Get current ART and PCS timestamps using HW
+				cross-timestamping and calculate ART clock and
+				system clock speed ratio */
+				ret = smokey_check_errno(ioctl(fd,
+						RT_PTP_SYS_OFFSET_PRECISE2,
+							&current_offset));
+				if (ret < 0)
+					goto end;
+
+				uint64_t art_cur_ns =
+					ptptime2ns(current_offset.device);
+				uint64_t tsc_cur_ns =
+					ptptime2ns(current_offset.sys_realtime);
+				long double art_to_tsc_ratio = (long double)
+					(art_cur_ns -
+					ptptime2ns(initial_offset.device)) /
+						(tsc_cur_ns -
+					ptptime2ns(initial_offset.sys_realtime));
+
+				/* Convert TGPIO event timestamp to the system
+				clock */
+				int64_t delta = ptptime2ns(events.device_time) -
+					ptptime2ns(initial_offset.device);
+				uint64_t tsc_event =
+					ptptime2ns(initial_offset.sys_realtime)
+						+ delta / art_to_tsc_ratio;
+
+				smokey_warning("Poll mode detected edge on"
+						"channel %d at %s.%09lu \n",
+					events.index,
+					convert_to_human_readable(tsc_event /
+							TCC_NSEC_PER_SEC),
+					tsc_event % TCC_NSEC_PER_SEC);
+
+				previous_count = events.event_count;
+			}
+			/* Poll frequency 10 KHz. Even if signal edge occurs when
+			application is sleeping, it will be captured by TGPIO
+			HW and application will get the precise timestamp of the
+			edge after resuming on the next iteration*/
+			usleep(SLEEP_TIME_USEC);
+		} else {
+			ret = smokey_check_errno(read(fd, &event,
+					sizeof(struct rt_ptp_extts_event)));
+			if (ret < 0)
+				goto end;
+			ret = smokey_check_errno(ioctl(fd,
+						RT_PTP_SYS_OFFSET_PRECISE2,
+							&current_offset));
+			if (ret < 0)
+				goto end;
+			uint64_t art_cur_ns = ptptime2ns(current_offset.device);
+			uint64_t tsc_cur_ns =
+					ptptime2ns(current_offset.sys_realtime);
+			long double art_to_tsc_ratio =
+					(long double)(art_cur_ns -
+					ptptime2ns(initial_offset.device)) /
+			(tsc_cur_ns - ptptime2ns(initial_offset.sys_realtime));
+
+			int64_t delta = ptptime2ns(event.t) -
+					ptptime2ns(initial_offset.device);
+			uint64_t tsc_event =
+					ptptime2ns(initial_offset.sys_realtime) +
+						delta / art_to_tsc_ratio;
+
+			smokey_warning("Interrupt mode detected edge on channel"
+					"%d at %s.%09lu \n",
+				event.index,
+				convert_to_human_readable(tsc_event /
+					TCC_NSEC_PER_SEC),
+				tsc_event % TCC_NSEC_PER_SEC);
+		}
+	}
+	smokey_warning("\nDone\n");
+end:
+	/* Shut down TGPIO pin */
+	request.flags = 0;
+	ioctl(fd, RT_PTP_EXTTS_REQUEST2, &request);
+	desc.func = 0;
+	ioctl(fd, RT_PTP_PIN_SETFUNC2, &desc);
+	close(fd);
+	return ret;
+}
+
+static int run_tgpio_info(struct smokey_test *t, int argc, char *const argv[])
+{
+	const char *device = NULL;
+	int fd, ret = 0;
+	struct rt_ptp_clock_caps caps = {0};
+	struct rt_ptp_pin_desc desc = {0};
+	int n_pins = 0;
+
+	smokey_parse_args(t, argc, argv);
+
+	if (!SMOKEY_ARG_ISSET(tgpio_info, device)) {
+		smokey_warning("missing device= specification");
+		return -EINVAL;
+	}
+
+	device = SMOKEY_ARG_STRING(tgpio_info, device);
+	fd = open(device, O_RDONLY|O_NONBLOCK);
+	if (fd < 0) {
+		ret = -errno;
+		smokey_warning("cannot open device %s [%s]",
+						device, symerror(ret));
+		return ret;
+	}
+
+	ret = smokey_check_errno(ioctl(fd, RT_PTP_CLOCK_GETCAPS2, &caps));
+	if (ret < 0)
+		goto end;
+
+	smokey_warning("Available capabilities:\n"
+			"  Pins: %d\n"
+			"  Input function  - External timestamp channels: %d\n"
+			"  Output function - Programmable periodic signals: %d\n"
+			"  Precise system-device cross-timestamps: %s\n",
+			caps.n_pins,
+			caps.n_ext_ts,
+			caps.n_per_out,
+			caps.cross_timestamping ? "Supported" : "Not supported");
+
+	n_pins = caps.n_pins;
+	if (n_pins > 0) {
+		smokey_warning("Available TGPIO pins:\n");
+		smokey_warning("Pin Name   Index   Used Function  Channel\n");
+		for (int i = 0; i < n_pins; i++) {
+			desc.index = (unsigned)i;
+			ret = smokey_check_errno(ioctl(fd, RT_PTP_PIN_GETFUNC2,
+							&desc));
+			if (ret < 0)
+				goto end;
+			smokey_warning("%s    %d       %s               %d\n",
+					desc.name, desc.index,
+					functions[desc.func], desc.chan);
+		}
+	}
+end:
+	close(fd);
+	return ret;
+}
+
+int main(int argc, char *const argv[])
+{
+	struct smokey_test *t;
+	int ret, fails = 0;
+
+	if (pvlist_empty(&smokey_test_list))
+		return 0;
+
+	for_each_smokey_test(t) {
+		ret = t->run(t, argc, argv);
+		if (ret) {
+			if (ret == -ENOSYS) {
+				smokey_note("%s skipped (no kernel support)",
+							t->name);
+				continue;
+			}
+			fails++;
+			if (smokey_keep_going)
+				continue;
+			if (smokey_verbose_mode)
+				error(1, -ret, "test %s failed", t->name);
+			return 1;
+		}
+		smokey_note("%s OK", t->name);
+	}
+	return fails != 0;
+}
-- 
2.25.1


