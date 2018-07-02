From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8f2145ed-739c-a4c4-ff5e-98bd2335af3a@siemens.com>
Date: Mon, 2 Jul 2018 15:41:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] cobalt/posix/signal: Plug leak of pending signal
 struct on thread deletion
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

We need to free pending signals that have been allocated via
cobalt_signal_alloc() on thread destruction, or we will run out of them
quickly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/signal.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 7090754418..8e4d920b2d 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -177,6 +177,7 @@ void cobalt_signal_flush(struct cobalt_thread *thread)
 {
 	struct cobalt_sigpending *sigp, *tmp;
 	struct list_head *sigq;
+	spl_t s;
 	int n;
 
 	/*
@@ -195,8 +196,15 @@ void cobalt_signal_flush(struct cobalt_thread *thread)
 		 * detect this fact when deleting their respective
 		 * owners.
 		 */
-		list_for_each_entry_safe(sigp, tmp, sigq, next)
+		list_for_each_entry_safe(sigp, tmp, sigq, next) {
 			list_del_init(&sigp->next);
+			if ((void *)sigp >= sigpending_mem &&
+			    (void *)sigp < sigpending_mem + __SIGPOOL_SIZE) {
+				xnlock_get_irqsave(&nklock, s);
+				list_add_tail(&sigp->next, &sigpending_pool);
+				xnlock_put_irqrestore(&nklock, s);
+			}
+		}
 	}
 
 	sigemptyset(&thread->sigpending);
-- 
2.16.4

