Message-ID: <474D9B1C.7060003@domain.hid>
Date: Wed, 28 Nov 2007 17:45:16 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <474D8B34.8080502@domain.hid>
In-Reply-To: <474D8B34.8080502@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] ipipe_suspend_domain() not scheduling IRQ threads
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
To: =?UTF-8?B?UGV0ZXIgU2NodWXCn2xsZXI=?= <peter.schueller@domain.hid>
Cc: xenomai@xenomai.org

Peter Schueller wrote:
> Hi!
> 
> I am currently trying to port IPIPE to a new architecture and have the following symptoms with my
> first testcase:
> 
> - I am using a 2.6.23 Kernel and mainly looked at blackfin and i386 when porting.
> - I create a domain with priority IPIPE_ROOT_PRIO+100 in a kernel module
> - The domain entry does only: for(;;) ipipe_suspend_domain();
> - After registering the domain I get the message "I-pipe: Domain Module Testdomain registered." and
> after that the system hangs.
> 
> I traced the problem a bit and found out that
> 
> - ipipe_suspend_domain() always returns to the test domain with the highest priority.
> - Within ipipe_suspend_domain() the function __ipipe_sync_stage() gets called for the root domain
> and calls __ipipe_run_isr for
>    irq 1 (Linux Timer Tick)
>    irq 2 (network - the whole thing runs from NFS)
>    irq 32 (there are 32 hardware interrupts, the last one is irq 31, this must be a virtual irq)
>

A common issue causing lockups is having the CPU being stormed by a
level triggered interrupt which does not get masked and processed
properly. IRQ threading may add a certain amount of confusion to this,
since  it may have an impact on the order your IRQ threads must be
scheduled to avoid this situation. Think of the situation with a GPIO
demultiplexing IRQ for instance, where you want all multiplexed IRQ
threads to run before the demultiplexer ISR runs and unmasks the
interrupt source.

Even without the threading issue, the interrupt storm issue is quite
frequent during the initial stage of porting the I-pipe; it usually
happens because the assumption that the IRQ handler would be called
shortly after the interrupt is taken becomes wrong with the I-pipe. As a
matter of fact, pipelining interrupts means that they may be delayed for
some time, before the Linux device driver is called and actually removes
the interrupt condition at hw level (think of a real-time activity
preempting the CPU, while some device hammers the CPU with interrupts
because Linux does not seem to care fast enough). This is why most - if
not all interrupts - should be masked+acked at receipt (see ipipe_ack)
then unmasked after handler completion, when the I-pipe is enabled.

> I think the problem is that the IRQ threads do not get scheduled and so cannot handle the
> Interrupts, although they have been "kicked" by __ipipe_run_isr.
>

Are you sure you need to thread the Linux ISRs on your target
architecture? This is a Blackfin-specific implementation of the I-pipe,
which addresses some arch-dependent peculiarities on this CPU. I suspect
you may not need this at all, which would greatly simplify the issue.
Which arch are we talking about?

> It would be very kind if you could help me with the following questions:
> 
> - Are some of my assumptions/ideas above completely wrong?
> - Should I read some documentation to get help? (I only found the porting guide and some other 
> guides which did not help me answer the following questions)

I don't know of any other doc -- this one being rather outdated,
unfortunately.

> - Which part of the code should schedule the IRQ threads? (__ipipe_run_isr only "kicks" them afaik)
>

The interposed IRQ handler, which wakes up the thread instead of running
the actual ISR code. So, yes, it's over __ipipe_run_isr() for the Linux
domain.

 - Where should ipipe_suspend_domain() hand control over to another
domain (i.e. schedule in the
> other domain because the higher priority domain has suspended itself)?
> - Should I handle the Linux System timer differently from the other interrupts so that it is not
> subject to IRQ threading?

Threading the timer interrupt is a source of troubles and may cause
lockups. In the usual - non-threaded - implementation, the timer
interrupt is not that different from others, except the additional bits
needed to allow client RTOS to control its pace and delivery date for
the whole system, including Linux. This is why you may have both
__ipipe_grab_irq and __ipipe_grab_timer, but this does not change the
way the pipeline handles and deliver them eventually.

> 
> Best Regards,
> 
> Peter
> 


-- 
Philippe.

