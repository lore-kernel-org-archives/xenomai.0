From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 3/5] cobalt/thread: skip boundary check for infinite
 round-robin time slice
Date: Mon, 14 Jan 2019 18:35:20 +0100
Message-Id: <20190114173522.25750-3-rpm@xenomai.org>
In-Reply-To: <20190114173522.25750-1-rpm@xenomai.org>
References: <20190114173522.25750-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Disabling round-robin is obtained by passing XN_INFINITE for quantum
to xnthread_set_slice(), which is zero: we don't want to check such
value against the clock gravity.

As a matter of fact, this bug may have prevented the RR mode to be
switched off for years, causing the routine to always fail early with
-EINVAL.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/thread.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 04c0b62d3..a43d2f1ad 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1471,16 +1471,14 @@ int xnthread_set_slice(struct xnthread *thread, xnticks_t quantum)
 	struct xnsched *sched;
 	spl_t s;
 
-	if (quantum <= xnclock_get_gravity(&nkclock, user))
-		return -EINVAL;
-
 	xnlock_get_irqsave(&nklock, s);
 
 	sched = thread->sched;
 	thread->rrperiod = quantum;
 
 	if (quantum != XN_INFINITE) {
-		if (thread->base_class->sched_tick == NULL) {
+		if (quantum <= xnclock_get_gravity(&nkclock, user) ||
+		    thread->base_class->sched_tick == NULL) {
 			xnlock_put_irqrestore(&nklock, s);
 			return -EINVAL;
 		}
-- 
2.17.2


