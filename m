Message-ID: <470F5F24.4020306@domain.hid>
Date: Fri, 12 Oct 2007 13:48:52 +0200
From: Daniel Rossier <daniel.rossier@domain.hid>
MIME-Version: 1.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E0B47607@domain.hid>
	<470E5724.3000100@domain.hid>
In-Reply-To: <470E5724.3000100@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
>  ROSSIER Daniel wrote:
> > Hi everyone,
> >
> > I'm taking over the original thread from Patrick concerning the
> > port of Xenomai on Xscale with Linux 2.6.20. Briefly summarized,
> > the boot process actually freezes after a while right after the
> > nucleus has been started.
> >
> > I've investigated the issue over the last hours, and I came up with
> > the following conclusion: it seems that the problem is due to a
> > endless loop in do_gettimeofday in arch/arm/kernel/time.c. Here is
> > the code:
> >
> > "... do { seq = read_seqbegin_irqsave(&xtime_lock, flags); usec =
> > system_timer->offset(); sec = xtime.tv_sec; usec += xtime.tv_nsec /
> > 1000; } while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
> > ..."
> >
> > If I remove the do { } while loop with the call to
> > read_seqbegin_irqsave(), then the boot process is going ahead (I
> > got a suspicious error like "I-pipe: Detected illicit call from
> > domain 'Xenomai' " but it might well be normal with such a
> > modification.
>
>  Please post the full oops about that "illicit call". It may point to
>  an otherwise hidden invalid usage of Linux services over the Xenomai
>  domain and explain the lock-up.

Sure; here is the output message:
"
I-pipe: Detected illicit call from domain 'Xenomai'
        into a service reserved for domain 'Linux' and below.
[<c0027328>] (show_stack+0x0/0x40) from [<c005d590>] 
(ipipe_check_context+0x88/0xa4)
[<c005d508>] (ipipe_check_context+0x0/0xa4) from [<c002d9e4>] 
(__ipipe_mach_set_dec+0x24/0x7c)
 r5 = 54503BD0  r4 = 00003029
[<c002d9c0>] (__ipipe_mach_set_dec+0x0/0x7c) from [<c00681e0>] 
(xntimer_do_tick_aperiodic+0x2f4/0x33c)
 r4 = 00003029
[<c0067eec>] (xntimer_do_tick_aperiodic+0x0/0x33c) from [<c0062b48>] 
(xnpod_announce_tick+0x24/0xb8)
[<c0062b24>] (xnpod_announce_tick+0x0/0xb8) from [<c00604ec>] 
(xnintr_irq_handler+0x50/0x1b8)
 r6 = 00005E73  r5 = C02FA3D4  r4 = C02F8220
[<c006049c>] (xnintr_irq_handler+0x0/0x1b8) from [<c0060670>] 
(xnintr_clock_handler+0x1c/0x24)
[<c0060654>] (xnintr_clock_handler+0x0/0x24) from [<c005dc0c>] 
(__ipipe_sync_stage+0x1f8/0x27c)
[<c005da14>] (__ipipe_sync_stage+0x0/0x27c) from [<c005dd10>] 
(ipipe_suspend_domain+0x80/0xb0)
[<c005dc90>] (ipipe_suspend_domain+0x0/0xb0) from [<c005dd9c>] 
(__ipipe_walk_pipeline+0x5c/0xc0)
 r6 = 00000000  r5 = C02D72C0  r4 = C02F8220
[<c005dd40>] (__ipipe_walk_pipeline+0x0/0xc0) from [<c005e264>] 
(__ipipe_restore_pipeline_head+0xac/0xc8)
 r8 = 00000000  r7 = C0068228  r6 = 00000000  r5 = 00989680
 r4 = C02FB37C
[<c005e1b8>] (__ipipe_restore_pipeline_head+0x0/0xc8) from [<c0062430>] 
(xnpod_start_timer+0x2e8/0x33c)
[<c0062148>] (xnpod_start_timer+0x0/0x33c) from [<c00624c4>] 
(xnpod_reset_timer+0x40/0x54)
[<c0062484>] (xnpod_reset_timer+0x0/0x54) from [<c0065c7c>] 
(xnpod_init+0x42c/0x478)
 r4 = 00000000
[<c0065850>] (xnpod_init+0x0/0x478) from [<c006a934>] 
(__native_skin_init+0x20/0xf8)
[<c006a914>] (__native_skin_init+0x0/0xf8) from [<c00220c4>] 
(init+0x98/0x27c)
 r4 = C001CA04
[<c002202c>] (init+0x0/0x27c) from [<c003c588>] (do_exit+0x0/0x898)
 r7 = 00000000  r6 = 00000000  r5 = 00000000  r4 = 00000000
"
>
>  Jan
>


Daniel



