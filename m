Message-ID: <4432C03B.7080001@domain.hid>
Date: Tue, 04 Apr 2006 20:51:39 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai on PPC
References: <CC692F5386B0AA47A62B7484A7CA2B6D027A2D87@domain.hid>
	<443295C2.4060504@domain.hid>
In-Reply-To: <443295C2.4060504@domain.hid>
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
To: Randy Smith <rsmith@domain.hid>
Cc: xenomai@xenomai.org

Randy Smith wrote:
> See below...
> 
> Behre, Frederik - LT wrote:
>>
>> Hello
>>
>> I have following Problem when I Build my uImage from my kernel.
>>
>> But first my configuration
>>
>> Host system:
>> ix86
>> Suse Linux 10.0 32bit
>>
>> Cross Compiler
>> Denx eldk ver. 3.11
>> (_www.denx.de_ <file://www.denx.de>)
>>
>> Target System
>> PPC (MPC8270) on Microsys PM827 Board.
>> linuxppc_2_4_devel-2005-10-25-1440
>> xenomai-2.1
>> adeos-ipipe-2.4.25-ppc-denx-1.0-03.patch
>>
>> I did following Steps
>>
>> installing the eldk
>> export Path to the Cross compiler to system Path
>> extrakt linux and xenomai
>> copy adeos
>>
>> THEN
>> >./xenomai-2.1.0/scripts/prepare-kernel.sh --arch=powerpc \
>>         --adeos=adeos-ipipe-2.4.25-ppc-denx-1.0-03patch  \
>>         --linux=linuxppc_2_4_devel-2005-10-25-1440/
>> patching file arch/ppc/config.in
>> patching file arch/ppc/kernel/Makefile
>> patching file arch/ppc/kernel/entry.S
>> patching file arch/ppc/kernel/head.S
>> patching file arch/ppc/kernel/head_440.S
>> patching file arch/ppc/kernel/head_44x.S
>> patching file arch/ppc/kernel/head_4xx.S
>> patching file arch/ppc/kernel/head_8xx.S
>> patching file arch/ppc/kernel/head_e500.S
>> patching file arch/ppc/kernel/idle.c
>> patching file arch/ppc/kernel/ipipe-core.c
>> patching file arch/ppc/kernel/ipipe-root.c
>> patching file arch/ppc/kernel/irq.c
>> patching file arch/ppc/kernel/ppc_ksyms.c
>> patching file arch/ppc/kernel/traps.c
>> patching file arch/ppc/mm/fault.c
>> patching file include/asm-ppc/hw_irq.h
>> patching file include/asm-ppc/ipipe.h
>> patching file include/asm-ppc/mmu_context.h
>> patching file include/asm-ppc/system.h
>> patching file include/linux/ipipe.h
>> patching file include/linux/sched.h
>> patching file init/main.c
>> patching file kernel/Makefile
>> patching file kernel/exit.c
>> patching file kernel/fork.c
>> patching file kernel/ipipe/Makefile
>> patching file kernel/ipipe/core.c
>> patching file kernel/ipipe/generic.c
>> patching file kernel/printk.c
>> patching file kernel/sched.c
>> patching file kernel/signal.c
>>
>> # I think I is ok ???
>>
>> >cd linuxppc_2_4_devel-2005-10-25-1440
>> >make ARCH=ppc CROSS_COMPILE=ppc_82xx- PM825config
>> /bin/sh: ppc-82xx-gcc: command not found
>> make: *** No rule to make target `PM825config'.  Stop.
>>
> 
> Make sure that you use something like
> 
> ${CROSS_COMPILE}make instead of just make.  It looks as if your are 
> picking up your host's make and it is confused.

There is _no_ ${CROSS_COMPILE}make in the ELDK. Standard make works just 
fine.

Wolfgang.

