From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1192715021.5884.32.camel@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E016387F8@domain.hid>
	<1192714042.5884.20.camel@domain.hid> <1192715021.5884.32.camel@domain.hid>
Content-Type: multipart/mixed; boundary="=-MR3DNLWFKIxMz1PiBb93"
Date: Thu, 18 Oct 2007 16:10:05 +0200
Message-Id: <1192716605.5884.35.camel@domain.hid>
Mime-Version: 1.0
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] xnpod_announce_tick when migrating from 2.3
	to	2.4
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Necker <thomas.necker@domain.hid>
Cc: xenomai@xenomai.org


--=-MR3DNLWFKIxMz1PiBb93
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-10-18 at 15:43 +0200, Philippe Gerum wrote:
> > It's actually much simpler with 2.4. You may install a hook into the
> > periodic tick handler by calling the following helper, somewhere in
> your
> > module init code:
> > 
> > 	xntbase_set_hook(psos_tbase, your_psos_hook);
> > 
> > The only difference compared to your current approach is that
> Xenomai
> > will have processed the incoming tick before calling your hook, so
> you
> > don't need to forward the tick anymore. Sidenote: this only works
> with
> > periodic timebases so far.
> > 
> 
> Actually, I now think we should rather implement to the traditional
> "daisy-chain" pattern here, with the user-defined hook being called in
> replacement of the genuine tick processing code, and the hook expected
> to call into xntbase_tick() to signal the incoming tick when it sees
> fit. This would allow the skin to implement time slowdowns etc.
> 
> Thomas, I'm going to send a patch asap to this end. Please rely on the
> common behaviour (i.e. daisy-chain) you would expect from pSOS.

Here we are. This patch is against 2.4-rc4, and allows to implement a
daisy-chain of tick handlers.

-- 
Philippe.


--=-MR3DNLWFKIxMz1PiBb93
Content-Disposition: attachment; filename=tick-daisy-chain.patch
Content-Type: text/x-patch; name=tick-daisy-chain.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: include/nucleus/timer.h
===================================================================
--- include/nucleus/timer.h	(revision 3081)
+++ include/nucleus/timer.h	(working copy)
@@ -710,6 +710,8 @@
 
 void xntimer_tick_periodic(xntimer_t *timer);
 
+void xntimer_tick_periodic_inner(xntslave_t *slave);
+
 void xntimer_adjust_all_aperiodic(xnsticks_t delta);
 
 #ifdef CONFIG_SMP
Index: ksrc/nucleus/timer.c
===================================================================
--- ksrc/nucleus/timer.c	(revision 3081)
+++ ksrc/nucleus/timer.c	(working copy)
@@ -465,9 +465,8 @@
  * @note Only active timers are inserted into the timer wheel.
  */
 
-void xntimer_tick_periodic(xntimer_t *mtimer)
+void xntimer_tick_periodic_inner(xntslave_t *slave)
 {
-	xntslave_t *slave = timer2slave(mtimer);
 	xnsched_t *sched = xnpod_current_sched();
 	xntbase_t *base = &slave->base;
 	xntlholder_t *holder;
@@ -502,9 +501,17 @@
 	}
 
 	xnpod_do_rr();		/* Do round-robin management. */
+}
 
-	if (base->hook)
+void xntimer_tick_periodic(xntimer_t *mtimer)
+{
+	xntslave_t *slave = timer2slave(mtimer);
+	xntbase_t *base = &slave->base;
+
+	if (unlikely(base->hook))
 		base->hook();
+	else
+		xntimer_tick_periodic_inner(slave);
 }
 
 static void
Index: ksrc/nucleus/timebase.c
===================================================================
--- ksrc/nucleus/timebase.c	(revision 3081)
+++ ksrc/nucleus/timebase.c	(working copy)
@@ -475,9 +475,8 @@
 	if (base == &nktbase)
 		xntimer_tick_aperiodic();
 	else {
-		unsigned cpu = xnarch_current_cpu();
-		struct percpu_cascade *pc = &base2slave(base)->cascade[cpu];
-		xntimer_tick_periodic(&pc->timer);
+		xntslave_t *slave = base2slave(base);
+		xntimer_tick_periodic_inner(slave);
 	}
 
 	xnlock_put_irqrestore(&nklock, s);

--=-MR3DNLWFKIxMz1PiBb93--


