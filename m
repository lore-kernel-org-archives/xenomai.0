Subject: Re: Kernel panic while booting in single processor mode
References: <1108-5eb3c880-3-411d5c80@96373432>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2ec8a8b0-7c08-050b-c8a4-b236300033aa@siemens.com>
Date: Thu, 7 May 2020 10:42:39 +0200
MIME-Version: 1.0
In-Reply-To: <1108-5eb3c880-3-411d5c80@96373432>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On 07.05.20 10:36, François Legal via Xenomai wrote:
> Hello,
> 
> trying to diagnose an imprecise external abort, I reconfigured the kernel to boot on a single core (SMP disabled) with I&D caches disabled.
> 
> Config is linux 4.4.189, xenomai-3.0.9
> 
> During the boot, when the system creates the thread for RTNET stack mgr, I get a kernel panic as you can see below.
> I could track that down to the "list_add_tail(&timer->next_stat, &clock->timerq);" in __xntimer_init.
> 
> Looks like clock->timerq (which is nkclock->timerq) is not initialized.
> 
> Am I missing something ?

I thinks there was an ordering issue... Is RTnet built-in (I suspect 
from the backtrace) or a module? That should be addressed in 3.1, 
possibly not backported to 3.0 (or only in current stable). I would have 
to dig into the git history myself now.

Jan

> 
> Thanks
> 
> François
> 
> [   13.432407] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [   13.441334] pgd = c0004000
> [   13.444419] [00000000] *pgd=00000000
> [   13.448370] Internal error: Oops: 817 [#1] PREEMPT ARM
> [   13.453955] Modules linked in:
> [   13.457409] CPU: 0 PID: 1 Comm: swapper Tainted: G        W       4.4.189 #14
> [   13.465087] Hardware name: Xilinx Zynq Platform
> [   13.470052] I-pipe domain: Linux
> [   13.473711] task: df458000 ti: df45a000 task.ti: df45a000
> [   13.479650] PC is at __xntimer_init+0xc0/0x108
> [   13.484577] LR is at string+0x3c/0x108
> [   13.488828] pc : [<c0091ec4>]    lr : [<c023e0fc>]    psr: 800f0093
> [   13.488828] sp : df45bd90  ip : c06fc65c  fp : df45bdb4
> [   13.501332] r10: c06fcb58  r9 : 3b9ac9ff  r8 : c075ddc0
> [   13.507062] r7 : df458000  r6 : 00000000  r5 : c06fc600  r4 : c075dc68
> [   13.514135] r3 : c06fb0e4  r2 : 00000000  r1 : c075dce0  r0 : 00000000
> [   13.521219] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   13.529281] Control: 18c52c79  Table: 1eb40059  DAC: 00000051
> [   13.535539] Process swapper (pid: 1, stack limit = 0xdf45a218)
> [   13.541885] Stack: (0xdf45bd90 to 0xdf45c000)
> [   13.546773] bd80:                                     df4582a4 c0240aac c075dbd8 00000000
> [   13.555943] bda0: 00000010 c075dcc0 df45be14 df45bdb8 c0090b10 c0091e10 00000080 c00dc614
> [   13.565106] bdc0: c075dcf0 c075dc68 c06fc9f8 00000080 c075a718 df447aa0 00000000 ffffe000
> [   13.574268] bde0: df45be14 df45bdf0 c02364d4 00000001 c075dbd8 c036cb54 c075dbd8 00000000
> [   13.583425] be00: deb05700 00000007 df45be34 df45be18 c0090cc0 c00909bc df45be48 000000a6
> [   13.592588] be20: deafd380 00000001 df45be84 df45be38 c0099060 c0090c78 df45be74 df45be48
> [   13.601752] be40: c013641c c023a810 00000062 c0549f6c deafd380 c06fcffc c06fced0 00000001
> [   13.610909] be60: 00000000 c0569c00 c075dbd8 c06f3ca0 00000000 00000000 df45beb4 df45be88
> [   13.620065] be80: c036ccfc c0099018 00000062 df45be98 00000000 00000000 c0716f00 00000000
> [   13.629232] bea0: c06f2008 c05be200 df45becc df45beb8 c05be2dc c036cc68 c06f3ca0 c06f3ca0
> [   13.638396] bec0: df45bf4c df45bed0 c00097d4 c05be20c df45bef4 df45bee0 c003f030 c023cb2c
> [   13.647550] bee0: dfffce78 00000000 df45bf4c df45bef8 c003f2b4 c05a151c 00000000 c052d138
> [   13.656699] bf00: 00000000 c052ca98 00000006 00000006 c0561904 c059f268 c0486f08 00000000
> [   13.665862] bf20: c06f6e2c 1d11931a c059f268 c05d178c c0720000 c0720000 c05c7850 c05c7830
> [   13.675020] bf40: df45bf94 df45bf50 c05a1edc c0009738 00000006 00000006 00000000 c05a1510
> [   13.684166] bf60: c05a1510 00000082 00000000 00000000 c04675a8 00000000 00000000 00000000
> [   13.693317] bf80: 00000000 00000000 df45bfac df45bf98 c04675b8 c05a1da0 00000000 c04675a8
> [   13.702467] bfa0: 00000000 df45bfb0 c000fe90 c04675b4 00000000 00000000 00000000 00000000
> [   13.711603] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   13.720737] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [   13.729724] Backtrace:
> [   13.732638] [<c0091e04>] (__xntimer_init) from [<c0090b10>] (__xnthread_init+0x160/0x2bc)
> [   13.741654]  r7:c075dcc0 r6:00000010 r5:00000000 r4:c075dbd8
> [   13.747851] [<c00909b0>] (__xnthread_init) from [<c0090cc0>] (xnthread_init+0x54/0x64)
> [   13.756594]  r10:00000007 r9:deb05700 r8:00000000 r7:c075dbd8 r6:c036cb54 r5:c075dbd8
> [   13.765169]  r4:00000001
> [   13.768151] [<c0090c6c>] (xnthread_init) from [<c0099060>] (rtdm_task_init+0x54/0xf4)
> [   13.776798]  r4:00000001
> [   13.779775] [<c009900c>] (rtdm_task_init) from [<c036ccfc>] (rt_stack_mgr_init+0xa0/0xac)
> [   13.788778]  r7:00000000 r6:00000000 r5:c06f3ca0 r4:c075dbd8
> [   13.794945] [<c036cc5c>] (rt_stack_mgr_init) from [<c05be2dc>] (rtnet_init+0xdc/0x180)
> [   13.803686]  r7:c05be200 r6:c06f2008 r4:00000000
> [   13.808767] [<c05be200>] (rtnet_init) from [<c00097d4>] (do_one_initcall+0xa8/0x21c)
> [   13.817326]  r5:c06f3ca0 r4:c06f3ca0
> [   13.821370] [<c000972c>] (do_one_initcall) from [<c05a1edc>] (kernel_init_freeable+0x148/0x1e0)
> [   13.830925]  r9:c05c7830 r8:c05c7850 r7:c0720000 r6:c0720000 r5:c05d178c r4:c059f268
> [   13.839521] [<c05a1d94>] (kernel_init_freeable) from [<c04675b8>] (kernel_init+0x10/0xec)
> [   13.848534]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04675a8
> [   13.857072]  r4:00000000
> [   13.860063] [<c04675a8>] (kernel_init) from [<c000fe90>] (ret_from_fork+0x18/0x28)
> [   13.868442]  r5:c04675a8 r4:00000000
> [   13.872464] Code: e2000001 e5851060 e584c078 e584207c (e5821000)
> [   13.879084] ---[ end trace f24b6c88ae00fa9b ]---
> [   13.885445] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   13.885445]
> [   13.895789] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   13.895789]
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

