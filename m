Message-ID: <53A3FAB0.4050100@axelsw.it>
Date: Fri, 20 Jun 2014 11:11:12 +0200
From: Marco Tessore <marco.tessore@axelsw.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Kernel freezes in __ipipe_sync_stage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Good morning,
I am a fairly new programmer to kernel code developement, and recently I 
deal with the development of applications and device drivers using the 
Linux / Ipipe / Xenomai platform;
I have a problem with a kernel installed on devices that we have in 
production, set up by another programmer.

Please allow me to describe the problem:
the problem is essentially that the kernel rarely, but often enough to 
be a problem,
seems to freeze at boot, and from what I have seen with a debugger 
hardware - specifically the Lauterbach T32 -
it seems that the stalemate is due to the ipipe code.

The kernel is version 2.6.31 for ARM architecture - specifically a 
Freescale iMX257, ARM926EJ-S - with Xenomai 2.5.6 and a not very recent 
ipipe patch, of which I did not know the version, i presume the one 
included in the xenomai archive.
The stalling seems to occur in the function __ ipipe_sync_stage, in 
kernel/ipipe/core.c, and can occur at various times during the system boot.

As an example, I describe the stack that I could observe during one of 
these stall conditions:

__ipipe_mach_get_tsc
xntimer_tick_aperiodic
xintr_clock_handler
__ipipe_sync_stage
ipipe_suspend_domain
__ipipe_walk_pipeline
__ipipe_restore_pipeline
xnarc_next_htick_shot
clockevents_program_event
tick_dev_program_event
tick_program_event
hrtimer_interrupt
mxc_timer_interrupt
handle_IRQ_event
handle_level_irq
asm_do_IRQ
__ipipe_sync_stage  <-- loop
ipipe_suspend_domain
__ipipe_walk_pipeline
__ipipe_restore_pipeline_head
xnpod_enable_timesource
xnpod_init
__native_skin_init
do_one_initcall
kernel_init


The problem seems to occur within the first call to the function 
__ipipe_sync_stage (as indicated by the arrow),
in particular it seems that we never match the exit condition of the 
innermost "while" loop:
((submask = p-> irqpend_lomask [level])! = 0).

It seems that after the reset of p->irqpend_lomask[level], during the 
execution of interrupt service routine, timer interrupt I think,
it seems that the flag, or some other flags in the variable returns set, 
and this seems to cause the lock.

Given that, although I had an idea of the general mechanisms that drive 
ipipe, I am not able to grasp the implementation details,
in particular I cannot state when and where that flags are set, I 
presume when hw interrupt occours.

I was wondering if you could give me an idea of what could cause 
stalling or if you had any suggestions on how to get out, making
advancing the kernel in a clean state.

Thank you in advance for any suggestions you could give me,
kind regards
Marco Tessore

