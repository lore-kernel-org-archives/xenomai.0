From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CE18FDF.4010700@domain.hid>
References: <4CE18A9F.5030007@domain.hid>  <4CE18FDF.4010700@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Nov 2010 21:53:42 +0100
Message-ID: <1289854422.1933.204.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Flaw in x86-32 syscall/irq return path - and maybe
 more
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Mon, 2010-11-15 at 20:54 +0100, Jan Kiszka wrote:
> Am 15.11.2010 20:31, Jan Kiszka wrote:
> > Hi Philippe,
> > 
> > debugging some variant of I-pipe over an x86-32 target, I think I found
> > some fairly old flaw in the IRQ virtualization that causes rescheduling
> > delays (up to deadlocks) for Linux:
> > 
> > - we are in sysenter_tail (other exit paths should be affected as well)
> > - we DISABLE_INTERRUPTS, but only virtually
> > - we go past "testl $_TIF_ALLWORK_MASK, %ecx", nothing to be done
> > - an IRQ for Linux arrives, it is pushed to the backlog
> > - __ipipe_unstall_iret_root replays the IRQ as the regs we are about to
> >   return to have IF set (obviously, we return from a syscall)
> > - the Linux IRQ handler sets _TIF_NEED_RESCHED, but doesn't perform the
> >   work on return as __ipipe_sync_stage set the stall flag for the Linux
> >   domain before calling the handler
> > - but now the preempted sysenter return also does no reschedule as it
> >   already passed the check - bang!
> > 
> > Another variant of this Linux rescheduling issue:
> > 
> > - we are in a lengthy loop inside the kernel, but we are preemptible
> >   most of the time
> > - after disabling Linux IRQs briefly, we are calling
> >   local_irq_enable() again
> > - in the meantime, we received a Linux IRQ which is now pending in the
> >   backlog
> > - __ipipe_unstall_root triggers __ipipe_sync_stage
> > - Linux handler is called, sets NEED_RESCHED but does not reschedule
> >   (see above)
> > - we do not test for resched again as we are not returning to user
> >   space, and that for quite some time - bang!
> 
> And this one actually affects x86-64 as well: Here, ret_from_intr checks
> for NEED_RESCHED only if IF is set in the flags of the preempted
> context. But if the Linux domain is alone, we enter __ipipe_do_root_xirq
> with hard IRQs disabled, thus we push this information incorrectly on
> the Linux handler stack, preventing the required rescheduling check.
> 
> I guess the simplest fix for this is to drop the
> "!__ipipe_pipeline_head_p(ipd)" check from __ipipe_sync_stage.
> 

We can't do that unfortunately, we would introduce significant latency
when the interrupt is to be delivered to the high priority domain. This
check makes sure to keep irqs off when delivering to Xenomai for
instance, since we don't want the handler to be delayed for pushing
non-rt interrupts to the log while handling a rt event.

Not that pretty, but this would be innocuous latency-wise:

diff --git a/arch/x86/include/asm/ipipe_64.h b/arch/x86/include/asm/ipipe_64.h
index b9367f6..a3b4fed 100644
--- a/arch/x86/include/asm/ipipe_64.h
+++ b/arch/x86/include/asm/ipipe_64.h
@@ -71,6 +71,7 @@ static inline void __do_root_xirq(ipipe_irq_handler_t handler,
 			     "pushq $0\n\t"
 			     "pushq %%rax\n\t"
 			     "pushfq\n\t"
+			     "orq   %[x86if],(%%rsp)\n\t"
 			     "pushq %[kernel_cs]\n\t"
 			     "pushq $__xirq_end\n\t"
 			     "pushq %[vector]\n\t"
@@ -91,7 +92,8 @@ static inline void __do_root_xirq(ipipe_irq_handler_t handler,
 			     : /* no output */
 			     : [kernel_cs] "i" (__KERNEL_CS),
 			       [vector] "rm" (regs->orig_ax),
-			       [handler] "r" (handler), "D" (regs)
+			       [handler] "r" (handler), "D" (regs),
+			       [x86if] "i" (X86_EFLAGS_IF)
 			     : "rax");
 }
 
@@ -109,6 +111,7 @@ static inline void __do_root_virq(ipipe_irq_handler_t handler,
 			     "pushq $0\n\t"
 			     "pushq %%rax\n\t"
 			     "pushfq\n\t"
+			     "orq   %[x86if],(%%rsp)\n\t"
 			     "pushq %[kernel_cs]\n\t"
 			     "pushq $__virq_end\n\t"
 			     "pushq $-1\n\t"
@@ -125,7 +128,8 @@ static inline void __do_root_virq(ipipe_irq_handler_t handler,
 			     "call  *%[handler]\n\t"
 			     : /* no output */
 			     : [kernel_cs] "i" (__KERNEL_CS),
-			       [handler] "r" (handler), "D" (irq), "S" (cookie)
+			       [handler] "r" (handler), "D" (irq), "S" (cookie),
+			       [x86if] "i" (X86_EFLAGS_IF)
 			     : "rax");
 	irq_exit();
 	__asm__ __volatile__("cli\n\t"

> > 
> > I think both issues are only related to virtualizing DISABLE_INTERRUPTS
> > for entry_32.S and I wonder if this doesn't finally qualify for a switch
> > to the 64-bit model. Or do you see simpler fixes?
> > 
> 
> Jan
> 

-- 
Philippe.



