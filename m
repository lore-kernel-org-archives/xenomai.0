Message-ID: <45B770C5.6000803@domain.hid>
Date: Wed, 24 Jan 2007 15:44:21 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Patching latest Denx 2.4.25-devel kernel with
	xenomai-2.3.0 fails
References: <DD39B5C3F4963040ADC9768BE7E430CB01903C10@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01903C10@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Hi Daniel,

Daniel Schnell wrote:
> Hi,
> 
> I want to patch the latest Denx 2.4.25 kernel with Xenomai-2.3.0
> 
> The prepare-kernel.sh skript fails with the following message:
> 
> [root@domain.hid xenomai-2.3.0]# scripts/prepare-kernel.sh --arch=ppc
> --adeos=ksrc/arch/powerpc/patches/adeos-ipipe-2.4.25-ppc-CVS-20060707-1.
> 2-01.patch --linux=../linuxppc_2_4_devel-git-xenomai-2.3.0
> patching file arch/ppc/config.in
> Hunk #1 succeeded at 858 (offset 40 lines).
> patching file arch/ppc/kernel/Makefile
> patching file arch/ppc/kernel/entry.S
> patching file arch/ppc/kernel/head.S
> patching file arch/ppc/kernel/head_440.S
> patching file arch/ppc/kernel/head_44x.S
> patching file arch/ppc/kernel/head_4xx.S
> patching file arch/ppc/kernel/head_8xx.S
> patching file arch/ppc/kernel/head_e500.S
> patching file arch/ppc/kernel/idle.c
> patching file arch/ppc/kernel/ipipe-core.c
> patching file arch/ppc/kernel/ipipe-root.c
> patching file arch/ppc/kernel/irq.c
> patching file arch/ppc/kernel/ppc_ksyms.c
> patching file arch/ppc/kernel/traps.c
> patching file arch/ppc/mm/fault.c
> patching file include/asm-ppc/hw_irq.h
> patching file include/asm-ppc/ipipe.h
> patching file include/asm-ppc/mmu_context.h
> patching file include/asm-ppc/system.h
> patching file include/linux/ipipe.h
> patching file include/linux/sched.h
> Hunk #3 succeeded at 424 with fuzz 1.
> patching file init/main.c
> Hunk #1 succeeded at 412 (offset 3 lines).
> patching file kernel/Makefile
> patching file kernel/exit.c
> patching file kernel/fork.c
> patching file kernel/ipipe/Makefile
> patching file kernel/ipipe/core.c
> patching file kernel/ipipe/generic.c
> patching file kernel/printk.c
> patching file kernel/sched.c
> patching file kernel/signal.c
> ?
> 
> 
> Then the script unexpectedly exits without error (but a ?).
> 
> 
> Any hints appreciated.

I unable to reproduce your problem with a fresh linuxppc_2_4_devel tree 
and xenomai-2.3.0. Could you please use the "--verbose" option with 
prepare_kernel.sh and post the result.

Wolfgang.


