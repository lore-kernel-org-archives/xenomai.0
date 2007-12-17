Message-ID: <2ff1a98a0712170642k161ec758p18b6dc7896f42fa7@domain.hid>
Date: Mon, 17 Dec 2007 15:42:10 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <168027.86920.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <168027.86920.qm@domain.hid>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: adeos-main@gna.org

On Dec 17, 2007 3:20 PM, Michael Trimarchi <trimarchimichael@domain.hid> wrote:
>
>
>
> Hi,
> >> >Wait a minute. You mean that you want more than 5000 interrupts by
> >> >second ? Are you sure you do not get overruns with plain, unpatched
> >> >Linux, if you load it sufficiently ?
> >> If you do a simple count ( 115200 bps ) considering buffer length = 1 the
> >> answer is yes.
> >>
> >> :)
> >>
> >> regards Michael
> >>
> >> PS work with linux
>
> >Do you observe this behaviour with I-pipe only or with Xenomai running
> >? If we xenomai, could you try only booting Linux with I-pipe enabled
> >?
> >
> >--
> >                                              Gilles Chanteperdrix
>
> I report this only using ipipe. I have some trouble with xenomai, that I
> will try to solve ( see below )

Ok. Could you try something ? It will work with I-pipe only but will
break Xenomai, so do not try to run Xenomai over this modification.

In include/asm-arm/system.h in the definition of the switch_to macro
try removing the calls to local_irq_disable_hw_cond and
local_irq_enable_hw_cond, and tell us if you still get the serial
driver overruns.

> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> I-pipe: Detected illicit call from domain 'Xenomai'
>         into a service reserved for domain 'Linux' and below.
> [<c0021988>] (show_stack+0x0/0x48) from [<c005cca0>]
> (ipipe_check_context+0x88/0xa4)
> [<c005cc18>] (ipipe_check_context+0x0/0xa4) from [<c0057e40>]
> (search_module_extables+0x3c/0xe8)
>  r5:00000000 r4:c0063cf0
> [<c0057e04>] (search_module_extables+0x0/0xe8) from [<c004887c>]
> (search_exception_tables+0x30/0x3c)
>  r8:00000154 r7:00000017 r6:00000000 r5:c0271e00 r4:c0063cf0
> [<c004884c>] (search_exception_tables+0x0/0x3c) from [<c00231c0>]
> (fixup_exception+0x18/0x30)
>  r4:c0271e00
> [<c00231a8>] (fixup_exception+0x0/0x30) from [<c002339c>]
> (__do_kernel_fault+0x24/0x7c)
>  r4:00000154
> [<c0023378>] (__do_kernel_fault+0x0/0x7c) from [<c0023670>]
> (do_page_fault+0x27c/0x29c)
>  r7:00000000 r6:c0266520 r5:c01a1e6c r4:ffffffff
> [<c00233f4>] (do_page_fault+0x0/0x29c) from [<c001c2c8>]
> (do_DataAbort+0x3c/0x11c)
> [<c001c28c>] (do_DataAbort+0x0/0x11c) from [<c001cb40>]
> (__dabt_svc+0x40/0x60)
> Exception stack(0xc0271e00 to 0xc0271e48)
> 1e00: 204c0000 c0457860 40000093 40000093 c0457860 00000000 c01bf860
> 00000000
> 1e20: c0280b30 c0270000 c01bf890 c0271e80 00000000 c0271e48 c0063ce4
> c0063cf0
> 1e40: 40000093 ffffffff
>  r8:c0280b30 r7:00000000 r6:c01bf860 r5:c0271e34 r4:ffffffff
> [<c00636ec>] (xnpod_schedule+0x0/0x7ac) from [<c00608f8>]
> (xnintr_clock_handler+0xa8/0x124)
> [<c0060850>] (xnintr_clock_handler+0x0/0x124) from [<c005deb0>]
> (__ipipe_dispatch_wired+0xdc/0x104)
>  r8:c0266520 r7:c01bf480 r6:c01a8120 r5:c01aa4e0 r4:c01bd140
> [<c005ddd4>] (__ipipe_dispatch_wired+0x0/0x104) from [<c0021efc>]
> (__ipipe_handle_irq+0x94/0x1c8)
>  r6:c0271f20 r5:00000011 r4:c01bd140
> [<c0021e68>] (__ipipe_handle_irq+0x0/0x1c8) from [<c00220f4>]
> (__ipipe_grab_irq+0xc4/0x120)
> [<c0022030>] (__ipipe_grab_irq+0x0/0x120) from [<c001cb90>]
> (__irq_svc+0x30/0x78)
>  r8:c0266520 r7:c0457860 r6:00000011 r5:fefff000 r4:ffffffff
> [<c014e0d4>] (schedule+0x0/0x814) from [<c006af54>]
> (gatekeeper_thread+0xfc/0x194)
> [<c006ae58>] (gatekeeper_thread+0x0/0x194) from [<c004b1a4>]
> (kthread+0x58/0x90)
> [<c004b14c>] (kthread+0x0/0x90) from [<c003780c>] (do_exit+0x0/0x94c)
>  r6:00000000 r5:00000000 r4:00000000

This means that there is a fault in xnpod_schedule, that causes a
Linux function to be called over Xenomai domain. But the problem is
the fault in the first place. To debug this, we need a disassembly of
xnpod_schedule. This will be best discussed on Xenomai mailing list.
You probably have a problem in your port of the I-pipe patch, since
Xenomai is reported to works on other AT91s.

>
>
> There is a patch to using the serial device with DMA too and I use it with
> other board
>   equipped with the at91rm9200. But my question is this:
>
>  spi prioriy < serial priority
>
>  In linux the interrupt nesting is controlled by the hardware logic. Is it
> true?
>
>  The priority is mainted using ipipe in at91sam9260?

This is a difficult subject, will give a detailed explanation later.
The I-pipe evolved between the 1.7-08 and 1.8-02 versions, and Linux
is going to evolve in the same way. But the short answer is that
interrupt controller priority should matter only when receiving
several interrupts at the same time, which means not often, if it
matters it is because there is a bug in the interrupt handling, the
bug that was fixed in I-pipe version 1.8 and which is going to be
fixed in Linux soon.
http://marc.info/?l=linux-arm-kernel&m=119776017521950&w=2
-- 
                                               Gilles Chanteperdrix

