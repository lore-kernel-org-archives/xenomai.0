From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15632.63612.203881.96921@domain.hid>
Date: Wed, 19 Jun 2002 23:32:44 +0200
Subject: Re: [Adeos-main] Re: My first tests with adeos!!!
In-Reply-To: <20020619051755.75505.qmail@domain.hid>
References: <3D0F0BA2.969434A3@domain.hid>
	<20020619051755.75505.qmail@domain.hid>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: mohan kumar <mohan_knb@domain.hid>
Cc: adeos <adeos-main@gna.org>

Hi Mohan,

Good news! I found the problem you encountered while hooking the
keyboard IRQ. Basically, I forgot to save a bunch of potentially
clobbered registers in the inline assembly code that calls the domain
handler. Other problems have been fixed too. All this leads to the
following updates in the current CVS tree:

1. adeos_virtualize_irq() now takes a 4th "modemask" argument which
specifies the initial IRQ control mode so that you don't have to call
adeos_control_irq() immediately after for the same purpose. Moreover,
this is nicely atomic as far as interrupt preemption is concerned.
Finally, a different handling of the "acknowledge" function pointer is
done. Passing NULL used to delegate the IRQ acknowledging to the next
domain down the pipeline able to perform it (i.e. having a non-zero
acknowledge routine pointer). Now, passing a NULL acknowledge routine
tells Adeos to use the ack routine defined by the root (Linux) domain
for the same IRQ. If you really don't want anyone down the pipeline
to ack the IRQ, just pass a pointer to an empty C routine returning
a non-zero value.

2. You can now specify one of the next two calling conventions for
your IRQ handler:

- The default one makes Adeos call your domain-specific IRQ handler
like a C routine, with the irq # stacked as its sole argument
(i.e. void my_kbd_handler(unsigned irq)).

- The other one makes Adeos assume that your handler is an assembly
routine.

The difference is important: when calling a C routine, Adeos saves and
restores the CPU registers automatically for you, so that your handler
can clobber them without any risk.  Conversely, using an assembly
calling convention tells Adeos that your routine handles the
appropriate register backup/recovery stuff according to which
registers are clobbered by your code. Moreover, you _must_ exit your
handler with an __asm("iret") instruction, and *not* a regular
"ret". On entry, %eax is loaded with the IRQ number. Linux handlers
use the assembly calling convention (see
linux/arch/i386/kernel/traps.c), while you will likely prefer using a
nice regular C routine to handle the interrupts Adeos passes to your
domain.

The calling convention can be selected using the new "modemask"
argument passed to adeos_virtualize_irq(): add IPIPE_CALLASM_MASK to
the mode mask to declare an assembly calling convention, otherwise,
the C calling convention will be applied by default.

Here is your code snippet, slightly modified to take these updates in
account. You will find that the keyboard IRQ is marked as "dynamic" in
adeos_virtualize_irq(), which means "IPIPE_HANDLE only and let the
handler decide". The handler can then invoke adeos_propagate_irq() to
pass the interrupt down the pipeline if he wants to, or do nothing,
which is equivalent to "don't pass". You will notice that the keyboard
IRQ _must_ be passed to Linux when your are done with it. If you don't
the keyboard driver state will be wrecked since some mandatory
processing is performed on behalf of the regular Linux keyboard
handler... :o> (in any case, the keyboard interrupt is a special beast
here since the keyboard softirq handler happens to sit in a busy wait
loop for supplemental kbd IRQs).

Philippe.

--

#include <linux/version.h>
#include <linux/module.h>
#include <linux/wrapper.h>
#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <asm/system.h>

MODULE_LICENSE("GPL");

static adomain_t this_domain;

void handler(unsigned irq)

{
    printk("CAUGHT IRQ #%d\n",irq);
    adeos_propagate_irq(1);
}

void domain_entry (void)

{
    printk("Domain %s started.\n",adp_current->name);

    adeos_virtualize_irq(1,&handler,NULL,IPIPE_DYNAMIC_MASK);

    for (;;)
	/* This is this domain's idle loop. */
	adeos_suspend_domain();	/* Yield control back to ADEOS. */
}
	
static int __init __adtest_init (void)

{
    adattr_t attr;

    attr.name = "TestDomain";
    attr.domid = 1;		/* Anything but 0 */
    attr.entry = &domain_entry;
    attr.estacksz = 0;	/* Let ADEOS choose a reasonable stack size */
    attr.priority = ADEOS_ROOT_PRI + 1;
    attr.dswitch = NULL;	/* Domain switch hook - always a C routine */

    return adeos_register_domain(&this_domain,&attr);
}

static void __exit __adtest_exit (void)

{
    adeos_unregister_domain(&this_domain);
}

module_init(__adtest_init);
module_exit(__adtest_exit);

