From: Fino Meng <fino.meng@linux.intel.com>
Subject: [PATCH 3/4] cobalt/kernel: fix compile error for incompatible pointer
 type
Date: Fri, 18 Sep 2020 14:32:34 +0800
Message-Id: <20200918063234.8557-1-fino.meng@linux.intel.com>
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
To: xenomai@xenomai.org, jan.kiszka@siemens.com, fino.meng@intel.com

Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
Signed-off-by: Mingliang Hu <mingliang.hu@intel.com>
---
 include/cobalt/kernel/stat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/stat.h b/include/cobalt/kernel/stat.h
index b857cd19f..be529ad72 100644
--- a/include/cobalt/kernel/stat.h
+++ b/include/cobalt/kernel/stat.h
@@ -58,7 +58,7 @@ do { \
 #define xnstat_exectime_set_current(sched, new_account) \
 ({ \
 	xnstat_exectime_t *__prev; \
-	__prev = (xnstat_exectime_t *)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
+	__prev = (xnstat_exectime_t *)atomic_long_xchg((atomic_long_t *)&(sched)->current_account, (long)(new_account)); \
 	__prev; \
 })
 
-- 
2.20.1


