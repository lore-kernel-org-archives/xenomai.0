Date: Thu, 14 Dec 2017 18:23:51 +0800
From: Peng Fan <van.freenix@gmail.com>
Message-ID: <20171214102348.tkgnln3xvzxkx5bc@linux-u7w5.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] xenomai on ARM64 question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am trying xenomai on ARM64 with GICV3, but met the following error.
I have no good idea on this. I disabled KVM/CPUFREQ/CPUIDLE, enabled DEBUG.
I use ipipe-core-4.9.51-arm64-3.patch with these patches applied from 4.9.y branch
"
ipipe: printk: fix unprotected check for deferrable output
ipipe: drop obsolete ipipe_probe_kernel*() calls
lib/ipipe: make dump_stack() domain-aware
ipipe: gicv3: [v3] Enable interrupt pipelining.
ipipe: add back migration notifiers
"

Do you know what this issue maybe related about?

Log:
[   20.236548] dhd_module_init out
[   20.239689] ALSA device list:
[   20.242750]   #0: amix-audio-sai
[   20.246170] Unable to handle kernel NULL pointer dereference at virtual addr0
[   20.254331] mm_pgd = ffff000009469000, hw_pgd = ffff8000015a4000
[   20.260341] [00000000] *pgd=00000008bfffe003, *pud=00000008bfffd003, *pmd=000
[   20.268640] Internal error: Oops: 86000004 [#1] PREEMPT SMP
[   20.274215] Modules linked in:
[   20.277278] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.51-ipipe-04033-g067
[   20.286238] Hardware name: Freescale i.MX8QXP MEK (DT)
[   20.291381] I-pipe domain: Linux
[   20.294614] task: ffff80083a088000 task.stack: ffff80083a034000
[   20.300540] PC is at 0x0
[   20.303083] LR is at __ipipe_ack_fasteoi_irq+0x1c/0x28
[   20.308228] pc : [<0000000000000000>] lr : [<ffff0000080ea104>] pstate: 20005
[   20.315626] sp : ffff80083ff31fd0
[   20.318945] x29: ffff80083ff31fd0 x28: ffff80083a034000
[   20.324270] x27: ffff80083acacb00 x26: ffff80083ff32090
[   20.329595] x25: ffff80083ff2e0a0 x24: 00000000024000c0
[   20.334921] x23: 0000000000000000 x22: 0000000000000000
[   20.340246] x21: ffff000009282000 x20: 0000000000000038
[   20.345572] x19: 0000000000000038 x18: 0000000000000001
[   20.350897] x17: 0000000000000001 x16: 0000000000000019
[   20.356223] x15: ffffffffffffffff x14: 0088000000000000
[   20.361548] x13: ffff00000970e000 x12: 0000000000000040
[   20.366874] x11: ffff8008380016d0 x10: 0000000000000038
[   20.372199] x9 : ffff8008380001e8 x8 : 0000000000000000
[   20.377524] x7 : ffff80083a3eb800 x6 : ffff80083a3eb800
[   20.382850] x5 : ffff800838000000 x4 : ffff80083a3eb800
[   20.388175] x3 : 0000000000000000 x2 : 0000000000000000
[   20.393500] x1 : 0000000000000000 x0 : ffff80083a3eb820
[   20.398827]
[   20.400315] Process swapper/0 (pid: 1, stack limit = 0xffff80083a034038)
[   20.407022] Stack: (0xffff80083ff31fd0 to 0xffff80083a038000)
[   20.412772] Call trace:
[   20.415224] Exception stack(0xffff80083ff31e00 to 0xffff80083ff31f30)
[   20.421671] 1e00: 0000000000000038 0001000000000000 ffff80083ff31fd0 00000000
[   20.429507] 1e20: ffff00000922a000 0000000000000000 0000000000000000 00000000
[   20.437343] 1e40: 0000000000000000 ffff00000939d9c2 0000000000000003 00008000
[   20.445180] 1e60: ffff80083a011078 ffff80083a0c4000 00000000fffeee9e ffff8000
[   20.453013] 1e80: ffff80083ff31e90 ffff0000080a88d8 ffff80083ff31eb0 ffff0000
[   20.460849] 1ea0: ffff80083a3eb820 0000000000000000 0000000000000000 00000000
[   20.468686] 1ec0: ffff80083a3eb800 ffff800838000000 ffff80083a3eb800 ffff8000
[   20.476522] 1ee0: 0000000000000000 ffff8008380001e8 0000000000000038 ffff8000
[   20.484358] 1f00: 0000000000000040 ffff00000970e000 0088000000000000 ffffffff
[   20.492192] 1f20: 0000000000000019 0000000000000001
[   20.497076] [<          (null)>]           (null)
[   20.501790] [<ffff000008139070>] __ipipe_dispatch_irq+0x70/0x338
[   20.507800] [<ffff0000080812f4>] __ipipe_grab_irq+0x54/0xc8
[   20.513372] Exception stack(0xffff80083a037870 to 0xffff80083a0379a0)
[   20.519819] 7860:                                   0000000000000000 00000000
[   20.527658] 7880: ffff80083ff358d8 0000800836d11000 00000000000c0000 00000001
[   20.535493] 78a0: ffff80083aca3118 fefefeff646c606d 7f7f7f7f7f7f7f7f fffffff9
[   20.543331] 78c0: 0101010101010101 0000000000000003 ffff7e0000000000 ffff0000
[   20.551165] 78e0: 0088000000000000 ffffffffffffffff 0000000000000019 00000001
[   20.559001] 7900: 0000000000000001 ffff0000092248d8 0000000000000000 ffff8000
[   20.566837] 7920: ffff80083b244800 0000000000000000 00000000024000c0 ffff0000
[   20.574673] 7940: 0000000000020002 ffff80083acacb00 ffff80083b244800 ffff8000
[   20.582511] 7960: ffff000008138c74 ffff80083a0379a0 ffff000008138c98 00000005
[   20.590346] 7980: ffff80083a0379a0 ffff000008138c74 ffffffffffffffff ffff0004
[   20.598183] [<ffff0000080817b0>] gic_handle_irq+0xa8/0x100
[   20.603672] Exception stack(0xffff80083a037870 to 0xffff80083a0379a0)
[   20.610117] 7860:                                   0000000000000000 00000000
[   20.617954] 7880: ffff80083ff358d8 0000800836d11000 00000000000c0000 00000001
[   20.625792] 78a0: ffff80083aca3118 fefefeff646c606d 7f7f7f7f7f7f7f7f fffffff9
[   20.633627] 78c0: 0101010101010101 0000000000000003 ffff7e0000000000 ffff0000
[   20.641465] 78e0: 0088000000000000 ffffffffffffffff 0000000000000019 00000001
[   20.649299] 7900: 0000000000000001 ffff0000092248d8 0000000000000000 ffff8000
[   20.657135] 7920: ffff80083b244800 0000000000000000 00000000024000c0 ffff0000
[   20.664971] 7940: 0000000000020002 ffff80083acacb00 ffff80083b244800 ffff8000
[   20.672807] 7960: ffff000008138c74 ffff80083a0379a0 ffff000008138c98 00000005
[   20.680645] 7980: ffff80083a0379a0 ffff000008138c74 ffffffffffffffff ffff0004
[   20.688481] [<ffff000008082fc8>] el1_irq+0xc8/0x108
[   20.693361] [<ffff000008138c98>] ipipe_unstall_root+0x48/0x90
[   20.699116] [<ffff000008c25a24>] _raw_spin_unlock_irqrestore+0x44/0x48
[   20.705650] [<ffff0000085a563c>] lpuart32_startup+0xfc/0x190
[   20.711314] [<ffff000008584abc>] uart_startup.part.7+0x6c/0x160
[   20.717237] [<ffff000008584c00>] uart_port_activate+0x50/0x60
[   20.722990] [<ffff00000856df8c>] tty_port_open+0x84/0xe0
[   20.728302] [<ffff000008583660>] uart_open+0x38/0x48
[   20.733274] [<ffff000008566a70>] tty_open+0xd8/0x600
[   20.738245] [<ffff0000081f6e20>] chrdev_open+0x98/0x1c0
[   20.743475] [<ffff0000081eee64>] do_dentry_open+0x21c/0x320
[   20.749048] [<ffff0000081f0260>] vfs_open+0x48/0x80
[   20.753933] [<ffff000008200f38>] path_openat+0x560/0x10e8
[   20.759334] [<ffff000008202b84>] do_filp_open+0x64/0xe0
[   20.764564] [<ffff0000081f0680>] do_sys_open+0x130/0x208
[   20.769881] [<ffff0000081f0774>] SyS_open+0x1c/0x28
[   20.774769] [<ffff000009150d28>] kernel_init_freeable+0x1d4/0x24c
[   20.780863] [<ffff000008c1ffb8>] kernel_init+0x10/0x100
[   20.786094] [<ffff0000080837e4>] ret_from_fork+0x14/0x30
[   20.791412] Code: bad PC value
[   20.794508] ---[ end trace 9112804697c4e2a5 ]---
[   20.799147] note: swapper/0[1] exited with preempt_count 1
[   20.804710] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0b
[   20.804710]
[   20.813849] Kernel Offset: disabled
[   20.817340] Memory Limit: none
[   20.820402] ---[ end Kernel panic - not syncing: Attempted to kill init! exib
[   20.820402]


Thanks,
Peng.
-- 

