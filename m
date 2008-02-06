Date: Wed, 06 Feb 2008 15:09:55 +0100
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200802061509.13010@domain.hid>
References: <200710081503.15198@domain.hid>
In-Reply-To: <200710081503.15198@domain.hid>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [Xenomai-help] FPU not available
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hello.
Recently, we switched to newer distribution of linux (Kubuntu 7.10). During this switch we changed many things (Xenomai 2.4.1, linux kernel 2.6.24, x86_64 architecture, ...).
No we have problem, that in one of our tasks we are sometimes not able to use floating point operations (under very specific circumstances) . In such case, that task crashes immediately, but rest of the application runs "normaly". Output from dmesg is attached to this message. Task was created with T_FPU flag.
Is there anything we can check or change?
Petr Cervenka


[ 1132.862102] ------------[ cut here ]------------
[ 1132.862110] kernel BUG at kernel/ipipe/core.c:321!
[ 1132.862112] invalid opcode: 0000 [2] PREEMPT SMP
[ 1132.862115] CPU 0
[ 1132.862117] Modules linked in: rt_r8169 rtpacket rtnet rfcomm l2cap bluetooth ppdev container ac sbs sbshc dock battery lp irtty_sir sir_dev psmouse irda serio_raw parport_pc parport crc_ccitt pcspkr k8temp shpchp pci_hotplug i2c_nforce2 button i2c_core af_packet ipv6 evdev ext3 jbd mbcache sg sd_mod sata_nv forcedeth ata_generic ehci_hcd ohci_hcd libata amd74xx ide_core scsi_mod usbcore fan fuse
[ 1132.862148] Pid: 5802, comm: REG_TASK_2056 Tainted: G      D 2.6.24-adeos #2
[ 1132.862150] RIP: 0010:[<ffffffff80277adc>]  [<ffffffff80277adc>] __ipipe_restore_root+0x3c/0x50
[ 1132.862159] RSP: 0000:ffff81003b74ff00  EFLAGS: 00010002
[ 1132.862161] RAX: ffffffff80674aa0 RBX: ffffffff80674aa0 RCX: ffff81008099b000
[ 1132.862163] RDX: ffff81008099b000 RSI: 0000000000418ed6 RDI: 0000000000000000
[ 1132.862165] RBP: 00000000400903e0 R08: 0000000080400140 R09: 00000000007e883f
[ 1132.862168] R10: 0000000000000000 R11: 0000000000000206 R12: ffff81003b74ff58
[ 1132.862170] R13: 0000000000000007 R14: ffffffff8066f7c0 R15: 0000000000000001
[ 1132.862172] FS:  0000000040091950(0063) GS:ffffffff805ee000(0000) knlGS:0000000000000000
[ 1132.862174] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1132.862176] CR2: 00002aaab0bbe028 CR3: 000000003b7c6000 CR4: 00000000000006e0
[ 1132.862178] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1132.862180] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1132.862183] Process REG_TASK_2056 (pid: 5802, threadinfo ffff81003b74e000, task ffff81003be78790)
[ 1132.862184] Stack:  ffffffff8022728b 0000000000000296 0000000000000000 0000000000000000
[ 1132.862189]  0000000000000000 00000000400903e0 00000000007f2bb8 0000000040090380
[ 1132.862193]  00000000007f2a50 0000000000000001 ffffffff8049c103 0000000000000001
[ 1132.862197] Call Trace:
[ 1132.862203]  [<ffffffff8022728b>] __ipipe_handle_exception+0x16b/0x210
[ 1132.862210]  [<ffffffff8049c103>] error_sti+0x1e/0x52
[ 1132.862218]
[ 1132.862219]
[ 1132.862219] Code: 0f 0b 66 90 eb fc 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
[ 1132.862229] RIP  [<ffffffff80277adc>] __ipipe_restore_root+0x3c/0x50
[ 1132.862233]  RSP <ffff81003b74ff00>
[ 1132.862238] ---[ end trace a3cc53b342d61517 ]---


