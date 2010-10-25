From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CC5F612.8040508@domain.hid>
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>
	<4CC20AD2.4060501@domain.hid>
	<AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>
	<4CC44C02.4050003@domain.hid>
	<AANLkTinjUHYvNJwcuEd2RQuQLWL3WvGx-jFb5iG88f0c@domain.hid>
	<AANLkTikGFw6dxQHC1ukWHsTP-QoHzpbDzeMdLj=jZRP5@domain.hid>
	<AANLkTimsGjmPNE1GOzmyF4pHQe6m4RmFphuhGqdTrs1D@mail.gmail.com>
	<4CC5603E.1090707@domain.hid>	<4CC566A2.2000702@domain.hid>
	<AANLkTik76N-mL6ogtzFJ_vX4NF=7oDc_zdCA_y33z+Jh@domain.hid>
	<AANLkTimp5_OXSo_EGkn6O0mexR1Oxb_m9SJEfPmrSf0M@mail.gmail.com>
	<AANLkTi=Ne35gXZ=BRo09eXRjEtvPaXnkp6ix9tMWUwvn@domain.hid>
	<4CC5C93E.70503@domain.hid>
	<AANLkTimS7-CEvA74Viwu4mLm9-O_NpakXYG7=FXK1L1f@domain.hid>
	<4CC5DD1F.4090405@domain.hid> <1288041712.26618.189.camel@domain.hid>
	<4CC5F612.8040508@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Oct 2010 23:43:14 +0200
Message-ID: <1288042994.26618.206.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, Peter Pastor <peter.pastor@domain.hid>

On Mon, 2010-10-25 at 23:26 +0200, Jan Kiszka wrote:
> Am 25.10.2010 23:21, Philippe Gerum wrote:
> > On Mon, 2010-10-25 at 21:40 +0200, Jan Kiszka wrote:
> >> Am 25.10.2010 21:03, Peter Pastor wrote:
> >>> Hey Jan,
> >>>
> >>> I did not apply any ubuntu patch for kernel 2.6.35 (since I do not have
> >>> one).  Also, good to know that I should not use xenomai patches together
> >>> with ubuntu patches.
> >>>
> >>> Anyway, the problem occurred as well with the kernel 2.6.35 (see attached
> >>> dmesg_bad_2.6.35)
> >>> I also attached the config.
> >>>
> >>
> >> ...
> >>
> >>> [ 5751.714643] irq 16: nobody cared (try booting with the "irqpoll" option)
> >>> [ 5751.714649] Pid: 0, comm: swapper Tainted: P            2.6.35-ipipe-2.5.4-slim #2
> >>> [ 5751.714653] Call Trace:
> >>> [ 5751.714655]  <IRQ>  [<ffffffff8108bb56>] __report_bad_irq+0x26/0xa0
> >>> [ 5751.714668]  [<ffffffff8108bd5c>] note_interrupt+0x18c/0x1d0
> >>> [ 5751.714672]  [<ffffffff8108c77d>] handle_fasteoi_irq+0xcd/0x100
> >>> [ 5751.714677]  [<ffffffff8100656d>] handle_irq+0x1d/0x30
> >>> [ 5751.714681]  [<ffffffff81005a40>] do_IRQ+0x70/0x100
> >>> [ 5751.714685]  [<ffffffff81092147>] __ipipe_sync_stage+0x207/0x20d
> >>> [ 5751.714689]  [<ffffffff810059d0>] ? do_IRQ+0x0/0x100
> >>> [ 5751.714692]  [<ffffffff8109214d>] ? __xirq_end+0x0/0x9c
> >>> [ 5751.714696]  [<ffffffff810059d0>] ? do_IRQ+0x0/0x100
> >>> [ 5751.714700]  [<ffffffff810926a3>] __ipipe_walk_pipeline+0x113/0x120
> >>> [ 5751.714706]  [<ffffffff81024414>] __ipipe_handle_irq+0x124/0x310
> >>> [ 5751.714708]  [<ffffffff8108bf10>] ? __ipipe_ack_fasteoi_irq+0x0/0x10
> >>> [ 5751.714712]  [<ffffffff814f78d3>] common_interrupt+0x13/0x2c
> >>> [ 5751.714713]  <EOI>  [<ffffffff810249d6>] ? __ipipe_halt_root+0x26/0x40
> >>> [ 5751.714718]  [<ffffffff81061191>] ? atomic_notifier_call_chain+0x11/0x20
> >>> [ 5751.714722]  [<ffffffff8100cbd5>] default_idle+0x45/0x50
> >>> [ 5751.714725]  [<ffffffff8100198a>] cpu_idle+0x7a/0xd0
> >>> [ 5751.714728]  [<ffffffff814f14a1>] start_secondary+0x1c1/0x1c5
> >>> [ 5751.714730] handlers:
> >>> [ 5751.714730] [<ffffffff8136ed60>] (usb_hcd_irq+0x0/0xb0)
> >>> [ 5751.714735] [<ffffffffa00bac30>] (mpt_interrupt+0x0/0xa00 [mptbase])
> >>> [ 5751.714747] Disabling IRQ #16
> >>
> >> I'm not yet sure, but a first thought: We have a shared fasteoi IRQ
> >> here, and we are on SMP. Compared to vanilla, the fasteoi flow of ipipe
> >> looks so much different to me ATM that I tend to believe two cores end
> >> up having this IRQ queued at the same time. One runs first and handles
> >> all triggers, the second bails out like above.
> >>
> >> Philippe, we _end_ fasteoi in the ipipe ack path. Do we mask them prior
> >> to this? What prevents a second IRQ arriving after this early eoi?
> > 
> > All fasteoi handlers are supposed to mask+ack when the pipeline is
> > enabled, 
> 
> What am I missing? The code I was looking at (__ipipe_ack_fasteoi) just
> does a regular eoi at chip level.

Have a look at the chip handlers.

> 
> > to avoid interrupt storm due to the deferral we may introduce
> > in the irq delivery. I do see this in the regular ioapic chip
> > descriptor, but this is lacking with interrupt remap. I guess we could
> > have a problem with Intel IOMMUs.
> 
> IOMMUs should blow up the system anyway once a PCI driver is used in the
> RT domain (DMA remapping involved Linux locks and may even allocate
> memory). Guess we should add a !IPIPE to their Kconfig entries.
> 

Yes, would make sense.

> Jan
> 

-- 
Philippe.



