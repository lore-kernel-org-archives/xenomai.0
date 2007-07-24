From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1185210931.5998.273.camel@domain.hid>
References: <16123805.1184916759093.JavaMail.ngmail@domain.hid>
	<1184890451.28303.356.camel@domain.hid>
	<1184852543.28303.67.camel@domain.hid>
	<24703926.1184851660664.JavaMail.ngmail@domain.hid>
	<32098568.1184853156077.JavaMail.ngmail@domain.hid>
	<25782679.1184932464850.JavaMail.ngmail@domain.hid>
	<1184933771.5998.3.camel@domain.hid> <1185202908.5998.271.camel@domain.hid>
	<1185210931.5998.273.camel@domain.hid>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 11:55:49 +0200
Message-Id: <1185270949.5998.326.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] RPI is good for you
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Mon, 2007-07-23 at 19:15 +0200, Philippe Gerum wrote:
> On Mon, 2007-07-23 at 17:01 +0200, Philippe Gerum wrote:
> > On Fri, 2007-07-20 at 14:16 +0200, Philippe Gerum wrote: 
> > > On Fri, 2007-07-20 at 13:54 +0200, M. Koehrer wrote:
> > > > Hi Philippe,
> > > > I left my test running for a couple of hours - no freeze so far... 
> > > > 
> > > > However, I have to do some other stuff on this machine, I have to stop the test now...
> > > > 
> > > 
> > > Ok, thanks for the feedback. I will send an extended patch later today,
> > > so that you could test it on a longer period when you see fit.
> > 
> > It took me a bit longer than expected, but here is a patch which
> > addresses all the pending issues with RPI, hopefully (applies against
> > 2.3.1 stock).
> > 
> 
> Here is a fix for a typo if you happen to use the scalable scheduler.
> 
> --- include/nucleus/queue.h~	2007-07-23 18:47:21.000000000 +0200
> +++ include/nucleus/queue.h	2007-07-23 19:10:40.000000000 +0200
> @@ -744,7 +744,7 @@
>  
>  static inline xnpholder_t *getheadmlq(xnmlqueue_t *mlqslot)
>  {
> -	xnpholder_t *pholder;
> +	xnpholder_t *holder;
>  	xnqueue_t *queue;
>  
>  	if (emptymlq_p(mlqslot))

This other fix is needed to cope with a tiny migration window which
exists while creating a thread, and which may affect RPI.

--- ksrc/nucleus/shadow.c	(revision 2782)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -386,10 +386,12 @@
 	 * the gatekeeper's RPI slot for the current CPU. */
 
 	if (unlikely(threadin->rpi == NULL)) {
-		xnlock_get_irqsave(&rpislot->lock, s);
-		sched_insertpqf(&rpislot->threadq, &threadin->xlink, newprio);
-		threadin->rpi = rpislot;
-		xnlock_put_irqrestore(&rpislot->lock, s);
+		if (!xnthread_test_state(threadin, XNDORMANT)) {
+			xnlock_get_irqsave(&rpislot->lock, s);
+			sched_insertpqf(&rpislot->threadq, &threadin->xlink, newprio);
+			threadin->rpi = rpislot;
+			xnlock_put_irqrestore(&rpislot->lock, s);
+		}
 	} else if (unlikely(threadin->rpi != rpislot))
 		/* We hold no lock here. */
 		rpi_migrate(threadin);

-- 
Philippe.



