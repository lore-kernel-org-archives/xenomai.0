From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH V3 1/3] rtdm/testing: latmus: introduce latmus driver
Date: Wed, 21 Apr 2021 01:05:07 -0400
Message-Id: <20210421050509.31420-2-hongzhan.chen@intel.com>
In-Reply-To: <20210421050509.31420-1-hongzhan.chen@intel.com>
References: <20210421050509.31420-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

To support the latmus application for determining the best
gravity values for the cobalt core clock, and measuring
the response time to timer events.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 include/rtdm/uapi/testing.h     |   63 ++
 kernel/drivers/testing/Kconfig  |   10 +
 kernel/drivers/testing/Makefile |    3 +
 kernel/drivers/testing/latmus.c | 1237 +++++++++++++++++++++++++++++++
 4 files changed, 1313 insertions(+)
 create mode 100644 kernel/drivers/testing/latmus.c

diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
index f8207b8c7..b1723b9f8 100644
--- a/include/rtdm/uapi/testing.h
+++ b/include/rtdm/uapi/testing.h
@@ -118,6 +118,52 @@ struct rttst_heap_stathdr {
 	struct rttst_heap_stats *buf;
 };
 
+/* Latmus context types. */
+#define COBALT_LAT_IRQ   0
+#define COBALT_LAT_KERN  1
+#define COBALT_LAT_USER  2
+#define COBALT_LAT_SIRQ  3
+#define COBALT_LAT_LAST	COBALT_LAT_SIRQ
+
+struct latmus_setup {
+	__u32 type;
+	__u64 period;
+	__s32 priority;
+	__u32 cpu;
+	union {
+		struct {
+			__u32 verbosity;
+		} tune;
+		struct {
+			__u32 xfd;
+			__u32 hcells;
+		} measure;
+	} u;
+};
+
+/*
+ * The measurement record which the driver sends to userland each
+ * second through an xbuf channel.
+ */
+struct latmus_measurement {
+	__s64 sum_lat;
+	__s32 min_lat;
+	__s32 max_lat;
+	__u32 overruns;
+	__u32 samples;
+};
+
+struct latmus_measurement_result {
+	__u64 last_ptr;		/* (struct latmus_measurement __user *last) */
+	__u64 histogram_ptr;	/* (__s32 __user *histogram) */
+	__u32 len;
+};
+
+struct latmus_result {
+	__u64 data_ptr;		/* (void __user *data) */
+	__u32 len;
+};
+
 #define RTIOC_TYPE_TESTING		RTDM_CLASS_TESTING
 
 /*!
@@ -133,6 +179,8 @@ struct rttst_heap_stathdr {
 #define RTDM_SUBCLASS_RTDMTEST		3
 /** subclase name: "heapcheck" */
 #define RTDM_SUBCLASS_HEAPCHECK		4
+/** subclase name: "latmus" */
+#define RTDM_SUBCLASS_LATMUS		5
 /** @} */
 
 /*!
@@ -193,6 +241,21 @@ struct rttst_heap_stathdr {
 #define RTTST_RTIOC_HEAP_STAT_COLLECT \
 	_IOR(RTIOC_TYPE_TESTING, 0x45, int)
 
+#define RTTST_RTIOC_COBALT_LATIOC_TUNE \
+	_IOWR(RTIOC_TYPE_TESTING, 0x50, struct latmus_setup)
+
+#define RTTST_RTIOC_COBALT_LATIOC_MEASURE \
+	_IOWR(RTIOC_TYPE_TESTING, 0x51, struct latmus_setup)
+
+#define RTTST_RTIOC_COBALT_LATIOC_RUN \
+	_IOR(RTIOC_TYPE_TESTING, 0x52, struct latmus_result)
+
+#define RTTST_RTIOC_COBALT_LATIOC_PULSE \
+	_IOW(RTIOC_TYPE_TESTING, 0x53, __u64)
+
+#define RTTST_RTIOC_COBALT_LATIOC_RESET	\
+	_IO(RTIOC_TYPE_TESTING, 0x54)
+
 /** @} */
 
 #endif /* !_RTDM_UAPI_TESTING_H */
diff --git a/kernel/drivers/testing/Kconfig b/kernel/drivers/testing/Kconfig
index 88c043c82..d39338eb5 100644
--- a/kernel/drivers/testing/Kconfig
+++ b/kernel/drivers/testing/Kconfig
@@ -26,4 +26,14 @@ config XENO_DRIVERS_RTDMTEST
 	help
 	Kernel driver for performing RTDM unit tests.
 
+config XENO_DRIVERS_LATMUS
+	bool "Timer latency calibration and measurement"
+	depends on DOVETAIL && XENO_OPT_PIPE
+	default y
+	help
+	  This driver supports the latmus application for
+	  determining the best gravity values for the cobalt core
+	  clock, and measuring the response time to timer events.
+	  If in doubt, say 'Y'.
+
 endmenu
diff --git a/kernel/drivers/testing/Makefile b/kernel/drivers/testing/Makefile
index 09b076348..e323d8de7 100644
--- a/kernel/drivers/testing/Makefile
+++ b/kernel/drivers/testing/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
 obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
 obj-$(CONFIG_XENO_DRIVERS_RTDMTEST)   += xeno_rtdmtest.o
 obj-$(CONFIG_XENO_DRIVERS_HEAPCHECK)   += xeno_heapcheck.o
+obj-$(CONFIG_XENO_DRIVERS_LATMUS)	+= xeno_latmus.o
 
 xeno_timerbench-y := timerbench.o
 
@@ -11,3 +12,5 @@ xeno_switchtest-y := switchtest.o
 xeno_rtdmtest-y := rtdmtest.o
 
 xeno_heapcheck-y := heapcheck.o
+
+xeno_latmus-y := latmus.o
diff --git a/kernel/drivers/testing/latmus.c b/kernel/drivers/testing/latmus.c
new file mode 100644
index 000000000..bef662260
--- /dev/null
+++ b/kernel/drivers/testing/latmus.c
@@ -0,0 +1,1237 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Derived from Xenomai Cobalt's autotune driver, https://xenomai.org/
+ * Copyright (C) 2014, 2018 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/sort.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/fcntl.h>
+#include <cobalt/kernel/pipe.h>
+#include <cobalt/kernel/sched.h>
+#include <rtdm/ipc.h>
+#include <rtdm/testing.h>
+#include <rtdm/driver.h>
+#include <rtdm/compat.h>
+
+#define ONE_BILLION  1000000000
+#define TUNER_SAMPLING_TIME	500000000UL
+#define TUNER_WARMUP_STEPS	10
+#define TUNER_RESULT_STEPS	40
+
+#define progress(__runner, __fmt, __args...)				\
+	do {								\
+		if ((__runner)->verbosity > 1)				\
+			printk(XENO_INFO "latmus(%s) " __fmt "\n",	\
+			       (__runner)->name, ##__args);		\
+	} while (0)
+
+#define cobalt_init_xntimer_on_cpu(__timer, __cpu, __handler)		\
+		rtdm_timer_init_on_cpu(__timer, __handler,		\
+			#__handler, __cpu)
+
+struct latmus_message {
+	struct xnpipe_mh mh;
+	char data[];
+};
+
+struct tuning_score {
+	int pmean;
+	int stddev;
+	int minlat;
+	unsigned int step;
+	unsigned int gravity;
+};
+
+struct runner_state {
+	ktime_t ideal;
+	int offset;
+	int min_lat;
+	int max_lat;
+	int allmax_lat;
+	int prev_mean;
+	int prev_sqs;
+	int cur_sqs;
+	int sum;
+	unsigned int overruns;
+	unsigned int cur_samples;
+	unsigned int max_samples;
+};
+
+struct latmus_runner {
+	const char *name;
+	unsigned int (*get_gravity)(struct latmus_runner *runner);
+	void (*set_gravity)(struct latmus_runner *runner, unsigned int gravity);
+	unsigned int (*adjust_gravity)(struct latmus_runner *runner, int adjust);
+	int (*start)(struct latmus_runner *runner, ktime_t start_time);
+	void (*stop)(struct latmus_runner *runner);
+	void (*destroy)(struct latmus_runner *runner);
+	int (*add_sample)(struct latmus_runner *runner, ktime_t timestamp);
+	int (*run)(struct rtdm_fd *fd, struct latmus_runner *runner,
+			struct latmus_result *result);
+	void (*cleanup)(struct latmus_runner *runner);
+	struct runner_state state;
+	struct rtdm_event done;
+	int status;
+	int verbosity;
+	ktime_t period;
+	union {
+		struct {
+			struct tuning_score scores[TUNER_RESULT_STEPS];
+			int nscores;
+		};
+		struct {
+			unsigned int warmup_samples;
+			unsigned int warmup_limit;
+			int socketfd;
+			void *xbuf;
+			u32 hcells;
+			s32 *histogram;
+		};
+	};
+};
+
+struct irq_runner {
+	rtdm_timer_t timer;
+	struct latmus_runner runner;
+};
+
+struct kthread_runner {
+	rtdm_task_t kthread;
+	struct rtdm_event barrier;
+	ktime_t start_time;
+	struct latmus_runner runner;
+};
+
+struct uthread_runner {
+	rtdm_timer_t timer;
+	struct rtdm_event pulse;
+	struct latmus_runner runner;
+};
+
+struct sirq_runner {
+	int sirq;
+	struct sirq_runner * __percpu *sirq_percpu;
+	rtdm_timer_t timer;
+	struct latmus_runner runner;
+};
+
+struct latmus_state {
+	struct latmus_runner *runner;
+	rtdm_lock_t latmus_lock;
+};
+
+static inline void init_runner_base(struct latmus_runner *runner)
+{
+	rtdm_event_init(&runner->done, 0);
+	runner->status = 0;
+	runner->socketfd = -1;
+}
+
+static inline void destroy_runner_base(struct latmus_runner *runner)
+{
+	rtdm_event_destroy(&runner->done);
+	if (runner->cleanup)
+		runner->cleanup(runner);
+}
+
+static inline void done_sampling(struct latmus_runner *runner,
+				 int status)
+{
+	runner->status = status;
+	rtdm_event_signal(&runner->done);
+}
+
+static void send_measurement(struct latmus_runner *runner)
+{
+	struct runner_state *state = &runner->state;
+	struct latmus_measurement *meas;
+	struct latmus_message *mbuf;
+	int len;
+
+	len = sizeof(*meas) + sizeof(*mbuf);
+	mbuf = xnmalloc(len);
+	if (mbuf == NULL)
+		return;
+
+	meas = (struct latmus_measurement *)mbuf->data;
+	meas->min_lat = state->min_lat;
+	meas->max_lat = state->max_lat;
+	meas->sum_lat = state->sum;
+	meas->overruns = state->overruns;
+	meas->samples = state->cur_samples;
+
+	runner->xbuf = mbuf;
+	xnpipe_send(runner->socketfd, &mbuf->mh, len, XNPIPE_NORMAL);
+
+	/* Reset counters for next round. */
+	state->min_lat = INT_MAX;
+	state->max_lat = INT_MIN;
+	state->sum = 0;
+	state->overruns = 0;
+	state->cur_samples = 0;
+}
+
+static int add_measurement_sample(struct latmus_runner *runner,
+				  ktime_t timestamp)
+{
+	struct runner_state *state = &runner->state;
+	ktime_t period = runner->period;
+	int delta, cell, offset_delta;
+
+	/* Skip samples in warmup time. */
+	if (runner->warmup_samples < runner->warmup_limit) {
+		runner->warmup_samples++;
+		state->ideal = ktime_add(state->ideal, period);
+		return 0;
+	}
+
+	delta = (int)ktime_to_ns(ktime_sub(timestamp, state->ideal));
+	offset_delta = delta - state->offset;
+	if (offset_delta < state->min_lat)
+		state->min_lat = offset_delta;
+	if (offset_delta > state->max_lat)
+		state->max_lat = offset_delta;
+	if (offset_delta > state->allmax_lat) {
+		state->allmax_lat = offset_delta;
+		//trace_evl_latspot(offset_delta);
+		//trace_evl_trigger("latmus");
+	}
+
+	if (runner->histogram) {
+		cell = (offset_delta < 0 ? -offset_delta : offset_delta) / 1000; /* us */
+		if (cell >= runner->hcells)
+			cell = runner->hcells - 1;
+		runner->histogram[cell]++;
+	}
+
+	state->sum += offset_delta;
+	state->ideal = ktime_add(state->ideal, period);
+
+	while (delta > 0 &&
+		(unsigned int)delta > ktime_to_ns(period)) { /* period > 0 */
+		state->overruns++;
+		state->ideal = ktime_add(state->ideal, period);
+		delta -= ktime_to_ns(period);
+	}
+
+	if (++state->cur_samples >= state->max_samples)
+		send_measurement(runner);
+
+	return 0;	/* Always keep going. */
+}
+
+static int add_tuning_sample(struct latmus_runner *runner,
+			     ktime_t timestamp)
+{
+	struct runner_state *state = &runner->state;
+	int n, delta, cur_mean;
+
+	delta = (int)ktime_to_ns(ktime_sub(timestamp, state->ideal));
+	if (delta < state->min_lat)
+		state->min_lat = delta;
+	if (delta > state->max_lat)
+		state->max_lat = delta;
+	if (delta < 0)
+		delta = 0;
+
+	state->sum += delta;
+	state->ideal = ktime_add(state->ideal, runner->period);
+	n = ++state->cur_samples;
+
+	/* TAOCP (Vol 2), single-pass computation of variance. */
+	if (n == 1)
+		state->prev_mean = delta;
+	else {
+		cur_mean = state->prev_mean + (delta - state->prev_mean) / n;
+		state->cur_sqs = state->prev_sqs + (delta - state->prev_mean)
+			* (delta - cur_mean);
+		state->prev_mean = cur_mean;
+		state->prev_sqs = state->cur_sqs;
+	}
+
+	if (n >= state->max_samples) {
+		done_sampling(runner, 0);
+		return 1;	/* Finished. */
+	}
+
+	return 0;	/* Keep going. */
+}
+
+static void latmus_irq_handler(rtdm_timer_t *timer) /* hard irqs off */
+{
+	struct irq_runner *irq_runner;
+	ktime_t now;
+
+	irq_runner = container_of(timer, struct irq_runner, timer);
+	now = xnclock_read_raw(&nkclock);
+	if (irq_runner->runner.add_sample(&irq_runner->runner, now))
+		rtdm_timer_stop(timer);
+}
+
+static void destroy_irq_runner(struct latmus_runner *runner)
+{
+	struct irq_runner *irq_runner;
+
+	irq_runner = container_of(runner, struct irq_runner, runner);
+	rtdm_timer_destroy(&irq_runner->timer);
+	destroy_runner_base(runner);
+	kfree(irq_runner);
+}
+
+static unsigned int get_irq_gravity(struct latmus_runner *runner)
+{
+	return nkclock.gravity.irq;
+}
+
+static void set_irq_gravity(struct latmus_runner *runner, unsigned int gravity)
+{
+	nkclock.gravity.irq = gravity;
+}
+
+static unsigned int adjust_irq_gravity(struct latmus_runner *runner, int adjust)
+{
+	return nkclock.gravity.irq += adjust;
+}
+
+static int start_irq_runner(struct latmus_runner *runner,
+			    ktime_t start_time)
+{
+	struct irq_runner *irq_runner;
+
+	irq_runner = container_of(runner, struct irq_runner, runner);
+
+	rtdm_timer_start(&irq_runner->timer, start_time,
+				runner->period, RTDM_TIMERMODE_ABSOLUTE);
+
+	return 0;
+}
+
+static void stop_irq_runner(struct latmus_runner *runner)
+{
+	struct irq_runner *irq_runner;
+
+	irq_runner = container_of(runner, struct irq_runner, runner);
+
+	rtdm_timer_stop(&irq_runner->timer);
+}
+
+static struct latmus_runner *create_irq_runner(int cpu)
+{
+	struct irq_runner *irq_runner;
+
+	irq_runner = kzalloc(sizeof(*irq_runner), GFP_KERNEL);
+	if (irq_runner == NULL)
+		return NULL;
+
+	irq_runner->runner = (struct latmus_runner){
+		.name = "irqhand",
+		.destroy = destroy_irq_runner,
+		.get_gravity = get_irq_gravity,
+		.set_gravity = set_irq_gravity,
+		.adjust_gravity = adjust_irq_gravity,
+		.start = start_irq_runner,
+		.stop = stop_irq_runner,
+	};
+
+	init_runner_base(&irq_runner->runner);
+	cobalt_init_xntimer_on_cpu(&irq_runner->timer, cpu, latmus_irq_handler);
+
+	return &irq_runner->runner;
+}
+
+static irqreturn_t latmus_sirq_handler(int sirq, void *dev_id)
+{
+	struct sirq_runner * __percpu *self_percpu = dev_id;
+	struct sirq_runner *sirq_runner = *self_percpu;
+	ktime_t now;
+
+	now = xnclock_read_raw(&nkclock);
+	if (sirq_runner->runner.add_sample(&sirq_runner->runner, now))
+		rtdm_timer_stop(&sirq_runner->timer);
+
+	return IRQ_HANDLED;
+}
+
+static void latmus_sirq_timer_handler(rtdm_timer_t *timer) /* hard irqs off */
+{
+	struct sirq_runner *sirq_runner;
+	struct runner_state *state;
+	ktime_t now;
+
+	now = xnclock_read_raw(&nkclock);
+	sirq_runner = container_of(timer, struct sirq_runner, timer);
+	state = &sirq_runner->runner.state;
+	state->offset = (int)ktime_to_ns(ktime_sub(now, state->ideal));
+	irq_post_inband(sirq_runner->sirq);
+}
+
+static void destroy_sirq_runner(struct latmus_runner *runner)
+{
+	struct sirq_runner *sirq_runner;
+
+	sirq_runner = container_of(runner, struct sirq_runner, runner);
+	rtdm_timer_destroy(&sirq_runner->timer);
+	free_percpu_irq(sirq_runner->sirq, sirq_runner->sirq_percpu);
+	free_percpu(sirq_runner->sirq_percpu);
+	irq_dispose_mapping(sirq_runner->sirq);
+	destroy_runner_base(runner);
+	kfree(sirq_runner);
+}
+
+static int start_sirq_runner(struct latmus_runner *runner,
+			ktime_t start_time)
+{
+	struct sirq_runner *sirq_runner;
+
+	sirq_runner = container_of(runner, struct sirq_runner, runner);
+
+	rtdm_timer_start(&sirq_runner->timer, start_time,
+				runner->period, RTDM_TIMERMODE_ABSOLUTE);
+
+	return 0;
+}
+
+static void stop_sirq_runner(struct latmus_runner *runner)
+{
+	struct sirq_runner *sirq_runner;
+
+	sirq_runner = container_of(runner, struct sirq_runner, runner);
+
+	rtdm_timer_stop(&sirq_runner->timer);
+}
+
+static struct latmus_runner *create_sirq_runner(int cpu)
+{
+	struct sirq_runner * __percpu *sirq_percpu;
+	struct sirq_runner *sirq_runner;
+	int sirq, ret, _cpu;
+
+	sirq_percpu = alloc_percpu(struct sirq_runner *);
+	if (sirq_percpu == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	sirq_runner = kzalloc(sizeof(*sirq_runner), GFP_KERNEL);
+	if (sirq_runner == NULL) {
+		free_percpu(sirq_percpu);
+		return NULL;
+	}
+
+	sirq = irq_create_direct_mapping(synthetic_irq_domain);
+	if (sirq == 0) {
+		free_percpu(sirq_percpu);
+		kfree(sirq_runner);
+		return ERR_PTR(-EAGAIN);
+	}
+
+	sirq_runner->runner = (struct latmus_runner){
+		.name = "sirqhand",
+		.destroy = destroy_sirq_runner,
+		.start = start_sirq_runner,
+		.stop = stop_sirq_runner,
+	};
+	sirq_runner->sirq = sirq;
+	sirq_runner->sirq_percpu = sirq_percpu;
+	init_runner_base(&sirq_runner->runner);
+	cobalt_init_xntimer_on_cpu(&sirq_runner->timer, cpu,
+			latmus_sirq_timer_handler);
+
+	for_each_possible_cpu(_cpu)
+		*per_cpu_ptr(sirq_percpu, _cpu) = sirq_runner;
+
+	ret = __request_percpu_irq(sirq, latmus_sirq_handler,
+				IRQF_NO_THREAD,
+				"latmus sirq",
+				sirq_percpu);
+	if (ret) {
+		rtdm_timer_destroy(&sirq_runner->timer);
+		irq_dispose_mapping(sirq);
+		free_percpu(sirq_percpu);
+		kfree(sirq_runner);
+		return ERR_PTR(ret);
+	}
+
+	return &sirq_runner->runner;
+}
+
+void kthread_handler(void *arg)
+{
+	struct kthread_runner *k_runner = arg;
+	ktime_t now;
+	int ret = 0;
+
+	for (;;) {
+		if (rtdm_task_should_stop())
+			break;
+
+		ret = rtdm_event_wait(&k_runner->barrier);
+		if (ret)
+			break;
+
+		ret = rtdm_task_set_period(&k_runner->kthread,
+					k_runner->start_time,
+					k_runner->runner.period);
+		if (ret)
+			break;
+
+		for (;;) {
+			ret = rtdm_task_wait_period(NULL);
+			if (ret && ret != -ETIMEDOUT)
+				goto out;
+
+			now = xnclock_read_raw(&nkclock);
+			if (k_runner->runner.add_sample(&k_runner->runner, now)) {
+				rtdm_task_set_period(&k_runner->kthread, 0, 0);
+				break;
+			}
+		}
+	}
+out:
+	done_sampling(&k_runner->runner, ret);
+	rtdm_task_destroy(&k_runner->kthread);
+}
+
+static void destroy_kthread_runner(struct latmus_runner *runner)
+{
+	struct kthread_runner *k_runner;
+
+	k_runner = container_of(runner, struct kthread_runner, runner);
+	rtdm_task_destroy(&k_runner->kthread);
+	rtdm_event_destroy(&k_runner->barrier);
+	destroy_runner_base(runner);
+	kfree(k_runner);
+}
+
+static unsigned int get_kthread_gravity(struct latmus_runner *runner)
+{
+	return nkclock.gravity.kernel;
+}
+
+static void
+set_kthread_gravity(struct latmus_runner *runner, unsigned int gravity)
+{
+	nkclock.gravity.kernel = gravity;
+}
+
+static unsigned int
+adjust_kthread_gravity(struct latmus_runner *runner, int adjust)
+{
+	return nkclock.gravity.kernel += adjust;
+}
+
+static int start_kthread_runner(struct latmus_runner *runner,
+				ktime_t start_time)
+{
+	struct kthread_runner *k_runner;
+
+	k_runner = container_of(runner, struct kthread_runner, runner);
+
+	k_runner->start_time = start_time;
+	rtdm_event_signal(&k_runner->barrier);
+
+	return 0;
+}
+
+static struct latmus_runner *
+create_kthread_runner(int priority, int cpu)
+{
+	struct kthread_runner *k_runner;
+	int ret;
+	char *taskname;
+
+	k_runner = kzalloc(sizeof(*k_runner), GFP_KERNEL);
+	if (k_runner == NULL)
+		return NULL;
+
+	k_runner->runner = (struct latmus_runner){
+		.name = "kthread",
+		.destroy = destroy_kthread_runner,
+		.get_gravity = get_kthread_gravity,
+		.set_gravity = set_kthread_gravity,
+		.adjust_gravity = adjust_kthread_gravity,
+		.start = start_kthread_runner,
+	};
+
+	init_runner_base(&k_runner->runner);
+	rtdm_event_init(&k_runner->barrier, 0);
+
+	taskname = kasprintf(GFP_KERNEL, "latmus-klat:%d",
+			task_pid_nr(current));
+	ret = rtdm_task_init_on_cpu(&k_runner->kthread, cpu,
+				taskname,
+				kthread_handler,
+				k_runner,
+				priority,
+				0);
+	kfree(taskname);
+	if (ret) {
+		kfree(k_runner);
+		return ERR_PTR(ret);
+	}
+
+	return &k_runner->runner;
+}
+
+static void latmus_pulse_handler(rtdm_timer_t *timer)
+{
+	struct uthread_runner *u_runner;
+
+	u_runner = container_of(timer, struct uthread_runner, timer);
+	rtdm_event_signal(&u_runner->pulse);
+}
+
+static void destroy_uthread_runner(struct latmus_runner *runner)
+{
+	struct uthread_runner *u_runner;
+
+	u_runner = container_of(runner, struct uthread_runner, runner);
+	rtdm_timer_destroy(&u_runner->timer);
+	rtdm_event_destroy(&u_runner->pulse);
+	destroy_runner_base(runner);
+	kfree(u_runner);
+}
+
+static unsigned int get_uthread_gravity(struct latmus_runner *runner)
+{
+	return nkclock.gravity.user;
+}
+
+static void set_uthread_gravity(struct latmus_runner *runner,
+				unsigned int gravity)
+{
+	nkclock.gravity.user = gravity;
+}
+
+static unsigned int
+adjust_uthread_gravity(struct latmus_runner *runner, int adjust)
+{
+	return nkclock.gravity.user += adjust;
+}
+
+static int start_uthread_runner(struct latmus_runner *runner,
+				ktime_t start_time)
+{
+	struct uthread_runner *u_runner;
+
+	u_runner = container_of(runner, struct uthread_runner, runner);
+
+	rtdm_timer_start(&u_runner->timer, start_time,
+				runner->period, RTDM_TIMERMODE_ABSOLUTE);
+
+	return 0;
+}
+
+static void stop_uthread_runner(struct latmus_runner *runner)
+{
+	struct uthread_runner *u_runner;
+
+	u_runner = container_of(runner, struct uthread_runner, runner);
+
+	rtdm_timer_stop(&u_runner->timer);
+}
+
+static int add_uthread_sample(struct latmus_runner *runner,
+			      ktime_t user_timestamp)
+{
+	struct uthread_runner *u_runner;
+	int ret;
+
+	u_runner = container_of(runner, struct uthread_runner, runner);
+
+	if (user_timestamp &&
+	    u_runner->runner.add_sample(runner, user_timestamp)) {
+		rtdm_timer_stop(&u_runner->timer);
+		/* Tell the caller to park until next round. */
+		ret = -EPIPE;
+	} else {
+		ret = rtdm_event_wait(&u_runner->pulse);
+	}
+
+	return ret;
+}
+
+static struct latmus_runner *create_uthread_runner(int cpu)
+{
+	struct uthread_runner *u_runner;
+
+	u_runner = kzalloc(sizeof(*u_runner), GFP_KERNEL);
+	if (u_runner == NULL)
+		return NULL;
+
+	u_runner->runner = (struct latmus_runner){
+		.name = "uthread",
+		.destroy = destroy_uthread_runner,
+		.get_gravity = get_uthread_gravity,
+		.set_gravity = set_uthread_gravity,
+		.adjust_gravity = adjust_uthread_gravity,
+		.start = start_uthread_runner,
+		.stop = stop_uthread_runner,
+	};
+
+	init_runner_base(&u_runner->runner);
+	cobalt_init_xntimer_on_cpu(&u_runner->timer, cpu, latmus_pulse_handler);
+	xntimer_set_gravity(&u_runner->timer, XNTIMER_UGRAVITY);
+	rtdm_event_init(&u_runner->pulse, 0);
+
+	return &u_runner->runner;
+}
+
+static inline void build_score(struct latmus_runner *runner, int step)
+{
+	struct runner_state *state = &runner->state;
+	unsigned int variance, n;
+
+	n = state->cur_samples;
+	runner->scores[step].pmean = state->sum / n;
+	variance = n > 1 ? state->cur_sqs / (n - 1) : 0;
+	runner->scores[step].stddev = int_sqrt(variance);
+	runner->scores[step].minlat = state->min_lat;
+	runner->scores[step].gravity = runner->get_gravity(runner);
+	runner->scores[step].step = step;
+	runner->nscores++;
+}
+
+static int cmp_score_mean(const void *c, const void *r)
+{
+	const struct tuning_score *sc = c, *sr = r;
+
+	return sc->pmean - sr->pmean;
+}
+
+static int cmp_score_stddev(const void *c, const void *r)
+{
+	const struct tuning_score *sc = c, *sr = r;
+
+	return sc->stddev - sr->stddev;
+}
+
+static int cmp_score_minlat(const void *c, const void *r)
+{
+	const struct tuning_score *sc = c, *sr = r;
+
+	return sc->minlat - sr->minlat;
+}
+
+static int cmp_score_gravity(const void *c, const void *r)
+{
+	const struct tuning_score *sc = c, *sr = r;
+
+	return sc->gravity - sr->gravity;
+}
+
+static int filter_mean(struct latmus_runner *runner)
+{
+	sort(runner->scores, runner->nscores,
+	     sizeof(struct tuning_score),
+	     cmp_score_mean, NULL);
+
+	/* Top half of the best pondered means. */
+
+	return (runner->nscores + 1) / 2;
+}
+
+static int filter_stddev(struct latmus_runner *runner)
+{
+	sort(runner->scores, runner->nscores,
+	     sizeof(struct tuning_score),
+	     cmp_score_stddev, NULL);
+
+	/* Top half of the best standard deviations. */
+
+	return (runner->nscores + 1) / 2;
+}
+
+static int filter_minlat(struct latmus_runner *runner)
+{
+	sort(runner->scores, runner->nscores,
+	     sizeof(struct tuning_score),
+	     cmp_score_minlat, NULL);
+
+	/* Top half of the minimum latencies. */
+
+	return (runner->nscores + 1) / 2;
+}
+
+static int filter_gravity(struct latmus_runner *runner)
+{
+	sort(runner->scores, runner->nscores,
+	     sizeof(struct tuning_score),
+	     cmp_score_gravity, NULL);
+
+	/* Smallest gravity required among the shortest latencies. */
+
+	return runner->nscores;
+}
+
+static void dump_scores(struct latmus_runner *runner)
+{
+	int n;
+
+	if (runner->verbosity < 2)
+		return;
+
+	for (n = 0; n < runner->nscores; n++)
+		printk(XENO_INFO
+		       ".. S%.2d pmean=%d stddev=%d minlat=%d gravity=%u\n",
+		       runner->scores[n].step,
+		       runner->scores[n].pmean,
+		       runner->scores[n].stddev,
+		       runner->scores[n].minlat,
+		       runner->scores[n].gravity);
+}
+
+static inline void filter_score(struct latmus_runner *runner,
+				int (*filter)(struct latmus_runner *runner))
+{
+	runner->nscores = filter(runner);
+	dump_scores(runner);
+}
+
+static void __latmus_free_handler(void *buf, void *skarg) /* nklock free */
+{
+	struct latmus_runner *runner = skarg;
+
+	xnfree(runner->xbuf);
+}
+
+static int measure_continously(struct latmus_runner *runner)
+{
+	struct runner_state *state = &runner->state;
+	ktime_t period = runner->period;
+	int ret;
+
+	state->max_samples = ONE_BILLION / (int)ktime_to_ns(period);
+	runner->add_sample = add_measurement_sample;
+	state->min_lat = INT_MAX;
+	state->max_lat = INT_MIN;
+	state->allmax_lat = INT_MIN;
+	state->sum = 0;
+	state->overruns = 0;
+	state->cur_samples = 0;
+	state->offset = 0;	/* for SIRQ latency only. */
+	state->ideal = ktime_add(xnclock_read_raw(&nkclock), period);
+
+	ret = runner->start(runner, state->ideal);
+	if (ret)
+		goto out;
+
+	ret = rtdm_event_wait(&runner->done) ?: runner->status;
+
+	if (runner->stop)
+		runner->stop(runner);
+out:
+	return ret;
+}
+
+static int tune_gravity(struct latmus_runner *runner)
+{
+	struct runner_state *state = &runner->state;
+	int ret, step, gravity_limit, adjust;
+	ktime_t period = runner->period;
+	unsigned int orig_gravity;
+
+	state->max_samples = TUNER_SAMPLING_TIME / (int)ktime_to_ns(period);
+	orig_gravity = runner->get_gravity(runner);
+	runner->add_sample = add_tuning_sample;
+	runner->set_gravity(runner, 0);
+	runner->nscores = 0;
+	adjust = 500; /* Gravity adjustment step */
+	gravity_limit = 0;
+	progress(runner, "warming up...");
+
+	for (step = 0; step < TUNER_WARMUP_STEPS + TUNER_RESULT_STEPS; step++) {
+		state->ideal = ktime_add_ns(xnclock_read_raw(&nkclock),
+			    ktime_to_ns(period) * TUNER_WARMUP_STEPS);
+		state->min_lat = INT_MAX;
+		state->max_lat = INT_MIN;
+		state->prev_mean = 0;
+		state->prev_sqs = 0;
+		state->cur_sqs = 0;
+		state->sum = 0;
+		state->cur_samples = 0;
+
+		ret = runner->start(runner, state->ideal);
+		if (ret)
+			goto fail;
+
+		/* Runner stops when posting. */
+		ret = rtdm_event_wait(&runner->done);
+		if (ret)
+			goto fail;
+
+		ret = runner->status;
+		if (ret)
+			goto fail;
+
+		if (step < TUNER_WARMUP_STEPS) {
+			if (state->min_lat > gravity_limit) {
+				gravity_limit = state->min_lat;
+				progress(runner, "gravity limit set to %u ns (%d)",
+					 gravity_limit, state->min_lat);
+			}
+			continue;
+		}
+
+		if (state->min_lat < 0) {
+			if (runner->get_gravity(runner) < -state->min_lat) {
+				printk(XENO_WARNING
+				       "latmus(%s) failed with early shot (%d ns)\n",
+				       runner->name,
+				       -(runner->get_gravity(runner) + state->min_lat));
+				ret = -EAGAIN;
+				goto fail;
+			}
+			break;
+		}
+
+		if (((step - TUNER_WARMUP_STEPS) % 5) == 0)
+			progress(runner, "calibrating... (slice %d)",
+				 (step - TUNER_WARMUP_STEPS) / 5 + 1);
+
+		build_score(runner, step - TUNER_WARMUP_STEPS);
+
+		/*
+		 * Anticipating by more than the minimum latency
+		 * detected at warmup would make no sense: cap the
+		 * gravity we may try.
+		 */
+		if (runner->adjust_gravity(runner, adjust) > gravity_limit) {
+			progress(runner, "beyond gravity limit at %u ns",
+				 runner->get_gravity(runner));
+			break;
+		}
+	}
+
+	progress(runner, "calibration scores");
+	dump_scores(runner);
+	progress(runner, "pondered mean filter");
+	filter_score(runner, filter_mean);
+	progress(runner, "standard deviation filter");
+	filter_score(runner, filter_stddev);
+	progress(runner, "minimum latency filter");
+	filter_score(runner, filter_minlat);
+	progress(runner, "gravity filter");
+	filter_score(runner, filter_gravity);
+	runner->set_gravity(runner, runner->scores[0].gravity);
+
+	return 0;
+fail:
+	runner->set_gravity(runner, orig_gravity);
+
+	return ret;
+}
+
+static int setup_tuning(struct latmus_runner *runner,
+			struct latmus_setup *setup)
+{
+	runner->verbosity = setup->u.tune.verbosity;
+	runner->period = setup->period;
+
+	return 0;
+}
+
+static int run_tuning(struct rtdm_fd *fd,
+		struct latmus_runner *runner,
+		struct latmus_result *result)
+{
+	__u32 gravity;
+	int ret;
+
+	ret = tune_gravity(runner);
+	if (ret)
+		return ret;
+
+	gravity = runner->get_gravity(runner);
+
+	if (rtdm_safe_copy_to_user(fd, (void *)(long)result->data_ptr,
+				&gravity, sizeof(gravity)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int setup_measurement(struct latmus_runner *runner,
+			     struct latmus_setup *setup)
+{
+	struct xnpipe_operations ops;
+	int xnpipefd;
+
+	memset(&ops, 0, sizeof(ops));
+	ops.free_obuf = &__latmus_free_handler;
+	xnpipefd = xnpipe_connect(-1, &ops, runner);
+	if (xnpipefd < 0)
+		return xnpipefd;
+	runner->socketfd = xnpipefd;
+	runner->period = setup->period;
+	runner->warmup_limit = ONE_BILLION / (int)ktime_to_ns(setup->period); /* 1s warmup */
+	runner->histogram = NULL;
+	runner->hcells = setup->u.measure.hcells;
+	if (runner->hcells == 0)
+		return 0;
+
+	if (runner->hcells > 1000) /* LART */
+		return -EINVAL;
+
+	runner->histogram = kzalloc(runner->hcells * sizeof(s32),
+				    GFP_KERNEL);
+
+	return runner->histogram ? 0 : -ENOMEM;
+}
+
+static int run_measurement(struct rtdm_fd *fd,
+			struct latmus_runner *runner,
+			struct latmus_result *result)
+{
+	struct runner_state *state = &runner->state;
+	struct latmus_measurement_result mr;
+	struct latmus_measurement last;
+	size_t len;
+	int ret;
+
+	if (result->len != sizeof(mr))
+		return -EINVAL;
+
+	if (rtdm_safe_copy_from_user(fd, &mr, (void *)(long)result->data_ptr,
+				sizeof(mr)))
+		return -EFAULT;
+
+	ret = measure_continously(runner);
+	if (ret != -EINTR)
+		return ret;
+
+	/*
+	 * Copy the last bulk of consolidated measurements and the
+	 * histogram distribution data back to userland.
+	 */
+	last.min_lat = state->min_lat;
+	last.max_lat = state->max_lat;
+	last.sum_lat = state->sum;
+	last.overruns = state->overruns;
+	last.samples = state->cur_samples;
+	if (rtdm_safe_copy_to_user(fd, (void *)(long)mr.last_ptr,
+				&last, sizeof(last)))
+		return -EFAULT;
+
+	if (runner->histogram) {
+		len = runner->hcells * sizeof(s32);
+		if (len > mr.len)
+			len = result->len;
+		if (len > 0 &&
+		    rtdm_safe_copy_to_user(fd, (void *)(long)mr.histogram_ptr,
+					   runner->histogram, len))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static void cleanup_measurement(struct latmus_runner *runner)
+{
+	if (runner->socketfd >= 0) {
+		xnpipe_disconnect(runner->socketfd);
+		runner->socketfd = -1;
+	}
+
+	if (runner->histogram)
+		kfree(runner->histogram);
+}
+
+static int latmus_ioctl(struct rtdm_fd *fd, unsigned int cmd, void *arg)
+{
+	struct latmus_state *ls = rtdm_fd_to_private(fd);
+	int (*setup)(struct latmus_runner *runner,
+		     struct latmus_setup *setup_data);
+	int (*run)(struct rtdm_fd *fd,
+		struct latmus_runner *runner,
+		struct latmus_result *result);
+	void (*cleanup)(struct latmus_runner *runner);
+	struct latmus_setup setup_data;
+	struct latmus_runner *runner;
+	int ret;
+
+	if (cmd == RTTST_RTIOC_COBALT_LATIOC_RESET) {
+		xnclock_reset_gravity(&nkclock);
+		return 0;
+	}
+
+	/* All other cmds require a setup struct to be passed. */
+
+	if (rtdm_copy_from_user(fd, &setup_data, arg, sizeof(setup_data)))
+		return -EFAULT;
+
+	if (setup_data.type == COBALT_LAT_SIRQ &&
+			cmd != RTTST_RTIOC_COBALT_LATIOC_MEASURE)
+		return -EINVAL;
+
+	switch (cmd) {
+	case RTTST_RTIOC_COBALT_LATIOC_TUNE:
+		setup = setup_tuning;
+		run = run_tuning;
+		cleanup = NULL;
+		break;
+	case RTTST_RTIOC_COBALT_LATIOC_MEASURE:
+		setup = setup_measurement;
+		run = run_measurement;
+		cleanup = cleanup_measurement;
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	if (setup_data.period <= 0 ||
+	    setup_data.period > ONE_BILLION)
+		return -EINVAL;
+
+	if (setup_data.priority < 1 ||
+	    setup_data.priority > XNSCHED_FIFO_MAX_PRIO)
+		return -EINVAL;
+
+	if (setup_data.cpu >= num_possible_cpus() ||
+		!xnsched_supported_cpu(setup_data.cpu))
+		return -EINVAL;
+
+	/* Clear previous runner. */
+	runner = ls->runner;
+	if (runner) {
+		runner->destroy(runner);
+		ls->runner = NULL;
+	}
+
+	switch (setup_data.type) {
+	case COBALT_LAT_IRQ:
+		runner = create_irq_runner(setup_data.cpu);
+		break;
+	case COBALT_LAT_KERN:
+		runner = create_kthread_runner(setup_data.priority,
+					       setup_data.cpu);
+		break;
+	case COBALT_LAT_USER:
+		runner = create_uthread_runner(setup_data.cpu);
+		break;
+	case COBALT_LAT_SIRQ:
+		runner = create_sirq_runner(setup_data.cpu);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (IS_ERR(runner))
+		return PTR_ERR(runner);
+
+	ret = setup(runner, &setup_data);
+	if (ret) {
+		runner->destroy(runner);
+		return ret;
+	}
+
+	runner->run = run;
+	runner->cleanup = cleanup;
+	ls->runner = runner;
+
+	return ((cmd == RTTST_RTIOC_COBALT_LATIOC_MEASURE) ?
+			runner->socketfd : 0);
+}
+
+static int latmus_oob_ioctl(struct rtdm_fd *fd, unsigned int cmd, void *arg)
+{
+	struct latmus_state *ls = rtdm_fd_to_private(fd);
+	struct latmus_runner *runner;
+	struct latmus_result result;
+	__u64 timestamp;
+	int ret;
+
+	switch (cmd) {
+	case RTTST_RTIOC_COBALT_LATIOC_RUN:
+		runner = ls->runner;
+		if (runner == NULL)
+			return -EAGAIN;
+		ret = rtdm_safe_copy_from_user(fd, &result,
+				arg, sizeof(result));
+
+		if (ret)
+			return -EFAULT;
+		ret = runner->run(fd, runner, &result);
+		break;
+	case RTTST_RTIOC_COBALT_LATIOC_PULSE:
+		runner = ls->runner;
+		if (runner == NULL)
+			return -EAGAIN;
+		if (runner->start != start_uthread_runner)
+			return -EINVAL;
+		ret = rtdm_safe_copy_from_user(fd,  &timestamp,
+						arg, sizeof(timestamp));
+		if (ret)
+			return -EFAULT;
+		ret = add_uthread_sample(runner, ns_to_ktime(timestamp));
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	return ret;
+}
+
+static int latmus_open(struct rtdm_fd *fd, int oflags)
+{
+	struct latmus_state *ls;
+
+	ls = rtdm_fd_to_private(fd);
+	ls->runner = NULL;
+	rtdm_lock_init(&ls->latmus_lock);
+
+	return 0;
+}
+
+static void latmus_close(struct rtdm_fd *fd)
+{
+	struct latmus_state *ls = rtdm_fd_to_private(fd);
+	struct latmus_runner *runner;
+
+	runner = ls->runner;
+	if (runner)
+		runner->destroy(runner);
+
+}
+
+static struct rtdm_driver latmus_driver = {
+	.profile_info		= RTDM_PROFILE_INFO(latmus,
+						    RTDM_CLASS_TESTING,
+						    RTDM_SUBCLASS_LATMUS,
+						    RTTST_PROFILE_VER),
+	.device_flags		= RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
+	.device_count		= 1,
+	.context_size		= sizeof(struct latmus_state),
+	.ops = {
+		.open		= latmus_open,
+		.close		= latmus_close,
+		.ioctl_rt	= latmus_oob_ioctl,
+		.ioctl_nrt	= latmus_ioctl,
+	},
+};
+
+static struct rtdm_device device = {
+	.driver = &latmus_driver,
+	.label = "latmus",
+};
+
+static int __init __latmus_init(void)
+{
+	return rtdm_dev_register(&device);
+}
+
+static void __latmus_exit(void)
+{
+	rtdm_dev_unregister(&device);
+}
+
+module_init(__latmus_init);
+module_exit(__latmus_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.17.1


