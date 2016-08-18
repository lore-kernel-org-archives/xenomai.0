References: <57B41CA5.5040103@allwinnertech.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a7e6b5c8-ba49-3b78-09a3-f8417ae4a0b9@xenomai.org>
Date: Thu, 18 Aug 2016 21:50:47 +0200
MIME-Version: 1.0
In-Reply-To: <57B41CA5.5040103@allwinnertech.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: xielinfei <xielinfei@allwinnertech.com>, xenomai@xenomai.org

On 08/17/2016 10:13 AM, xielinfei wrote:
> Hi Philippe,
> 
>      I try to port Xenomai-2.6.2 to ARM (cortex-a7) soc, Using:
>      Linux version: linux-3.4.39
>      I-pipe patch:  ipipe-core-3.4.6-arm-4.patch
>      Hardware: ARM (cortex-a7) single CPU
>      Following the guild: Porting Xenomai dual kernel to a new ARM SoC -
> Xenomai<https://www.google.com.hk/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=0ahUKEwiC5a-r8cfOAhWJRI8KHatQC_cQFggmMAE&url=https%3A%2F%2Fxenomai.org%2F2014%2F09%2Fporting-xenomai-dual-kernel-to-a-new-arm-soc%2F&usg=AFQjCNF7_SLahZ2bEmhJokUuxzy44eH10A&sig2=zgLgf_uma3eALRUl5S9v3A&bvm=bv.129759880,d.dGo>
> 
> 
>      For I-pipe patch, I modified <ipipe_tsc.c> and <ipipe_tsc_asm.S> to
> add support for "IPIPE_TSC_TYPE_FREERUNNING_ARCH"
>       (I have successfully running on linux-3.10 on the same ARM soc)
> 
>      After integrate I-pipe patch(without Xenomai), the kernel running
> for a while then halt, "__ipipe_tsc_update()" not update any more.
>      I trace the code, the timer IRQ is always got by the gic
> controller, but ipipe not dispatch. the call trace is :
>      __ipipe_grab_irq()--> __ipipe_dispatch_irq() -->
> __ipipe_sync_pipeline()
> 
>     static inline void __ipipe_sync_pipeline(struct ipipe_domain *top,
> unsigned int irq)
>     {
>               if (__ipipe_current_domain != top) {
>                   __ipipe_do_sync_pipeline(top);
>                   return;
>              }
>              if (!test_bit(IPIPE_STALL_FLAG,
> &ipipe_this_cpu_context(top)->status)){
>                  __ipipe_sync_stage();
>              }
>     }
> 
>     While halt,  the __ipipe_sync_pipeline will do nothing, if I hack
> it, force it calling "__ipipe_sync_stage"
>     the kernel can goes on, but this should not be the solution.
>     I don't know who set the IPIPE_STALL_FLAG, for I trace the code  it
> seems to be ok,
>    
> -------------------------------------------------------------------------------------------
> 
>     fun:ipipe_unstall_root,clear
>     fun:__ipipe_dispatch_irq, line=1279, control=1, name =Linux
>     fun:__ipipe_dispatch_irq, line=1285
>     fun:__ipipe_spin_lock_irqsave,test and set
>     fun:__ipipe_spin_unlock_irqrestore,clear
>     fun:__ipipe_dispatch_irq, line=1319
>     fun:__ipipe_spin_lock_irqsave,test and set
>     fun:ipipe_unstall_root,clear
>     fun:ipipe_unstall_root,clear
>     fun:ipipe_unstall_root,clear
>     fun:__ipipe_dispatch_irq, line=1279, control=1, name =Linux
>     fun:__ipipe_dispatch_irq, line=1285
>     fun:__ipipe_spin_lock_irqsave,test and set
>     fun:__ipipe_spin_unlock_irqrestore,clear
>     fun:__ipipe_dispatch_irq, line=1319
>     fun:__ipipe_spin_lock_irqsave,test and set
>     fun:ipipe_unstall_root,clear
>     fun:ipipe_unstall_root,clear
>     fun:ipipe_unstall_root,clear
>   
> ------------------------------------------------------------------------------------------
> 
> 
>    Looking forward to get some suggestion!   thank you!
> 

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

Now, when the stall bit looks wacky at some point, there are two typical
culprits:

- the low level irq trampoline spuriously branches back to the regular
linux IRQ tail code after the interrupt was handled from __irq_svc or
__irq_usr, although the root domain is not current or stalled. This may
happen with a new architecture port, but I don't think it can happen
with an existing arm port unless you touched this code, which you should
not have. Your SoC is likely defining MULTI_IRQ_HANDLER, so the macro
irq_handler in entry-armv.S needs inspection for that particular path,
making sure that it ends with a call to
__ipipe_check_root_interruptible. That call should return non-zero if
the IRQ can be seen by the regular kernel (i.e. root domain active and
not stalled), zero otherwise.

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

Also, the best way to debug those issues is to start with the minimum
possible code involved, and the maximum debug knobs turn on. That means:

- enable the pipeline, but disable Xenomai. With a Xenomai 2.6 core,
that means that no skin (posix, native, etc) should be pushed on top of
the nucleus, so that the hardware timer is not redirected to the
real-time core. In fact, you should basically leave Xenomai out of the
kernel build.

- turn on IPIPE_DEBUG, IPIPE_DEBUG_INTERNAL, IPIPE_DEBUG_CONTEXT,
DEBUG_SPINLOCKS.

- try downgrading to uniprocessor mode, to see if SMP is involved.

If nothing of the above helps, there is the possibility to use the
I-pipe tracer for tracking the stall bit manipulation until a certain
point in the execution is reached (IPIPE_TRACE_MCOUNT). If you can
certainly identify at which point the situation looks wrong, which you
seem to be able to, then call ipipe_trace_panic_freeze() followed by
ipipe_trace_panic_dump() at that point - you will need IPIPE_TRACE_PANIC
enabled too.

Make sure to keep the serial console in the kernel boot line, instead of
switching over a vt.

With a bit of luck, you should see a backtrace of kernel function calls,
with the current state of the stall bit for each of them. Maybe you
could find the offending call that leaves the root domain unexpectedly
stalled. You may have to play with the backtrace depth to collect enough
data, there is no knob for this, just adjust IPIPE_DEFAULT_BACK_TRACE
from kernel/ipipe/tracer.c.
This may help as well:
http://xenomai.org/2014/06/using-the-i-pipe-tracer/

-- 
Philippe.

