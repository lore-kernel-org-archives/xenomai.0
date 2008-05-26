Message-ID: <2ff1a98a0805260947q4587700era0e5af4527a26cfc@domain.hid>
Date: Mon, 26 May 2008 18:47:32 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150805260929yeb4e263o618c446cdd96856b@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
	<18489.30774.304777.148110@domain.hid>
	<d6c8ef150805260626o3ba03d42sce1100bab89540a5@domain.hid>
	<d6c8ef150805260929yeb4e263o618c446cdd96856b@domain.hid>
Subject: Re: [Xenomai-help] Interrupt priorities and handling problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Mon, May 26, 2008 at 6:29 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> Hi Gilles,
>
> I've enabled tracer, as documented on Xenomai site. Well, to be
> honest, I dont see much from the output :) I've put
> xntrace_user_freeze (1, 1) in the handler to happen at the 1000th
> iteration. At the beginning of the interrupt handler one IO PIN is set
> to 1 and set back to 0 at the end. In the meantime, there is only for
> ().
>
> Attached file osc1.jpg is screen shot of USB Osciloscope when there is
> no Ethernet activity. osc2.jpg is good example of what happens when
> there is Ethernet activity (this time ping -f from PC box in the same
> LAN as Device).
>
> Do you see anything in those .txt files?

Well, if we read the sequence:
:|   #func                -199+   7.000  __ipipe_grab_irq+0x10 (__irq_svc+0x2c)
:|   #begin   0xffffffff  -192+   6.750  __ipipe_grab_irq+0x40 (__irq_svc+0x2c)
:|   #func                -185+   5.500  __ipipe_handle_irq+0x10
(__ipipe_grab_irq+0x90)
:|   #func                -180+   5.250  __ipipe_ack_timerirq+0x10

We see a timer irq

(__ipipe_handle_irq+0x70)
:|   #func                -175+   6.000  __ipipe_ack_level_irq+0x10
(__ipipe_ack_timerirq+0x30)
:|   #func                -169+   5.750  at91_aic_mask_irq+0x10
(__ipipe_ack_level_irq+0x2c)
:|   #func                -163+   6.000  __ipipe_mach_acktimer+0x10
(__ipipe_ack_timerirq+0x40)
:|   #func                -157+   5.250  __ipipe_end_level_irq+0x10
(__ipipe_ack_timerirq+0x50)
:|   #func                -152+   6.000  at91_aic_unmask_irq+0x10
(__ipipe_end_level_irq+0x24)
:|   #func                -146+   6.500  __ipipe_dispatch_wired+0x10
(__ipipe_handle_irq+0x7c)
:|  #*func                -139+   7.250  xnintr_clock_handler+0x10
(__ipipe_dispatch_wired+0x100)
:|  #*func                -132+   8.500  xntimer_tick_aperiodic+0x10
(xnintr_clock_handler+0x34)
:|  #*func                -123!  14.250  xntimer_next_local_shot+0x10
(xntimer_tick_aperiodic+0x250)
:|  #*func                -109+   7.750  __ipipe_mach_set_dec+0x10
(xntimer_next_local_shot+0xd0)
:|  #*func                -101+   5.250  rthal_irq_host_pend+0x10
(xnintr_clock_handler+0xd0)
:|  #*func                 -96+   5.750  __ipipe_schedule_irq+0x10
(rthal_irq_host_pend+0x20)
:|  #*func                 -90+   9.500  __ipipe_set_irq_pending+0x10
(__ipipe_schedule_irq+0x80)
:|   #func                 -81+   7.750  __ipipe_walk_pipeline+0x10
(__ipipe_handle_irq+0x118)
:|   #end     0xffffffff   -73+   5.500  __ipipe_grab_irq+0x9c (__irq_svc+0x2c)

Immediately followed by a gpio irq.

:|   #func                 -68+   6.250  __ipipe_grab_irq+0x10 (__irq_svc+0x2c)
:|   #begin   0xffffffff   -61+   6.500  __ipipe_grab_irq+0x40 (__irq_svc+0x2c)
:|   #func                 -55+   5.500  __ipipe_mach_demux_irq+0x14
(__ipipe_grab_irq+0x60)
:|   #func                 -49!  12.250  at91_aic_mask_irq+0x10
(__ipipe_mach_demux_irq+0x3c)
:|   #func                 -37+   5.250  __ipipe_handle_irq+0x10
(__ipipe_mach_demux_irq+0xa0)
:|   #func                 -32+   5.750  __ipipe_ack_irq+0x10
(__ipipe_handle_irq+0x70)
:|   #func                 -26+   5.750  __ipipe_ack_simple_irq+0x10
(__ipipe_ack_irq+0x28)
:|   #func                 -20+   6.250  __ipipe_dispatch_wired+0x10
(__ipipe_handle_irq+0x7c)
:|  #*func                 -14+   6.250  xnintr_irq_handler+0x10
(__ipipe_dispatch_wired+0x100)
:|  #*func                  -8+   8.250  <bf0071fc> (xnintr_irq_handler+0x44)
<|  #*freeze  0x00000001     0    6.750  <bf007230> (xnintr_irq_handler+0x44)
 |  #*func                   6    5.750  rthal_irq_end+0x10
(xnintr_irq_handler+0xfc)
 |  #*func                  12    8.000  __ipipe_end_simple_irq+0x10
(rthal_irq_end+0x34)
 |   #func                  20    7.250  __ipipe_walk_pipeline+0x10
(__ipipe_handle_irq+0x118)
 |   #func                  27    7.250  at91_aic_unmask_irq+0x10
(__ipipe_mach_demux_irq+0xc4)
 |   #end     0xffffffff    35    7.250  __ipipe_grab_irq+0x9c (__irq_svc+0x2c)

Then, later:

 |   +func                 202    7.000  __ipipe_grab_irq+0x10 (__irq_svc+0x2c)
 |   +begin   0xffffffff   209    5.750  __ipipe_grab_irq+0x40 (__irq_svc+0x2c)
 |   +func                 215    5.750  __ipipe_mach_demux_irq+0x14
(__ipipe_grab_irq+0x60)
 |   +func                 221   10.750  at91_aic_mask_irq+0x10
(__ipipe_mach_demux_irq+0x3c)
 |   +func                 232    7.250  __ipipe_handle_irq+0x10
(__ipipe_mach_demux_irq+0xa0)
 |   +func                 239    6.250  __ipipe_set_irq_pending+0x10
(__ipipe_handle_irq+0xb4)
 |   +func                 245    5.500  __ipipe_ack_irq+0x10
(__ipipe_handle_irq+0xd4)
 |   +func                 251    5.750  __ipipe_ack_simple_irq+0x10
(__ipipe_ack_irq+0x28)
 |   +func                 256    7.000  __ipipe_walk_pipeline+0x10
(__ipipe_handle_irq+0x118)
 |   +func                 263    7.000  __ipipe_sync_stage+0x14
(__ipipe_walk_pipeline+0x9c)
 |   +func                 270    7.000  at91_aic_unmask_irq+0x10
(__ipipe_mach_demux_irq+0xc4)
 |   +end     0xffffffff   277    7.500  __ipipe_grab_irq+0x9c (__irq_svc+0x2c)

Which is a second gpio interrupt. I am afraid from this sequence, it
appears that the two interrupt are generated at hardware level. Did
you try setting up the irq with at91_set_gpio_input ?

-- 
 Gilles

