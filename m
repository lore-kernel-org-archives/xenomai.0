From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu,  5 Jul 2018 17:46:10 +0200
Message-Id: <5fe277d0c9632608b95c2e4c710e2de01ed43201.1530805570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1530805570.git.jan.kiszka@siemens.com>
References: <cover.1530805570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1530805570.git.jan.kiszka@siemens.com>
References: <cover.1530805570.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 3/4] cobalt/rtdm: Switch rtdm_printk_ratelimited
	to xnclock_ratelimit
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

Will allow to remove the RTDM-specific core.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/rtdm/driver.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 5a205852ef..1c7dcab635 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -1236,14 +1236,10 @@ int rtdm_ratelimit(struct rtdm_ratelimit_state *rs, const char *func);
 #define DEF_RTDM_RATELIMIT_INTERVAL	5000000000LL
 #define DEF_RTDM_RATELIMIT_BURST	10
 
-#define rtdm_printk_ratelimited(fmt, ...)  ({				\
-	static DEFINE_RTDM_RATELIMIT_STATE(_rs,				\
-					   DEF_RTDM_RATELIMIT_INTERVAL,	\
-					   DEF_RTDM_RATELIMIT_BURST);	\
-									\
-	if (rtdm_ratelimit(&_rs, __func__))				\
+#define rtdm_printk_ratelimited(fmt, ...)  do {				\
+	if (xnclock_ratelimit())					\
 		printk(fmt, ##__VA_ARGS__);				\
-})
+} while (0)
 
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
 static inline void *rtdm_malloc(size_t size)
-- 
2.16.4


