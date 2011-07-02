MIME-Version: 1.0
Date: Sat, 2 Jul 2011 23:33:13 +0200
Message-ID: <CAMJ=MEcTefZicuRNSv77kQB3XQTkvQDekHNeq04KPA86-yTEuw@domain.hid>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Adeos-main] Kernel blocked during send/receive raw ethernet
	packets.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello

we use have a FreeScale P4040 (powerpc) based board running Linux+Xenomai.
I copy-paste here some information I found in the bootlog:

[    0.000000] Using P4080 DS machine description
[    0.000000] Memory CAM mapping: 256/256/256 Mb, residual: 1248Mb
[    0.000000] Linux version 2.6.35.7-hg98224f47aa52-dirty
(xxxxx@domain.hid) (gcc version 4.4.6 (Buildroot 2011.05-hg98224f47aa52)
) #1 SMP Fri Jul 1 08:42:30 CEST 2011

[    0.000000] clocksource: timebase mult[6aaaf09] shift[22] registered
[    0.000000] I-pipe 2.12-01: pipeline enabled.
[    0.000000] Console: colour dummy device 80x25
[    0.181150] pid_max: default: 32768 minimum: 301

[    2.093842] I-pipe: Domain Xenomai registered.
[    2.146016] Xenomai: hal/powerpc started.
[    2.193904] Xenomai: scheduling class idle registered.
[    2.255328] Xenomai: scheduling class rt registered.
[    2.319092] Xenomai: real-time nucleus v2.5.5 (Ghosts) loaded.
[    2.388207] Xenomai: starting native API services.
[    2.445249] Xenomai: starting pSOS+ services.
[    2.497478] highmem bounce pool size: 64 pages
[    2.550932] fuse init (API version 7.14)

Although the P4040 has 4 cores, we are currently using only 1 core.
This is specified in the device tree we are using.
The kernel runs SMP enabled.

I start 2 test applications on this board.
The first application is sending raw Ethernet packets on a link that
is put in loop. The result is that all packets we send are received
(unmodified) back on the same interface.
The second application is listening on the same Ethernet interface
also via a raw Ethernet socket.
Both application are plain Linux application so no Xenomai code is used.

One side effect of using raw Ethernet sockets is that all packets sent
on one socket will also be received by all other raw Ethernet sockets.
This means that the listening application will receive each packet 2
times: once while sending and a second time when it is received via
the loop. (A side question: can the behavior be disabled somehow? We
basically do not want to receive all packets we send ...)

After a very short time (sending something like 30000 packets), both
applications block completely and 60 seconds later an indication is
displayed on the console that the kernel is locked.

[  805.307213] BUG: soft lockup - CPU#0 stuck for 61s! [send_eth_socket:1907]
[  805.389519] Modules linked in: reboot_helper dpll_si53xx crave ndps_a_cpld
[  805.471880] NIP: c000cc4c LR: 00000000 CTR: 00000000
[  805.531274] REGS: c1f87040 TRAP: 0000   Not tainted
(2.6.35.7-hg98224f47aa52-dirty)
[  805.623992] MSR: 00029002 <EE,ME,CE>  CR: 00000000  XER: 00000000
[  805.696972] TASK = ec7116d0[1907] 'send_eth_socket' THREAD: ec6aa000 CPU: 0
[  805.778248] GPR00: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  805.878359] GPR08: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  805.978452] GPR16: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  806.078571] GPR24: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  806.180773] NIP [c000cc4c] udelay+0x24/0x30
[  806.230782] LR [00000000] (null)
[  806.269334] Call Trace:
[  806.298521] [efff3b50] [c00071b4] show_stack+0x78/0x18c (unreliable)
[  806.374600] [efff3b90] [c00078c4] show_regs+0x200/0x2ec
[  806.437125] [efff3bc0] [c00658d4] softlockup_tick+0x1dc/0x23c
[  806.505897] [efff3bf0] [c003cc50] run_local_timers+0x1c/0x2c
[  806.573626] [efff3c00] [c003cca4] update_process_times+0x44/0x80
[  806.645528] [efff3c20] [c0059bc4] tick_sched_timer+0xd0/0x128
[  806.714307] [efff3c50] [c004d8f0] __run_hrtimer+0x68/0x14c
[  806.779958] [efff3c70] [c004efa4] hrtimer_interrupt+0x1d8/0x41c
[  806.850812] [efff3cf0] [c000d8d8] timer_interrupt+0x1b4/0x238
[  806.919586] [efff3d10] [c0009ac4] __ipipe_do_timer+0x44/0x54
[  806.987315] [efff3d20] [c006d448] __ipipe_sync_stage+0x1d0/0x27c
[  807.059212] [efff3d60] [c0009728] __ipipe_grab_timer+0x104/0x12c
[  807.131112] [efff3d70] [c00129e0] __ipipe_ret_from_except+0x0/0xc
[  807.204063] --- Exception: 901 at _raw_spin_lock+0x30/0x3c
[  807.204068]     LR = tpacket_rcv+0x264/0x570
[  807.320754] [efff3e30] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable)
[  807.397875] [efff3e80] [c02c43b0] __netif_receive_skb+0x2b4/0x2f0
[  807.470811] [efff3eb0] [c02c4fa0] netif_receive_skb+0x98/0xac
[  807.539583] [efff3ee0] [c0292838] ingress_rx_default_dqrr+0x428/0x4b4
[  807.616693] [efff3f10] [c02ac2a8] qman_poll_dqrr+0x1e0/0x284
[  807.684426] [efff3f50] [c0294088] dpaa_eth_poll+0x34/0xd0
[  807.749031] [efff3f70] [c02c5280] net_rx_action+0xc0/0x1e8
[  807.814683] [efff3fa0] [c0035ab0] __do_softirq+0x138/0x210
[  807.880333] [efff3ff0] [c00115e8] call_do_softirq+0x14/0x24
[  807.947022] [ec6abab0] [c000480c] do_softirq+0xb4/0xec
[  808.008503] --- Exception: ec6abbb0 at 0xec6abb70
[  808.008507]     LR = 0xec4e6c50
[  808.102274] [ec6abad0] [c00357cc] irq_exit+0x60/0xb8 (unreliable)
[  808.175227] [ec6abae0] [c0009b5c] __ipipe_do_IRQ+0x88/0xc0
[  808.240872] [ec6abb00] [c006d468] __ipipe_sync_stage+0x1f0/0x27c
[  808.312771] [ec6abb40] [c00095f4] __ipipe_handle_irq+0x1b8/0x1e8
[  808.384669] [ec6abb70] [c00098dc] __ipipe_grab_irq+0x18c/0x1bc
[  808.454482] [ec6abba0] [c00129e0] __ipipe_ret_from_except+0x0/0xc
[  808.527425] --- Exception: 501 at _raw_spin_lock+0x14/0x3c
[  808.527430]     LR = tpacket_rcv+0x264/0x570
[  808.644114] [ec6abc60] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable)
[  808.721232] [ec6abcb0] [c02c6238] dev_hard_start_xmit+0x164/0x414
[  808.794171] [ec6abcf0] [c0325b94] packet_sendmsg+0x8c0/0x984
[  808.861901] [ec6abd70] [c02b32f0] sock_sendmsg+0x90/0xb4
[  808.925465] [ec6abe40] [c02b3ea8] sys_sendto+0xd0/0x114
[  808.987988] [ec6abf10] [c02b522c] sys_socketcall+0x148/0x210
[  809.055718] [ec6abf40] [c0011d0c] ret_from_syscall+0x0/0x3c
[  809.122407] --- Exception: c01 at 0x48051f00
[  809.122411]     LR = 0x4808e030
[  809.210966] Instruction dump:
[  809.246401] 7d204850 7f891840 419cfff0 7c421378 4e800020 3d20c04c
800967e0 7c0301d6
[  809.339215] 7d2c42a6 48000008 7c210b78 <7d6c42a6> <7d695850>
7f8b0040 419cfff0 7c421378
[  874.025894] BUG: soft lockup - CPU#0 stuck for 61s! [send_eth_socket:1907]
[  874.108198] Modules linked in: reboot_helper dpll_si53xx crave ndps_a_cpld
[  874.190551] NIP: c000cc48 LR: 00000000 CTR: 00000000
[  874.249937] REGS: c1f87040 TRAP: 0000   Not tainted
(2.6.35.7-hg98224f47aa52-dirty)
[  874.342658] MSR: 00029002 <EE,ME,CE>  CR: 00000000  XER: 00000000
[  874.415638] TASK = ec7116d0[1907] 'send_eth_socket' THREAD: ec6aa000 CPU: 0
[  874.496907] GPR00: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  874.597018] GPR08: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  874.697124] GPR16: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  874.797235] GPR24: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  874.899421] NIP [c000cc40] udelay+0x18/0x30
[  874.949434] LR [00000000] (null)
[  874.987986] Call Trace:
[  875.017170] [efff3b50] [c00071b4] show_stack+0x78/0x18c (unreliable)
[  875.093240] [efff3b90] [c00078c4] show_regs+0x200/0x2ec
[  875.155763] [efff3bc0] [c00658d4] softlockup_tick+0x1dc/0x23c
[  875.224534] [efff3bf0] [c003cc50] run_local_timers+0x1c/0x2c
[  875.292265] [efff3c00] [c003cca4] update_process_times+0x44/0x80
[  875.364164] [efff3c20] [c0059bc4] tick_sched_timer+0xd0/0x128
[  875.432936] [efff3c50] [c004d8f0] __run_hrtimer+0x68/0x14c
[  875.498584] [efff3c70] [c004efa4] hrtimer_interrupt+0x1d8/0x41c
[  875.569437] [efff3cf0] [c000d8d8] timer_interrupt+0x1b4/0x238
[  875.638211] [efff3d10] [c0009ac4] __ipipe_do_timer+0x44/0x54
[  875.705941] [efff3d20] [c006d448] __ipipe_sync_stage+0x1d0/0x27c
[  875.777839] [efff3d60] [c0009728] __ipipe_grab_timer+0x104/0x12c
[  875.849736] [efff3d70] [c00129e0] __ipipe_ret_from_except+0x0/0xc
[  875.922680] --- Exception: 901 at _raw_spin_lock+0x30/0x3c
[  875.922684]     LR = tpacket_rcv+0x264/0x570
[  876.039367] [efff3e30] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable)
[  876.116479] [efff3e80] [c02c43b0] __netif_receive_skb+0x2b4/0x2f0
[  876.189418] [efff3eb0] [c02c4fa0] netif_receive_skb+0x98/0xac
[  876.258189] [efff3ee0] [c0292838] ingress_rx_default_dqrr+0x428/0x4b4
[  876.335297] [efff3f10] [c02ac2a8] qman_poll_dqrr+0x1e0/0x284
[  876.403025] [efff3f50] [c0294088] dpaa_eth_poll+0x34/0xd0
[  876.467632] [efff3f70] [c02c5280] net_rx_action+0xc0/0x1e8
[  876.533280] [efff3fa0] [c0035ab0] __do_softirq+0x138/0x210
[  876.598926] [efff3ff0] [c00115e8] call_do_softirq+0x14/0x24
[  876.665618] [ec6abab0] [c000480c] do_softirq+0xb4/0xec
[  876.727097] --- Exception: ec6abbb0 at 0xec6abb70
[  876.727101]     LR = 0xec4e6c50
[  876.820868] [ec6abad0] [c00357cc] irq_exit+0x60/0xb8 (unreliable)
[  876.893814] [ec6abae0] [c0009b5c] __ipipe_do_IRQ+0x88/0xc0
[  876.959459] [ec6abb00] [c006d468] __ipipe_sync_stage+0x1f0/0x27c
[  877.031358] [ec6abb40] [c00095f4] __ipipe_handle_irq+0x1b8/0x1e8
[  877.103256] [ec6abb70] [c00098dc] __ipipe_grab_irq+0x18c/0x1bc
[  877.173069] [ec6abba0] [c00129e0] __ipipe_ret_from_except+0x0/0xc
[  877.246012] --- Exception: 501 at _raw_spin_lock+0x14/0x3c
[  877.246017]     LR = tpacket_rcv+0x264/0x570
[  877.362701] [ec6abc60] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable)
[  877.439819] [ec6abcb0] [c02c6238] dev_hard_start_xmit+0x164/0x414
[  877.512758] [ec6abcf0] [c0325b94] packet_sendmsg+0x8c0/0x984
[  877.580487] [ec6abd70] [c02b32f0] sock_sendmsg+0x90/0xb4
[  877.644052] [ec6abe40] [c02b3ea8] sys_sendto+0xd0/0x114
[  877.706575] [ec6abf10] [c02b522c] sys_socketcall+0x148/0x210
[  877.774306] [ec6abf40] [c0011d0c] ret_from_syscall+0x0/0x3c
[  877.840994] --- Exception: c01 at 0x48051f00
[  877.840998]     LR = 0x4808e030
[  877.929553] Instruction dump:
[  877.964988] 419cfff0 7c421378 4e800020 3d20c04c 800967e0 7c0301d6
7d2c42a6 48000008
[  878.057802] 7c210b78 7d6c42a6 7d695850 7f8b0040 419cfff0 7c421378
4e800020 3d20c04a

I do not completely understand this dump, but it looks like both the
receive direction (running in the context of a softirq) and my
transmitting application are blocked on the spinlock used in the
tpacket_rcv function:

[  876.039367] [efff3e30] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable)
[  876.116479] [efff3e80] [c02c43b0] __netif_receive_skb+0x2b4/0x2f0
[  876.189418] [efff3eb0] [c02c4fa0] netif_receive_skb+0x98/0xac
[  876.258189] [efff3ee0] [c0292838] ingress_rx_default_dqrr+0x428/0x4b4
[  876.335297] [efff3f10] [c02ac2a8] qman_poll_dqrr+0x1e0/0x284
[  876.403025] [efff3f50] [c0294088] dpaa_eth_poll+0x34/0xd0
[  876.467632] [efff3f70] [c02c5280] net_rx_action+0xc0/0x1e8
[  876.533280] [efff3fa0] [c0035ab0] __do_softirq+0x138/0x210
[  876.598926] [efff3ff0] [c00115e8] call_do_softirq+0x14/0x24
[  876.665618] [ec6abab0] [c000480c] do_softirq+0xb4/0xec

and

[  877.362701] [ec6abc60] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable)
[  877.439819] [ec6abcb0] [c02c6238] dev_hard_start_xmit+0x164/0x414
[  877.512758] [ec6abcf0] [c0325b94] packet_sendmsg+0x8c0/0x984
[  877.580487] [ec6abd70] [c02b32f0] sock_sendmsg+0x90/0xb4
[  877.644052] [ec6abe40] [c02b3ea8] sys_sendto+0xd0/0x114
[  877.706575] [ec6abf10] [c02b522c] sys_socketcall+0x148/0x210
[  877.774306] [ec6abf40] [c0011d0c] ret_from_syscall+0x0/0x3c

Is my analysis correct?
If yes, can this have anything to do with the IPIPE mechanism we are
using (maybe a know issue??).

Any help would be much appreciated.

Thanks,
Ronny

