From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 2/2] cobalt/rtdm: introduce new interfaces to init timer
Date: Tue,  9 Mar 2021 19:57:32 -0500
Message-Id: <20210310005732.13439-2-hongzhan.chen@intel.com>
In-Reply-To: <20210310005732.13439-1-hongzhan.chen@intel.com>
References: <20210310005732.13439-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Initialise timer on specified cpu or current cpu.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 42daaa5b2..4b4ee965d 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -966,6 +966,17 @@ enum rtdm_timer_mode {
 int rtdm_timer_init(rtdm_timer_t *timer, rtdm_timer_handler_t handler,
 		    const char *name);
 
+int rtdm_timer_init_on_cpu(rtdm_timer_t *timer, rtdm_timer_handler_t handler,
+		    const char *name, int cpu);
+
+static inline int rtdm_timer_init_cpu(rtdm_timer_t *timer,
+		rtdm_timer_handler_t handler, const char *name)
+{
+	int cpu = raw_smp_processor_id();
+
+	return rtdm_timer_init_on_cpu(timer, handler, name, cpu);
+}
+
 void rtdm_timer_destroy(rtdm_timer_t *timer);
 
 int rtdm_timer_start(rtdm_timer_t *timer, nanosecs_abs_t expiry,
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 1c999362e..4e00d4e02 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -604,6 +604,37 @@ int rtdm_timer_init(rtdm_timer_t *timer, rtdm_timer_handler_t handler,
 
 EXPORT_SYMBOL_GPL(rtdm_timer_init);
 
+/**
+ * @brief Initialise a timer on specified cpu
+ *
+ * @param[in,out] timer Timer handle
+ * @param[in] handler Handler to be called on timer expiry
+ * @param[in] name Optional timer name
+ * @param[in] cpu that run on
+ *
+ * @return 0 on success, otherwise negative error code
+ *
+ * @coretags{task-unrestricted}
+ */
+int rtdm_timer_init_on_cpu(rtdm_timer_t *timer,
+		rtdm_timer_handler_t handler, const char *name, int cpu)
+{
+	struct xnsched *sched;
+
+	if (!realtime_core_enabled())
+		return -ENOSYS;
+
+	sched = xnsched_struct(cpu);
+	if (sched == NULL)
+		return -EINVAL;
+
+	xntimer_init((timer), &nkclock, handler, sched, XNTIMER_IGRAVITY);
+	xntimer_set_name((timer), (name));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rtdm_timer_init_on_cpu);
+
 /**
  * @brief Destroy a timer
  *
-- 
2.17.1


