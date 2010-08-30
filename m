From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C7B70F9.1090903@domain.hid>
References: <4C7783C9.5090501@domain.hid> <4C7788A5.2020307@domain.hid>
	<4C77B054.8080609@domain.hid> <4C77B208.5090802@domain.hid>
	<4C77F142.4030103@domain.hid> <4C77F5EF.3010701@domain.hid>
	<4C77F65E.5000208@domain.hid> <4C77FB05.4090301@domain.hid>
	<4C77FD89.5040100@domain.hid>  <4C77FF51.4000801@domain.hid>
	<1283013623.1709.226.camel@domain.hid>
	<4C7B70F9.1090903@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Aug 2010 17:11:04 +0200
Message-ID: <1283181064.1709.1827.camel@domain.hid>
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

On Mon, 2010-08-30 at 10:51 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2010-08-27 at 20:09 +0200, Jan Kiszka wrote:
> >> Gilles Chanteperdrix wrote:
> >>> Jan Kiszka wrote:
> >>>> Gilles Chanteperdrix wrote:
> >>>>> Gilles Chanteperdrix wrote:
> >>>>>> Jan Kiszka wrote:
> >>>>>>> Gilles Chanteperdrix wrote:
> >>>>>>>> Jan Kiszka wrote:
> >>>>>>>>> Gilles Chanteperdrix wrote:
> >>>>>>>>>> Jan Kiszka wrote:
> >>>>>>>>>>> Hi,
> >>>>>>>>>>>
> >>>>>>>>>>> I'm hitting that bug check in __xnpod_schedule after
> >>>>>>>>>>> xnintr_clock_handler issued a xnpod_schedule like this:
> >>>>>>>>>>>
> >>>>>>>>>>> 	if (--sched->inesting == 0) {
> >>>>>>>>>>> 		__clrbits(sched->status, XNINIRQ);
> >>>>>>>>>>> 		xnpod_schedule();
> >>>>>>>>>>> 	}
> >>>>>>>>>>>
> >>>>>>>>>>> Either the assumption behind the bug check is no longer correct (no call
> >>>>>>>>>>> to xnpod_schedule() without a real need), or we should check for
> >>>>>>>>>>> __xnpod_test_resched(sched) in xnintr_clock_handler (but under nklock then).
> >>>>>>>>>>>
> >>>>>>>>>>> Comments?
> >>>>>>>>>> You probably have a real bug. This BUG_ON means that the scheduler is
> >>>>>>>>>> about to switch context for real, whereas the resched bit is not set,
> >>>>>>>>>> which is wrong.
> >>>>>>>>> This happened over my 2.6.35 port - maybe some spurious IRQ enabling.
> >>>>>>>>> Debugging further...
> >>>>>>>> You should look for something which changes the scheduler state without
> >>>>>>>> setting the resched bit, or for something which clears the bit without
> >>>>>>>> taking the scheduler changes into account.
> >>>>>>> It looks like a generic Xenomai issue on SMP boxes, though a mostly
> >>>>>>> harmless one:
> >>>>>>>
> >>>>>>> The task that was scheduled in without XNRESCHED set locally has been
> >>>>>>> woken up by a remote CPU. The waker requeued the task and set the
> >>>>>>> resched condition for itself and in the resched proxy mask for the
> >>>>>>> remote CPU. But there is at least one place in the Xenomai code where we
> >>>>>>> drop the nklock between xnsched_set_resched and xnpod_schedule:
> >>>>>>> do_taskexit_event (I bet there are even more). Now the resched target
> >>>>>>> CPU runs into a timer handler, issues xnpod_schedule unconditionally,
> >>>>>>> and happens to find the woken-up task before it is actually informed via
> >>>>>>> an IPI.
> >>>>>>>
> >>>>>>> I think this is a harmless race, but it ruins the debug assertion
> >>>>>>> "need_resched != 0".
> >>>>>> Not that harmless, since without the debugging code, we would miss the
> >>>>>> reschedule too...
> >>>>> Ok. But we would finally reschedule when handling the IPI. So, the
> >>>>> effect we see is a useless delay in the rescheduling.
> >>>>>
> >>>> Depends on the POV: The interrupt or context switch between set_resched
> >>>> and xnpod_reschedule that may defer rescheduling may also hit us before
> >>>> we were able to wake up the thread at all. The worst case should not
> >>>> differ significantly.
> >>> Yes, and whether we set the bit and call xnpod_schedule atomically does
> >>> not really matter either: the IPI takes time to propagate, and since
> >>> xnarch_send_ipi does not wait for the IPI to have been received on the
> >>> remote CPU, there is no guarantee that xnpod_schedule could not have
> >>> been called in the mean time.
> >> Indeed.
> >>
> >>> More importantly, since in order to do an action on a remote xnsched_t,
> >>> we need to hold the nklock, is there any point in not setting the
> >>> XNRESCHED bit on that distant structure, at the same time as when we set
> >>> the cpu bit on the local sched structure mask and send the IPI? This
> >>> way, setting the XNRESCHED bit in the IPI handler would no longer be
> >>> necessary, and we would avoid the race.
> >>>
> >> I guess so. The IPI isn't more than a hint that something /may/ have
> >> changed in the schedule anyway.
> >>
> > 
> > This makes sense. I'm currently testing the patch below which implements
> > a close variant of Gilles's proposal. Could you try it as well, to see
> > if things improve?
> > http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=3200660065146915976c193387bf0851be10d0cc
> 
> Will test ASAP.
> 
> > 
> > The logic makes sure that we can keep calling xnsched_set_resched() then
> > xnpod_schedule() outside of the same critical section, which is
> > something we need. Otherwise this requirement would extend to
> > xnpod_suspend/resume_thread(), which is not acceptable.
> 
> I still wonder if things can't be even simpler. What is the purpose of
> xnsched_t::resched? I first thought it's just there to coalesce multiple
> remote reschedule requests, thus IPIs triggered by one CPU over
> successive wakeups etc. If that is true, why going through resched for
> local changes, why not setting XNRESCHED directly? And why not setting
> the remote XNRESCHED instead of remote's xnsched_t::resched?
> 

Ok, Gilles did not grumble at you, so I'm daring the following patch,
since I agree with you here. Totally untested, not even compiled, just
for the fun of getting lockups and/or threads in limbos. Nah, just
kidding, your shiny SMP box should be bricked even before that:

diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
index f75c6f6..6ad66ba 100644
--- a/include/nucleus/sched.h
+++ b/include/nucleus/sched.h
@@ -184,10 +184,9 @@ static inline int xnsched_self_resched_p(struct xnsched *sched)
 #define xnsched_set_resched(__sched__) do {				\
   xnsched_t *current_sched = xnpod_current_sched();			\
   xnarch_cpu_set(xnsched_cpu(__sched__), current_sched->resched);	\
-  if (unlikely(current_sched != (__sched__)))				\
-      xnarch_cpu_set(xnsched_cpu(__sched__), (__sched__)->resched);	\
   setbits(current_sched->status, XNRESCHED);				\
-  /* remote will set XNRESCHED locally in the IPI handler */		\
+  if (current_sched != (__sched__))					\
+      setbits((__sched__)->status, XNRESCHED);				\
 } while (0)
 
 void xnsched_zombie_hooks(struct xnthread *thread);
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 623bdff..cff76c2 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -285,13 +285,6 @@ void xnpod_schedule_handler(void) /* Called with hw interrupts off. */
 		xnshadow_rpi_check();
 	}
 #endif /* CONFIG_SMP && CONFIG_XENO_OPT_PRIOCPL */
-	/*
-	 * xnsched_set_resched() did set the resched mask remotely. We
-	 * just need to make sure that our rescheduling request won't
-	 * be filtered out locally when testing for XNRESCHED
-	 * presence.
-	 */
-	setbits(sched->status, XNRESCHED);
 	xnpod_schedule();
 }
 
@@ -2167,10 +2160,10 @@ static inline int __xnpod_test_resched(struct xnsched *sched)
 {
 	int cpu = xnsched_cpu(sched), resched;
 
-	resched = xnarch_cpu_isset(cpu, sched->resched);
-	xnarch_cpu_clear(cpu, sched->resched);
+	resched = testbits(sched->status, XNRESCHED);
 #ifdef CONFIG_SMP
 	/* Send resched IPI to remote CPU(s). */
+	xnarch_cpu_clear(cpu, sched->resched);
 	if (unlikely(xnsched_resched_p(sched))) {
 		xnarch_send_ipi(sched->resched);
 		xnarch_cpus_clear(sched->resched);

> Jan
> 

-- 
Philippe.



