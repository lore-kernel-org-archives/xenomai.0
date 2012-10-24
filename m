Message-ID: <50882782.50003@xenomai.org>
Date: Wed, 24 Oct 2012 19:38:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>	
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>	
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>	
	<506DC2DA.5000105@xenomai.org> <506E9510.7090105@xenomai.org>	
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>	
	<506F402A.9030102@xenomai.org>	
	<1349473634.26881.221.camel@ENG-09-LX.emacinc.com>	
	<506F6283.2040901@xenomai.org>	
	<5afa3b9a7c7daf116f8284b4f255227e.squirrel@mail.emacinc.com>	
	<506FFDDC.60104@xenomai.org>	
	<1349816136.25350.426.camel@ENG-09-LX.emacinc.com>	
	<50749349.5070900@xenomai.org>	
	<1350681759.1282.88.camel@ENG-09-LX.emacinc.com>	
	<5081FF74.4010109@xenomai.org>	
	<1350933768.17153.16.camel@ENG-09-LX.emacinc.com>	
	<50859D99.5040009@xenomai.org>	
	<1350934476.17153.20.camel@ENG-09-LX.emacinc.com>	
	<5085B6BC.8060906@xenomai.org>	
	<1351006344.2975.60.camel@ENG-09-LX.emacinc.com>	
	<5086FA29.6010008@xenomai.org>
	<1351099930.25888.286.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1351099930.25888.286.camel@ENG-09-LX.emacinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Warren <wwarren@emacinc.com>
Cc: xenomai@xenomai.org

On 10/24/2012 07:32 PM, Wayne Warren wrote:
> We decided to try to continue debugging our current branch for another
> day or two.
> 
> We thought to check the link register just as execution enters
> __dabt_srv and found that the data abort exception occurs in an
> interrupt handler called from __int_svc, which is why we thought it was
> occurring on the cpsie instruction...actually, an interrupt seems to
> have occurred just as interrupts were enabled. The backtrace from the
> breakpoint in the function found using the LR value at __dabt_svc is:
> 
> (gdb) bt                                                                                                                                                     │············································································································
> #0  __ipipe_tsc_update () at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/arch/arm/kernel/ipipe_tsc.c:123                                                 │············································································································
> #1  0xc0059ac0 in omap2_gp_timer_interrupt (irq=38, dev_id=0xc07e4ba0) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/arch/arm/mach-omap2/timer-gp.c:77  │············································································································
> #2  0xc00c0bb0 in handle_IRQ_event (irq=38, action=0xc0634038) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/kernel/irq/handle.c:68                     │············································································································
> #3  0xc00c3378 in handle_level_irq (irq=38, desc=0xc07a68c8) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/kernel/irq/chip.c:529                        │············································································································
> #4  0xc003f044 in asm_do_IRQ (irq=38, regs=<value optimized out>) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/include/linux/irqdesc.h:125             │············································································································
> #5  0xc00c57c8 in __ipipe_sync_stage () at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/kernel/ipipe/core.c:1284                                          │············································································································
> #6  0xc005280c in __ipipe_grab_irq (irq=38, regs=0xc062df80) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/arch/arm/kernel/ipipe.c:605                  │············································································································
> #7  0xc04868f8 in __irq_svc ()                                                                                                                               │············································································································
> Backtrace stopped: frame did not save the PC       
> 
> This shows that the backtrace occurs in __ipipe_tsc_update.
> Specifically, it occurs when a "BLX" instruction is called on a register
> holding an address that points to no function in particular. I believe
> this is because the function __ipipe_tsc_get (called in
> __ipipe_tsc_update) is not defined.
> 
> CONFIG_IPIPE_ARM_KUSER_TSC is set to 'y' by default since CONFIG_OMAP is
> selected, so it seems that __ipipe_tsc_get is not mapped to
> __ipipe_mach_get_tsc by the preprocessor macro in
> arc/arm/include/asm/ipipe.h, near line 340. 
> 
> __ipipe_mach_get_tsc is something that the ArmPorting guide you linked
> me to a couple weeks ago mentions as needing to be defined, yet it
> appears because CONFIG_IPIPE_ARM_KUSER_TSC is defined, it wouldn't
> matter.
> 
> Do you have any suggestions? For now I think I will work on the
> __ipipe_mach_get_tsc function and force CONFIG_IPIPE_ARM_KUSER_TSC=n.

What you need is __ipipe_tsc_register to be called before any call to
__ipipe_tsc_update.

__ipipe_tsc_get is supposed to be defined to be something like 0xffff0f40

Or apply the following patch:
http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=42dd9056983cb6f65b6a336363f2f08f4426625a;hp=3b51cebda0b0d0123cb61b6ec07ecb62f293a528
-- 
					    Gilles.

