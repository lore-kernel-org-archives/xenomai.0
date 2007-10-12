Message-ID: <470F6CA5.4010008@domain.hid>
Date: Fri, 12 Oct 2007 14:46:29 +0200
From: Daniel Rossier <daniel.rossier@domain.hid>
MIME-Version: 1.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E0B47607@domain.hid>	
	<470E5724.3000100@domain.hid> <470F5F24.4020306@domain.hid>
	<2ff1a98a0710120534i5c6c5768od843412b07fe46ed@domain.hid>
In-Reply-To: <2ff1a98a0710120534i5c6c5768od843412b07fe46ed@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
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
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
>  On 10/12/07, Daniel Rossier <daniel.rossier@domain.hid> wrote:
> > Jan Kiszka wrote:
> >> ROSSIER Daniel wrote:
> >>> Hi everyone,
> >>>
> >>> I'm taking over the original thread from Patrick concerning the
> >>>  port of Xenomai on Xscale with Linux 2.6.20. Briefly
> >>> summarized, the boot process actually freezes after a while
> >>> right after the nucleus has been started.
> >>>
> >>> I've investigated the issue over the last hours, and I came up
> >>> with the following conclusion: it seems that the problem is due
> >>> to a endless loop in do_gettimeofday in arch/arm/kernel/time.c.
> >>> Here is the code:
> >>>
> >>> "... do { seq = read_seqbegin_irqsave(&xtime_lock, flags); usec
> >>> = system_timer->offset(); sec = xtime.tv_sec; usec +=
> >>> xtime.tv_nsec / 1000; } while
> >>> (read_seqretry_irqrestore(&xtime_lock, seq, flags)); ..."
> >>>
> >>> If I remove the do { } while loop with the call to
> >>> read_seqbegin_irqsave(), then the boot process is going ahead
> >>> (I got a suspicious error like "I-pipe: Detected illicit call
> >>> from domain 'Xenomai' " but it might well be normal with such a
> >>>  modification.
> >> Please post the full oops about that "illicit call". It may point
> >> to an otherwise hidden invalid usage of Linux services over the
> >> Xenomai domain and explain the lock-up.
> > Sure; here is the output message: " I-pipe: Detected illicit call
> > from domain 'Xenomai' into a service reserved for domain 'Linux'
> > and below. [<c0027328>] (show_stack+0x0/0x40) from [<c005d590>]
> > (ipipe_check_context+0x88/0xa4) [<c005d508>]
> > (ipipe_check_context+0x0/0xa4) from [<c002d9e4>]
> > (__ipipe_mach_set_dec+0x24/0x7c) r5 = 54503BD0  r4 = 00003029
> > [<c002d9c0>] (__ipipe_mach_set_dec+0x0/0x7c) from [<c00681e0>]
> > (xntimer_do_tick_aperiodic+0x2f4/0x33c) r4 = 00003029
>
>  This does not make sense, __ipipe_mach_set_dec is a very simple
>  function that should not trigger this illicit call.
>

Exactly Gilles! Now I solved this bug. Having a look at the 
__ipipe_mach_set_dec() showed me
an invokation to write_seqlock(&xtime_lock) !! I don't know why...

As Philippe said, it is not allowed. I changed with 
local_irq_save_hw(flags) (as it is in the 2.6.15) and there is no 
deadlock anymore...

Unfortunately, it still freezes a bit later, but I can go forward. I'll 
be reporting my investigations.

Thanks a lot
Daniel



