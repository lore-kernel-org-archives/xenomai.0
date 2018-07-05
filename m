From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu,  5 Jul 2018 17:46:11 +0200
Message-Id: <cc1c4ff31dbfcb79c5920038daf21f19941e6f54.1530805570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1530805570.git.jan.kiszka@siemens.com>
References: <cover.1530805570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1530805570.git.jan.kiszka@siemens.com>
References: <cover.1530805570.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 4/4] cobalt/rtdm: Remove rtdm_ratelimit()
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

This should have been used only by rtdm_printk_ratelimited which was
switched to xnclock_ratelimit.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/rtdm/driver.h | 22 ------------------
 kernel/cobalt/rtdm/drvlib.c         | 46 -------------------------------------
 2 files changed, 68 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 1c7dcab635..72f75388da 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -1214,28 +1214,6 @@ void rtdm_mutex_destroy(rtdm_mutex_t *mutex);
 
 #define rtdm_printk(format, ...)	printk(format, ##__VA_ARGS__)
 
-struct rtdm_ratelimit_state {
-	rtdm_lock_t	lock;		/* protect the state */
-	nanosecs_abs_t  interval;
-	int		burst;
-	int		printed;
-	int		missed;
-	nanosecs_abs_t	begin;
-};
-
-int rtdm_ratelimit(struct rtdm_ratelimit_state *rs, const char *func);
-
-#define DEFINE_RTDM_RATELIMIT_STATE(name, interval_init, burst_init)	\
-	struct rtdm_ratelimit_state name = {				\
-		.lock		= RTDM_LOCK_UNLOCKED((name).lock),	\
-		.interval	= interval_init,			\
-		.burst		= burst_init,				\
-	}
-
-/* We use the Linux defaults */
-#define DEF_RTDM_RATELIMIT_INTERVAL	5000000000LL
-#define DEF_RTDM_RATELIMIT_BURST	10
-
 #define rtdm_printk_ratelimited(fmt, ...)  do {				\
 	if (xnclock_ratelimit())					\
 		printk(fmt, ##__VA_ARGS__);				\
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 4fdd9bc1f4..316d87b29d 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -2106,52 +2106,6 @@ int rtdm_munmap(void *ptr, size_t len)
 }
 EXPORT_SYMBOL_GPL(rtdm_munmap);
 
-/**
- * @brief Enforces a rate limit
- *
- * This function enforces a rate limit: not more than @a rs->burst callbacks
- * in every @a rs->interval.
- *
- * @param[in,out] rs rtdm_ratelimit_state data
- * @param[in] func name of calling function
- *
- * @return 0 means callback will be suppressed and 1 means go ahead and do it
- *
- * @coretags{unrestricted}
- */
-int rtdm_ratelimit(struct rtdm_ratelimit_state *rs, const char *func)
-{
-	rtdm_lockctx_t lock_ctx;
-	int ret;
-
-	if (!rs->interval)
-		return 1;
-
-	rtdm_lock_get_irqsave(&rs->lock, lock_ctx);
-
-	if (!rs->begin)
-		rs->begin = rtdm_clock_read();
-	if (rtdm_clock_read() >= rs->begin + rs->interval) {
-		if (rs->missed)
-			printk(KERN_WARNING "%s: %d callbacks suppressed\n",
-			       func, rs->missed);
-		rs->begin   = 0;
-		rs->printed = 0;
-		rs->missed  = 0;
-	}
-	if (rs->burst && rs->burst > rs->printed) {
-		rs->printed++;
-		ret = 1;
-	} else {
-		rs->missed++;
-		ret = 0;
-	}
-	rtdm_lock_put_irqrestore(&rs->lock, lock_ctx);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(rtdm_ratelimit);
-
 int rtdm_get_iovec(struct rtdm_fd *fd, struct iovec **iovp,
 		   const struct user_msghdr *msg,
 		   struct iovec *iov_fast)
-- 
2.16.4


