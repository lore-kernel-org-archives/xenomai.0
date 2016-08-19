Message-ID: <57B6FA48.4070609@allwinnertech.com>
Date: Fri, 19 Aug 2016 20:23:36 +0800
From: xielinfei <xielinfei@allwinnertech.com>
MIME-Version: 1.0
References: <57B41CA5.5040103@allwinnertech.com>
 <a7e6b5c8-ba49-3b78-09a3-f8417ae4a0b9@xenomai.org>
 <458bb092-c690-e8e9-7d9b-a66969b4505f@xenomai.org>
 <57B67DAD.8060707@allwinnertech.com>
In-Reply-To: <57B67DAD.8060707@allwinnertech.com>
Content-Type: text/plain; charset="Windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [help] porting I-pipe patch on linux-3.4
 ARM(cortex-a7) soc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Hi Philippe,


test-3.4.6-patch: it is the official I-pipe patch  ipipe-core-3.4.6-arm-4.p=
atch<http://xenomai.org/downloads/ipipe/v3.x/arm/older/ipipe-core-3.4.6-arm=
-4.patch>
test-3.4.v3s-patch: It is the vendor sdk with the modified I-pipe patch  (m=
ainly based on ipipe-core-3.4.6-arm-4.patch<http://xenomai.org/downloads/ip=
ipe/v3.x/arm/older/ipipe-core-3.4.6-arm-4.patch>)

The mainly differ as follow:
---------------------------------------------------------------------------=
-----------------------------------------------------------
diff -r test-3.4.6-patch/arch/arm/kernel/entry-armv.S test-3.4.v3s-patch/ar=
ch/arm/kernel/entry-armv.S
269a270,282
> __und_fault:
>     @ Correct the PC such that it is pointing at the instruction
>     @ which caused the fault.  If the faulting instruction was ARM
>     @ the PC will be pointing at the next instruction, and have to
>     @ subtract 4.  Otherwise, it is Thumb, and the PC will be
>     @ pointing at the second half of the Thumb instruction.  We
>     @ have to subtract 2.
>     ldr    r2, [r0, #S_PC]
>     sub    r2, r2, r1
>     str    r2, [r0, #S_PC]
>     b    do_undefinstr
> ENDPROC(__und_fault)
>
295c308
< #ifndef    CONFIG_THUMB2_KERNEL
---
> #ifndef CONFIG_THUMB2_KERNEL
297a311
>     mov    r1, #2
300,301c314,318
<     ldrhhs    r9, [r4]            @ bottom 16 bits
<     orrhs    r0, r9, r0, lsl #16
---
>     blo    __und_svc_fault
>     ldrh    r9, [r4]            @ bottom 16 bits
>     add    r4, r4, #2
>     str    r4, [sp, #S_PC]
>     orr    r0, r9, r0, lsl #16
303c320
<     adr    r9, BSYM(1f)
---
>     adr    r9, BSYM(__und_svc_finish)
306a324,325
>     mov    r1, #4                @ PC correction to apply
> __und_svc_fault:
308c327
<     bl    do_undefinstr
---
>     bl    __und_fault
313c332,333
< 1:    disable_irq_notrace
---
> __und_svc_finish:
>     disable_irq_notrace
476a497,499
>     @ r2 =3D regs->ARM_pc, which is either 2 or 4 bytes ahead of the
>     @      faulting instruction depending on Thumb mode.
>     @ r3 =3D regs->ARM_cpsr
478,482c501,503
<     @ fall through to the emulation code, which returns using r9 if
<     @ it has emulated the instruction, or the more conventional lr
<     @ if we are to treat this as a real undefined instruction
<     @
<     @  r0 - instruction
---
>     @ The emulation code returns using r9 if it has emulated the
>     @ instruction, or the more conventional lr if we are to treat
>     @ this as a real undefined instruction
485c506
<     adr    lr, BSYM(__und_usr_unknown)
---
>
487,490c508,510
<     itet    eq                @ explicit IT needed for the 1f label
<     subeq    r4, r2, #4            @ ARM instr at LR - 4
<     subne    r4, r2, #2            @ Thumb instr at LR - 2
< 1:    ldreqt    r0, [r4]
---
>     bne    __und_usr_thumb
>     sub    r4, r2, #4            @ ARM instr at LR - 4
> 1:    ldrt    r0, [r4]
492c512
<     reveq    r0, r0                @ little endian instruction
---
>     rev    r0, r0                @ little endian instruction
494c514,521
<     beq    call_fpe
---
>     @ r0 =3D 32-bit ARM instruction which caused the exception
>     @ r2 =3D PC value for the following instruction (:=3D regs->ARM_pc)
>     @ r4 =3D PC value for the faulting instruction
>     @ lr =3D 32-bit undefined instruction function
>     adr    lr, BSYM(__und_usr_fault_32)
>     b    call_fpe
>
> __und_usr_thumb:
495a523
>     sub    r4, r2, #2            @ First half of thumb instr at LR - 2
509c537
<     blo    __und_usr_unknown
---
>     blo    __und_usr_fault_16        @ 16bit undefined instruction
517,520c545
< 2:
<  ARM(    ldrht    r5, [r4], #2    )
<  THUMB(    ldrht    r5, [r4]    )
<  THUMB(    add    r4, r4, #2    )
---
> 2:    ldrht    r5, [r4]
522,523c547,548
<     blo    __und_usr_unknown
< 3:    ldrht    r0, [r4]
---
>     blo    __und_usr_fault_16        @ 16bit undefined instruction
> 3:    ldrht    r0, [r2]
524a550
>     str    r2, [sp, #S_PC]            @ it's a 2x16bit instr, update
525a552,556
>     adr    lr, BSYM(__und_usr_fault_32)
>     @ r0 =3D the two 16-bit Thumb instructions which caused the exception
>     @ r2 =3D PC value for the following Thumb instruction (:=3D regs->ARM=
_pc)
>     @ r4 =3D PC value for the first 16-bit Thumb instruction
>     @ lr =3D 32bit undefined instruction function
536c567
<     b    __und_usr_unknown
---
>     b    __und_usr_fault_16
538c569
<  UNWIND(.fnend        )
---
>  UNWIND(.fnend)
541,544d571
<     @
<     @ fallthrough to call_fpe
<     @
<
546c573
<  * The out of line fixup for the ldrt above.
---
>  * The out of line fixup for the ldrt instructions above.
577,578c604,605
<  *  r0  =3D instruction opcode.
<  *  r2  =3D PC+4
---
>  *  r0  =3D instruction opcode (32-bit ARM or two 16-bit Thumb)
>  *  r2  =3D PC value to resume execution after successful emulation
580c607
<  *  r10 =3D this threads thread_info structure.
---
>  *  r10 =3D this threads thread_info structure
581a609
>  * IRQs disabled, FIQs enabled.
716,717c744,749
< __und_usr_unknown:
<     enable_irq
---
> __und_usr_fault_32:
>     mov    r1, #4
>     b    1f
> __und_usr_fault_16:
>     mov    r1, #2
> 1:    enable_irq
720,721c752,754
<     b    do_undefinstr
< ENDPROC(__und_usr_unknown)
---
>     b    __und_fault
> ENDPROC(__und_usr_fault_32)
> ENDPROC(__und_usr_fault_16)
diff -r test-3.4.6-patch/arch/arm/kernel/entry-common.S test-3.4.v3s-patch/=
arch/arm/kernel/entry-common.S
385a386,394
> #ifdef CONFIG_ALIGNMENT_TRAP
>     ldr    ip, __cr_alignment
>     ldr    ip, [ip]
>     mcr    p15, 0, ip, c1, c0        @ update control register
> #endif
>     enable_irq
> #ifndef    CONFIG_IPIPE
>     get_thread_info tsk
> #endif /* !CONFIG_IPIPE */
399c408
<     ldreq    r10, [lr, #-4]            @ get SWI instruction
---
>  USER(    ldreq    r10, [lr, #-4]        )    @ get SWI instruction
401c410
<     ldr    r10, [lr, #-4]            @ get SWI instruction
---
>  USER(    ldr    r10, [lr, #-4]        )    @ get SWI instruction
425c434
<     ldreq    scno, [lr, #-4]
---
>  USER(    ldreq    scno, [lr, #-4]        )
430c439
<     ldr    scno, [lr, #-4]            @ get SWI instruction
---
>  USER(    ldr    scno, [lr, #-4]        )    @ get SWI instruction
437,446d445
< #ifdef CONFIG_ALIGNMENT_TRAP
<     ldr    ip, __cr_alignment
<     ldr    ip, [ip]
<     mcr    p15, 0, ip, c1, c0        @ update control register
< #endif
<     enable_irq
<
< #ifndef    CONFIG_IPIPE
<     get_thread_info tsk
< #endif /* !CONFIG_IPIPE */
499a499,513
>
> #if defined(CONFIG_OABI_COMPAT) || !defined(CONFIG_AEABI)
>     /*
>      * We failed to handle a fault trying to access the page
>      * containing the swi instruction, but we're not really in a
>      * position to return -EFAULT. Instead, return back to the
>      * instruction and re-enter the user fault handling path trying
>      * to page it in. This will likely result in sending SEGV to the
>      * current task.
>      */
> 9001:
>     sub    lr, lr, #4
>     str    lr, [sp, #S_PC]
>     b    ret_fast_syscall
> #endif
diff -r test-3.4.6-patch/arch/arm/kernel/entry-header.S test-3.4.v3s-patch/=
arch/arm/kernel/entry-header.S
132,133c132,133
<     mov    \rd, sp, lsr #13
<     mov    \rd, \rd, lsl #13
---
>     mov    \rd, sp, lsr #(PAGE_SHIFT + THREAD_SIZE_ORDER)
>     mov    \rd, \rd, lsl #(PAGE_SHIFT + THREAD_SIZE_ORDER)
193,194c193,194
<     lsr    \rd, \rd, #13
<     mov    \rd, \rd, lsl #13
---
>     lsr    \rd, \rd, #(PAGE_SHIFT + THREAD_SIZE_ORDER)
>     mov    \rd, \rd, lsl #(PAGE_SHIFT + THREAD_SIZE_ORDER)
diff -r test-3.4.6-patch/arch/arm/kernel/ipipe_tsc_asm.S test-3.4.v3s-patch=
/arch/arm/kernel/ipipe_tsc_asm.S
246a247,258
>
>     .align 5
>     .globl __ipipe_freerunning_arch
> __ipipe_freerunning_arch:
>     nop
> #ifdef CONFIG_ARM_ARCH_TIMER
>     mrrc    p15, 0, r0, r1, c14
> #else
>     mov    r0, #0
>     mov    r1, #0
> #endif
>     usr_ret    lr
diff -r test-3.4.6-patch/arch/arm/kernel/ipipe_tsc.c test-3.4.v3s-patch/arc=
h/arm/kernel/ipipe_tsc.c
19c19,20
<     __ipipe_freerunning_twice_16;
---
>     __ipipe_freerunning_twice_16,
>     __ipipe_freerunning_arch;
95a97,100
>         break;
>
>     case IPIPE_TSC_TYPE_FREERUNNING_ARCH:
>         implem =3D &__ipipe_freerunning_arch;
---------------------------------------------------------------------------=
-----------------------------------------------------------

kernel config as follow:
#
# Processor Type
#
CONFIG_CPU_V7=3Dy
CONFIG_CPU_32v6K=3Dy
CONFIG_CPU_32v7=3Dy
CONFIG_CPU_ABRT_EV7=3Dy
CONFIG_CPU_PABRT_V7=3Dy
CONFIG_CPU_CACHE_V7=3Dy
CONFIG_CPU_CACHE_VIPT=3Dy
CONFIG_CPU_COPY_V6=3Dy
CONFIG_CPU_TLB_V7=3Dy
CONFIG_CPU_HAS_ASID=3Dy
CONFIG_CPU_CP15=3Dy
CONFIG_CPU_CP15_MMU=3Dy

#
# Processor Features
#
# CONFIG_ARM_LPAE is not set
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
CONFIG_ARM_THUMB=3Dy
CONFIG_ARM_THUMBEE=3Dy
CONFIG_SWP_EMULATE=3Dy
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
# CONFIG_CPU_BPREDICT_DISABLE is not set
CONFIG_MIGHT_HAVE_CACHE_L2X0=3Dy
# CONFIG_CACHE_L2X0 is not set
CONFIG_ARM_L1_CACHE_SHIFT_6=3Dy
CONFIG_ARM_L1_CACHE_SHIFT=3D6
CONFIG_ARM_DMA_MEM_BUFFERABLE=3Dy
CONFIG_ARM_NR_BANKS=3D8
CONFIG_CPU_HAS_PMU=3Dy
CONFIG_MULTI_IRQ_HANDLER=3Dy
CONFIG_ARM_ERRATA_430973=3Dy
CONFIG_ARM_ERRATA_458693=3Dy
CONFIG_ARM_ERRATA_460075=3Dy
CONFIG_ARM_ERRATA_720789=3Dy
CONFIG_ARM_ERRATA_743622=3Dy
CONFIG_ARM_ERRATA_751472=3Dy
CONFIG_ARM_ERRATA_754322=3Dy
CONFIG_ARM_ERRATA_775420=3Dy
CONFIG_ARM_GIC=3Dy
# CONFIG_FIQ_DEBUGGER is not set
------------------------------------------------------------------------


On 2016?08?19? 04:01, Philippe Gerum wrote:

On 08/18/2016 09:50 PM, Philippe Gerum wrote:


On 08/17/2016 10:13 AM, xielinfei wrote:


Hi Philippe,

     I try to port Xenomai-2.6.2 to ARM (cortex-a7) soc, Using:
     Linux version: linux-3.4.39
     I-pipe patch:  ipipe-core-3.4.6-arm-4.patch
     Hardware: ARM (cortex-a7) single CPU
     Following the guild: Porting Xenomai dual kernel to a new ARM SoC -
Xenomai<https://www.google.com.hk/url?sa=3Dt&rct=3Dj&q=3D&esrc=3Ds&source=
=3Dweb&cd=3D2&cad=3Drja&uact=3D8&ved=3D0ahUKEwiC5a-r8cfOAhWJRI8KHatQC_cQFgg=
mMAE&url=3Dhttps%3A%2F%2Fxenomai.org%2F2014%2F09%2Fporting-xenomai-dual-ker=
nel-to-a-new-arm-soc%2F&usg=3DAFQjCNF7_SLahZ2bEmhJokUuxzy44eH10A&sig2=3DzgL=
gf_uma3eALRUl5S9v3A&bvm=3Dbv.129759880,d.dGo><https://www.google.com.hk/url=
?sa=3Dt&rct=3Dj&q=3D&esrc=3Ds&source=3Dweb&cd=3D2&cad=3Drja&uact=3D8&ved=3D=
0ahUKEwiC5a-r8cfOAhWJRI8KHatQC_cQFggmMAE&url=3Dhttps%3A%2F%2Fxenomai.org%2F=
2014%2F09%2Fporting-xenomai-dual-kernel-to-a-new-arm-soc%2F&usg=3DAFQjCNF7_=
SLahZ2bEmhJokUuxzy44eH10A&sig2=3DzgLgf_uma3eALRUl5S9v3A&bvm=3Dbv.129759880,=
d.dGo>


     For I-pipe patch, I modified <ipipe_tsc.c> and <ipipe_tsc_asm.S> to
add support for "IPIPE_TSC_TYPE_FREERUNNING_ARCH"
      (I have successfully running on linux-3.10 on the same ARM soc)

     After integrate I-pipe patch(without Xenomai), the kernel running
for a while then halt, "__ipipe_tsc_update()" not update any more.
     I trace the code, the timer IRQ is always got by the gic
controller, but ipipe not dispatch. the call trace is :
     __ipipe_grab_irq()--> __ipipe_dispatch_irq() -->
__ipipe_sync_pipeline()

    static inline void __ipipe_sync_pipeline(struct ipipe_domain *top,
unsigned int irq)
    {
              if (__ipipe_current_domain !=3D top) {
                  __ipipe_do_sync_pipeline(top);
                  return;
             }
             if (!test_bit(IPIPE_STALL_FLAG,
&ipipe_this_cpu_context(top)->status)){
                 __ipipe_sync_stage();
             }
    }

    While halt,  the __ipipe_sync_pipeline will do nothing, if I hack
it, force it calling "__ipipe_sync_stage"
    the kernel can goes on, but this should not be the solution.
    I don't know who set the IPIPE_STALL_FLAG, for I trace the code  it
seems to be ok,

---------------------------------------------------------------------------=
----------------

    fun:ipipe_unstall_root,clear
    fun:__ipipe_dispatch_irq, line=3D1279, control=3D1, name =3DLinux
    fun:__ipipe_dispatch_irq, line=3D1285
    fun:__ipipe_spin_lock_irqsave,test and set
    fun:__ipipe_spin_unlock_irqrestore,clear
    fun:__ipipe_dispatch_irq, line=3D1319
    fun:__ipipe_spin_lock_irqsave,test and set
    fun:ipipe_unstall_root,clear
    fun:ipipe_unstall_root,clear
    fun:ipipe_unstall_root,clear
    fun:__ipipe_dispatch_irq, line=3D1279, control=3D1, name =3DLinux
    fun:__ipipe_dispatch_irq, line=3D1285
    fun:__ipipe_spin_lock_irqsave,test and set
    fun:__ipipe_spin_unlock_irqrestore,clear
    fun:__ipipe_dispatch_irq, line=3D1319
    fun:__ipipe_spin_lock_irqsave,test and set
    fun:ipipe_unstall_root,clear
    fun:ipipe_unstall_root,clear
    fun:ipipe_unstall_root,clear

---------------------------------------------------------------------------=
---------------


   Looking forward to get some suggestion!   thank you!



As Lennart told you, you may be asking for trouble with porting an
outdated Xenomai release to an outdated Linux kernel, I assume you have
good reasons for inflicting such pain on yourself, so I won't rehash.
Bottom line is that arm-related changes between 3.4 and 3.10 are
significant both for the mainline kernel and the I-pipe implementation,
so I'm not surprised this is not a trivial backport.

It's a bit difficult to give you any advice without exactly knowing how
you did that backport, assuming you picked the official ipipe-3.10(-32?)
as the reference version, and which is that SoC exactly. At the very
least you should paste your diffs against the original ipipe code
composing the backport changes, so that we can better understand the
situation.

Your Cortex-A7 based SoC is likely to sport an architected timer, I
don't think the pipeline support code for this one would cause the issue.


Looking at the boot log that followed, this is indeed an architected timer.



Now, when the stall bit looks wacky at some point, there are two typical
culprits:


[snip]

I overlooked that you mentioned a single core SoC (sun8i single A7?
which SoC is it?), so downgrading from SMP to UP is unlikely to be an
option anyway, however the spinlock issue is still important with
respect to interrupt virtualization, including in uniprocessor mode:



- a hard spinlock construct is trashing the real IRQ state at unlocking.
__ipipe_spin_unlock_debug() should detect when this happens; make sure
to enable IPIPE_DEBUG_INTERNAL in SMP mode to catch it at the call site.
This assertion may trigger when some regular spinlock has not been
converted to a hard (ipipe) spinlock as it should have been, so one ends
up with the construct following construct: spin_lock_irqsave(&hard_lock)
-> spin_lock_irqsave(&regular_lock) ->
spin_unlock_irqrestore(&regular_lock) ->
spin_unlock_irqrestore(&hard_lock), which is wrong (bad nesting of a
regular lock within a hard lock).




--

Best regards!
=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97
???
????????????     BU1-PSW
??:???????????????2?9?
??:519000
TEL:15018321890
????: http://www.allwinnertech.com


--

Best regards!
=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97
???
????????????     BU1-PSW
??:???????????????2?9?
??:519000
TEL:15018321890
????: http://www.allwinnertech.com

NOTICE: This e-mail and any included attachments are intended only for the =
sole use of named and intended recipient (s) only. If you are the named and=
 intended recipient, please note that the information contained in this ema=
il and its embedded files are confidential and privileged. If you are neith=
er the intended nor named recipient, you are hereby notified that any unaut=
horized review, use, disclosure, dissemination, distribution, or copying of=
 this communication, or any of its contents, is strictly prohibited. Please=
 reply to the sender and destroy the original message and all your records =
of this message (whether electronic or otherwise). Furthermore, you should =
not disclose to any other person, use, copy or disseminate the contents of =
this e-mail and/or the documents accompanying it.
