Date: Wed, 1 Sep 2010 13:12:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20100901111257.GA13058@domain.hid>
References: <4C77FB05.4090301@domain.hid> <4C77FD89.5040100@domain.hid>
	<4C77FF51.4000801@domain.hid>
	<1283013623.1709.226.camel@domain.hid>
	<4C7B70F9.1090903@domain.hid>
	<1283181064.1709.1827.camel@domain.hid>
	<4C7BD09A.4080106@domain.hid>
	<1283238579.1709.1853.camel@domain.hid>
	<4C7E1149.9070604@domain.hid>
	<1283338335.1709.1923.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1283338335.1709.1923.camel@domain.hid>
Subject: Re: [Xenomai-core] False positive XENO_BUGON(NUCLEUS,
	need_resched	== 0)?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Wed, Sep 01, 2010 at 12:52:15PM +0200, Philippe Gerum wrote:
> On Wed, 2010-09-01 at 10:39 +0200, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> > > On Mon, 2010-08-30 at 17:39 +0200, Jan Kiszka wrote:
> > >> Philippe Gerum wrote:
> > >>> Ok, Gilles did not grumble at you, so I'm daring the following patch,
> > >>> since I agree with you here. Totally untested, not even compiled, just
> > >>> for the fun of getting lockups and/or threads in limbos. Nah, just
> > >>> kidding, your shiny SMP box should be bricked even before that:
> > >>>
> > >>> diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
> > >>> index f75c6f6..6ad66ba 100644
> > >>> --- a/include/nucleus/sched.h
> > >>> +++ b/include/nucleus/sched.h
> > >>> @@ -184,10 +184,9 @@ static inline int xnsched_self_resched_p(struct xnsched *sched)
> > >>>  #define xnsched_set_resched(__sched__) do {				\
> > >>>    xnsched_t *current_sched = xnpod_current_sched();			\
> > >>>    xnarch_cpu_set(xnsched_cpu(__sched__), current_sched->resched);	\
> > >> To increase the probability of regressions: What about moving the above
> > >> line...
> > >>
> > >>> -  if (unlikely(current_sched != (__sched__)))				\
> > >>> -      xnarch_cpu_set(xnsched_cpu(__sched__), (__sched__)->resched);	\
> > >>>    setbits(current_sched->status, XNRESCHED);				\
> > >>> -  /* remote will set XNRESCHED locally in the IPI handler */		\
> > >>> +  if (current_sched != (__sched__))					\
> > >>> +      setbits((__sched__)->status, XNRESCHED);				\
> > >> ...into this conditional block? Then you should be able to...
> > >>
> > >>>  } while (0)
> > >>>  
> > >>>  void xnsched_zombie_hooks(struct xnthread *thread);
> > >>> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
> > >>> index 623bdff..cff76c2 100644
> > >>> --- a/ksrc/nucleus/pod.c
> > >>> +++ b/ksrc/nucleus/pod.c
> > >>> @@ -285,13 +285,6 @@ void xnpod_schedule_handler(void) /* Called with hw interrupts off. */
> > >>>  		xnshadow_rpi_check();
> > >>>  	}
> > >>>  #endif /* CONFIG_SMP && CONFIG_XENO_OPT_PRIOCPL */
> > >>> -	/*
> > >>> -	 * xnsched_set_resched() did set the resched mask remotely. We
> > >>> -	 * just need to make sure that our rescheduling request won't
> > >>> -	 * be filtered out locally when testing for XNRESCHED
> > >>> -	 * presence.
> > >>> -	 */
> > >>> -	setbits(sched->status, XNRESCHED);
> > >>>  	xnpod_schedule();
> > >>>  }
> > >>>  
> > >>> @@ -2167,10 +2160,10 @@ static inline int __xnpod_test_resched(struct xnsched *sched)
> > >>>  {
> > >>>  	int cpu = xnsched_cpu(sched), resched;
> > >>>  
> > >>> -	resched = xnarch_cpu_isset(cpu, sched->resched);
> > >>> -	xnarch_cpu_clear(cpu, sched->resched);
> > >>> +	resched = testbits(sched->status, XNRESCHED);
> > >>>  #ifdef CONFIG_SMP
> > >>>  	/* Send resched IPI to remote CPU(s). */
> > >>> +	xnarch_cpu_clear(cpu, sched->resched);
> > >> ...drop the line above as well.
> > >>
> > >>>  	if (unlikely(xnsched_resched_p(sched))) {
> > >>>  		xnarch_send_ipi(sched->resched);
> > >>>  		xnarch_cpus_clear(sched->resched);
> > >>>
> > > 
> > > Yes, I do think that we are way too stable on SMP boxes these days.
> > > Let's merge this as well to bring the fun back.
> > > 
> > 
> > The current cpu bit in the resched cpu mask allowed us to know whether
> > the local cpu actually needed rescheduling. At least on SMP. It may
> > happen that only remote cpus were set, so, in that case, we were only
> > sending the IPI, then exiting __xnpod_schedule.
> > 
> 
> So the choice here is, in SMP non-debug mode only, between:
> 
> - setting and clearing a bit at each local rescheduling unconditionally
> - peeking at the runqueue uselessly at each rescheduling only involving
> remote threads
> 
> The answer does not seem obvious.

Well... It will probably even be hard to come up with a benchmark which 
shows a difference between the two solutions. So, if the current one is 
the simplest one, then so be it.

-- 
					    Gilles.

