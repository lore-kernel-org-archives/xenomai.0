From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0B47607@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E0B47607@domain.hid>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 19:00:00 +0200
Message-Id: <1192122000.6118.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
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
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-10-11 at 18:35 +0200, ROSSIER Daniel wrote:
> Hi everyone,
> 
> I'm taking over the original thread from Patrick concerning the port of
> Xenomai on Xscale with Linux 2.6.20. Briefly summarized, the boot
> process actually freezes after a while right after the nucleus has been
> started.
> 
> I've investigated the issue over the last hours, and I came up with the
> following conclusion: it seems that the problem is due to a endless loop
> in do_gettimeofday in arch/arm/kernel/time.c. Here is the code:
> 
> "...
> do {
> 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
> 		usec = system_timer->offset();
> 		sec = xtime.tv_sec;
> 		usec += xtime.tv_nsec / 1000;
> 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
> ..."
> 
> If I remove the do { } while loop with the call to
> read_seqbegin_irqsave(), then the boot process is going ahead (I got a
> suspicious error like "I-pipe: Detected illicit call from domain
> 'Xenomai' " but it might well be normal with such a modification.
> 
> I checked with the code from a 2.6.15 kernel, and it is basically the
> same structure.
> 
> Any idea about the cause of this problem?
> 

That's typical of someone from the real-time (Xenomai) domain spuriously
calling into this routine, which is illegal.

The usual scenario for the lockup to happen is:
- Linux task A calls into some code grabbing the xtime lock for writing
- Xenomai preempts task A before it releases the seqlock, e.g. to
process an interrupt
- some code on behalf of the Xenomai IRQ handler calls into
do_gettimeofday, which is wrong
- the culprit gets a reader lock sequence token, which will never match
the quiescent state. This will cause an infinite loop, since task A
can't get out the critical section to put the sequence in a quiescent
state again, until the Xenomai code relinquishes the CPU. Catch #22.

You likely need to chase the code who triggers the "Detected illicit
domain" message, likely in some code also calling do_gettimeofday().

> I checked the timer IRQs and other pipeline activity, and everything
> seems to be OK. By the way, if I disable the nucleus, Linux is working
> properly (timer not being stolen by I-pipe).
> 
> Thanks in advance for any help.
> 
> Cheers
> Daniel
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



