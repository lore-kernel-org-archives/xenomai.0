From: "Steven Seeger" <sseeger@mpl.com>
Date: Thu, 29 Nov 2012 09:18:11 -0500
Message-ID: <01f101cdce3c$5dd719f0$19854dd0$@mpl.com>
MIME-Version: 1.0
Content-Language: en-us
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] xenomai in vmware smp crash
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gentlemen,

 

Hello! It's been many years since I've been on the list. I still dabble in
Xenomai when jobs come up. I wish I had more need to use it so I can
contribute. I've missed my "friendly" back and forth emails with Gilles on
geopolitical issues. 

 

I was asked by a client to patch an Ubuntu 64-bit VM in VMWARE with xenomai
to use as a development platform. It obviously is not going to be realtime
and nobody is concerned about that. I built a kernel with SMP mode but have
just one core for my VM, and everything works fine. However, if I give my VM
more than one processor or core, I get a kernel panic after about 6-8
seconds after bootup when the login GUI appears.

 

I set up the kernel to use a serial console and captured the panic:

 

[   17.062448] ------------[ cut here ]------------

[   17.065610] kernel BUG at arch/x86/kernel/ipipe.c:592!

[   17.069109] invalid opcode: 0000 [#1] SMP 

[   17.070161] CPU 0 

[   17.070575] Modules linked in: bnep rfcomm bluetooth parport_pc ppdev
snd_ens1371 gameport snd_ac97_codec ac97_bus snd_pcm snd_seq_midi
snd_rawmidi snd_seq_midi_event snd_seq joydev snd_timer snd_seq_device
mac_hid snd vmw_balloon psmouse soundcore snd_page_alloc serio_raw i2c_piix4
vmwgfx ttm drm shpchp lp parport usbhid hid e1000 mptspi mptscsih mptbase
vmw_pvscsi vmxnet3

[   17.079691] 

[   17.080167] Pid: 0, comm: swapper/0 Not tainted 3.2.31xenomai #2 VMware,
Inc. VMware Virtual Platform/440BX Desktop Reference Platform

[   17.083084] RIP: 0010:[<ffffffff8101de4e>]  [<ffffffff8101de4e>]
__ipipe_handle_irq+0x1be/0x1c0

[   17.085104] RSP: 0018:ffffffff81a03e20  EFLAGS: 00010286

[   17.086262] RAX: 000000000000da80 RBX: 00000000ffffffff RCX:
00000000ffffffff

[   17.088014] RDX: ffffffffffffffdf RSI: ffffffff81a03e58 RDI:
ffffffff81a03e38

[   17.089693] RBP: ffffffff81a03e40 R08: 0000000000000000 R09:
0000000000000000

[   17.091284] R10: 0000000000000000 R11: 0000000000000000 R12:
000000000000da80

[   17.092850] R13: ffffffff81a03e38 R14: ffff88003be00000 R15:
0000000000000000

[   17.094562] FS:  0000000000000000(0000) GS:ffff88003be00000(0000)
knlGS:0000000000000000

[   17.096556] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b

[   17.098080] CR2: 00007f7f2e678eb0 CR3: 0000000038df4000 CR4:
00000000000006f0

[   17.099696] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000

[   17.101322] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400

[   17.103029] Process swapper/0 (pid: 0, threadinfo ffffffff81a00000, task
ffffffff81a0f020)

[   17.104932] Stack:

[   17.105400]  ffffffff81a03fd8 ffffffff81ad3920 0000000000000000
ffffffffffffffff

[   17.107190]  ffffffff81a03ee8 ffffffff815c6d5d ffffffff81a03e58
ffffffff81a03ee8

[   17.109004]  ffffffff810605ad 0000000000000000 0000000000000000
0000000000000000

[   17.111037] Call Trace:

[   17.112251]  [<ffffffff815c6d5d>] irq_move_cleanup_interrupt+0x5d/0x90

[   17.114259]  [<ffffffff810605ad>] ? get_next_timer_interrupt+0x1cd/0x260

[   17.115958]  [<ffffffff8101d47a>] ? __ipipe_halt_root+0x2a/0x40

[   17.117321]  [<ffffffff8100a5e3>] default_idle+0x53/0x1d0

[   17.118611]  [<ffffffff81001236>] cpu_idle+0xe6/0x130

[   17.119752]  [<ffffffff81596afe>] rest_init+0x72/0x74

[   17.120933]  [<ffffffff81b32bdb>] start_kernel+0x3e9/0x3f6

[   17.122203]  [<ffffffff81b32322>] x86_64_start_reservations+0x132/0x136

[   17.123723]  [<ffffffff81b3245b>] x86_64_start_kernel+0x135/0x13c

[   17.125223] Code: 0f 1f 44 00 00 48 83 a0 70 07 00 00 fe 4c 89 ee bf 20
00 00 00 e8 13 c8 0a 00 e9 f3 fe ff ff 89 d3 be 01 00 00 00 e9 a6 fe ff ff
<0f> 0b 55 48 89 e5 53 48 81 ec b8 00 00 00 66 66 66 66 90 9c 5b 

[   17.131844] RIP  [<ffffffff8101de4e>] __ipipe_handle_irq+0x1be/0x1c0

[   17.133398]  RSP <ffffffff81a03e20>

[   17.134295] ---[ end trace bc97edd2d31fbe38 ]---

[   17.135365] Kernel panic - not syncing: Attempted to kill the idle task!

[   17.136838] Pid: 0, comm: swapper/0 Tainted: G      D      3.2.31xenomai
#2

[   17.138503] Call Trace:

[   17.139159]  [<ffffffff815b44fb>] panic+0x91/0x1a2

[   17.140313]  [<ffffffff8101d542>] ? __ipipe_do_IRQ+0x82/0xa0

[   17.141809]  [<ffffffff81053904>] do_exit+0x784/0x870

[   17.143129]  [<ffffffff815be39b>] ? _raw_spin_unlock_irqrestore+0x1b/0x30

[   17.144692]  [<ffffffff8105106c>] ? kmsg_dump+0x5c/0xf0

[   17.145944]  [<ffffffff815bf37f>] oops_end+0xaf/0xf0

[   17.147049]  [<ffffffff810057d8>] die+0x58/0x90

[   17.148112]  [<ffffffff815becb4>] do_trap+0xc4/0x170

[   17.149317]  [<ffffffff81002db5>] do_invalid_op+0x95/0xb0

[   17.150516]  [<ffffffff8101de4e>] ? __ipipe_handle_irq+0x1be/0x1c0

[   17.151979]  [<ffffffff81056d7c>] ? irq_exit+0x7c/0xb0

[   17.153308]  [<ffffffff815c944c>] ? do_IRQ+0x6c/0xf0

[   17.154408]  [<ffffffff8101d84f>] __ipipe_handle_exception+0x11f/0x2a0

[   17.155941]  [<ffffffff815c88ac>] invalid_op+0x1c/0x60

[   17.157201]  [<ffffffff8101de4e>] ? __ipipe_handle_irq+0x1be/0x1c0

[   17.158767]  [<ffffffff815c6d5d>] irq_move_cleanup_interrupt+0x5d/0x90

[   17.160266]  [<ffffffff810605ad>] ? get_next_timer_interrupt+0x1cd/0x260

[   17.161858]  [<ffffffff8101d47a>] ? __ipipe_halt_root+0x2a/0x40

[   17.163250]  [<ffffffff8100a5e3>] default_idle+0x53/0x1d0

[   17.164528]  [<ffffffff81001236>] cpu_idle+0xe6/0x130

[   17.165702]  [<ffffffff81596afe>] rest_init+0x72/0x74

[   17.166859]  [<ffffffff81b32bdb>] start_kernel+0x3e9/0x3f6

[   17.168309]  [<ffffffff81b32322>] x86_64_start_reservations+0x132/0x136

[   17.169907]  [<ffffffff81b3245b>] x86_64_start_kernel+0x135/0x13c

 

I figured I would post here and see if anyone has noticed this issue before.

 

I'm glad to see the project still going strong! If I am lucky I will find a
way to use it for my doctoral research. J

 

Thanks,

Steven

 

