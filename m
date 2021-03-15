From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt: Avoid reading time twice via xnstat_exectime_update
Message-ID: <ae5b0a97-510d-0977-6895-0ef3f44d698e@siemens.com>
Date: Mon, 15 Mar 2021 17:02:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This macro may unroll to instantiating 'date' twice. If that is a call
to some get-time function, as via xnstat_exectime_switch, we needlessly
do that twice.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/stat.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/stat.h b/include/cobalt/kernel/stat.h
index b08567b41c..3c059a54ff 100644
--- a/include/cobalt/kernel/stat.h
+++ b/include/cobalt/kernel/stat.h
@@ -44,9 +44,10 @@ typedef struct xnstat_exectime {
 /* Accumulate exectime of the current account until the given date. */
 #define xnstat_exectime_update(sched, date) \
 do { \
+	xnticks_t __date = date; \
 	(sched)->current_account->total += \
-		date - (sched)->last_account_switch; \
-	(sched)->last_account_switch = date; \
+		__date - (sched)->last_account_switch; \
+	(sched)->last_account_switch = __date; \
 	/* All changes must be committed before changing the current_account \
 	   reference in sched (required for xnintr_sync_stat_references) */ \
 	smp_wmb(); \
-- 
2.26.2

