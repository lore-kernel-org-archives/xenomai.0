Date: Sat, 20 Oct 2018 22:03:18 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
Message-ID: <1051803715.13351499.1540072998520@mail.yahoo.com>
MIME-Version: 1.0
References: <1051803715.13351499.1540072998520.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] 4.14 IPIPE kernel results - Interesting bug?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

$ testsuite/smokey/smokey --verbose=3D9 --trace=3D9
--=C2=A0 cold init from program
--=C2=A0 memcheck->tune()
--=C2=A0 cobalt->init()
--=C2=A0 connected to Cobalt
--=C2=A0 memory locked
--=C2=A0 memory heaps mapped
--=C2=A0 boilerplate->init()
--=C2=A0 copperplate->init()
--=C2=A0 smokey->init()
--=C2=A0 program bootstrap done
No crash, all seems fine?

After running xeno-test though:
[=C2=A0 255.675666] I-pipe: Detected stalled head domain, probably caused b=
y a bug.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A critical section may have been=
 left unterminated.
[=C2=A0 255.675670] DEBUG_LOCKS_WARN_ON(preemptible())
[=C2=A0 255.675678] BUG: using __this_cpu_write() in preemptible [00000000]=
 code: InputThread/830
[=C2=A0 255.675684] caller is do_vprintk+0x56/0x100
[=C2=A0 255.675688] CPU: 0 PID: 830 Comm: InputThread Not tainted 4.14.77-I=
PIPE+ #3
[=C2=A0 255.675689] I-pipe domain: Linux
[=C2=A0 255.675692] Call Trace:
[=C2=A0 255.675695]=C2=A0 <IRQ>
[=C2=A0 255.675699]=C2=A0 ? dump_stack+0x6f/0x87
[=C2=A0 255.675703]=C2=A0 ? check_preemption_disabled+0x110/0x120
[=C2=A0 255.675706]=C2=A0 ? do_vprintk+0x56/0x100
[=C2=A0 255.675709]=C2=A0 ? printk+0x43/0x45
[=C2=A0 255.675712]=C2=A0 ? ipipe_root_only+0xd7/0xe0
[=C2=A0 255.675715]=C2=A0 ? ipipe_stall_root+0x7/0x30
[=C2=A0 255.675718]=C2=A0 ? __ipipe_trap_prologue+0x215/0x240
[=C2=A0 255.675721]=C2=A0 ? invalid_op+0x2a/0x55
[=C2=A0 255.675725]=C2=A0 ? __switch_to_xtra+0x34b/0x370
[=C2=A0 255.675728]=C2=A0 ? __switch_to_asm+0x34/0x70
[=C2=A0 255.675730]=C2=A0 ? __switch_to_asm+0x40/0x70
[=C2=A0 255.675733]=C2=A0 ? __switch_to+0x306/0x340
[=C2=A0 255.675735]=C2=A0 ? __switch_to_asm+0x40/0x70
[=C2=A0 255.675739]=C2=A0 ? ___xnsched_run+0x155/0x3e0
[=C2=A0 255.675741]=C2=A0 ? xnintr_core_clock_handler+0x24b/0x260
[=C2=A0 255.675744]=C2=A0 ? dispatch_irq_head+0x90/0x130
[=C2=A0 255.675747]=C2=A0 ? __ipipe_handle_irq+0x6e/0x1f0
[=C2=A0 255.675750]=C2=A0 ? apic_timer_interrupt+0x77/0xa0
[=C2=A0 255.675751]=C2=A0 </IRQ>
[=C2=A0 255.675756]=C2=A0 ? ep_send_events_proc+0xa9/0x180
[=C2=A0 255.675758]=C2=A0 ? ep_send_events_proc+0x9c/0x180
[=C2=A0 255.675761]=C2=A0 ? ep_poll+0x470/0x470
[=C2=A0 255.675764]=C2=A0 ? ep_scan_ready_list.isra.18+0x98/0x1e0
[=C2=A0 255.675767]=C2=A0 ? ep_poll+0x23a/0x470
[=C2=A0 255.675770]=C2=A0 ? try_to_wake_up+0x350/0x350
[=C2=A0 255.675773]=C2=A0 ? SyS_epoll_wait+0xad/0xd0
[=C2=A0 255.675775]=C2=A0 ? do_syscall_64+0x8a/0x27d
[=C2=A0 255.675778]=C2=A0 ? __do_page_fault+0x17c/0x3e0
[=C2=A0 255.675781]=C2=A0 ? entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[=C2=A0 255.675785] CPU: 0 PID: 830 Comm: InputThread Not tainted 4.14.77-I=
PIPE+ #3
[=C2=A0 255.675787] I-pipe domain: Linux
[=C2=A0 255.675789] Call Trace:
[=C2=A0 255.675791]=C2=A0 <IRQ>
[=C2=A0 255.675795]=C2=A0 ? dump_stack+0x6f/0x87
[=C2=A0 255.675798]=C2=A0 ? ipipe_stall_root+0x7/0x30
[=C2=A0 255.675800]=C2=A0 ? __ipipe_trap_prologue+0x215/0x240
[=C2=A0 255.675804]=C2=A0 ? invalid_op+0x2a/0x55
[=C2=A0 255.675808]=C2=A0 ? __switch_to_xtra+0x34b/0x370
[=C2=A0 255.675811]=C2=A0 ? __switch_to_asm+0x34/0x70
[=C2=A0 255.675814]=C2=A0 ? __switch_to_asm+0x40/0x70
[=C2=A0 255.675817]=C2=A0 ? __switch_to+0x306/0x340
[=C2=A0 255.675820]=C2=A0 ? __switch_to_asm+0x40/0x70
[=C2=A0 255.675823]=C2=A0 ? ___xnsched_run+0x155/0x3e0
[=C2=A0 255.675827]=C2=A0 ? xnintr_core_clock_handler+0x24b/0x260
[=C2=A0 255.675830]=C2=A0 ? dispatch_irq_head+0x90/0x130
[=C2=A0 255.675833]=C2=A0 ? __ipipe_handle_irq+0x6e/0x1f0
[=C2=A0 255.675837]=C2=A0 ? apic_timer_interrupt+0x77/0xa0
[=C2=A0 255.675839]=C2=A0 </IRQ>
[=C2=A0 255.675843]=C2=A0 ? ep_send_events_proc+0xa9/0x180
[=C2=A0 255.675847]=C2=A0 ? ep_send_events_proc+0x9c/0x180
[=C2=A0 255.675850]=C2=A0 ? ep_poll+0x470/0x470
[=C2=A0 255.675853]=C2=A0 ? ep_scan_ready_list.isra.18+0x98/0x1e0
[=C2=A0 255.675857]=C2=A0 ? ep_poll+0x23a/0x470
[=C2=A0 255.675861]=C2=A0 ? try_to_wake_up+0x350/0x350
[=C2=A0 255.675864]=C2=A0 ? SyS_epoll_wait+0xad/0xd0
[=C2=A0 255.675867]=C2=A0 ? do_syscall_64+0x8a/0x27d
[=C2=A0 255.675870]=C2=A0 ? __do_page_fault+0x17c/0x3e0
[=C2=A0 255.675874]=C2=A0 ? entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[=C2=A0 255.675880] BUG: Unhandled exception over domain Xenomai at 0xfffff=
fffb1c0f2db - switching to ROOT
[=C2=A0 255.675882] CPU: 0 PID: 830 Comm: InputThread Not tainted 4.14.77-I=
PIPE+ #3
[=C2=A0 255.675884] I-pipe domain: Linux
[=C2=A0 255.675886] Call Trace:
[=C2=A0 255.675888]=C2=A0 <IRQ>
[=C2=A0 255.675891]=C2=A0 ? dump_stack+0x6f/0x87
[=C2=A0 255.675894]=C2=A0 ? __ipipe_trap_prologue+0x18a/0x240
[=C2=A0 255.675898]=C2=A0 ? invalid_op+0x2a/0x55
[=C2=A0 255.675902]=C2=A0 ? __switch_to_xtra+0x34b/0x370
[=C2=A0 255.675905]=C2=A0 ? __switch_to_asm+0x34/0x70
[=C2=A0 255.675908]=C2=A0 ? __switch_to_asm+0x40/0x70
[=C2=A0 255.675911]=C2=A0 ? __switch_to+0x306/0x340
[=C2=A0 255.675913]=C2=A0 ? __switch_to_asm+0x40/0x70
[=C2=A0 255.675917]=C2=A0 ? ___xnsched_run+0x155/0x3e0
[=C2=A0 255.675920]=C2=A0 ? xnintr_core_clock_handler+0x24b/0x260
[=C2=A0 255.675923]=C2=A0 ? dispatch_irq_head+0x90/0x130
[=C2=A0 255.675926]=C2=A0 ? __ipipe_handle_irq+0x6e/0x1f0
[=C2=A0 255.675930]=C2=A0 ? apic_timer_interrupt+0x77/0xa0
[=C2=A0 255.675932]=C2=A0 </IRQ>
[=C2=A0 255.675937]=C2=A0 ? ep_send_events_proc+0xa9/0x180
[=C2=A0 255.675940]=C2=A0 ? ep_send_events_proc+0x9c/0x180
[=C2=A0 255.675943]=C2=A0 ? ep_poll+0x470/0x470
[=C2=A0 255.675947]=C2=A0 ? ep_scan_ready_list.isra.18+0x98/0x1e0
[=C2=A0 255.675950]=C2=A0 ? ep_poll+0x23a/0x470
[=C2=A0 255.675954]=C2=A0 ? try_to_wake_up+0x350/0x350
[=C2=A0 255.675957]=C2=A0 ? SyS_epoll_wait+0xad/0xd0
[=C2=A0 255.675960]=C2=A0 ? do_syscall_64+0x8a/0x27d
[=C2=A0 255.675963]=C2=A0 ? __do_page_fault+0x17c/0x3e0
[=C2=A0 255.675967]=C2=A0 ? entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[=C2=A0 255.675973] ------------[ cut here ]------------
[=C2=A0 255.675977] WARNING: CPU: 0 PID: 830 at ./arch/x86/include/asm/desc=
.h:312 __switch_to_xtra+0x34b/0x370
[=C2=A0 255.675979] Modules linked in: af_packet nf_conntrack_ipv6 nf_defra=
g_ipv6 ip6table_filter ip6_tables hid_generic usbhid hid nf_conntrack_ipv4 =
nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ohci_pci xhci_pci x=
hci_hcd ohci_hcd ehci_pci r8169 ehci_hcd usbcore rtc_cmos usb_common mii ip=
_tables x_tables ipv6
[=C2=A0 255.676022] CPU: 0 PID: 830 Comm: InputThread Not tainted 4.14.77-I=
PIPE+ #3
[=C2=A0 255.676024] I-pipe domain: Linux
[=C2=A0 255.676026] task: ffff9f222e352600 task.stack: ffffb21d80878000
[=C2=A0 255.676029] RIP: 0010:__switch_to_xtra+0x34b/0x370
[=C2=A0 255.676032] RSP: 0018:ffff9f223fc03e70 EFLAGS: 00010046
[=C2=A0 255.676036] RAX: 0000000000000023 RBX: 0000000000400000 RCX: 000000=
0000000001
[=C2=A0 255.676038] RDX: 0000000000000000 RSI: 0000000000001140 RDI: 000000=
0000000045
[=C2=A0 255.676046] RBP: ffff9f223fc03e98 R08: 0000000000000000 R09: ffffff=
ffb2730894
[=C2=A0 255.676053] R10: 000000000000000d R11: ffffb21d828fbcb0 R12: 000000=
0000000000
[=C2=A0 255.676059] R13: ffff9f223fc00000 R14: 0000000000000000 R15: 000000=
0000004000
[=C2=A0 255.676066] FS:=C2=A0 0000766ce8c47700(0000) GS:ffff9f223fc00000(00=
00) knlGS:0000000000000000
[=C2=A0 255.676072] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[=C2=A0 255.676078] CR2: 000070981d8ae000 CR3: 0000000427f8c000 CR4: 000000=
00000406f0
[=C2=A0 255.676085] Call Trace:
[=C2=A0 255.676091]=C2=A0 <IRQ>
[=C2=A0 255.676098]=C2=A0 ? __switch_to_asm+0x34/0x70
[=C2=A0 255.676104]=C2=A0 ? __switch_to_asm+0x40/0x70
[=C2=A0 255.676112]=C2=A0 ? __switch_to+0x306/0x340
[=C2=A0 255.676119]=C2=A0 ? __switch_to_asm+0x40/0x70
[=C2=A0 255.676128]=C2=A0 ? ___xnsched_run+0x155/0x3e0
[=C2=A0 255.676137]=C2=A0 ? xnintr_core_clock_handler+0x24b/0x260
[=C2=A0 255.676145]=C2=A0 ? dispatch_irq_head+0x90/0x130
[=C2=A0 255.676154]=C2=A0 ? __ipipe_handle_irq+0x6e/0x1f0
[=C2=A0 255.676163]=C2=A0 ? apic_timer_interrupt+0x77/0xa0
[=C2=A0 255.676169]=C2=A0 </IRQ>
[=C2=A0 255.676180]=C2=A0 ? ep_send_events_proc+0xa9/0x180
[=C2=A0 255.676188]=C2=A0 ? ep_send_events_proc+0x9c/0x180
[=C2=A0 255.676196]=C2=A0 ? ep_poll+0x470/0x470
[=C2=A0 255.676205]=C2=A0 ? ep_scan_ready_list.isra.18+0x98/0x1e0
[=C2=A0 255.676215]=C2=A0 ? ep_poll+0x23a/0x470
[=C2=A0 255.676225]=C2=A0 ? try_to_wake_up+0x350/0x350
[=C2=A0 255.676234]=C2=A0 ? SyS_epoll_wait+0xad/0xd0
[=C2=A0 255.676242]=C2=A0 ? do_syscall_64+0x8a/0x27d
[=C2=A0 255.676249]=C2=A0 ? __do_page_fault+0x17c/0x3e0
[=C2=A0 255.676259]=C2=A0 ? entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[=C2=A0 255.676270] Code: 00 85 c0 0f 84 3a fd ff ff 83 3d 40 01 c2 00 00 0=
f 85 2d fd ff ff 48 c7 c6 85 72 49 b2 48 c7 c7 93 72 49 b2 31 c0 e8 1d e6 0=
5 00 <0f> 0b e9 11 fd ff ff 44 89 ef e8 86 41 00 00 ba 01 00 00 00 eb=20
[=C2=A0 255.676568] ---[ end trace 7e0ca3fbc0d12858 ]---
No panic, system still works, and I am still able to run the latency test:

$ testsuite/latency/latency
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|=C2=A0 00:00:01=C2=A0 (periodic user-mode task, 100 us period, priority=
 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.878|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
52|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.241|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.878|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.241
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.732|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
61|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.425|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.732|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.425
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.209|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
68|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.732|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.648|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5=
42|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.852|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.648|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.855|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5=
53|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.707|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.648|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.824|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
62|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.941|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.648|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.843|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
59|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.572|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.648|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.207|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
60|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.236|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.648|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.210|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
64|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.737|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.648|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.901|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
85|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.725|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.648|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.991|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5=
00|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.209|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.648|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5=
57|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.802|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.787|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
82|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.473|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.824|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
67|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.610|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.211|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
64|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.443|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.899|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
57|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.934|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.210|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
60|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.942|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.206|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
51|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.614|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.614|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5=
83|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.802|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
RTD|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.854|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5=
49|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.202|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690
^C---|-----------|-----------|-----------|--------|------|-----------------=
--------
RTS|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.535|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.4=
88|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9.690|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0|=C2=A0=C2=A0=C2=A0=C2=A0 0|=C2=A0=C2=A0=C2=A0 00:00:20/00:00:20

Using Xenomai branch next.
Cheers!
Alec
