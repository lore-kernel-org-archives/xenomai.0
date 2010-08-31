From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1283238579.1709.1853.camel@domain.hid>
References: <4C7783C9.5090501@domain.hid> <4C7788A5.2020307@domain.hid>
	<4C77B054.8080609@domain.hid> <4C77B208.5090802@domain.hid>
	<4C77F142.4030103@domain.hid> <4C77F5EF.3010701@domain.hid>
	<4C77F65E.5000208@domain.hid> <4C77FB05.4090301@domain.hid>
	<4C77FD89.5040100@domain.hid>  <4C77FF51.4000801@domain.hid>
	<1283013623.1709.226.camel@domain.hid>
	<4C7B70F9.1090903@domain.hid>
	<1283181064.1709.1827.camel@domain.hid>
	<4C7BD09A.4080106@domain.hid>
	<1283238579.1709.1853.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 Aug 2010 16:52:00 +0200
Message-ID: <1283266320.1709.1866.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] False positive XENO_BUGON(NUCLEUS,
 need_resched == 0)?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2010-08-31 at 09:09 +0200, Philippe Gerum wrote:
> On Mon, 2010-08-30 at 17:39 +0200, Jan Kiszka wrote:
> > Philippe Gerum wrote:
> > > Ok, Gilles did not grumble at you, so I'm daring the following patch,
> > > since I agree with you here. Totally untested, not even compiled, just
> > > for the fun of getting lockups and/or threads in limbos. Nah, just
> > > kidding, your shiny SMP box should be bricked even before that:
> > > 
> > > diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
> > > index f75c6f6..6ad66ba 100644
> > > --- a/include/nucleus/sched.h
> > > +++ b/include/nucleus/sched.h
> > > @@ -184,10 +184,9 @@ static inline int xnsched_self_resched_p(struct xnsched *sched)
> > >  #define xnsched_set_resched(__sched__) do {				\
> > >    xnsched_t *current_sched = xnpod_current_sched();			\
> > >    xnarch_cpu_set(xnsched_cpu(__sched__), current_sched->resched);	\
> > 
> > To increase the probability of regressions: What about moving the above
> > line...
> > 
> > > -  if (unlikely(current_sched != (__sched__)))				\
> > > -      xnarch_cpu_set(xnsched_cpu(__sched__), (__sched__)->resched);	\
> > >    setbits(current_sched->status, XNRESCHED);				\
> > > -  /* remote will set XNRESCHED locally in the IPI handler */		\
> > > +  if (current_sched != (__sched__))					\
> > > +      setbits((__sched__)->status, XNRESCHED);				\
> > 
> > ...into this conditional block? Then you should be able to...
> > 
> > >  } while (0)
> > >  
> > >  void xnsched_zombie_hooks(struct xnthread *thread);
> > > diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
> > > index 623bdff..cff76c2 100644
> > > --- a/ksrc/nucleus/pod.c
> > > +++ b/ksrc/nucleus/pod.c
> > > @@ -285,13 +285,6 @@ void xnpod_schedule_handler(void) /* Called with hw interrupts off. */
> > >  		xnshadow_rpi_check();
> > >  	}
> > >  #endif /* CONFIG_SMP && CONFIG_XENO_OPT_PRIOCPL */
> > > -	/*
> > > -	 * xnsched_set_resched() did set the resched mask remotely. We
> > > -	 * just need to make sure that our rescheduling request won't
> > > -	 * be filtered out locally when testing for XNRESCHED
> > > -	 * presence.
> > > -	 */
> > > -	setbits(sched->status, XNRESCHED);
> > >  	xnpod_schedule();
> > >  }
> > >  
> > > @@ -2167,10 +2160,10 @@ static inline int __xnpod_test_resched(struct xnsched *sched)
> > >  {
> > >  	int cpu = xnsched_cpu(sched), resched;
> > >  
> > > -	resched = xnarch_cpu_isset(cpu, sched->resched);
> > > -	xnarch_cpu_clear(cpu, sched->resched);
> > > +	resched = testbits(sched->status, XNRESCHED);
> > >  #ifdef CONFIG_SMP
> > >  	/* Send resched IPI to remote CPU(s). */
> > > +	xnarch_cpu_clear(cpu, sched->resched);
> > 
> > ...drop the line above as well.
> > 
> > >  	if (unlikely(xnsched_resched_p(sched))) {
> > >  		xnarch_send_ipi(sched->resched);
> > >  		xnarch_cpus_clear(sched->resched);
> > > 
> > 
> 
> Yes, I do think that we are way too stable on SMP boxes these days.
> Let's merge this as well to bring the fun back.
> 

All worked according to plan, this introduced a nice lockup under
switchtest load. Unfortunately, a solution exists to fix it:

--- a/include/nucleus/sched.h
+++ b/include/nucleus/sched.h
@@ -176,17 +176,17 @@ static inline int xnsched_self_resched_p(struct xnsched *sched)
 
 /* Set self resched flag for the given scheduler. */
 #define xnsched_set_self_resched(__sched__) do {		\
-  xnarch_cpu_set(xnsched_cpu(__sched__), (__sched__)->resched); \
   setbits((__sched__)->status, XNRESCHED);			\
 } while (0)


-- 
Philippe.



