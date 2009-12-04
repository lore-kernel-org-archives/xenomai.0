Message-ID: <4B191BEA.3060801@domain.hid>
Date: Fri, 04 Dec 2009 15:25:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <634c78ce0912040535l753f267cycb3ea7057bfc432c@domain.hid>
In-Reply-To: <634c78ce0912040535l753f267cycb3ea7057bfc432c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] undefined symbols in xeno_nucleus
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Peter Soetens wrote:
> When compiling xenomai-head (master) from today with vanilla Linux
> 2.6.31.1 for amd64/smp, most of xenomai compiled as modules, I get at
> the end of the build process this:
> 
>   Building modules, stage 2.
>   MODPOST 2169 modules
> ERROR: "per_cpu__cpu_tlbstate"
> [kernel/xenomai/nucleus/xeno_nucleus.ko] undefined!

This is only exported by I-pipe for 32-bit.

> ERROR: "per_cpu__irq_stack_union"
> [kernel/xenomai/nucleus/xeno_nucleus.ko] undefined!

This not exported at all.

Likely both issues require a new I-pipe patch - unless we can remove the
need for them.

> WARNING: modpost: Found 12 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
> make[2]: *** [__modpost] Error 1
> 
> And grepping for them gives:
> 
> $ wcgrep per_cpu__cpu_tlbstate
> ./System.map:154:000000000001e100 D per_cpu__cpu_tlbstate
> ./.tmp_System.map:154:000000000001e100 D per_cpu__cpu_tlbstate
> 
> $ vader ~/src/xenomai/linux-2.6.31.1 $ wcgrep per_cpu__irq_stack_union
> ./System.map:3:0000000000000000 D per_cpu__irq_stack_union
> ./System.map:42431:ffffffff81774000 A init_per_cpu__irq_stack_union
> ./.tmp_System.map:3:0000000000000000 D per_cpu__irq_stack_union
> ./.tmp_System.map:42431:ffffffff81774000 A init_per_cpu__irq_stack_union
> ./arch/x86/kernel/asm-offsets.s:18246:  .string "per_cpu__irq_stack_union"
> ./arch/x86/kernel/vmlinux.lds.S:382:. = ASSERT((per_cpu__irq_stack_union == 0),
> ./arch/x86/kernel/vmlinux.lds:573:init_per_cpu__irq_stack_union =
> per_cpu__irq_stack_union + __per_cpu_load;
> ./arch/x86/kernel/vmlinux.lds:579:. = ASSERT((per_cpu__irq_stack_union == 0),
> 
> Any idea what went wrong ?
> 
> Also, I hit the 'sparse irqs' issue where ipipe.h complains about
> CONFIG_NR_IRQS being too high but the true cause is another option.
> Maybe the #error in ipipe.h should be:
> 
> #error "CONFIG_NR_CPUS is too large, please lower it or disable
> CONFIG_SPARSE_IRQ."

Removing this limitation is on our agenda.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

