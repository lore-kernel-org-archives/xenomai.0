Message-ID: <8e029de8-dac5-5788-c28b-1d20736ef494@siemens.com>
Date: Mon, 4 Apr 2022 15:47:33 +0200
MIME-Version: 1.0
Subject: Re: Machine freezes under Ubuntu 20.04
Content-Language: en-US
References: <CAMMcbao60ib7YVUDsD5FD=J7aTCzsTAsG3ggUc7vXPHvbvd5uw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAMMcbao60ib7YVUDsD5FD=J7aTCzsTAsG3ggUc7vXPHvbvd5uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arturo Laurenzi <arturo.laurenzi@gmail.com>, xenomai@xenomai.org

On 04.04.22 15:21, Arturo Laurenzi via Xenomai wrote:
> Dear Xenomai community,
> in our lab we use Xenomai + RTnet to control complex EtherCAT-based robotic
> platforms (research prototypes).
> 
> Our infrastructure is made of two multi-threaded processes, let's say A and
> B, as follows.
> 
> Process A is an ethercat master, wrapped to expose both a RT and NRT
> interface to other processes:
>  - A1: ecat master (SOEM-based, uses RTnet), SCHED_FIFO
>  - A2: iddp end-point, SCHED_FIFO
>  - A3: zmq server, xddp end-point, SCHED_OTHER
> 
> Process B is our "control process" where algorithms actually run:
>  - B1: control thread, SCHED_FIFO
>  - B2: communication thread, SCHED_OTHER
> 
> The two processes interact in two ways.
> The first is zmq-based, and happens between B1 and A3 during the
> initialization phase (so, before the time-critical part of thread B1).
> The second is iddp-based. Both endpoints (A2 and B1) will bind/connect to a
> set of pipes, to realize a bi-directional communication channel that is
> RT-safe.
> 
> This usually works fine under the following setup:
> 
> CPU: Intel Core i7-7820EQ @3.00 GHz
> OS/Kernel: Ubuntu 18.04 + Linux 4.19.140-xeno-ipipe-3.1
> Xenomai: v3.1 (Cobalt + Posix API)
> Compiler: default GCC (v7.5)
> 
> Recently, we have started a transition towards Ubuntu 20.04, and things
> have started to break.
> 
> The first attempt was to install kernel 5.4.151 and stick to ipipe. Under
> this setup, we experience issues even before starting our applications. We
> have seen random crashes while compiling with GCC, sporadic "System Program
> Problem Detected" popups by Ubuntu, and others. We even tried to re-install
> OS and kernel from scratch with no luck.

A reference setup for this kernel line can be found in xenomai-images
(https://source.denx.de/Xenomai/xenomai-images). Would be good to
understand which deviation from it makes the difference for which
component (see also further questions below).

> 
> The second attempt was to stick to our old kernel 4.19.140. All the weird
> issues disappear and the system is stable. However, we are unable to have
> the system pass our suite of "stress tests", which basically involve starting,
> running, and killing process B multiple times in a cyclic fashion, while
> process A runs in the background. After a short while (minutes), the whole
> system just hangs, forcing us to do an hard reset. Only once, we managed to
> get this kernel oops after rebooting (journalctl -k -b -1 --no-pager).
> 

For reliably recording crashes, it is highly recommended to use a UART
as kernel debug output.

> 
> *dic 20 17:07:10 com-exp-dev kernel: BUG: unable to handle kernel paging
> request at fffffffeee9e41b1*
> *dic 20 17:07:10 com-exp-dev kernel: PGD 42080c067 P4D 42080c067 PUD 0*
> *dic 20 17:07:10 com-exp-dev kernel: Oops: 0010 [#1] SMP PTI*
> *dic 20 17:07:10 com-exp-dev kernel: CPU: 1 PID: 134 Comm: kworker/u16:1
> Not tainted 4.19.140-xeno-ipipe-3.1 #1*
> *dic 20 17:07:10 com-exp-dev kernel: Hardware name:  /TS175, BIOS BQKLR112
> 07/04/2017*
> *dic 20 17:07:10 com-exp-dev kernel: I-pipe domain: Linux*
> *dic 20 17:07:10 com-exp-dev kernel: Workqueue: efi_rts_wq efi_call_rts*
> *dic 20 17:07:10 com-exp-dev kernel: RIP: 0010:0xfffffffeee9e41b1*
> *dic 20 17:07:10 com-exp-dev kernel: Code: Bad RIP value.*
> *dic 20 17:07:10 com-exp-dev kernel: RSP: 0018:ffffa6170334fd28 EFLAGS:
> 00010246*
> *dic 20 17:07:10 com-exp-dev kernel: RAX: 00000000000002ff RBX:
> 0000000000000000 RCX: fffffffeee9e73b8*
> *dic 20 17:07:10 com-exp-dev kernel: RDX: 00000000000000a1 RSI:
> ffff8884d8371400 RDI: ffffa61704f8fdcc*
> *dic 20 17:07:10 com-exp-dev kernel: RBP: ffff8884d8371000 R08:
> fffffffeee9e73b8 R09: ffffa61704f8fdd0*
> *dic 20 17:07:10 com-exp-dev kernel: R10: 00000000000002ff R11:
> 0000000000000018 R12: ffff8884d8371000*
> *dic 20 17:07:10 com-exp-dev kernel: R13: ffff8884d8371400 R14:
> ffffa61704f8fdcc R15: ffff8884c8331d84*
> *dic 20 17:07:10 com-exp-dev kernel: FS:  0000000000000000(0000)
> GS:ffff8884df500000(0000) knlGS:0000000000000000*
> *dic 20 17:07:10 com-exp-dev kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033*
> *dic 20 17:07:10 com-exp-dev kernel: CR2: fffffffeee9e4187 CR3:
> 000000042080a005 CR4: 00000000003606e0*
> *dic 20 17:07:10 com-exp-dev kernel: DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000*
> *dic 20 17:07:10 com-exp-dev kernel: DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400*
> *dic 20 17:07:10 com-exp-dev kernel: Call Trace:*
> *dic 20 17:07:10 com-exp-dev kernel:  ? __switch_to_asm+0x35/0x70*
> *dic 20 17:07:10 com-exp-dev kernel:  ? __switch_to_asm+0x41/0x70*
> *dic 20 17:07:10 com-exp-dev kernel:  ? __switch_to_asm+0x35/0x70*
> *dic 20 17:07:10 com-exp-dev kernel:  ? __switch_to_asm+0x41/0x70*
> *dic 20 17:07:10 com-exp-dev kernel:  ? efi_call+0x58/0x90*
> *dic 20 17:07:10 com-exp-dev kernel:  ? __switch_to_asm+0x41/0x70*
> *dic 20 17:07:10 com-exp-dev kernel:  ? efi_call_rts+0x18c/0x960*
> *dic 20 17:07:10 com-exp-dev kernel:  ? process_one_work+0x1ac/0x330*
> *dic 20 17:07:10 com-exp-dev kernel:  ? worker_thread+0x48/0x3e0*
> *dic 20 17:07:10 com-exp-dev kernel:  ? kthread+0xfc/0x130*
> *dic 20 17:07:10 com-exp-dev kernel:  ? process_one_work+0x330/0x330*
> *dic 20 17:07:10 com-exp-dev kernel:  ? kthread_park+0x80/0x80*
> *dic 20 17:07:10 com-exp-dev kernel:  ? ret_from_fork+0x36/0x50*
> *dic 20 17:07:10 com-exp-dev kernel: Modules linked in: fuse rtpacket
> binfmt_misc nls_ascii nls_cp437 vfat fat evdev x86_pkg_temp_thermal
> rt_e1000e intel_powerclamp i915 crc32c_intel rtnet i2c_algo_bit
> drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
> fb_sys_fops cfbcopyarea fb efi_pstore font fbdev efivars intel_pch_thermal
> video button loop sch_fq_codel msr drm drm_panel_orientation_quirks sunrpc
> efivarfs autofs4 e1000e i2c_i801 xhci_pci xhci_hcd ptp pps_core ahci
> libahci usbcore libata usb_common*
> *dic 20 17:07:10 com-exp-dev kernel: CR2: fffffffeee9e41b1*
> *dic 20 17:07:10 com-exp-dev kernel: ---[ end trace d36b472eaef981c9 ]---*
> *dic 20 17:07:10 com-exp-dev kernel: RIP: 0010:0xfffffffeee9e41b1*
> *dic 20 17:07:10 com-exp-dev kernel: Code: Bad RIP value.*
> *dic 20 17:07:10 com-exp-dev kernel: RSP: 0018:ffffa6170334fd28 EFLAGS:
> 00010246*
> *dic 20 17:07:10 com-exp-dev kernel: RAX: 00000000000002ff RBX:
> 0000000000000000 RCX: fffffffeee9e73b8*
> *dic 20 17:07:10 com-exp-dev kernel: RDX: 00000000000000a1 RSI:
> ffff8884d8371400 RDI: ffffa61704f8fdcc*
> *dic 20 17:07:10 com-exp-dev kernel: RBP: ffff8884d8371000 R08:
> fffffffeee9e73b8 R09: ffffa61704f8fdd0*
> *dic 20 17:07:10 com-exp-dev kernel: R10: 00000000000002ff R11:
> 0000000000000018 R12: ffff8884d8371000*
> *dic 20 17:07:10 com-exp-dev kernel: R13: ffff8884d8371400 R14:
> ffffa61704f8fdcc R15: ffff8884c8331d84*
> *dic 20 17:07:10 com-exp-dev kernel: FS:  0000000000000000(0000)
> GS:ffff8884df500000(0000) knlGS:0000000000000000*
> *dic 20 17:07:10 com-exp-dev kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033*
> *dic 20 17:07:10 com-exp-dev kernel: CR2: fffffffeee9e4187 CR3:
> 000000042080a005 CR4: 00000000003606e0*
> *dic 20 17:07:10 com-exp-dev kernel: DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000*
> *dic 20 17:07:10 com-exp-dev kernel: DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400*
> *dic 20 17:07:10 com-exp-dev kernel: general protection fault: 0000 [#2]
> SMP PTI*
> *dic 20 17:07:10 com-exp-dev kernel: CPU: 1 PID: 445 Comm: rs:main Q:Reg
> Tainted: G      D           4.19.140-xeno-ipipe-3.1 #1*
> *dic 20 17:07:10 com-exp-dev kernel: Hardware name:  /TS175, BIOS BQKLR112
> 07/04/2017*
> *dic 20 17:07:10 com-exp-dev kernel: I-pipe domain: Linux*
> *dic 20 17:07:10 com-exp-dev kernel: RIP: 0010:pgd_free+0x56/0x90*
> *dic 20 17:07:10 com-exp-dev kernel: Code: 2b 15 66 89 b4 00 48 bf 00 01 00
> 00 00 00 ad de 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 3a 89 b4 00 48 8b
> 48 08 48 8b 50 10 <48> 89 51 08 48 89 0a 48 b9 00 02 00 00 00 00 ad de 48
> 89 78 08 48*
> *dic 20 17:07:10 com-exp-dev kernel: RSP: 0018:ffffa617033f7b68 EFLAGS:
> 00010282*
> *dic 20 17:07:10 com-exp-dev kernel: RAX: fffff43d117c1b80 RBX:
> 0000000000000402 RCX: dead000000000100*
> *dic 20 17:07:10 com-exp-dev kernel: RDX: dead000000000200 RSI:
> ffff8884df06e000 RDI: dead000000000100*
> *dic 20 17:07:10 com-exp-dev kernel: RBP: ffffa617033f7b70 R08:
> 0000000000000001 R09: 0000000000000003*
> *dic 20 17:07:10 com-exp-dev kernel: R10: 00000000000acfb0 R11:
> 00000000000007ff R12: ffff8884df06e000*
> *dic 20 17:07:10 com-exp-dev kernel: R13: ffff8884d6f031c0 R14:
> ffffffffafa785a0 R15: ffff8884cd1c4080*
> *dic 20 17:07:10 com-exp-dev kernel: FS:  00007f0cc3fff700(0000)
> GS:ffff8884df500000(0000) knlGS:0000000000000000*
> *dic 20 17:07:10 com-exp-dev kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033*
> *dic 20 17:07:10 com-exp-dev kernel: CR2: fffffffeee9e4187 CR3:
> 000000044da2c004 CR4: 00000000003606e0*
> *dic 20 17:07:10 com-exp-dev kernel: DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000*
> *dic 20 17:07:10 com-exp-dev kernel: DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400*
> *dic 20 17:07:10 com-exp-dev kernel: Call Trace:*
> *dic 20 17:07:10 com-exp-dev kernel:  __mmdrop+0x52/0xf0*
> *dic 20 17:07:10 com-exp-dev kernel:  finish_task_switch+0x1bf/0x240*
> *dic 20 17:07:10 com-exp-dev kernel:  __schedule+0x208/0x650*
> *dic 20 17:07:10 com-exp-dev kernel:  ? default_wake_function+0xd/0x10*
> *dic 20 17:07:10 com-exp-dev kernel:  schedule+0x31/0x80*
> *dic 20 17:07:10 com-exp-dev kernel:  futex_wait_queue_me+0xc3/0x130*
> *dic 20 17:07:10 com-exp-dev kernel:  futex_wait+0x10a/0x250*
> *dic 20 17:07:10 com-exp-dev kernel:  do_futex+0x146/0xc50*
> *dic 20 17:07:10 com-exp-dev kernel:  ? ext4_file_write_iter+0xff/0x3a0*
> *dic 20 17:07:10 com-exp-dev kernel:  ? _cond_resched+0x14/0x30*
> *dic 20 17:07:10 com-exp-dev kernel:  ? dput+0x31/0x140*
> *dic 20 17:07:10 com-exp-dev kernel:  __x64_sys_futex+0x144/0x180*
> *dic 20 17:07:10 com-exp-dev kernel:  ? __f_unlock_pos+0xd/0x10*
> *dic 20 17:07:10 com-exp-dev kernel:  ? ksys_write+0xbc/0xd0*
> *dic 20 17:07:10 com-exp-dev kernel:  do_syscall_64+0x6d/0x250*
> *dic 20 17:07:10 com-exp-dev kernel:
> entry_SYSCALL_64_after_hwframe+0x44/0xa9*
> *dic 20 17:07:10 com-exp-dev kernel: RIP: 0033:0x7f0cc945d376*
> *dic 20 17:07:10 com-exp-dev kernel: Code: 44 24 60 0f 11 44 24 68 e8 97 38
> 00 00 e8 82 3c 00 00 89 de 45 31 d2 31 d2 41 89 c0 40 80 f6 80 4c 89 ff b8
> ca 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 26 01 00 00 44 89 c7 e8 b6 3c
> 00 00 31 f6*
> *dic 20 17:07:10 com-exp-dev kernel: RSP: 002b:00007f0cc3ffeab0 EFLAGS:
> 00000282 ORIG_RAX: 00000000000000ca*
> *dic 20 17:07:10 com-exp-dev kernel: RAX: ffffffffffffffda RBX:
> 0000000000000000 RCX: 00007f0cc945d376*
> *dic 20 17:07:10 com-exp-dev kernel: RDX: 0000000000000000 RSI:
> 0000000000000080 RDI: 000055b4f8812d74*
> *dic 20 17:07:10 com-exp-dev kernel: RBP: 000055b4f8812d48 R08:
> 0000000000000001 R09: 0000000000000004*
> *dic 20 17:07:10 com-exp-dev kernel: R10: 0000000000000000 R11:
> 0000000000000282 R12: 000055b4f8812d6c*
> *dic 20 17:07:10 com-exp-dev kernel: R13: 000055b4f880ba60 R14:
> 00007f0cc3ffeaf0 R15: 000055b4f8812d74*
> *dic 20 17:07:10 com-exp-dev kernel: Modules linked in: fuse rtpacket
> binfmt_misc nls_ascii nls_cp437 vfat fat evdev x86_pkg_temp_thermal
> rt_e1000e intel_powerclamp i915 crc32c_intel rtnet i2c_algo_bit
> drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
> fb_sys_fops cfbcopyarea fb efi_pstore font fbdev efivars intel_pch_thermal
> video button loop sch_fq_codel msr drm drm_panel_orientation_quirks sunrpc
> efivarfs autofs4 e1000e i2c_i801 xhci_pci xhci_hcd ptp pps_core ahci
> libahci usbcore libata usb_common*
> *dic 20 17:07:10 com-exp-dev kernel: ---[ end trace d36b472eaef981ca ]---*
> *dic 20 17:07:10 com-exp-dev kernel: RIP: 0010:0xfffffffeee9e41b1*
> *dic 20 17:07:10 com-exp-dev kernel: Code: Bad RIP value.*
> *dic 20 17:07:10 com-exp-dev kernel: RSP: 0018:ffffa6170334fd28 EFLAGS:
> 00010246*
> *dic 20 17:07:10 com-exp-dev kernel: RAX: 00000000000002ff RBX:
> 0000000000000000 RCX: fffffffeee9e73b8*
> *dic 20 17:07:10 com-exp-dev kernel: RDX: 00000000000000a1 RSI:
> ffff8884d8371400 RDI: ffffa61704f8fdcc*
> *dic 20 17:07:10 com-exp-dev kernel: RBP: ffff8884d8371000 R08:
> fffffffeee9e73b8 R09: ffffa61704f8fdd0*
> *dic 20 17:07:10 com-exp-dev kernel: R10: 00000000000002ff R11:
> 0000000000000018 R12: ffff8884d8371000*
> *dic 20 17:07:10 com-exp-dev kernel: R13: ffff8884d8371400 R14:
> ffffa61704f8fdcc R15: ffff8884c8331d84*
> *dic 20 17:07:10 com-exp-dev kernel: FS:  00007f0cc3fff700(0000)
> GS:ffff8884df500000(0000) knlGS:0000000000000000*
> *dic 20 17:07:10 com-exp-dev kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033*
> *dic 20 17:07:10 com-exp-dev kernel: CR2: fffffffeee9e4187 CR3:
> 000000044da2c004 CR4: 00000000003606e0*
> *dic 20 17:07:10 com-exp-dev kernel: DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000*
> *dic 20 17:07:10 com-exp-dev kernel: DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400*
> *dic 20 17:07:48 com-exp-dev kernel: rcu: INFO: rcu_sched self-detected
> stall on CPU*
> *dic 20 17:07:48 com-exp-dev kernel: rcu:         5-....: (20999 ticks this
> GP) idle=85e/1/0x4000000000000004 softirq=7766/7766 fqs=5246*
> *dic 20 17:07:48 com-exp-dev kernel: rcu:          (t=21000 jiffies g=13261
> q=147)*
> *dic 20 17:07:48 com-exp-dev kernel: NMI backtrace for cpu 5*
> *dic 20 17:07:48 com-exp-dev kernel: CPU: 5 PID: 387 Comm: NetworkManager
> Tainted: G      D           4.19.140-xeno-ipipe-3.1 #1*
> *dic 20 17:07:48 com-exp-dev kernel: Hardware name:  /TS175, BIOS BQKLR112
> 07/04/2017*
> *dic 20 17:07:48 com-exp-dev kernel: I-pipe domain: Linux*
> *dic 20 17:07:48 com-exp-dev kernel: Call Trace:*
> *dic 20 17:07:48 com-exp-dev kernel:  <IRQ>*
> *dic 20 17:07:48 com-exp-dev kernel:  dump_stack+0x98/0xbc*
> *dic 20 17:07:48 com-exp-dev kernel:  nmi_cpu_backtrace.cold+0x14/0x54*
> *dic 20 17:07:48 com-exp-dev kernel:  ? lapic_can_unplug_cpu.cold+0x39/0x39*
> *dic 20 17:07:48 com-exp-dev kernel:
> nmi_trigger_cpumask_backtrace+0xfa/0xfc*
> *dic 20 17:07:48 com-exp-dev kernel:
> arch_trigger_cpumask_backtrace+0x14/0x20*
> *dic 20 17:07:48 com-exp-dev kernel:  rcu_dump_cpu_stacks+0x96/0xca*
> *dic 20 17:07:48 com-exp-dev kernel:  rcu_check_callbacks.cold+0x20c/0x35e*
> *dic 20 17:07:48 com-exp-dev kernel:  update_process_times+0x40/0x80*
> *dic 20 17:07:48 com-exp-dev kernel:  tick_sched_handle.isra.0+0x2f/0x50*
> *dic 20 17:07:48 com-exp-dev kernel:  tick_sched_timer+0x3b/0x80*
> *dic 20 17:07:48 com-exp-dev kernel:  ? tick_sched_handle.isra.0+0x50/0x50*
> *dic 20 17:07:48 com-exp-dev kernel:  __hrtimer_run_queues+0xe6/0x190*
> *dic 20 17:07:48 com-exp-dev kernel:  hrtimer_interrupt+0x104/0x220*
> *dic 20 17:07:48 com-exp-dev kernel:  ? ___xnsched_run+0x2f5/0x4f0*
> *dic 20 17:07:48 com-exp-dev kernel:  smp_apic_timer_interrupt+0x45/0x90*
> *dic 20 17:07:48 com-exp-dev kernel:  ?
> smp_call_function_single_interrupt+0x10/0x10*
> *dic 20 17:07:48 com-exp-dev kernel:  __ipipe_do_IRQ+0x46/0x80*
> *dic 20 17:07:48 com-exp-dev kernel:  __ipipe_do_sync_stage+0x143/0x180*
> *dic 20 17:07:48 com-exp-dev kernel:  __ipipe_do_sync_pipeline+0xb1/0xc0*
> *dic 20 17:07:48 com-exp-dev kernel:  dispatch_irq_head+0xe1/0x110*
> *dic 20 17:07:48 com-exp-dev kernel:  __ipipe_dispatch_irq+0x198/0x1c0*
> *dic 20 17:07:48 com-exp-dev kernel:  __ipipe_handle_irq+0x89/0x1f0*
> *dic 20 17:07:48 com-exp-dev kernel:  apic_timer_interrupt+0x12/0x40*
> *dic 20 17:07:48 com-exp-dev kernel:  </IRQ>*
> *dic 20 17:07:48 com-exp-dev kernel: RIP:
> 0010:queued_spin_lock_slowpath+0xde/0x190*
> *dic 20 17:07:48 com-exp-dev kernel: Code: f7 41 89 c0 66 45 31 c0 41 39 c8
> 0f 84 ac 00 00 00 48 85 f6 c6 07 01 74 22 c7 46 08 01 00 00 00 65 ff 0d f1
> 5b 21 51 c3 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f3 90 48
> 8b 02 48 85*
> *dic 20 17:07:48 com-exp-dev kernel: RSP: 0018:ffffa617036dbc48 EFLAGS:
> 00000202 ORIG_RAX: ffffffffffffff13*
> *dic 20 17:07:48 com-exp-dev kernel: RAX: 0000000000140101 RBX:
> ffffa61705548000 RCX: ffff8884d595ba40*
> *dic 20 17:07:48 com-exp-dev kernel: RDX: 0000000000000001 RSI:
> 0000000000000000 RDI: ffffffffafc9ec70*
> *dic 20 17:07:48 com-exp-dev kernel: RBP: ffffa617036dbc50 R08:
> 8000000000000063 R09: ffff8884cd8e35c0*
> *dic 20 17:07:48 com-exp-dev kernel: R10: ffffa617036dbb88 R11:
> 0000000000000004 R12: ffffff8000000000*
> *dic 20 17:07:48 com-exp-dev kernel: R13: 0000008000000000 R14:
> ffffa61705547fff R15: ffffa61705548000*
> *dic 20 17:07:48 com-exp-dev kernel:  ? kmem_cache_alloc_node+0x166/0x1d0*
> *dic 20 17:07:48 com-exp-dev kernel:  ? _raw_spin_lock+0x1b/0x20*
> *dic 20 17:07:48 com-exp-dev kernel:
> __ipipe_pin_mapping_globally+0x6a/0xa5*
> *dic 20 17:07:48 com-exp-dev kernel:  vmap_page_range_noflush+0x28c/0x320*
> *dic 20 17:07:48 com-exp-dev kernel:  map_vm_area+0x30/0x40*
> *dic 20 17:07:48 com-exp-dev kernel:  __vmalloc_node_range+0x1ca/0x260*
> *dic 20 17:07:48 com-exp-dev kernel:  copy_process.part.0+0x6c8/0x1c00*
> *dic 20 17:07:48 com-exp-dev kernel:  ? _do_fork+0xd8/0x330*
> *dic 20 17:07:48 com-exp-dev kernel:  ? __alloc_file+0x70/0xe0*
> *dic 20 17:07:48 com-exp-dev kernel:  ? alloc_empty_file+0x63/0xb0*
> *dic 20 17:07:48 com-exp-dev kernel:  _do_fork+0xd8/0x330*
> *dic 20 17:07:48 com-exp-dev kernel:  ? __sys_socketpair+0x17d/0x230*
> *dic 20 17:07:48 com-exp-dev kernel:  __x64_sys_clone+0x22/0x30*
> *dic 20 17:07:48 com-exp-dev kernel:  do_syscall_64+0x6d/0x250*
> *dic 20 17:07:48 com-exp-dev kernel:
> entry_SYSCALL_64_after_hwframe+0x44/0xa9*
> *dic 20 17:07:48 com-exp-dev kernel: RIP: 0033:0x7f4153096285*
> *dic 20 17:07:48 com-exp-dev kernel: Code: 48 85 ff 74 3d 48 85 f6 74 38 48
> 83 ee 10 48 89 4e 08 48 89 3e 48 89 d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8
> 38 00 00 00 0f 05 <48> 85 c0 7c 13 74 01 c3 31 ed 58 5f ff d0 48 89 c7 b8
> 3c 00 00 00*
> *dic 20 17:07:48 com-exp-dev kernel: RSP: 002b:00007ffc7a31e0f8 EFLAGS:
> 00000206 ORIG_RAX: 0000000000000038*
> *dic 20 17:07:48 com-exp-dev kernel: RAX: ffffffffffffffda RBX:
> 00007f414b7fe700 RCX: 00007f4153096285*
> *dic 20 17:07:48 com-exp-dev kernel: RDX: 00007f414b7fe9d0 RSI:
> 00007f414b7fdb30 RDI: 00000000003d0f00*
> *dic 20 17:07:48 com-exp-dev kernel: RBP: 00007ffc7a31e1b0 R08:
> 00007f414b7fe700 R09: 00007f414b7fe700*
> *dic 20 17:07:48 com-exp-dev kernel: R10: 00007f414b7fe9d0 R11:
> 0000000000000206 R12: 00007ffc7a31e1ae*
> *dic 20 17:07:48 com-exp-dev kernel: R13: 00007ffc7a31e1af R14:
> 00007ffc7a31e1b0 R15: 00007f414b7fdb40*
> 
> 
> 
> The third attempt was to try out kernel 5.10.89 plus the new dovetail
> patch, and Xenomai v3.2.1. Again, all the weird issues are gone and the
> system is stable. However, we are unable to have the system pass our suite
> of "stress tests". Differently from 4.19-ipipe, the system resists for a
> longer time before hanging (few hours sometimes), but this also varies a
> lot.
> 
> After some more investigation, we found out something interesting. By
> removing the code that interacts with Process A, Process B is then able to
> run "forever" (overnight at least), but *only if Process A is not running*.
> Otherwise, the system will hang. In other words, the mere presence of
> Process A is affecting Process B, even though both IDDP and ZMQ have been
> removed from B and replaced with fake data. Furthermore, the system does
> not freeze if we set B1's scheduling policy to SCHED_OTHER.

Do you have the Xenomai watchdog enabled, thus will you be able to tell
RT application "hangs" (infinite loop at high prio) apart from real
hangs/crashes?

> 
> We have also run one more test where we disable B's non-RT thread, so that
> B is now single-threaded, and only runs B1 (SCHED_FIFO). We could therefore
> remove all mutexes and condition variables from the system, and the system
> is then able to run indefinitely. Notice that, even in this single-thread
> mode, the system still hangs if mutexes are left in their place.
> 
> From these - rather heuristic - tests, it looks like there could be some
> coupling between unrelated processes which causes some sort of bug, that is
> probably related to some interaction with mutexes/condvars, when these are
> used from a RT context. This issue shows up (or at least we have seen it)
> only under Ubuntu 20.04 (GCC 9.x), whereas a 18.04 build (GCC 7.x) looks
> fine.

Ubuntu toolchains are known for agressively enabling certain security
features. Maybe one that we didn't check yet flipped between 18.04 and
20.04 - if that switch is only difference between working and
non-working builds in your case. GCC itself should be fine, we are
testing with gcc-10 via Debian 11 in our CI.

Can you check whether the toolchain change breaks the kernel (kernel
with old toolchain runs fine with userspace built via new toolchain)?

> 
> The purpose of this message is twofold.
> First, to see if these symptoms might "ring a bell" to anyone in the
> community, who might be able to suggest a fix.
> Second, we'd like to ask what you would do to debug this issue. Which tool
> could we use to trace what's going on, considering that whatever the bug
> is, it leads to a state where the machine is not usable at all. We can
> share our .config files if required, and we are willing to test more
> combinations of kernel and xenomai patch or library versions upon your
> advice. Any help you can give us is greatly appreciated.
> 

Can you simplify your test case to a level that makes it sharable,
executable by third parties? Please also share your kernel .config.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

