MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 11 Jul 2019 00:29:03 +0200
Message-ID: <CAFLxGvzoCXUq_QFMT=b54nnLd8Oeu3XfFeiCKoCj3a0Q3Xg8yA@mail.gmail.com>
Subject: Enable/Disable of ftrace events crashes kernel
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi!

I can reliable kill Linux on qemu by writing a few times 1 and 0 to
/sys/kernel/debug/tracing/events/cobalt_core/enable

Didn't test on real hardware so far.
The following splat happened on ipipe-core-4.19.57-x86-3 plus
xenomai-git as of today.

[   33.664656] Kernel panic - not syncing: Machine halted.
[   33.665323] CPU: 2 PID: 2088 Comm: bash Not tainted 4.19.57 #1
[   33.666142] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.11.0-0-g63451fc-prebuilt.qemu-project.org 04/01/2014
[   33.667524] I-pipe domain: Linux
[   33.667895] Call Trace:
[   33.668354]  <#DF>
[   33.668695]  dump_stack+0x8e/0xb3
[   33.669104]  panic+0xdd/0x238
[   33.669456]  df_debug+0x24/0x30
[   33.669834]  do_double_fault+0x95/0x120
[   33.670323]  double_fault+0x3f/0x60
[   33.670794] RIP: 0010:xnintr_core_clock_handler+0xad/0x370
[   33.671426] Code: c0 48 09 c2 49 89 96 80 1a 00 00 49 8d ae 88 1a
00 00 48 8d 59 08 48 87 5d 00 48 c7 c0 d0 e3 02 00 48 83 01 01 cc 1f
44 00 00 <41> 8b 86 10 03 00 00 49 81 4e 08 00 40 00 00 83 c0 01 41 89
86 10
[   33.673615] RSP: 0018:ffff964ebbb03f58 EFLAGS: 00010002
[   33.674235] RAX: 000000000002e3d0 RBX: ffff964ebbb315c0 RCX: ffff964ebbb3bb00
[   33.675079] RDX: 00000013d41dbbce RSI: fffffffffc25fc34 RDI: ffff964ebbb315c0
[   33.675923] RBP: ffff964ebbb31748 R08: ffff964ebb000249 R09: 000000000002e320
[   33.676761] R10: 0000000000000040 R11: 0000000000000000 R12: 0000000000000002
[   33.677600] R13: 000000000002fcc0 R14: ffff964ebbb2fcc0 R15: ffff964ebbb2fcc0
[   33.678444]  </#DF>
[   33.678704]  <IRQ>
[   33.678955]  dispatch_irq_head+0x84/0x110
[   33.679437]  __ipipe_handle_irq+0x7c/0x1d0
[   33.679927]  apic_timer_interrupt+0x12/0x40
[   33.680448]  </IRQ>
[   33.680805] RIP: 0010:smp_call_function_many+0x1e0/0x250
[   33.681505] Code: 5f 97 00 3b 05 d5 70 47 01 0f 83 99 fe ff ff 48
63 c8 48 8b 13 48 03 14 cd 00 b7 c9 ac 8b 4a 18 83 e1 01 74 0a f3 90
8b 4a 18 <83> e1 01 75 f6 eb c8 48 c7 c2 20 b9 f5 ac 48 89 ee 89 df e8
b8 5f
[   33.684312] RSP: 0018:ffffa2478079bc00 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[   33.685347] RAX: 0000000000000001 RBX: ffff964ebbb35a00 RCX: 0000000000000003
[   33.686198] RDX: ffff964ebbab9c80 RSI: 0000000000000000 RDI: ffff964ebbb35a08
[   33.687044] RBP: ffff964ebbb35a08 R08: 000000000000000b R09: ffffffffaba22300
[   33.687883] R10: ffffa2478079bc20 R11: f000000000000000 R12: ffffffffaba22200
[   33.688725] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000040
[   33.689577]  ? optimize_nops+0xe0/0xe0
[   33.690055]  ? alternatives_text_reserved+0x60/0x60
[   33.690643]  ? optimize_nops+0xe0/0xe0
[   33.691092]  ? xnintr_core_clock_handler+0xa9/0x370
[   33.691657]  ? trace_event_raw_event_irq_event+0xa0/0xa0
[   33.692489]  on_each_cpu+0x23/0x50
[   33.692902]  ? xnintr_core_clock_handler+0xa8/0x370
[   33.693464]  text_poke_bp+0x63/0xe0
[   33.693875]  __jump_label_transform.isra.0+0x12f/0x140
[   33.694466]  arch_jump_label_transform+0x26/0x40
[   33.695093]  __jump_label_update+0x78/0xb0
[   33.695567]  static_key_slow_inc_cpuslocked+0x83/0x90
[   33.696147]  static_key_slow_inc+0x11/0x20
[   33.696622]  tracepoint_probe_register_prio+0x214/0x290
[   33.697241]  __ftrace_event_enable_disable+0x96/0x260
[   33.697905]  __ftrace_set_clr_event_nolock+0xe8/0x130
[   33.698488]  system_enable_write+0xb3/0xf0
[   33.698537] BUG: Unhandled exception over domain Xenomai at
0xffffffffabb5413d - switching to ROOT
[   33.699032]  __vfs_write+0x31/0x180
[   33.700443]  ? selinux_file_permission+0x118/0x130
[   33.700979]  ? security_file_permission+0x27/0xb0
[   33.701491]  vfs_write+0xa8/0x190
[   33.701856]  ksys_write+0x55/0xd0
[   33.702220]  do_syscall_64+0x64/0x160
[   33.702644]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   33.703210] RIP: 0033:0x7fcc38f5bd04
[   33.703603] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
1f 80 00 00 00 00 8b 05 2a fb 2c 00 48 63 ff 85 c0 75 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 55 53 48 89 d5 48 89 f3
48 83
[   33.705712] RSP: 002b:00007ffd5b051008 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   33.706673] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcc38f5bd04
[   33.707552] RDX: 0000000000000002 RSI: 0000564c21421700 RDI: 0000000000000001
[   33.708399] RBP: 0000564c21421700 R08: 000000000000000a R09: 0000000000000000
[   33.709264] R10: 000000000000000a R11: 0000000000000246 R12: 0000000000000002
[   33.710197] R13: 0000000000000001 R14: 00007fcc39227720 R15: 0000000000000002
[   33.711080] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.19.57 #1
[   33.711974] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.11.0-0-g63451fc-prebuilt.qemu-project.org 04/01/2014
[   33.715226] I-pipe domain: Linux
[   33.715730] Call Trace:
[   33.716176]  <#DF>
[   33.716529]  dump_stack+0x8e/0xb3
[   33.717053]  __ipipe_trap_prologue+0x1cd/0x220
[   33.717578]  double_fault+0x24/0x60
[   33.717993] RIP: 0010:xnintr_core_clock_handler+0xad/0x370
[   33.718672] Code: c0 48 09 c2 49 89 96 80 1a 00 00 49 8d ae 88 1a
00 00 48 8d 59 08 48 87 5d 00 48 c7 c0 d0 e3 02 00 48 83 01 01 cc 1f
44 00 00 <41> 8b 86 10 03 00 00 49 81 4e 08 00 40 00 00 83 c0 01 41 89
86 10
[   33.720893] RSP: 0018:ffff964ebbb83f58 EFLAGS: 00010006 ORIG_RAX:
0000000000000000
[   33.721775] RAX: 000000000002e3d0 RBX: ffff964ebbbb15c0 RCX: ffff964ebbbbbb00
[   33.722624] RDX: 00000013d92e08de RSI: fffffffffcb1388a RDI: ffff964ebbbb15c0
[   33.723469] RBP: ffff964ebbbb1748 R08: ffff964ebb000249 R09: 000000000002e320
[   33.724416] R10: 0000000000000040 R11: 0000000000000000 R12: 0000000000000003
[   33.725417] R13: 000000000002fcc0 R14: ffff964ebbbafcc0 R15: ffff964ebbbafcc0
[   33.726380]  </#DF>
[   33.726711]  <IRQ>
[   33.727000]  ? recalibrate_cpu_khz+0x10/0x10
[   33.727596]  dispatch_irq_head+0x84/0x110
[   33.728151]  __ipipe_handle_irq+0x7c/0x1d0
[   33.728759]  apic_timer_interrupt+0x12/0x40
[   33.729367]  </IRQ>
[   33.729665] RIP: 0010:__ipipe_halt_root+0x25/0x40
[   33.730316] Code: 0b eb 87 66 90 fa 48 c7 c0 00 c2 01 00 65 48 8b
15 08 15 5d 54 48 01 d0 48 0f ba 30 00 48 83 78 08 00 75 10 85 ff 75
03 fb f4 <c3> 31 c0 89 c1 fb 0f 01 c9 c3 e8 cc 2b 0d 00 fb c3 66 2e 0f
1f 84
[   33.732943] RSP: 0018:ffffa247806a3ea8 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[   33.734181] RAX: ffff964ebbb9c200 RBX: 0000000000000003 RCX: ffff964ebbb80000
[   33.735184] RDX: ffff964ebbb80000 RSI: 0000000000000000 RDI: 0000000000000000
[   33.736179] RBP: 0000000000000003 R08: ffff964ebbb80000 R09: 00000007d3facb6a
[   33.737155] R10: ffffa247806a3e88 R11: 0000000000080c00 R12: 0000000000000000
[   33.738117] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   33.739367]  default_idle+0x19/0x140
[   33.739873]  do_idle+0x1cb/0x270
[   33.740336]  cpu_startup_entry+0x6a/0x70
[   33.740901]  start_secondary+0x178/0x1a0
[   33.741458]  secondary_startup_64+0xa4/0xb0
[   33.742056] PANIC: double fault, error_code: 0x0
[   33.742707] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.19.57 #1
[   33.743542] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.11.0-0-g63451fc-prebuilt.qemu-project.org 04/01/2014
[   33.745162] I-pipe domain: Linux
[   33.745641] RIP: 0010:xnintr_core_clock_handler+0xad/0x370
[   33.746399] Code: c0 48 09 c2 49 89 96 80 1a 00 00 49 8d ae 88 1a
00 00 48 8d 59 08 48 87 5d 00 48 c7 c0 d0 e3 02 00 48 83 01 01 cc 1f
44 00 00 <41> 8b 86 10 03 00 00 49 81 4e 08 00 40 00 00 83 c0 01 41 89
86 10
[   33.749092] RSP: 0018:ffff964ebbb83f58 EFLAGS: 00010006
[   33.749807] RAX: 000000000002e3d0 RBX: ffff964ebbbb15c0 RCX: ffff964ebbbbbb00
[   33.750803] RDX: 00000013d92e08de RSI: fffffffffcb1388a RDI: ffff964ebbbb15c0
[   33.751905] RBP: ffff964ebbbb1748 R08: ffff964ebb000249 R09: 000000000002e320
[   33.752866] R10: 0000000000000040 R11: 0000000000000000 R12: 0000000000000003
[   33.753877] R13: 000000000002fcc0 R14: ffff964ebbbafcc0 R15: ffff964ebbbafcc0
[   33.754879] FS:  0000000000000000(0000) GS:ffff964ebbb80000(0000)
knlGS:0000000000000000
[   33.756016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.756804] CR2: ffff964ebbb83f48 CR3: 0000000136c40000 CR4: 00000000000006e0
[   33.757820] Call Trace:
[   33.758221]  <IRQ>
[   33.758618]  ? recalibrate_cpu_khz+0x10/0x10
[   33.759508]  dispatch_irq_head+0x84/0x110
[   33.760545]  __ipipe_handle_irq+0x7c/0x1d0
[   33.761197]  apic_timer_interrupt+0x12/0x40
[   33.761710]  </IRQ>
[   33.761968] RIP: 0010:__ipipe_halt_root+0x25/0x40
[   33.762522] Code: 0b eb 87 66 90 fa 48 c7 c0 00 c2 01 00 65 48 8b
15 08 15 5d 54 48 01 d0 48 0f ba 30 00 48 83 78 08 00 75 10 85 ff 75
03 fb f4 <c3> 31 c0 89 c1 fb 0f 01 c9 c3 e8 cc 2b 0d 00 fb c3 66 2e 0f
1f 84
[   33.764794] RSP: 0018:ffffa247806a3ea8 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[   33.765739] RAX: ffff964ebbb9c200 RBX: 0000000000000003 RCX: ffff964ebbb80000
[   33.766568] RDX: ffff964ebbb80000 RSI: 0000000000000000 RDI: 0000000000000000
[   33.767437] RBP: 0000000000000003 R08: ffff964ebbb80000 R09: 00000007d3facb6a
[   33.768308] R10: ffffa247806a3e88 R11: 0000000000080c00 R12: 0000000000000000
[   33.769143] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   33.769975]  default_idle+0x19/0x140
[   33.770431]  do_idle+0x1cb/0x270
[   33.770853]  cpu_startup_entry+0x6a/0x70
[   33.771317]  start_secondary+0x178/0x1a0
[   33.771781]  secondary_startup_64+0xa4/0xb0
[   34.804315] Shutting down cpus with NMI
[   34.804938] Kernel Offset: 0x2aa00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   34.806481] ---[ end Kernel panic - not syncing: Machine halted. ]---
[   34.807305] BUG: Unhandled exception over domain Xenomai at
0xffffffffabb5413d - switching to ROOT
[   34.808369] CPU: 2 PID: 2088 Comm: bash Not tainted 4.19.57 #1
[   34.809093] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.11.0-0-g63451fc-prebuilt.qemu-project.org 04/01/2014
[   34.810495] I-pipe domain: Linux
[   34.810921] Call Trace:
[   34.811275]  <#DF>
[   34.811599]  dump_stack+0x8e/0xb3
[   34.811995]  __ipipe_trap_prologue+0x1cd/0x220
[   34.812521]  double_fault+0x24/0x60
[   34.812936] RIP: 0010:xnintr_core_clock_handler+0xad/0x370
[   34.813582] Code: c0 48 09 c2 49 89 96 80 1a 00 00 49 8d ae 88 1a
00 00 48 8d 59 08 48 87 5d 00 48 c7 c0 d0 e3 02 00 48 83 01 01 cc 1f
44 00 00 <41> 8b 86 10 03 00 00 49 81 4e 08 00 40 00 00 83 c0 01 41 89
86 10
[   34.815788] RSP: 0018:ffff964ebbb03f58 EFLAGS: 00010002 ORIG_RAX:
0000000000000000
[   34.816672] RAX: 000000000002e3d0 RBX: ffff964ebbb315c0 RCX: ffff964ebbb3bb00
[   34.817507] RDX: 00000013d41dbbce RSI: fffffffffc25fc34 RDI: ffff964ebbb315c0
[   34.818342] RBP: ffff964ebbb31748 R08: ffff964ebb000249 R09: 000000000002e320
[   34.819212] R10: 0000000000000040 R11: 0000000000000000 R12: 0000000000000002
[   34.820081] R13: 000000000002fcc0 R14: ffff964ebbb2fcc0 R15: ffff964ebbb2fcc0
[   34.820979]  </#DF>
[   34.821235]  <IRQ>
[   34.821481]  dispatch_irq_head+0x84/0x110
[   34.821957]  __ipipe_handle_irq+0x7c/0x1d0
[   34.822442]  apic_timer_interrupt+0x12/0x40
[   34.822999]  </IRQ>
[   34.823256] RIP: 0010:smp_call_function_many+0x1e0/0x250
[   34.823881] Code: 5f 97 00 3b 05 d5 70 47 01 0f 83 99 fe ff ff 48
63 c8 48 8b 13 48 03 14 cd 00 b7 c9 ac 8b 4a 18 83 e1 01 74 0a f3 90
8b 4a 18 <83> e1 01 75 f6 eb c8 48 c7 c2 20 b9 f5 ac 48 89 ee 89 df e8
b8 5f
[   34.826148] RSP: 0018:ffffa2478079bc00 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[   34.827095] RAX: 0000000000000001 RBX: ffff964ebbb35a00 RCX: 0000000000000003
[   34.827927] RDX: ffff964ebbab9c80 RSI: 0000000000000000 RDI: ffff964ebbb35a08
[   34.828797] RBP: ffff964ebbb35a08 R08: 000000000000000b R09: ffffffffaba22300
[   34.829675] R10: ffffa2478079bc20 R11: f000000000000000 R12: ffffffffaba22200
[   34.830509] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000040
[   34.831381]  ? optimize_nops+0xe0/0xe0
[   34.831824]  ? alternatives_text_reserved+0x60/0x60
[   34.832398]  ? optimize_nops+0xe0/0xe0
[   34.832843]  ? xnintr_core_clock_handler+0xa9/0x370
[   34.833452]  ? trace_event_raw_event_irq_event+0xa0/0xa0
[   34.834075]  on_each_cpu+0x23/0x50
[   34.834522]  ? xnintr_core_clock_handler+0xa8/0x370
[   34.835141]  text_poke_bp+0x63/0xe0
[   34.835592]  __jump_label_transform.isra.0+0x12f/0x140
[   34.836196]  arch_jump_label_transform+0x26/0x40
[   34.836777]  __jump_label_update+0x78/0xb0
[   34.837261]  static_key_slow_inc_cpuslocked+0x83/0x90
[   34.837854]  static_key_slow_inc+0x11/0x20
[   34.838337]  tracepoint_probe_register_prio+0x214/0x290
[   34.838985]  __ftrace_event_enable_disable+0x96/0x260
[   34.839655]  __ftrace_set_clr_event_nolock+0xe8/0x130
[   34.840268]  system_enable_write+0xb3/0xf0
[   34.840785]  __vfs_write+0x31/0x180
[   34.841201]  ? selinux_file_permission+0x118/0x130
[   34.841764]  ? security_file_permission+0x27/0xb0
[   34.842317]  vfs_write+0xa8/0x190
[   34.842745]  ksys_write+0x55/0xd0
[   34.843139]  do_syscall_64+0x64/0x160
[   34.843573]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   34.844166] RIP: 0033:0x7fcc38f5bd04
[   34.844590] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
1f 80 00 00 00 00 8b 05 2a fb 2c 00 48 63 ff 85 c0 75 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 55 53 48 89 d5 48 89 f3
48 83
[   34.846820] RSP: 002b:00007ffd5b051008 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   34.847703] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcc38f5bd04
[   34.848551] RDX: 0000000000000002 RSI: 0000564c21421700 RDI: 0000000000000001
[   34.849398] RBP: 0000564c21421700 R08: 000000000000000a R09: 0000000000000000
[   34.850228] R10: 000000000000000a R11: 0000000000000246 R12: 0000000000000002
[   34.851095] R13: 0000000000000001 R14: 00007fcc39227720 R15: 0000000000000002
[   34.851975] PANIC: double fault, error_code: 0x0
[   34.852552] CPU: 2 PID: 2088 Comm: bash Not tainted 4.19.57 #1
[   34.853232] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.11.0-0-g63451fc-prebuilt.qemu-project.org 04/01/2014
[   34.854592] I-pipe domain: Linux
[   34.855042] RIP: 0010:xnintr_core_clock_handler+0xad/0x370
[   34.855683] Code: c0 48 09 c2 49 89 96 80 1a 00 00 49 8d ae 88 1a
00 00 48 8d 59 08 48 87 5d 00 48 c7 c0 d0 e3 02 00 48 83 01 01 cc 1f
44 00 00 <41> 8b 86 10 03 00 00 49 81 4e 08 00 40 00 00 83 c0 01 41 89
86 10
[   34.857848] RSP: 0018:ffff964ebbb03f58 EFLAGS: 00010002
[   34.858483] RAX: 000000000002e3d0 RBX: ffff964ebbb315c0 RCX: ffff964ebbb3bb00
[   34.859366] RDX: 00000013d41dbbce RSI: fffffffffc25fc34 RDI: ffff964ebbb315c0
[   34.860199] RBP: ffff964ebbb31748 R08: ffff964ebb000249 R09: 000000000002e320
[   34.861031] R10: 0000000000000040 R11: 0000000000000000 R12: 0000000000000002
[   34.861864] R13: 000000000002fcc0 R14: ffff964ebbb2fcc0 R15: ffff964ebbb2fcc0
[   34.862729] FS:  00007fcc39894b80(0000) GS:ffff964ebbb00000(0000)
knlGS:0000000000000000
[   34.863672] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.864344] CR2: ffff964ebbb03f48 CR3: 0000000135154000 CR4: 00000000000006e0
[   34.865207] Call Trace:
[   34.865524]  <IRQ>
[   34.865779]  dispatch_irq_head+0x84/0x110
[   34.866270]  __ipipe_handle_irq+0x7c/0x1d0
[   34.866787]  apic_timer_interrupt+0x12/0x40
[   34.867280]  </IRQ>
[   34.867535] RIP: 0010:smp_call_function_many+0x1e0/0x250
[   34.868190] Code: 5f 97 00 3b 05 d5 70 47 01 0f 83 99 fe ff ff 48
63 c8 48 8b 13 48 03 14 cd 00 b7 c9 ac 8b 4a 18 83 e1 01 74 0a f3 90
8b 4a 18 <83> e1 01 75 f6 eb c8 48 c7 c2 20 b9 f5 ac 48 89 ee 89 df e8
b8 5f
[   34.870392] RSP: 0018:ffffa2478079bc00 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[   34.871308] RAX: 0000000000000001 RBX: ffff964ebbb35a00 RCX: 0000000000000003
[   34.872139] RDX: ffff964ebbab9c80 RSI: 0000000000000000 RDI: ffff964ebbb35a08
[   34.873002] RBP: ffff964ebbb35a08 R08: 000000000000000b R09: ffffffffaba22300
[   34.873834] R10: ffffa2478079bc20 R11: f000000000000000 R12: ffffffffaba22200
[   34.874698] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000040
[   34.875560]  ? optimize_nops+0xe0/0xe0
[   34.876003]  ? alternatives_text_reserved+0x60/0x60
[   34.876577]  ? optimize_nops+0xe0/0xe0
[   34.877021]  ? xnintr_core_clock_handler+0xa9/0x370
[   34.877594]  ? trace_event_raw_event_irq_event+0xa0/0xa0
[   34.878252]  on_each_cpu+0x23/0x50
[   34.878691]  ? xnintr_core_clock_handler+0xa8/0x370
[   34.879265]  text_poke_bp+0x63/0xe0
[   34.879682]  __jump_label_transform.isra.0+0x12f/0x140
[   34.880285]  arch_jump_label_transform+0x26/0x40
[   34.880827]  __jump_label_update+0x78/0xb0
[   34.881311]  static_key_slow_inc_cpuslocked+0x83/0x90
[   34.881902]  static_key_slow_inc+0x11/0x20
[   34.882384]  tracepoint_probe_register_prio+0x214/0x290
[   34.883031]  __ftrace_event_enable_disable+0x96/0x260
[   34.883623]  __ftrace_set_clr_event_nolock+0xe8/0x130
[   34.884251]  system_enable_write+0xb3/0xf0
[   34.884770]  __vfs_write+0x31/0x180
[   34.885218]  ? selinux_file_permission+0x118/0x130
[   34.885781]  ? security_file_permission+0x27/0xb0
[   34.886333]  vfs_write+0xa8/0x190
[   34.886760]  ksys_write+0x55/0xd0
[   34.887155]  do_syscall_64+0x64/0x160
[   34.887589]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   34.888220] RIP: 0033:0x7fcc38f5bd04
[   34.888645] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
1f 80 00 00 00 00 8b 05 2a fb 2c 00 48 63 ff 85 c0 75 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 55 53 48 89 d5 48 89 f3
48 83
[   34.890845] RSP: 002b:00007ffd5b051008 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   34.891728] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcc38f5bd04
[   34.892560] RDX: 0000000000000002 RSI: 0000564c21421700 RDI: 0000000000000001
[   34.893393] RBP: 0000564c21421700 R08: 000000000000000a R09: 0000000000000000
[   34.894228] R10: 000000000000000a R11: 0000000000000246 R12: 0000000000000002
[   34.895337] R13: 0000000000000001 R14: 00007fcc39227720 R15: 0000000000000002

-- 
Thanks,
//richard

