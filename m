Message-ID: <4EC4F67F.50401@domain.hid>
Date: Thu, 17 Nov 2011 12:56:47 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] rtdm: add rtdm_printk_ratelimited
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This patch implements a real-time safe rate-limited message printing
on kernel console similar to Linux's printk_ratelimited.

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
---
 include/rtdm/rtdm_driver.h |   31 +++++++++++++++++
 ksrc/skins/rtdm/drvlib.c   |   77 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 85624ed..4267bd7 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -1241,6 +1241,37 @@ static inline void rtdm_mutex_destroy(rtdm_mutex_t *mutex)
 
 #define rtdm_printk(format, ...)	printk(format, ##__VA_ARGS__)
 
+struct rtdm_ratelimit_state {
+	rtdm_lock_t	lock;		/* protect the state */
+	nanosecs_abs_t  interval;
+	int		burst;
+	int		printed;
+	int		missed;
+	nanosecs_abs_t	begin;
+};
+
+int rtdm_ratelimit(struct rtdm_ratelimit_state *rs, const char *func);
+
+#define DEFINE_RTDM_RATELIMIT_STATE(name, interval_init, burst_init)	\
+	struct rtdm_ratelimit_state name = {				\
+		.lock		= RTDM_LOCK_UNLOCKED,			\
+		.interval	= interval_init,			\
+		.burst		= burst_init,				\
+	}
+
+/* We use the Linux defaults */
+#define DEF_RTDM_RATELIMIT_INTERVAL	5000000000LL
+#define DEF_RTDM_RATELIMIT_BURST	10
+
+#define rtdm_printk_ratelimited(fmt, ...)  ({				\
+	static DEFINE_RTDM_RATELIMIT_STATE(_rs,				\
+					   DEF_RTDM_RATELIMIT_INTERVAL,	\
+					   DEF_RTDM_RATELIMIT_BURST);	\
+									\
+	if (rtdm_ratelimit(&_rs, __func__))				\
+		printk(fmt, ##__VA_ARGS__);				\
+})
+
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
 static inline void *rtdm_malloc(size_t size)
 {
diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
index 8c86705..06fa772 100644
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -2111,9 +2111,86 @@ int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len)
 EXPORT_SYMBOL_GPL(rtdm_munmap);
 #endif /* CONFIG_XENO_OPT_PERVASIVE || DOXYGEN_CPP */
 
+/**
+ * @brief Enforces a rate limit
+ *
+ * This function enforces a rate limit: not more than @rs->burst callbacks
+ * in every @rs->interval.
+ *
+ * @param[in,out] rtdm_ratelimit_state data
+ * @param[in] name of calling function
+ *
+ * @return 0 means callback will be suppressed and 1 means go ahead and do it
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Kernel-based task
+ * - User-space task (RT, non-RT)
+ *
+ * Rescheduling: possible.
+ */
+int rtdm_ratelimit(struct rtdm_ratelimit_state *rs, const char *func)
+{
+	rtdm_lockctx_t lock_ctx;
+	int ret;
+
+	if (!rs->interval)
+		return 1;
+
+	rtdm_lock_get_irqsave(&rs->lock, lock_ctx);
+
+	if (!rs->begin)
+		rs->begin = rtdm_clock_read();
+	if (rtdm_clock_read() >= rs->begin + rs->interval) {
+		if (rs->missed)
+			printk(KERN_WARNING "%s: %d callbacks suppressed\n",
+			       func, rs->missed);
+		rs->begin   = 0;
+		rs->printed = 0;
+		rs->missed  = 0;
+	}
+	if (rs->burst && rs->burst > rs->printed) {
+		rs->printed++;
+		ret = 1;
+	} else {
+		rs->missed++;
+		ret = 0;
+	}
+	rtdm_lock_put_irqrestore(&rs->lock, lock_ctx);
+
+	return ret;
+}
+EXPORT_SYMBOL(rtdm_ratelimit);
+
 #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 
 /**
+ * Real-time safe rate-limited message printing on kernel console
+ *
+ * @param[in] format Format string (conforming standard @c printf())
+ * @param ... Arguments referred by @a format
+ *
+ * @return On success, this service returns the number of characters printed.
+ * Otherwise, a negative error code is returned.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Interrupt service routine (consider the overhead!)
+ * - Kernel-based task
+ * - User-space task (RT, non-RT)
+ *
+ * Rescheduling: never in real-time context, possible in non-real-time
+ * environments.
+ */
+void rtdm_printk_ratelimited(const char *format, ...);
+
+/**
  * Real-time safe message printing on kernel console
  *
  * @param[in] format Format string (conforming standard @c printf())
-- 
1.7.4.1


