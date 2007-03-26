Message-ID: <4607EDF2.2020600@domain.hid>
Date: Mon, 26 Mar 2007 17:59:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Spinlock question.
References: <4607E038.8070505@domain.hid> <4607EA58.1070004@domain.hid>
In-Reply-To: <4607EA58.1070004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> 
>>Hi,
>>
>>I am porting a network driver from Linux to RTnet, and I have a sudden
>>doubt about what I am doing: is it safe to call a function like
>>wake_up_interruptible, from a non real-time context, with CONFIG_PREEMPT
>>enabled, while holding an rthal spinlock ? Do not I risk a rescheduling
>>with the spinlock locked ?
> 
> 
> Mmh, doesn't stalling the primary domain (what rthal_spin_lock_irqsave
> surely does) also make the root domain think it is running in interrupt
> context, thus will prevent any Linux reschedule?

Is not it sufficient to add a call to preempt_disable/preempt_enable
around the spinlock functions ?


> However, there is one big fat issue with this approach:
> wake_up_interruptible takes some Linux spin lock. So you must never call
> it from primary context on UP to avoid corruption. And an SMP, you
> create a nice source for priority inversion: CPU2 holds wait_queue lock,
> gets preempted by Xenomai and runs some longer low-prio RT job.
> Meanwhile CPU1 tries to acquire wait_queue as well with IRQs disabled,
> blocking any RT task on that CPU.
> 
> Better defer the Linux wake-up via a rtdm_nrtsig. Alternatively, make
> the Linux waiter also a Xenomai task and use a rtdm_event e.g. (mmh,
> maybe we should discuss the auto-shadow-any-Linux-task-on-demand feature
> for Xenomai once again...).

I have other cases where the function that does the wakeup do it from
real-time context, so I will probably have to use the nrtsig approach
anyway, thanks.

-- 
                                                 Gilles Chanteperdrix

