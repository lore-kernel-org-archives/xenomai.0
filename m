Date: Wed, 11 Jul 2007 17:35:45 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20070711173545.709225f1@domain.hid>
In-Reply-To: <4694E96B.5020801@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
	<20070608124927.1b789a9e@domain.hid>
	<46693B6B.1010201@domain.hid>
	<20070625175107.438849fa@domain.hid>
	<467FF391.8020401@domain.hid>
	<20070627105726.7db7a459@domain.hid>
	<46825054.7030800@domain.hid>
	<20070629164326.15579570@domain.hid>
	<4690B86C.1000907@domain.hid>
	<20070711155932.4b88699e@domain.hid>
	<4694E96B.5020801@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] measuring tasks execution time
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
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, 11 Jul 2007 16:30:03 +0200
Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Daniel Simon wrote:
> > On Sun, 08 Jul 2007 12:11:56 +0200
> > Jan Kiszka <jan.kiszka@domain.hid> wrote:
> > 
> > Hello,
> >> You are welcome to test, fix, improve, or just use it. Looking forward
> >> to your feedback!
> > 
> > here are attached some corrections against your previous patch (itself against
> > #2758 files): from my tests I now get likely exectime values from both remote
> > and self measurement (i.e. we get the accumulated exectime at the instant we
> > call rt_task_inquire ), and the stats given in /proc still seem to behave
> > normally...
> > 
> > the full patch against the original 2758 version is also given in attachement
> 
> To check if I got it the first attachment is an add-on patch, the second
> one is the base patch as in my repos + the former add-on patch?
yes
> Then let's comment on the add-on:
> 
> > diff -urN xenomai-2758/include/nucleus/stat.h xenomai-2758-V2/include/nucleus/stat.h
> > --- xenomai-2758/include/nucleus/stat.h	2007-07-11 15:16:14.000000000 +0200
> > +++ xenomai-2758-V2/include/nucleus/stat.h	2007-07-11 15:09:38.000000000 +0200
> > @@ -42,7 +42,7 @@
> >  do { \
> >  	(sched)->current_account->total += \
> >  		date - (sched)->last_account_switch; \
> > -	(sched)->last_account_switch = date; \
> > +	(sched)->last_account_switch = (sched)->current_account->start = date; \
> 
> That looks bogus on first sight, but I might miss your intention.
> current_account points to the overall stats of an accounted entity.
> Therefore, start must always contain the start time, not the last switch
> time. Please explain your idea.

sorry, I forgot to delete this attempt to correct a former bug, it's useless now, line 45 in stat.h remains as 
in your original patch

	(sched)->last_account_switch = date; \

just tested, the exectime measure still works...
> >  	/* All changes must be committed before changing the current_account \
> >  	   reference in sched (required for xnintr_sync_stat_references) */ \
> >  	xnarch_memory_barrier(); \
> > @@ -71,6 +71,9 @@
> >  #define xnstat_runtime_get_start(account)	((account)->start)
> >  #define xnstat_runtime_get_total(account)	((account)->total)
> >  
> > +/* Obtain last time something has been switched */
> > +#define xnstat_runtime_get_last_switch(sched)	((sched)->last_account_switch)
> > +
> 
> OK (though a more precise comment would be good :))
> 
/* Get the last time the calling thread was switched active */ 

may be better, but it could be also an intr. handler, isn't?

> >  /* Reset statistics from inside the accounted entity (e.g. after CPU
> >     migration). */
> >  #define xnstat_runtime_reset_stats(stat) \
> > @@ -113,6 +116,7 @@
> >  #define xnstat_runtime_finalize(sched, new_account)		do { } while (0)
> >  #define xnstat_runtime_get_start(account)			({ 0; })
> >  #define xnstat_runtime_get_total(account)			({ 0; })
> > +#define xnstat_runtime_get_last_switch(sched)			({ 0; })
> >  #define xnstat_runtime_reset_stats(account)			do { } while (0)
> >  
> >  typedef struct xnstat_counter {
> > diff -urN xenomai-2758/include/nucleus/thread.h xenomai-2758-V2/include/nucleus/thread.h
> > --- xenomai-2758/include/nucleus/thread.h	2007-07-11 15:16:14.000000000 +0200
> > +++ xenomai-2758-V2/include/nucleus/thread.h	2007-07-11 14:28:15.000000000 +0200
> > @@ -294,7 +294,7 @@
> >  #define xnthread_affinity(thread)          ((thread)->affinity)
> >  #define xnthread_affine_p(thread, cpu)     xnarch_cpu_isset(cpu, (thread)->affinity)
> >  #define xnthread_get_exectime(thread)      xnstat_runtime_get_total(&(thread)->stat.account)
> > -#define xnthread_get_lastswitch(thread)    xnstat_runtime_get_start(&(thread)->stat.account)
> > +#define xnthread_get_lastswitch(thread)    xnstat_runtime_get_last_switch((thread)->sched)
> 
> Yeah, that was wrong. Did your first patch hunk relate to an initial
> attempt to fix this bug?
> 
yes, it was made to cancel an extra period in the measure
> >  
> >  /* Class-level operations for threads. */
> >  static inline int xnthread_get_denormalized_prio(xnthread_t *t)
> > diff -urN xenomai-2758/ksrc/skins/native/task.c xenomai-2758-V2/ksrc/skins/native/task.c
> > --- xenomai-2758/ksrc/skins/native/task.c	2007-07-11 15:16:14.000000000 +0200
> > +++ xenomai-2758-V2/ksrc/skins/native/task.c	2007-07-11 15:22:10.000000000 +0200
> > @@ -1144,10 +1144,13 @@
> >  	info->cprio = xnthread_current_priority(&task->thread_base);
> >  	info->status = xnthread_state_flags(&task->thread_base);
> >  	info->relpoint = xntimer_get_date(&task->thread_base.ptimer);
> > +	if(task == xeno_current_task())
> >  	info->exectime = xnarch_tsc_to_ns(
> >  		xnthread_get_exectime(&task->thread_base) +
> >  		xnstat_runtime_now() -
> >  		xnthread_get_lastswitch(&task->thread_base));
> > +	else 
> > +	  info->exectime = xnarch_tsc_to_ns(xnthread_get_exectime(&task->thread_base));
> 
> OK, second bug taken. But you approach was written without SMP in mind
> (while I thought too much about SMP). The correct condition is "task is
> running, somewhere?":
> 
> if (task->thread_base.sched->runthread == &task->thread_base)
> 	<exectime up to now>
> else
> 	<currently stored exectime>

Can I leave you handling (and testing) this correction, as I don't have a running Xenomai/SMP machine at hand?

> Of course, one may still optimise the expression.
> 
> >  	info->modeswitches = xnstat_counter_get(&task->thread_base.stat.ssw);
> >  	info->ctxswitches = xnstat_counter_get(&task->thread_base.stat.csw);
> >  	info->pagefaults = xnstat_counter_get(&task->thread_base.stat.pf);
> > 
> > 
> 
> Jan
> 
> 
	Daniel

-- 
       Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
        Inovallee, 655 avenue de l'Europe, Montbonnot
             38 334 Saint Ismier Cedex France
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
          http://necs.inrialpes.fr/people/simon/



