Message-ID: <448D2574.1000204@domain.hid>
Date: Mon, 12 Jun 2006 10:27:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <44720BD1.805@domain.hid>
	<447E9E9E.6070301@domain.hid>	<4486FCA3.2070501@domain.hid>
	<448703C2.8030601@domain.hid> <4487DEC5.50705@domain.hid>
	<448B4589.6030101@domain.hid>
In-Reply-To: <448B4589.6030101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] kgdb/x86 over I-pipe
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Philippe Gerum wrote:
>>>
>>>
>>>>Hi Jan,
>>>>
>>>>Based on your previous work, here is a set of patches coupling KGDB and
>>>>the I-pipe. Basically, I've attempted to shrink the extra patches needed
>>>>against the original KGDB + I-pipe ones to the bare minimum. This has
>>>>been obtained by having the I-pipe provide ipipe_current_safe(), and
>>>>drastically reduce the amount of fiddling with smp_processor_id().
>>>>
>>>>The key difference with the former implementation is that a domain (e.g.
>>>>Xenomai) is now expected to tell the I-pipe when it's switching to a
>>>>non-Linux stack, and the I-pipe makes good use of this information to
>>>>return the proper "current" value when asked to through
>>>>ipipe_safe_current() from the KGDB code. The issue of swapping
>>>
>>>
>>>This looks nice.
>>>
>>>
>>>
>>>>smp_processor_id() with ipipe_processor_id() has been addressed the hard
>>>>way: smp_processor_id() is simply defined as ipipe_processor_id() when
>>>>CONFIG_IPIPE and CONFIG_KGDB are both enabled in include/linux/smp.h.
>>>>This approach was actually used during the old Adeos times when pipeline
>>>>domain had their own separate stack. I take for granted that the CPU
>>>>penalty taken in doing this is perfectly acceptable, since well, we are
>>>>debugging after all.
>>>
>>>
>>>There is only one drawback: we will not be able to debug
>>>smp_processor_id-related bugs in ipipe/Xenomai anymore...
>>>
>>
>>Good point. Here is an updated patch.
>>
> 
> 
> Nope that's not the point I meant. I was referring to bugs like the
> missing smp_processor_id patch in asm-i386/mmu_context.h. Your way makes
> such problems disappear once you switch on the debugger. Remember that
> we spotted the mmu_context issue via kgdb.
>

Got it now. Indeed, making such kind of bugs disappear would be a very 
undesirable side-effect of enabling KGDB.

> The attached kgdb-ipipe patch (which also updates to kgdb-CVS head)
> addresses maintenance and smp-safeness by redefining the involved
> services only per source file, not kernel-wide. What's do you think
> about this approach?
> 

Mixed feelings. On one hand, it locally fixes the issue without masking 
any bugs and that's good. On the other hand, I've been bitten using this 
kind of tricks in earlier Adeos releases for patching printk() the same 
way, substituting it with spin_lock_irqsave_hw. At some point, 
spin_lock_irqsave became local_irq_save + spin_lock in the vanilla code, 
making the substitution of the former pointless, and opening a 
preemption hole in the code. This said, no spinlock macros are involved 
in the substitution you are suggesting, so there is no such risk, and in 
any case, the risk is confined to one file and not spread all over the 
place like with the raw_smp_processor_id() substitution. IOW, let's go 
your way.

While we are at it,
#define current ipipe_safe_current() /* ? */

> I'm also posting two fixes for ipipe itself to 1) make kgdb work over
> SMP and 2) fix a compiler warning.
> 
> This version works fine for me, at least in qemu. I tried to check SMP
> as well, but qemu obviously lacks support for NMIs raised via IPI, and
> this is used by kgdb to sync all CPUs on debugging events (vanilla kgdb
> suffers too).
> 

-- 

Philippe.

