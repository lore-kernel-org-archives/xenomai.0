Subject: Re: [Xenomai-core] [patch, RFC] detect unhandled interrupts
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44F7346D.20602@domain.hid>
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<1157013092.4359.11.camel@domain.hid>  <44F7346D.20602@domain.hid>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 21:48:51 +0200
Message-Id: <1157053732.4359.73.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-08-31 at 21:11 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2006-08-29 at 21:28 +0200, Dmitry Adamushko wrote:
> >> Hello,
> >>
> >> Jan has rised this question initially and I was struggling last week
> >> to get his request eventually done :)
> >>
> >> The main idea is to prevent system lockups when the cross domain IRQ
> >> sharing isn't properly used (there were a number of reports recently).
> >>
> >> So here is an initial patch as well as some related critics (yep, I
> >> critisize my own patch).
> > 
> > [...]
> > 
> > Applied, thanks.
> > 
> 
> Unless I'm currently doing something completely wrong, it looks like it
> doesn't work as it should. :(
> 

Looks like, indeed. Is it any better on your side with the following
patch applied?

--- ksrc/nucleus/intr.c	(revision 1530)
+++ ksrc/nucleus/intr.c	(working copy)
@@ -395,10 +395,12 @@
 	s = intr->isr(intr);
 	++intr->hits;
 
-	if (unlikely(s == XN_ISR_NONE && ++intr->unhandled == XNINTR_MAX_UNHANDLED)) {
-		xnlogerr("%s: IRQ%d not handled. Disabling IRQ line.\n",
-			 __FUNCTION__, irq);
-		s |= XN_ISR_NOENABLE;
+	if (unlikely(s == XN_ISR_NONE)) {
+		if (unlikely(++intr->unhandled == XNINTR_MAX_UNHANDLED)) {
+			xnlogerr("%s: IRQ%d not handled. Disabling IRQ line.\n",
+				 __FUNCTION__, irq);
+			s |= XN_ISR_NOENABLE;
+		}
 	} else
 		intr->unhandled = 0;
 
@@ -499,11 +501,13 @@
 
 	xnintr_shirq_unlock(shirq);
 
-	if (unlikely(s == XN_ISR_NONE && ++shirq->unhandled == XNINTR_MAX_UNHANDLED)) {
-		xnlogerr("%s: IRQ%d not handled. Disabling IRQ line.\n",
-			 __FUNCTION__, irq);
-		s |= XN_ISR_NOENABLE;
-	} else	
+	if (unlikely(s == XN_ISR_NONE)) {
+		if (unlikely(++shirq->unhandled == XNINTR_MAX_UNHANDLED)) {
+			xnlogerr("%s: IRQ%d not handled. Disabling IRQ line.\n",
+				 __FUNCTION__, irq);
+			s |= XN_ISR_NOENABLE;
+		}
+	} else
 		shirq->unhandled = 0;
 
 	if (s & XN_ISR_PROPAGATE)
@@ -571,11 +575,13 @@
 		    ("xnintr_edge_shirq_handler() : failed to get the IRQ%d line free.\n",
 		     irq);
 
-	if (unlikely(s == XN_ISR_NONE && ++shirq->unhandled == XNINTR_MAX_UNHANDLED)) {
-		xnlogerr("%s: IRQ%d not handled. Disabling IRQ line.\n",
-			 __FUNCTION__, irq);
-		s |= XN_ISR_NOENABLE;
-	} else	
+	if (unlikely(s == XN_ISR_NONE)) {
+		if (unlikely(++shirq->unhandled == XNINTR_MAX_UNHANDLED)) {
+			xnlogerr("%s: IRQ%d not handled. Disabling IRQ line.\n",
+				 __FUNCTION__, irq);
+			s |= XN_ISR_NOENABLE;
+		}
+	} else
 		shirq->unhandled = 0;
 
 	if (s & XN_ISR_PROPAGATE)
-- 
Philippe.



