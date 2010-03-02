Message-ID: <4B8D566C.3030707@domain.hid>
Date: Tue, 02 Mar 2010 19:18:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] sigtest oops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

FYI - it might be due to other issues on my test box:

# sigtest
sigtest_queue(one_restart, ARRAY_SIZE(one_restart)): success.
sigtest_wait_pri() failed: 1
seen == 1 failed
sigtest_queue(one_restart, ARRAY_SIZE(one_restart)): success.
sigtest_wait_sec() failed: 1
seen == 1 failed
sigtest_queue(one_intr, ARRAY_SIZE(one_intr)): success.
sigtest_wait_pri() failed: 1
[  433.115386] BUG: unable to handle kernel NULL pointer dereference at 0000000000000401
[  433.116747] IP: [<ffffffff810dec89>] xnshadow_mark_sig+0x23/0x28d
[  433.116747] PGD cd5b067 PUD cd5c067 PMD 0
[  433.116747] Oops: 0000 [#1] SMP
[  433.116747] last sysfs file: /sys/class/net/lo/type
[  433.116747] CPU 0
[  433.116747] Modules linked in: xeno_sigtest ip6t_LOG ipt_LOG xt_tcpudp xt_limit xt_pkttype af_packet ip6t_REJECT nf_conntrack_ipv6 ip6table_raw ipt_REJECT xt_state iptable_raw iptable_filter ip6table_mangle nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 ip_tables ip6table_filter ip6_tables x_tables ipv6 fuse dm_crypt loop dm_mod md_mod rtc_cmos rtc_core sr_mod psmouse rtc_lib 8139cp button cdrom serio_raw pcspkr sg mii i2c_piix4 evdev sd_mod virtio_pci virtio_ring virtio_blk virtio ext3 mbcache jbd fan thermal_sys ide_pci_generic piix ata_generic ata_piix libata scsi_mod
[  433.116747] Pid: 5530, comm: sigtest Not tainted 2.6.32.8-xeno_64 #30 Bochs
[  433.116747] RIP: 0010:[<ffffffff810dec89>]  [<ffffffff810dec89>] xnshadow_mark_sig+0x23/0x28d
[  433.116747] RSP: 0018:ffff880003403e38  EFLAGS: 00010096
[  433.116747] RAX: ffffffff824c2308 RBX: ffffffffa00ef990 RCX: ffffffff824b72c0
[  433.116747] RDX: ffffffff824c22e8 RSI: 0000000000000004 RDI: 0000000000000000
[  433.116747] RBP: ffff880003403e78 R08: 000000ac49b01634 R09: 0000000000000003
[  433.116747] R10: 000000000002a560 R11: 000000000000e780 R12: ffffffff824b72c0
[  433.116747] R13: 0000000000000000 R14: 0000000000000004 R15: ffffffff82438d48
[  433.116747] FS:  00007f058a6826f0(0000) GS:ffff880003400000(0000) knlGS:0000000000000000
[  433.116747] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  433.116747] CR2: 0000000000000401 CR3: 000000000d6ec000 CR4: 00000000000006b0
[  433.116747] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  433.116747] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  433.116747] Process sigtest (pid: 5530, threadinfo ffff88000d710000, task ffff88000d70ec40)
[  433.116747] Stack:
[  433.116747]  ffff880003403e48 ffffffff8109eaf3 0000000003403eb8 ffffffffa00ef990
[  433.116747] <0> ffffffff824b72c0 ffffffff824c2308 ffffffff824c22e8 ffffffff82438d48
[  433.116747] <0> ffff880003403e88 ffffffffa00ef50a ffff880003403eb8 ffffffff810d3d94
[  433.116747] Call Trace:
[  433.116747]  <IRQ>
[  433.116747]  [<ffffffff8109eaf3>] ? ipipe_trace_function+0x1c/0x1e
[  433.116747]  [<ffffffffa00ef50a>] sigtest_timer_handler+0x1b/0x27 [xeno_sigtest]
[  433.116747]  [<ffffffff810d3d94>] xntimer_tick_aperiodic+0x96/0x1af
[  433.116747]  [<ffffffff810c2caf>] xnintr_clock_handler+0x113/0x368
[  433.116747]  [<ffffffff8109eaf3>] ? ipipe_trace_function+0x1c/0x1e
[  433.116747]  [<ffffffff8109c68b>] __ipipe_dispatch_wired_nocheck+0x75/0xb9
[  433.116747]  [<ffffffff810228f7>] ? __ipipe_ack_apic+0x0/0x1f
[  433.116747]  [<ffffffff8109c73d>] __ipipe_dispatch_wired+0x6e/0x70
[  433.116747]  [<ffffffff81022ab1>] __ipipe_handle_irq+0x10c/0x2dd
[  433.116747]  [<ffffffff8100c767>] common_interrupt+0x27/0x5b
[  433.116747]  <EOI>
[  433.116747]  [<ffffffff812bb6cf>] ? io_serial_out+0x19/0x1b
[  433.116747]  [<ffffffff812bb6bf>] ? io_serial_out+0x9/0x1b
[  433.116747]  [<ffffffff812bc11c>] ? serial8250_start_tx+0x31/0xa3
[  433.116747]  [<ffffffff812b8b43>] ? uart_start+0x67/0x7a
[  433.116747]  [<ffffffff812b9dbb>] ? uart_write+0xe6/0xf8
[  433.116747]  [<ffffffff8129e33b>] ? n_tty_write+0x264/0x390
[  433.116747]  [<ffffffff8103ddd5>] ? default_wake_function+0x0/0x14
[  433.116747]  [<ffffffff8129baae>] ? tty_write+0x199/0x236
[  433.116747]  [<ffffffff8129e0d7>] ? n_tty_write+0x0/0x390
[  433.116747]  [<ffffffff81182573>] ? vfs_write+0xb3/0x14f
[  433.116747]  [<ffffffff811826dd>] ? sys_write+0x4c/0x74
[  433.116747]  [<ffffffff8100bcaf>] ? system_call_fastpath+0x16/0x1b
[  433.116747] Code: 5a 00 ff ff ff ff eb b8 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 18 e8 14 cd f2 ff c7 45 d4 00 00 00 00 49 89 fd 41 89 f6 <f6> 87 01 04 00 00 01 0f 84 3c 02 00 00 9c 58 f6 c4 02 74 0b fa
[  433.116747] RIP  [<ffffffff810dec89>] xnshadow_mark_sig+0x23/0x28d
[  433.116747]  RSP <ffff880003403e38>
[  433.116747] CR2: 0000000000000401
[  433.116747] ---[ end trace c11eb86b23866ffa ]---


