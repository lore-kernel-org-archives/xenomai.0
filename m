Message-ID: <44180FB8.7080200@domain.hid>
Date: Wed, 15 Mar 2006 13:59:36 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid> <4417C14A.2010900@domain.hid>
In-Reply-To: <4417C14A.2010900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>Hi,
>>
>>for those who haven't followed the endless "RTDM and Timer functions"
>>thread: we are currently discussing a way to provide high-resolution
>>timestamps in periodic mode for RTDM users. It was suggested to use the
>>TSC for this, but I noted that this source will not be in sync with the
>>periodic system timer and may even be out of sync across multiple CPUs.
>>
>>A straight-forward approach to overcome this might be to record the
>>current TSC value together with the current jiffies in
>>xntimer_do_tick_periodic(). This tuple (per CPU) could then be provided
>>to skin implementers in order to let them offer a high-resolution
>>timestamp source even in periodic mode. Hmm, sounds too simple actually,
>>so I'm waiting now for someone pointing out the pitfalls.
> 
> 
> Likely too simple: The periodic IRQ seems to pop up on every CPU so that

Talking about x86, indeed it does, so that each per-CPU scheduler can have its own 
time feed. The basic principle is as follows on Xenomai SMP/x86:

- a spare APIC vector is used to relay the timer ticks to the Xenomai domain, 
grabbing the APIC timer to trigger those ticks (see RTHAL_APIC_TIMER_VECTOR).
- Xenomai timer ticks are programmed to occur on all CPUs, feeding the per-CPU 
schedulers with timing data, so that each CPU can in turn update the global 
scheduling state according to possible wakeups/suspensions.
- when a thread needs to be awaken or suspended on a remote CPU after a local tick 
on the local one, an IPI is sent to invoke the rescheduling procedure on the 
remote CPU (see xnpod_schedule)).

This also applies to Xeno's ia64 port.

> the TSC could be recorded, but will this happen synchronously?

Nope. You could not predict the state of hardware and/or virtual interrupt masking 
on a particular CPU when the IRQ get raised anyway.

  At least
> we will see (IRQ) jitters, and those jitters could already create in the
> single-CPU case a non-monotonic clock...
> 

At worst, you would see an old timestamp from a previous shot while the timer IRQ 
announcing the most accurate one is still outstanding but untaken, but I think 
that you would still have something behaving in a monotonic way though.

> Does anyone ever studied if and how Linux synchronises across CPUs?
> There was some activity around the problematic AMD64 multicores, but I
> haven't looked at the details and if it's actually solved now.
> 

Only once during boot AFAICT, see arch/i386/kernel/smpboot.c. This said, TSC 
synchronization would not work on NUMA boxen.

> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

