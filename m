From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu,  5 Jul 2018 17:46:08 +0200
Message-Id: <1a0859d098395088200d9385b48c8e4687dc2d04.1530805570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1530805570.git.jan.kiszka@siemens.com>
References: <cover.1530805570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1530805570.git.jan.kiszka@siemens.com>
References: <cover.1530805570.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 1/4] cobalt/kernel/xnclock: Introduce
	xnclock_ratelimit()
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

This will service as an internal building block for RT-safe rate-limited
printk (printk_ratelimit() is not suited). It's derived from the RTDM
variant, but simplied (central lock, static parameters). We will switch
rtdm_printk_ratelimited to this implementation later on.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/clock.h | 22 ++++++++++++++++++++++
 kernel/cobalt/clock.c         | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
index 8792dcff94..c26776a0ba 100644
--- a/include/cobalt/kernel/clock.h
+++ b/include/cobalt/kernel/clock.h
@@ -92,6 +92,14 @@ struct xnclock {
 #endif
 };
 
+struct xnclock_ratelimit_state {
+	xnticks_t interval;
+	xnticks_t begin;
+	int burst;
+	int printed;
+	int missed;
+};
+
 extern struct xnclock nkclock;
 
 extern unsigned long nktimerlat;
@@ -125,6 +133,20 @@ static inline xnticks_t xnclock_core_read_raw(void)
 	return t;
 }
 
+/* We use the Linux defaults */
+#define XN_RATELIMIT_INTERVAL	5000000000LL
+#define XN_RATELIMIT_BURST	10
+
+int __xnclock_ratelimit(struct xnclock_ratelimit_state *rs, const char *func);
+
+#define xnclock_ratelimit()	({					\
+	static struct xnclock_ratelimit_state __state = {		\
+		.interval	= XN_RATELIMIT_INTERVAL,		\
+		.burst		= XN_RATELIMIT_BURST,			\
+	};								\
+	__xnclock_ratelimit(&__state, __func__);			\
+})
+
 #ifdef CONFIG_XENO_OPT_EXTCLOCK
 
 static inline void xnclock_program_shot(struct xnclock *clock,
diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index 130cf340b2..272db32412 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -120,6 +120,41 @@ EXPORT_SYMBOL_GPL(xnclock_core_ticks_to_ns_rounded);
 EXPORT_SYMBOL_GPL(xnclock_core_ns_to_ticks);
 EXPORT_SYMBOL_GPL(xnclock_divrem_billion);
 
+DEFINE_PRIVATE_XNLOCK(ratelimit_lock);
+
+int __xnclock_ratelimit(struct xnclock_ratelimit_state *rs, const char *func)
+{
+	spl_t s;
+	int ret;
+
+	if (!rs->interval)
+		return 1;
+
+	xnlock_get_irqsave(&ratelimit_lock, s);
+
+	if (!rs->begin)
+		rs->begin = xnclock_read_realtime(&nkclock);
+	if (xnclock_read_realtime(&nkclock) >= rs->begin + rs->interval) {
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
+	xnlock_put_irqrestore(&ratelimit_lock, s);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__xnclock_ratelimit);
+
 void xnclock_core_local_shot(struct xnsched *sched)
 {
 	struct xntimerdata *tmd;
-- 
2.16.4


