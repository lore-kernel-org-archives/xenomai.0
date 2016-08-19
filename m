Message-ID: <57B67DAD.8060707@allwinnertech.com>
Date: Fri, 19 Aug 2016 11:31:57 +0800
From: xielinfei <xielinfei@allwinnertech.com>
MIME-Version: 1.0
References: <57B41CA5.5040103@allwinnertech.com>
 <a7e6b5c8-ba49-3b78-09a3-f8417ae4a0b9@xenomai.org>
 <458bb092-c690-e8e9-7d9b-a66969b4505f@xenomai.org>
In-Reply-To: <458bb092-c690-e8e9-7d9b-a66969b4505f@xenomai.org>
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

1. About the cpu info:
---------------------------------------------------------------------------=
-------------------------------
# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 5 (v7l)
BogoMIPS        : 4800.00
Features        : swp half thumb fastmult vfp edsp thumbee neon vfpv3 tls v=
fpv4 idiva idivt
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xc07
CPU revision    : 5
Hardware        : sun8i
Revision        : 0000
Serial          : 44005033c8182c1606cd
---------------------------------------------------------------------------=
-----------------------------

2.For I-pipe patch: I use the official one: http://xenomai.org/downloads/ip=
ipe/v3.x/arm/older/ipipe-core-3.4.6-arm-4.patch

3.For "ipipe_tsc.c" add <__ipipe_freerunning_arch>
---------------------------------------------------------------------------=
-------------------
extern __ipipe_tsc_t __ipipe_freerunning_64,
    __ipipe_freerunning_32,
    __ipipe_freerunning_16,
    __ipipe_freerunning_countdown,
    __ipipe_decrementer_16,
    __ipipe_freerunning_twice_16,
    __ipipe_freerunning_arch;
extern unsigned long __ipipe_tsc_addr;

static struct __ipipe_tscinfo tsc_info;

static struct clocksource clksrc =3D {
    .name =3D "ipipe_tsc",
    case IPIPE_TSC_TYPE_FREERUNNING_TWICE:
        if (info->u.mask !=3D 0xffff)
            goto unimplemented;
        implem =3D &__ipipe_freerunning_twice_16;
        break;

    case IPIPE_TSC_TYPE_FREERUNNING_ARCH:
        implem =3D &__ipipe_freerunning_arch;
        break;

    default:
    unimplemented:
        printk("I-pipel: Unimplemented tsc configuration, "
               "type: %d, mask: 0x%08Lx\n", info->type, info->u.mask);
        BUG();
    }
---------------------------------------------------------------------------=
-------------------
Add the following code to "ipipe_tsc_asm.S"
------------------------------------------------------------------
    .align 5
    .globl __ipipe_freerunning_arch
__ipipe_freerunning_arch:
    nop
#ifdef CONFIG_ARM_ARCH_TIMER
    mrrc    p15, 0, r0, r1, c14
#else
    mov    r0, #0
    mov    r1, #0
#endif
    usr_ret    lr
---------------------------------------------------------------------

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
