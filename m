Message-ID: <43DE3F54.8090105@domain.hid>
Date: Mon, 30 Jan 2006 17:31:16 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] Interrupt problem on powerpc
References: <43DE1DAD.8050302@domain.hid>
In-Reply-To: <43DE1DAD.8050302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

Anders Blomdell wrote:
> On a PrPMC800 (PPC 7410 processor) withe Xenomai-2.1-rc2, I get the 
> following if the interrupt handler takes too long (i.e. next interrupt 
> gets generated before the previous one has finished)
> 
> [   42.543765]  [c00c2008] spin_bug+0xa8/0xc4
> [   42.597617]  [c00c22d4] _raw_spin_lock+0x180/0x184

Someone (in arch/ppc64/kernel/*.c?) is spinlocking+irqsave desc->lock for any 
given IRQ without using the Adeos *_hw() spinlock variant that masks the interrupt 
at hw level. So we seem to have:

spin_lock_irqsave(&desc->lock)
	<hw IRQ>
		__ipipe_grab_irq
			__ipipe_handle_irq
				__ipipe_ack_irq
					spin_lock...(&desc->lock)
						deadlock.

The point is about having spinlock_irqsave only _virtually_ masking the interrupts 
by preventing their associated Linux handler from being called, but despite this, 
Adeos still actually acquires and acknowledges the incoming hw events before 
logging them, even if their associated action happen to be postponed until 
spinlock_irq_restore() is called.

To solve this, all spinlocks potentially touched by the ipipe's primary IRQ 
handler and/or the code it calls indirectly, _must_ be operated using the _hw() 
call variant all over the kernel, so that no hw IRQ can be taken while those 
spinlocks are held by Linux. Usually, only the spinlock(s) protecting the 
interrupt descriptors or the PIC hardware are concerned.

> [   42.660637]  [c000f388] __ipipe_ack_irq+0x88/0x130
> [   42.723657]  [c000efe4] __ipipe_handle_irq+0x140/0x268
> [   42.791259]  [c000f144] __ipipe_grab_irq+0x38/0xa4
> [   42.854279]  [c0005058] __ipipe_ret_from_except+0x0/0xc
> [   42.923029]  [00000000] 0x0
> [   42.959695]  [c0038348] __do_IRQ+0x134/0x164
> [   43.015839]  [c000ed04] __ipipe_do_IRQ+0x2c/0x44
> [   43.076567]  [c000eb08] __ipipe_sync_stage+0x1ec/0x228
> [   43.144170]  [c0039420] ipipe_suspend_domain+0x7c/0xc4
> [   43.211774]  [c000f0b0] __ipipe_handle_irq+0x20c/0x268
> [   43.279377]  [c000f144] __ipipe_grab_irq+0x38/0xa4
> [   43.342396]  [c0005058] __ipipe_ret_from_except+0x0/0xc
> [   43.411145]  [c0006524] default_idle+0x10/0x60
> 
> 
> Any ideas of where to look?
> 
> Regards
> 
> Anders Blomdell
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

