From: Abel Vesa <abel.vesa@nxp.com>
Date: Fri, 22 Jun 2018 07:14:41 +0000
Message-ID: <20180622071440.2of2edqeswqbomqa@fsr-ub1664-175>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67E3AED7F6167745B1330073E7659B86@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai]  LOCKDEP warning due to ipipe generic implementation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>

I'm just curious if anyone has seen this LOCKDEP warning before.

>From a quick look it seems to be something that has to do with the generic =
ipipe.
More exactly the fact that handle_IRQ gets called outside the hardirq conte=
xt and
LOCKDEP doens't understand the fact that this is how ipipe works. I would g=
uess either
the LOCKDEP config should depend on !IPIPE or the ipipe should have a speci=
fic case
the in LOCKDEP implementation so that this warning doesn't shown since it w=
ill never
happen when IPIPE is enabled.

I haven't looked too far into this and I might be missing stuff.

Here is the LOCKDEP warning itself:

...
[    0.309269] NET: Registered protocol family 31
[    0.309282] Bluetooth: HCI device and connection manager initialized
[    0.309350] Bluetooth: HCI socket layer initialized
[    0.309384] Bluetooth: L2CAP socket layer initialized
[    0.309597] Bluetooth: SCO socket layer initialized
[    0.312385]=20
[    0.312399] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.312410] [ INFO: inconsistent lock state ]
[    0.312423] 4.9.35-ipipe-00014-g0d0457a-dirty #700 Not tainted
[    0.312432] ---------------------------------
[    0.312442] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[    0.312456] swapper/1/0 [HC0[0]:SC0[0]:HE1:SE1] takes:
[    0.312466]  (std_spinlock_raw(&rq->lock)){?.-...}, at: [<c09ca9c8>] __s=
chedule+0x6c/0x61c
{IN-HARDIRQ-W} state was registered at:
[    0.312530]   lock_acquire+0x94/0xbc
[    0.312545]   _raw_spin_lock+0x30/0x40
[    0.312559]   scheduler_tick+0x38/0xc4
[    0.312575]   update_process_times+0x54/0x64
[    0.312588]   update_root_process_times+0x50/0x54
[    0.312605]   tick_periodic+0x3c/0xec
[    0.312618]   tick_handle_periodic+0x30/0xa4
[    0.312635]   twd_handler+0x40/0x54
[    0.312650]   handle_percpu_devid_irq+0x74/0x148
[    0.312666]   generic_handle_irq+0x28/0x3c
[    0.312680]   __handle_domain_irq+0x70/0xe4
[    0.312696]   handle_IRQ+0x20/0x24
[    0.312711]   __ipipe_do_IRQ+0x2c/0x38
[    0.312726]   __ipipe_do_sync_stage+0x260/0x298
[    0.312738]   ipipe_unstall_root+0x48/0x58
[    0.312751]   _raw_spin_unlock_irqrestore+0x3c/0x48
[    0.312769]   mix_pool_bytes+0x44/0x48
[    0.312782]   init_std_data+0x80/0xc0
[    0.312795]   rand_initialize+0x18/0xb0
[    0.312809]   do_one_initcall+0x44/0x178
[    0.312822]   kernel_init_freeable+0x158/0x2d8
[    0.312837]   kernel_init+0x10/0x11c
[    0.312850]   ret_from_fork+0x18/0x28
[    0.312860] irq event stamp: 1603
[    0.312880] hardirqs last  enabled at (1602): [<c01a2510>] tick_nohz_idl=
e_exit+0xd0/0x164
[    0.312896] hardirqs last disabled at (1603): [<c09ca9b0>] __schedule+0x=
54/0x61c
[    0.312915] softirqs last  enabled at (1597): [<c012b5ec>] _local_bh_ena=
ble+0x2c/0x60
[    0.312929] softirqs last disabled at (1596): [<c012c018>] irq_enter+0x5=
c/0x8c
[    0.312939]=20
[    0.312939] other info that might help us debug this:
[    0.312949]  Possible unsafe locking scenario:
[    0.312949]=20
[    0.312960]        CPU0
[    0.312968]        ----
[    0.312975]   lock(std_spinlock_raw(&rq->lock));
[    0.312993]   <Interrupt>
[    0.313000]     lock(std_spinlock_raw(&rq->lock));
[    0.313017]=20
[    0.313017]  *** DEADLOCK ***
[    0.313017]=20
[    0.313031] 1 lock held by swapper/1/0:
[    0.313039]  #0:  (std_spinlock_raw(&rq->lock)){?.-...}, at: [<c09ca9c8>=
] __schedule+0x6c/0x61c
[    0.313072]=20
[    0.313072] stack backtrace:
[    0.313089] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.9.35-ipipe-00014=
-g0d0457a-dirty #700
[    0.313100] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    0.313110] I-pipe domain: Linux
[    0.313119] Backtrace:=20
[    0.313143] [<c010c408>] (dump_backtrace) from [<c010c684>] (show_stack+=
0x18/0x1c)
[    0.313159]  r7:00000000 r6:00000080 r5:00000000 r4:c0f33cc4
[    0.313178] [<c010c66c>] (show_stack) from [<c0431fd0>] (dump_stack+0xb0=
/0xe0)
[    0.313195] [<c0431f20>] (dump_stack) from [<c016ec9c>] (print_usage_bug=
+0x1ec/0x2e0)
[    0.313210]  r9:c0c0bd18 r8:c17d77a0 r7:00000002 r6:00000000 r5:c10ac764=
 r4:ef0a8000
[    0.313226] [<c016eab0>] (print_usage_bug) from [<c016ef8c>] (mark_lock+=
0x1fc/0x6f0)
[    0.313242]  r9:ef0a4000 r8:00000002 r7:c016e224 r6:ef0a8000 r5:00000002=
 r4:ef0a84a8
[    0.313257] [<c016ed90>] (mark_lock) from [<c016f4f4>] (mark_held_locks+=
0x74/0x9c)
[    0.313272]  r10:c0a02c48 r9:ef0a4000 r8:00000002 r7:ef0a8000 r6:0000000=
3 r5:00000000
[    0.313281]  r4:ef0a84a8
[    0.313298] [<c016f480>] (mark_held_locks) from [<c016f5c4>] (trace_hard=
irqs_on_caller+0xa8/0x240)
[    0.313313]  r9:ef0a4000 r8:ef6ab750 r7:ef0a5ef4 r6:00000001 r5:c010d300=
 r4:ef0a8000
[    0.313329] [<c016f51c>] (trace_hardirqs_on_caller) from [<c016f770>] (t=
race_hardirqs_on+0x14/0x18)
[    0.313343]  r7:ef0a5ef4 r6:ffffffff r5:60000013 r4:c0115afc
[    0.313360] [<c016f75c>] (trace_hardirqs_on) from [<c010d300>] (__ipipe_=
fast_svc_irq_exit+0x4/0x28)
[    0.313379] [<c016c828>] (lock_is_held) from [<c0168474>] (pick_next_tas=
k_stop+0x64/0x84)
[    0.313394]  r7:00006d64 r6:c0e7d740 r5:ef6ab740 r4:ef0abd40
[    0.313413] [<c0168410>] (pick_next_task_stop) from [<c09cac64>] (__sche=
dule+0x308/0x61c)
[    0.313425]  r5:ef0a8000 r4:ef6ab740
[    0.313440] [<c09ca95c>] (__schedule) from [<c09cafc4>] (schedule+0x4c/0=
xac)
[    0.313456]  r10:00000000 r9:00000000 r8:c0f0d9c0 r7:00000002 r6:c0f0d96=
c r5:00000000
[    0.313465]  r4:ef0a4000
[    0.313482] [<c09caf78>] (schedule) from [<c09cb348>] (schedule_preempt_=
disabled+0x10/0x14)
[    0.313493]  r5:00000000 r4:ef0a4000
[    0.313511] [<c09cb338>] (schedule_preempt_disabled) from [<c01696f4>] (=
cpu_startup_entry+0x140/0x248)
[    0.313528] [<c01695b4>] (cpu_startup_entry) from [<c010f92c>] (secondar=
y_start_kernel+0x148/0x174)
[    0.313539]  r7:c0f85320
[    0.313555] [<c010f7e4>] (secondary_start_kernel) from [<1010192c>] (0x1=
010192c)
[    0.313566]  r5:00000051 r4:3f08806a
[    0.313649] clocksource: Switched to clocksource ipipe_tsc
[    0.313881] VFS: Disk quotas dquot_6.6.0
[    0.313996] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.336470] NET: Registered protocol family 2
[    0.337488] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.337623] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
...

