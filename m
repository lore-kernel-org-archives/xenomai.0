Subject: Re: [Xenomai-core] Spinlock question.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4607EDF2.2020600@domain.hid>
References: <4607E038.8070505@domain.hid> <4607EA58.1070004@domain.hid>
	<4607EDF2.2020600@domain.hid>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 18:34:39 +0200
Message-Id: <1174926879.7486.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Mon, 2007-03-26 at 17:59 +0200, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
> > Gilles Chanteperdrix wrote:
> > 
> >>Hi,
> >>
> >>I am porting a network driver from Linux to RTnet, and I have a sudden
> >>doubt about what I am doing: is it safe to call a function like
> >>wake_up_interruptible, from a non real-time context, with CONFIG_PREEMPT
> >>enabled, while holding an rthal spinlock ? Do not I risk a rescheduling
> >>with the spinlock locked ?
> > 
> > 
> > Mmh, doesn't stalling the primary domain (what rthal_spin_lock_irqsave
> > surely does) also make the root domain think it is running in interrupt
> > context, thus will prevent any Linux reschedule?
> 
> Is not it sufficient to add a call to preempt_disable/preempt_enable
> around the spinlock functions ?
> 

Yes, you could do that, and actually, you should do that, since rthal_*
macros manipulate raw spinlocks, not preempt-aware ones. This said, as
Jan pointed out, it would be pretty dangerous to hold such spinlock
right before going to sleep Linux-wise, due to priority inversion
issues.

The bottom-line is to never ever hold the nklock and anything that could
stall the high pipeline stage before being switched out by the Linux
scheduler.

> 
> > However, there is one big fat issue with this approach:
> > wake_up_interruptible takes some Linux spin lock. So you must never call
> > it from primary context on UP to avoid corruption. And an SMP, you
> > create a nice source for priority inversion: CPU2 holds wait_queue lock,
> > gets preempted by Xenomai and runs some longer low-prio RT job.
> > Meanwhile CPU1 tries to acquire wait_queue as well with IRQs disabled,
> > blocking any RT task on that CPU.
> > 
> > Better defer the Linux wake-up via a rtdm_nrtsig. Alternatively, make
> > the Linux waiter also a Xenomai task and use a rtdm_event e.g. (mmh,
> > maybe we should discuss the auto-shadow-any-Linux-task-on-demand feature
> > for Xenomai once again...).
> 
> I have other cases where the function that does the wakeup do it from
> real-time context, so I will probably have to use the nrtsig approach
> anyway, thanks.
> 
-- 
Philippe.



