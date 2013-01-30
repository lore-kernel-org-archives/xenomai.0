Message-ID: <5108FB91.2040105@xenomai.org>
Date: Wed, 30 Jan 2013 11:53:05 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5108FABD.8090401@sirius-es.it>
In-Reply-To: <5108FABD.8090401@sirius-es.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FPU problems in Xenomai 2.4.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Cc: xenomai@xenomai.org

On 01/30/2013 11:49 AM, Matteo Facchinetti wrote:
> Hi,
>
> in a PPC mpc5125 system we're using xenomai 2.4.x (from git repository)

2.4.x is no more supported since ages. Besides, we don't support mpc512x 
over this release for sure.

> with kernel 2.6.29
> and have applied
> ksrc_arch_powerpc_patches_adeos-ipipe-2.6.29.4-powerpc-DENX-2.6-02.patch
>
> We have encountered a problem in a userspace application that makes
> heavy use of the FPU.
> In specific, our application consists about two concurrent processes:
> - the first use FPU in a xenomai_task
> - the second use FPU in a normal linux thread
>
> After a random time of test, Kernel crash with the following oops:
>
> Unrecoverable FP Unavailable Exception 801 at c0003888
> Oops: Unrecoverable FP Unavailable Exception, sig: 6 [#1]
> PREEMPT MPC5125 ADS
> Modules linked in: xeno_can_mscan xeno_can mchpar1xxx ipv6
> NIP: c0003888 LR: c0006c14 CTR: 1008879c
> REGS: ced71e40 TRAP: 0801   Not tainted  (2.6.29.1)
> MSR: 00009032 <EE,ME,IR,DR>  CR: 84000444  XER: 00000000
> TASK = cec164e0[4069] 'gui_powerpc.elf' THREAD: ced70000
> GPR00: c0006c04 ced71ef0 cec164e0 ced71efc ced71ef8 cec166e8 102b24fe
> 000000cc
> GPR08: 102b2500 c0520000 00000000 00000000 0ec166e8
> NIP [c0003888] cvt_fd+0x0/0x1c
> LR [c0006c14] fix_alignment+0x6cc/0x84c
> Call Trace:
> [ced71ef0] [c0006c04] fix_alignment+0x6bc/0x84c (unreliable)
> [ced71f30] [c0010cec] alignment_exception+0x8c/0x128
> [ced71f40] [c0013820] ret_from_except_full+0x0/0x4c
> --- Exception: 600 at 0x100887ac
>      LR = 0x100887a4
> Instruction dump:
> dbe30110 fc00048e d8030118 41820014 80850084 38602900 7c841878 90850084
> 38a00000 3c80c052 90a46044 4e800020 <c8050118> fdfe058e c0030000 d8040000
> ---[ end trace 0cdaae6afca79e76 ]---
> note: gui_powerpc.elf[4069] exited with preempt_count 1
>
> In relation about mail:
> http://www.xenomai.org/pipermail/xenomai-core/2010-10/msg00007.html
> We commented out local_irq_save_hw_cond(flags).
> Kernel doesn't crash but application die with fpu register corrupted.
>
> Does anyone know if xenomai 2.4.x with 2.6.29 kernel series have
> problems with heavy FPU usage?

A number of FPU related bugs have been fixed in the last _years_, 
requiring both I-pipe fixes and Xenomai core fixes.

-- 
Philippe.

