From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/posix/signal: Fix iteration over sigwaiters
Message-ID: <7eea68db-9ea0-052c-89c3-aa1a435a5b3d@siemens.com>
Date: Wed, 19 Jun 2019 17:23:40 +0200
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

Using thread both as the iteration variable and the source of the list
causes list_for_each_entry to derail after the first thread that has no
hit. This could be triggered by sending a process a signal that was in
sigwait, but not for that signal.

Fix this by using a stable list pointer.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I had already tagged 3.0.9, just not pushed yet - tag deleted again.

 kernel/cobalt/posix/signal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 7e0eb52e99..e75ce2b693 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -46,6 +46,7 @@ static int cobalt_signal_deliver(struct cobalt_thread *thread,
 {				/* nklocked, IRQs off */
 	struct cobalt_sigwait_context *swc;
 	struct xnthread_wait_context *wc;
+	struct list_head *sigwaiters;
 	int sig, ret;
 
 	sig = sigp->si.si_signo;
@@ -67,10 +68,11 @@ static int cobalt_signal_deliver(struct cobalt_thread *thread,
 	 * group, try to deliver to any thread from the same process
 	 * waiting for that signal.
 	 */
-	if (!group || list_empty(&thread->process->sigwaiters))
+	sigwaiters = &thread->process->sigwaiters;
+	if (!group || list_empty(sigwaiters))
 		return 0;
 
-	list_for_each_entry(thread, &thread->process->sigwaiters, signext) {
+	list_for_each_entry(thread, sigwaiters, signext) {
 		wc = xnthread_get_wait_context(&thread->threadbase);
 		swc = container_of(wc, struct cobalt_sigwait_context, wc);
 		if (sigismember(swc->set, sig))
-- 
2.16.4

