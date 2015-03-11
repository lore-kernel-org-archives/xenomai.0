Message-ID: <55005580.6050702@siemens.com>
Date: Wed, 11 Mar 2015 15:47:28 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai 3: smokey test sched_tp causes oops when run in
	gdb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

Hi Philippe,

just happened to trigger the oops below by running

gdb --args smokey --run=8

That run already has troubles and generates different output than
running the test without gdb surveillance, probably due to unexpected
mode switches. But the real problem is that running the test again
afterwards, with or without gdb, causes the oops. Registers contain
suspicious "dead" patterns, thus we access invalid list elements. Do we
miss a cleanup when terminating smokey in the gdb session?

Jan

---

[  307.474060] [Xenomai] switching main to secondary mode after exception #13 in kernel-space at 0xffffffff8114aeb4 (pid 983)
[  307.478710] general protection fault: 0000 [#2] SMP DEBUG_PAGEALLOC
[  307.480013] Modules linked in: xt_limit 9p fscache ip6t_REJECT xt_tcpudp nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_raw ipt_REJECT iptable_raw xt_CT iptable_filter ip6table_mangle nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_ipv4 nf_defrag_ipv4 ip_tables xt_conntrack nf_conntrack ip6table_filter ip6_tables x_tables microcode rt_e1000 psmouse 9pnet_virtio serio_raw 9pnet pcspkr i2c_i801 intel_agp rtnet intel_gtt virtio_pci virtio_ring virtio ahci libahci e1000 floppy
[  307.480013] CPU: 0 PID: 983 Comm: main Tainted: G      D      3.14.28+ #228
[  307.480013] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.8.0-0-g4c59f5d-20150219_092859-nilsson.home.kraxel.org 04/01/2014
[  307.480013] task: ffff88003fa54a80 ti: ffff88003b064000 task.ti: ffff88003b064000
[  307.480013] RIP: 0010:[<ffffffff8114aeb4>]  [<ffffffff8114aeb4>] xnsched_tp_forget+0x14/0x50
[  307.480013] RSP: 0018:ffff88003b067dd0  EFLAGS: 00010246
[  307.480013] RAX: dead000000200200 RBX: ffff88003ad07040 RCX: ffffffff818f59f8
[  307.480013] RDX: dead000000100100 RSI: ffffffff81a1a5a0 RDI: ffff88003ad07040
[  307.480013] RBP: ffff88003b067df8 R08: 000000000000011b R09: ffffffff816ef2e1
[  307.480013] R10: 000000000000004b R11: ffff88003b067e98 R12: ffffffff81a1a5a0
[  307.480013] R13: ffff88003b067e08 R14: ffff88003ad08100 R15: ffff88003ad08100
[  307.480013] FS:  00007fda1a1c3740(0000) GS:ffff88003d400000(0000) knlGS:0000000000000000
[  307.480013] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  307.480013] CR2: 0000000002358ff8 CR3: 000000003b729000 CR4: 00000000000006f0
[  307.480013] I-pipe domain Linux
[  307.480013] Stack:
[  307.480013]  ffff88003b067df8 ffffffff81137ace dead0000000ffb58 ffff88003d6a7cc8
[  307.480013]  ffff88003d6a08c0 ffff88003b067e48 ffffffff8114b20f ffff880000000032
[  307.480013]  ffff88003ad08100 000000c3712f020f 000000000000000b 000000000000000b
[  307.480013] Call Trace:
[  307.480013]  [<ffffffff81137ace>] ? xnsched_set_policy+0x8e/0x170
[  307.480013]  [<ffffffff8114b20f>] xnsched_tp_set_schedule+0x7f/0x100
[  307.480013]  [<ffffffff8117787f>] __cobalt_sched_setconfig_np+0x2ff/0x1020
[  307.480013]  [<ffffffff81177030>] ? hard_local_irq_disable+0x30/0x30
[  307.480013]  [<ffffffff811785a0>] ? __cobalt_sched_setconfig_np+0x1020/0x1020
[  307.480013]  [<ffffffff811785bc>] cobalt_sched_setconfig_np+0x1c/0x20
[  307.480013]  [<ffffffff8117f82a>] ipipe_syscall_hook+0x16a/0x320
[  307.480013]  [<ffffffff810f77b7>] __ipipe_notify_syscall+0x97/0x3e0
[  307.480013]  [<ffffffff816d0372>] pipeline_syscall+0xa/0x17
[  307.480013] Code: 89 97 b0 05 00 00 48 89 0a 5d c3 0f 1f 40 00 b8 ea ff ff ff 5d c3 90 e8 db 51 58 00 48 8b 87 b0 05 00 00 48 8b 97 a8 05 00 00 55 <48> 89 42 08 48 89 10 48 b8 00 01 10 00 00 00 ad de 48 89 87 a8 
[  307.480013] RIP  [<ffffffff8114aeb4>] xnsched_tp_forget+0x14/0x50
[  307.480013]  RSP <ffff88003b067dd0>
[  307.541656] ---[ end trace bfb88524a477f00e ]---

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

