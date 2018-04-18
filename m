From: Jan Kiszka <jan.kiszka@siemens.com>
References: <ab079dfb-98cd-887b-6b54-33f0fa15f74b@siemens.com>
Message-ID: <7a7b6761-e304-d94f-a597-009829427f06@siemens.com>
Date: Wed, 18 Apr 2018 14:51:56 +0200
MIME-Version: 1.0
In-Reply-To: <ab079dfb-98cd-887b-6b54-33f0fa15f74b@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH 2/2] cobalt/synch: Clear PP boost prior to handing
 over the ownership
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Otherwise we first add the synch object to the new owner's boost list
before we remove it from the old one's, corrupting the list.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/synch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
index f1102a5df..8c217c247 100644
--- a/kernel/cobalt/synch.c
+++ b/kernel/cobalt/synch.c
@@ -942,6 +942,11 @@ bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
 	 */
 	xnlock_get_irqsave(&nklock, s);
 
+	if (synch->status & XNSYNCH_PP) {
+		clear_pp_boost(synch, curr);
+		need_resched = true;
+	}
+
 	h = atomic_cmpxchg(lockp, currh, XN_NO_HANDLE);
 	if ((h & ~XNSYNCH_FLCEIL) != currh)
 		/* FLCLAIM set, synch is contended. */
@@ -949,11 +954,6 @@ bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
 	else if (h != currh)	/* FLCEIL set, FLCLAIM clear. */
 		atomic_set(lockp, XN_NO_HANDLE);
 
-	if (synch->status & XNSYNCH_PP) {
-		clear_pp_boost(synch, curr);
-		need_resched = true;
-	}
-
 	xnlock_put_irqrestore(&nklock, s);
 
 	return need_resched;
-- 
2.13.6

