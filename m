From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <45eb5a2a-6255-f3b8-484a-151d9ce931ea@siemens.com>
Date: Thu, 14 Dec 2017 17:45:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] ipipe: Do not leak the preemption counter on
 interrupted migrations
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

If __schedule fails because of a pending signal, we have to re-enable
preemption before leaving __ipipe_migrate_head. Failing to do so causes
a leak and sooner or later a "scheduling while atomic" or similar
errors.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Sending separately as it seems critical.

 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index de3e8929a501..304399683e23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8672,10 +8672,10 @@ int __ipipe_migrate_head(void)
 	if (likely(__schedule(false)))
 		return 0;
 
-	if (signal_pending(p))
-		return -ERESTARTSYS;
+	BUG_ON(!signal_pending(p));
 
-	BUG();
+	preempt_enable();
+	return -ERESTARTSYS;
 }
 EXPORT_SYMBOL_GPL(__ipipe_migrate_head);
 
-- 
2.13.6

