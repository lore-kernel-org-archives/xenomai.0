From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4E5EEC62.2020307@domain.hid>
References: <4E5EEC62.2020307@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Sep 2011 11:56:56 +0200
Message-ID: <1314871016.18201.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] NULL interrupt handler "ipd->irqs[irq].handler" in
 __ipipe_run_irq()
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Tom Evans <tom_usenet@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2011-09-01 at 12:22 +1000, Tom Evans wrote:
> This problem has probably been solved years ago, but Google and 
> searching this list didn't find me anything.
> 
> I'm running an old (2006) Linux 2.4 kernel with Xenomai 2.1 with the 
> Adeos patches on an MPC5200 (ppc).
> 
> Every now and then when I stress the system it crashes because 
> "ipd->irqs[irq].handler" is NULL for "irq == 1" (a valid irq on this 
> system) in this code:

<snip>

> So it looks like the interrupt is happening in hardware and being queued 
> and THEN it is being deregistered (with the handler being set to zero in 
> ipipe_virtualize_irq()) and then it is being pulled from the pipe, run 
> and (usually) crashes.
> 
> I've checked all the Adeos patches I can find for all architectures up 
> to the current date, and none of them have had changes made to check for 
> the condition of a NULL interrupt handler in the pipe.
> 
> Simply adding a test in __ipipe_run_isr() to ignore these entries seems 
> to fix this problem for me.
> 
> The other solution I can think of would be to make 
> ipipe_virtualize_irq() smarter so on deregistration it removes any 
> pending interrupts from the pipelines. Has that been done in any newer 
> versions?
> 
> This problem might match the old (2007) and long running (40 messages) 
> bug report "Re: Xenomai and MSI enabled crashes kernel" listed here:
> 
> http://thread.gmane.org/gmane.linux.real-time.xenomai.users/3643/focus=3657
> 

Actually, the issue discussed in this thread is MSI+x86 specific,
related to the interrupt namespace, so this does not apply to your case.

> I'd be interested in any observations, comments or pointers to the "real 
> cause" and any other "real fixes".

ipipe_virtualize_irq() is an internal service which should be called for
unregistering an IRQ only after the source was shut at device level, and
possibly masked on the interrupt controller. It must be called with
interrupt enabled for the domain which owns the unregistered handler.
On uniprocessor systems, these two conditions are enough to make sure
that no IRQ is lingering in the interrupt log after the handler was
nullified.

I can't spot the routines appearing in the backtrace you sent in the
vanilla linux/xenomai code I have at hand, but if this is a real-time
CAN stack, you may want to check whether the device is properly quiesced
and the IRQ line masked prior to unregistering the interrupt in the
pipeline.

-- 
Philippe.



