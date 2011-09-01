Message-ID: <4E5EEC62.2020307@domain.hid>
Date: Thu, 01 Sep 2011 12:22:26 +1000
From: Tom Evans <tom_usenet@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] NULL interrupt handler "ipd->irqs[irq].handler" in
	__ipipe_run_irq()
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This problem has probably been solved years ago, but Google and 
searching this list didn't find me anything.

I'm running an old (2006) Linux 2.4 kernel with Xenomai 2.1 with the 
Adeos patches on an MPC5200 (ppc).

Every now and then when I stress the system it crashes because 
"ipd->irqs[irq].handler" is NULL for "irq == 1" (a valid irq on this 
system) in this code:

kernel/include/asm/ipipe.h::

#define __ipipe_run_isr(ipd, irq, cpuid)  \
do {                                      \
     if (ipd == ipipe_root_domain) {       \
         /*                                \
          * Linux handlers are called w/ hw interrupts on so \
          * that they could not defer interrupts for higher  \
          * priority domains.                                \
          */                                                 \
         local_irq_enable_hw();                              \
         ((void (*)(unsigned, struct pt_regs *))             \
          ipd->irqs[irq].handler) (irq, __ipipe_tick_regs + cpuid); \
         local_irq_disable_hw();                             \
     } else {                                                \
         __clear_bit(IPIPE_SYNC_FLAG, &cpudata->status);     \
         ipd->irqs[irq].handler(irq,ipd->irqs[irq].cookie);  \
         __set_bit(IPIPE_SYNC_FLAG, &cpudata->status);       \
     }                                                       \
} while(0)


If I add code to printk() when there's a NULL handler and also add a 
printk() to ipipe_virtualize_irq() to detail all interrupt registrations 
and de-registrations I get the following:

[   53.32] 1080:closing...
[   53.32] ipipe_virtualize_irq(256, 0x00000000)
[   53.32] ipipe_virtualize_irq(56, 0x00000000)
[   53.34] 1463:mscan_hwrelease out
[   53.34] ipipe_virtualize_irq(57, 0x00000000)
[   53.34] 1463:mscan_hwrelease out
[   53.35] pcan: pccard_release()
[   53.35] ipipe_virtualize_irq(1, 0x00000000)
[   53.36] __ipipe_run_isr(, 1, ) handler is NULL! #######

So it looks like the interrupt is happening in hardware and being queued 
and THEN it is being deregistered (with the handler being set to zero in 
ipipe_virtualize_irq()) and then it is being pulled from the pipe, run 
and (usually) crashes.

I've checked all the Adeos patches I can find for all architectures up 
to the current date, and none of them have had changes made to check for 
the condition of a NULL interrupt handler in the pipe.

Simply adding a test in __ipipe_run_isr() to ignore these entries seems 
to fix this problem for me.

The other solution I can think of would be to make 
ipipe_virtualize_irq() smarter so on deregistration it removes any 
pending interrupts from the pipelines. Has that been done in any newer 
versions?

This problem might match the old (2007) and long running (40 messages) 
bug report "Re: Xenomai and MSI enabled crashes kernel" listed here:

http://thread.gmane.org/gmane.linux.real-time.xenomai.users/3643/focus=3657

I'd be interested in any observations, comments or pointers to the "real 
cause" and any other "real fixes".

Tom Evans

