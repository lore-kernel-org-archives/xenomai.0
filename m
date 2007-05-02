From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <26575694.1178110645829.JavaMail.ngmail@domain.hid>
References: <26575694.1178110645829.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 02 May 2007 16:47:17 +0200
Message-Id: <1178117237.5111.123.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Wed, 2007-05-02 at 14:57 +0200, M. Koehrer wrote:
> Hi Jan,
> 
> I have looked closed into that issue.
> For that I have added a global array that is written within  
> __ipipe_handle_irq() (file arch/i386/kernel/ipipe.c):
> 
>                 extern int xxx_int[];
>                 irq = ~irq;
> 
>                 xxx_int[0] = irq;
> 
> #ifdef CONFIG_X86_LOCAL_APIC
>                 {
>                         unsigned vector = irq + FIRST_EXTERNAL_VECTOR;
>                         if (vector >= FIRST_SYSTEM_VECTOR)
>                                 irq = ipipe_apic_vector_irq(vector);
>                 }
> 
>                  xxx_int[1] = irq;
> 
> 
> This global variable is printed out within the kernel trap.
> It returns the values 0xcf and 0xe0 (207 and 224) for xxx_int[0], xxx_int[1].
> And this is the really strange thing as the IRQ for the e1000 should be 219 (on a non-adeos-patched kernel).
> I do not know what happens here, but it looks really strange...
> 

It's not, this is ok. Fact is that 0xcf is the LAPIC's local timer
interrupt vectored from 0xef, this has nothing to do with the e1000 IRQ.
The effect of my latest patch is to remap this value to the 224-256
range for IRQ numbers which Adeos now reserves to system interrupts on
your setup, i.e. 0xcf becomes interrupt number 224, because it is a
system interrupt.

As a sidenote, let's not draw any conclusion regarding the interrupt
number that might cause the bug for now, we just don't have any
guarantee that the boot log is not lying at us so far; e.g. the latest
IRQ trace could well be stuck into the printk() ring buffer, regardless
of ipipe_set_printk_sync() being in effect for the root domain or not.
What we'd need is a raw serial console output routine (i.e.
__ipipe_debug_serial() from other Adeos ports), but I've not implemented
this for x86, unfortunately.

The sole and only important thing to achieve right now, is to have this
bug 100% reproducible on a stabilized setup, which also provides enough
instrumentation to allow further debugging without moving targets. It's
an interrupt-related bug, no wonder it may have multiple incarnations,
so let's choose one and only one of them, we could trace.

What I need to know, is which code is laid at address
__ipipe_handle_irq+0x26b, this is why I asked for the disassembly.
Each change in the kernel code or configuration option will much likely
change this address, for that reason, what we need is:

- get back to CONFIG_DEBUG_KERNEL off, since enabling it changes the
behaviour
- boot the machine, and hopefully get back to the usual BUG() message,
- send a copy of the kernel disassembly along with the boot log.

Without that, I have no mean to help debugging anything, I'm afraid.

-- 
Philippe.



