From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <181804936ABC2349BE503168465576460D420F21@domain.hid>
References: <181804936ABC2349BE503168465576460D23D749@domain.hid>
	<181804936ABC2349BE503168465576460D420F21@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Jan 2010 17:33:50 +0100
Message-ID: <1262622830.2220.51.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Retrieving virq based on hardware irq
 forrt_intr_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2010-01-04 at 09:54 -0600, Steve Deiters wrote:
> I am still trying to figure out a good way to reliably get the irq
> numbers from user space.

To shortly answer your previous question, I don't think forcing a hw_irq
-> virq mapping is the right way to go, except if you are ok to adapt
your device tree description to this end, which might be overkill.

>   Would it be better to create an interrupt object using
> rt_intr_create in kernel space and then retrieve it in user space with
> rt_intr_bind?  This way I can use regular kernel services to retrieve
> the irq number and only have to worry about the name I give it in user
> space.  This could all be done in a simple kernel module.
>  
> Would this cause any problems?

You can't intr_wait() on an interrupt descriptor created from kernel
space. But, there is a trick you could use:

do what you suggested, i.e. create a kernel-based interrupt object, but
do install a valid ISR in kernel space collecting the interrupt events
for that source, _and_ make this ISR invoke the routine called
rt_intr_handler(). This handler does the gory stuff to wake up the
userland waiters, blocked on rt_intr_wait().

rt_intr_handler() is declared in native/intr.h, and you have to pass it
the address of the low-level Xenomai IRQ descriptor, your ISR has been
given on entry (i.e. the cookie which is converted to RT_INTR * via
I_DESC()).

This _should_ work (famous last words).

>   I would then have a basically unused ISR in kernel space, and in
> user space I would be handling the interrupt after returning from
> rt_intr_wait.  I just want to make sure there shouldn't be any issue
> using the interrupts in this manner.

Handling interrupts in userland is rarely a good idea, and you may want
to consider adopting a more conventional approach based on a RTDM-based
driver.

This said, if you really want to go that way, keep in mind the following
limitation of having IRQs handled in userland: no GDB possible on the
process implementing the IRQ server thread, especially if that interrupt
is level sensitive.

(GDB will stop the server thread to regain control over the process's
threads, which in turn will cause an interrupt storm, since your device
won't get proper attention from your ISR code - at least, not soon
enough).

>  
> Thanks.
> 
> 
> ______________________________________________________________________
> From: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] On Behalf Of Steve Deiters
> Sent: Tuesday, December 15, 2009 11:35 AM
> To: xenomai@xenomai.org
> Subject: [Xenomai-help] Retrieving virq based on hardware irq
> forrt_intr_create
> 
> 
> 
> I am using a PowerPC processor with an IPIC interrupt controller.  I
> know all the interrupt numbers assigned in the IPIC.  From userspace,
> I would like to use rt_intr_create to control an interrupt.  However,
> I don't know how to reliably retrieve the kernel assigned virq based
> on the hardware interrupt number.  I would like to be able to either
> retrieve this information somehow, or set up the kernel virq mapping
> so that I can force the desired virq mapping to the hardware irq
> number.
>  
> I'm not familiar enough with the kernel irq code to know how to do
> either of these.  I browsed through the code in irq.c.  It looks like
> the function irq_find_mapping is reserving space for
> NUM_ISA_INTERRUPTS, which I don't care about and is preventing me from
> getting a 1:1 mapping with the hardware irq.  I suppose I could get
> rid of that, but I'm hoping for a more practical solution.
>  
> Any help would be appreciated.
>  
> Thanks.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



