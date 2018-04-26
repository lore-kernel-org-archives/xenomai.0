From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d065542c-fe5d-ee6f-6a03-cfe26e156a3d@siemens.com>
Date: Thu, 26 Apr 2018 20:01:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RFC][PATCH] cobalt/synch: Do not drop PP on
 xnsynch_release if it wasn't committed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

We must not try to drop the prio ceiling in the kernel if it wasn't
committed yet. That could easily happen when using a prio-ceiling mutex
to wait on a cond-var.

This is not the most robust solution as it bases the decision on
userspace controlled state which could be corrupted.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

As written above, I'm wondering if we shouldn't mirror the state into
kernel space. Or do we have it somewhere already?

Also, could you have a second look at the whole PP thing Philippe. Are
there more imbalances possible? I'll think through that again as well.
TIA!

Test case will follow tomorrow (likely).

 kernel/cobalt/synch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
index 99397b01e..f2f10499b 100644
--- a/kernel/cobalt/synch.c
+++ b/kernel/cobalt/synch.c
@@ -942,12 +942,13 @@ bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
 	 */
 	xnlock_get_irqsave(&nklock, s);
 
-	if (synch->status & XNSYNCH_PP) {
+	h = atomic_cmpxchg(lockp, currh, XN_NO_HANDLE);
+
+	if (h & XNSYNCH_FLCEIL) {
 		clear_pp_boost(synch, curr);
 		need_resched = true;
 	}
 
-	h = atomic_cmpxchg(lockp, currh, XN_NO_HANDLE);
 	if ((h & ~XNSYNCH_FLCEIL) != currh)
 		/* FLCLAIM set, synch is contended. */
 		need_resched = transfer_ownership(synch, curr);
-- 
2.13.6

