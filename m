From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="o4DZcGApLB"
Content-Transfer-Encoding: 7bit
Message-ID: <18077.6065.115928.15934@domain.hid>
Date: Tue, 17 Jul 2007 21:25:37 +0200
Subject: [Xenomai-core] [patch] timers data structures wrap around fixes.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--o4DZcGApLB
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


Hi,

here comes a patch which should make the data structures used to store
timers objects safe with regard to tsc/jiffies wrap around.

-- 


					    Gilles Chanteperdrix.

--o4DZcGApLB
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-wrap-around-fixes.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/nucleus/timer.c
===================================================================
--- ksrc/nucleus/timer.c	(revision 2765)
+++ ksrc/nucleus/timer.c	(working copy)
@@ -212,7 +212,8 @@
 	while ((holder = xntimerq_head(timerq)) != NULL) {
 		timer = aplink2timer(holder);
 
-		if (xntimerh_date(&timer->aplink) - nklatency > now)
+		if ((xnsticks_t) (xntimerh_date(&timer->aplink) - now)
+		    > nklatency)
 			/* No need to continue in aperiodic mode since timeout
 			   dates are ordered by increasing values. */
 			break;
@@ -407,7 +408,8 @@
 	while ((holder = xntlist_head(timerq)) != NULL) {
 		timer = plink2timer(holder);
 
-		if (xntlholder_date(&timer->plink) > base->jiffies)
+		if ((xnsticks_t) (xntlholder_date(&timer->plink)
+				  - base->jiffies) > 0)
 			break;
 
 		xntimer_dequeue_periodic(timer);
Index: include/nucleus/timer.h
===================================================================
--- include/nucleus/timer.h	(revision 2765)
+++ include/nucleus/timer.h	(working copy)
@@ -86,7 +86,7 @@
 	   increased flexibility... */
 
 	for (p = q->head.last; p != &q->head; p = p->last)
-		if (holder->key > link2tlholder(p)->key ||
+		if ((xnsticks_t) (holder->key - link2tlholder(p)->key) > 0 ||
 		    (holder->key == link2tlholder(p)->key &&
 		     holder->prio <= link2tlholder(p)->prio))
 			break;
@@ -174,8 +174,8 @@
 		if ((xntlholder_date(candidate) >> q->date_shift) == q->next_shot)
 			return candidate;
 
-		if (!result
-		    || xntlholder_date(candidate) < xntlholder_date(result))
+		if (!result || (xnsticks_t) (xntlholder_date(candidate)
+					     - xntlholder_date(result)) < 0)
 			result = candidate;
 	}
 
@@ -191,7 +191,7 @@
 	unsigned long long shifted_date = xntlholder_date(h) >> q->date_shift;
 	unsigned bucket = ((unsigned) shifted_date) & XNTIMER_WHEELMASK;
 
-	if (shifted_date < q->next_shot)
+	if ((long long) (shifted_date - q->next_shot) < 0)
 		q->next_shot = shifted_date;
 	xntlist_insert(&q->bucket[bucket], h);
 }
Index: include/nucleus/bheap.h
===================================================================
--- include/nucleus/bheap.h	(revision 2765)
+++ include/nucleus/bheap.h	(working copy)
@@ -43,8 +43,8 @@
 #define bheaph_key(holder)  ((holder)->key)
 #define bheaph_prio(holder) ((holder)->prio)
 #define bheaph_pos(holder)  ((holder)->pos)
-#define bheaph_lt(h1, h2)   ((h1)->key < (h2)->key ||     \
-                             ((h1)->key == (h2)->key &&   \
+#define bheaph_lt(h1, h2)   ((long long) ((h1)->key - (h2)->key) < 0 ||	\
+                             ((h1)->key == (h2)->key &&			\
                               (h1)->prio > (h2)->prio))
 
 typedef struct bheap {

--o4DZcGApLB--

