From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/thread: Export __xnthread_discard
Message-ID: <ca133718-14d9-d542-7880-9f3a9eb3ff30@siemens.com>
Date: Wed, 15 Dec 2021 13:57:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

It's needed since f4dac53c04ae by switchtest, and that could be compiled
as module.

Reported-by: Lange Norbert <norbert.lange@andritz.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/thread.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 2e1667d197..debc5077b1 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -553,6 +553,7 @@ void __xnthread_discard(struct xnthread *thread)
 	xnthread_deregister(thread);
 	xnlock_put_irqrestore(&nklock, s);
 }
+EXPORT_SYMBOL_GPL(__xnthread_discard);
 
 /**
  * @fn void xnthread_init(struct xnthread *thread,const struct xnthread_init_attr *attr,struct xnsched_class *sched_class,const union xnsched_policy_param *sched_param)
-- 
2.31.1

