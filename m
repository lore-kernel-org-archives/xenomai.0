Message-ID: <b647ffbd0706300136h167d2e4dg62a247f28cd7f9c3@domain.hid>
Date: Sat, 30 Jun 2007 10:36:18 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <468025AA.7080908@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200706252111.40219.dmitry.adamushko@domain.hid>
	<468025AA.7080908@domain.hid>
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
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

Hello Jan,

I appologize for the huge reply latency.

>
> Yeah, that might explain while already trying to parse it manually
> failed: What is xnintr_sync_stat_references? :)

yeah.. it was supposed to be xnintr_sync_stat_refs()


> > 'prev = xnstat_get_current()' reference is also tracked as reference accounting becomes
> > a part of the xnstat interface (not sure we do need it though).
>
> Mind to elaborate on _why_ you think we need this, specifically if it
> adds new atomic counters?

Forget about it, it was a wrong approach. We do reschedule in
xnintr_*_handler() and if 'prev->refs' is non-zero and a newly
scheduled thread calls xnstat_runtime_synch() (well, how it could be
in theory with this interfcae) before deleting the first thread..
oops. so this 'referencing' scheme is bad anyway.

Note, that if the real re-schedule took place in xnpod_schedule() , we
actually don't need to _restore_ 'prev' when we get control back.. it
must be already restored by xnpod_schedule() when the preempted thread
('prev' is normally a thread in which context an interrupt occurs)
gets CPU back. if I'm not missing something. hum?

...
        if (--sched->inesting == 0 && xnsched_resched_p())
                xnpod_schedule();

(*) <---- 'sched->current_account' should be already == 'prev' in case
xnpod_schedule() took place

        xnltt_log_event(xeno_ev_iexit, irq);
        xnstat_runtime_switch(sched, prev);
...

The simpler scheme with xnstat_ accounting would be if we account only
time spent in intr->isr() to corresponding intr->stat[cpu].account...
This way, all accesses to the later one would be inside
xnlock_{get,put}(&xnirqs[irq].lock) sections [*].

It's preciceness (although, it's arguable to some extent) vs.
simplicity (e.g. no need for any xnintr_sync_stat_references()). I
would still prefer this approach :-)

Otherwise, so far I don't see any much nicer solution that the one
illustrated by your first patch.


> Uhh, be careful, I burned my fingers with similar things recently as
> well. You have to make sure that all types are resolvable for _all_
> includers of that header. Otherwise, I'm fine with cleanups like this.
> But I think there was once a reason for #define.

yeah.. now I recall it as well :-)


>
> Thanks,
> Jan
>

-- 
Best regards,
Dmitry Adamushko

