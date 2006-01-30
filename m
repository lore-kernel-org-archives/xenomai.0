Message-ID: <43DE43C7.3080608@domain.hid>
Date: Mon, 30 Jan 2006 17:50:15 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] Interrupt problem on powerpc
References: <43DE1DAD.8050302@domain.hid> <43DE2505.7000709@domain.hid>
	<43DE3A90.4040107@domain.hid> <43DE3F74.2070402@domain.hid>
In-Reply-To: <43DE3F74.2070402@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Anders Blomdell wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Anders Blomdell wrote:
>>>
>>>
>>>>On a PrPMC800 (PPC 7410 processor) withe Xenomai-2.1-rc2, I get the
>>>>following if the interrupt handler takes too long (i.e. next interrupt
>>>>gets generated before the previous one has finished)
>>>>
>>>>[   42.543765]  [c00c2008] spin_bug+0xa8/0xc4
>>>>[   42.597617]  [c00c22d4] _raw_spin_lock+0x180/0x184
>>>>[   42.660637]  [c000f388] __ipipe_ack_irq+0x88/0x130
>>>>[   42.723657]  [c000efe4] __ipipe_handle_irq+0x140/0x268
>>>>[   42.791259]  [c000f144] __ipipe_grab_irq+0x38/0xa4
>>>>[   42.854279]  [c0005058] __ipipe_ret_from_except+0x0/0xc
>>>>[   42.923029]  [00000000] 0x0
>>>>[   42.959695]  [c0038348] __do_IRQ+0x134/0x164
>>>>[   43.015839]  [c000ed04] __ipipe_do_IRQ+0x2c/0x44
>>>>[   43.076567]  [c000eb08] __ipipe_sync_stage+0x1ec/0x228
>>>>[   43.144170]  [c0039420] ipipe_suspend_domain+0x7c/0xc4
>>>>[   43.211774]  [c000f0b0] __ipipe_handle_irq+0x20c/0x268
>>>>[   43.279377]  [c000f144] __ipipe_grab_irq+0x38/0xa4
>>>>[   43.342396]  [c0005058] __ipipe_ret_from_except+0x0/0xc
>>>>[   43.411145]  [c0006524] default_idle+0x10/0x60
>>>>
>>>
>>>
>>>I think some probably important information is missing above this
>>>back-trace. 
>>
>>You are so right!
>>
>>
>>>What does the kernel state before these lines?
>>
>>[   42.346643] BUG: spinlock recursion on CPU#0, swapper/0
>>[   42.415438]  lock: c01c943c, .magic: dead4ead, .owner: swapper/0,
>>.owner_cpu: 0
>>[   42.511681] Call trace:
>>[   42.543765]  [c00c2008] spin_bug+0xa8/0xc4
>>[   42.597617]  [c00c22d4] _raw_spin_lock+0x180/0x184
>>[   42.660637]  [c000f388] __ipipe_ack_irq+0x88/0x130
>>[   42.723657]  [c000efe4] __ipipe_handle_irq+0x140/0x268
>>[   42.791259]  [c000f144] __ipipe_grab_irq+0x38/0xa4
>>[   42.854279]  [c0005058] __ipipe_ret_from_except+0x0/0xc
>>[   42.923029]  [00000000] 0x0
>>[   42.959695]  [c0038348] __do_IRQ+0x134/0x164
>>[   43.015839]  [c000ed04] __ipipe_do_IRQ+0x2c/0x44
>>[   43.076567]  [c000eb08] __ipipe_sync_stage+0x1ec/0x228
>>[   43.144170]  [c0039420] ipipe_suspend_domain+0x7c/0xc4
>>[   43.211774]  [c000f0b0] __ipipe_handle_irq+0x20c/0x268
>>[   43.279377]  [c000f144] __ipipe_grab_irq+0x38/0xa4
>>[   43.342396]  [c0005058] __ipipe_ret_from_except+0x0/0xc
>>[   43.411145]  [c0006524] default_idle+0x10/0x60
>>
>>
>>It might be that the problem is related to the fact that the interrupt
>>is a shared one (Harrier chip, "Functional Exception"), that is used for
>>both message-passing (should be RT) and UART (Linux, i.e. non-RT), my
>>current IRQ handler always pends the interrupt to the linux domain
>>(RTDM_IRQ_PROPAGATE), because all other attempts (RTDM_IRQ_ENABLE when
>>it wasn't a UART interrupt) has left the interrupts turned off.
>>
>>What I believe should be done, is
>>
>>  1. When UART interrupt is received, disable further non-RT interrupts
>>     on this IRQ-line, pend interrupt to Linux.
>>  2. Handle RT interrupts on this IRQ line
>>  3. When Linux has finished the pended interrupt, reenable non-RT
>>interrupts.
>>
>>but I have neither been able to achieve this, nor to verify that it is
>>the right thing to do...
> 
> 
> Your approach is basically what I proposed some years back on rtai-dev
> for handling unresolvable shared RT/NRT IRQs. I once successfully tested
> such a setup with two network cards, one RT, the other Linux.
> 
> So when you are really doomed and cannot change the IRQ line of your RT
> device, this is a kind of emergency workaround. Not nice and generic
> (you have to write the stub for disabling the NRT IRQ source), but it
> should work.
I'm doomed, the interrupts live in the same chip...
The problem is that I have not found any good place to reenable the non-RT 
interrupts.

> Anyway, I do not understand what made your spinlock recurs. This shared
> IRQ scenario should only cause indeterminism to the RT driver (by
> blocking the line until the Linux handler can release it), but it must
> not trigger this bug.
OK, seems like  have two problems then, I'll try to hunt it down


/Anders

