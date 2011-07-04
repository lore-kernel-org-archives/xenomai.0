MIME-Version: 1.0
In-Reply-To: <CAMJ=MEcTefZicuRNSv77kQB3XQTkvQDekHNeq04KPA86-yTEuw@domain.hid>
References: <CAMJ=MEcTefZicuRNSv77kQB3XQTkvQDekHNeq04KPA86-yTEuw@domain.hid>
Date: Mon, 4 Jul 2011 10:06:42 +0200
Message-ID: <CAMJ=MEcn1ZemK7XkW5F9MpJ9pWihm7UM-t-7HZP7LPD7QDLmcA@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] Kernel blocked during send/receive raw ethernet
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

On Sat, Jul 2, 2011 at 11:33 PM, Ronny Meeus <ronny.meeus@domain.hid> wrote:
> Hello
>
> we use have a FreeScale P4040 (powerpc) based board running Linux+Xenomai=
.
> I copy-paste here some information I found in the bootlog:
>
> [ =A0 =A00.000000] Using P4080 DS machine description
> [ =A0 =A00.000000] Memory CAM mapping: 256/256/256 Mb, residual: 1248Mb
> [ =A0 =A00.000000] Linux version 2.6.35.7-hg98224f47aa52-dirty
> (xxxxx@domain.hid) (gcc version 4.4.6 (Buildroot 2011.05-hg98224f47aa52)
> ) #1 SMP Fri Jul 1 08:42:30 CEST 2011
>
> [ =A0 =A00.000000] clocksource: timebase mult[6aaaf09] shift[22] register=
ed
> [ =A0 =A00.000000] I-pipe 2.12-01: pipeline enabled.
> [ =A0 =A00.000000] Console: colour dummy device 80x25
> [ =A0 =A00.181150] pid_max: default: 32768 minimum: 301
>
> [ =A0 =A02.093842] I-pipe: Domain Xenomai registered.
> [ =A0 =A02.146016] Xenomai: hal/powerpc started.
> [ =A0 =A02.193904] Xenomai: scheduling class idle registered.
> [ =A0 =A02.255328] Xenomai: scheduling class rt registered.
> [ =A0 =A02.319092] Xenomai: real-time nucleus v2.5.5 (Ghosts) loaded.
> [ =A0 =A02.388207] Xenomai: starting native API services.
> [ =A0 =A02.445249] Xenomai: starting pSOS+ services.
> [ =A0 =A02.497478] highmem bounce pool size: 64 pages
> [ =A0 =A02.550932] fuse init (API version 7.14)
>
> Although the P4040 has 4 cores, we are currently using only 1 core.
> This is specified in the device tree we are using.
> The kernel runs SMP enabled.
>
> I start 2 test applications on this board.
> The first application is sending raw Ethernet packets on a link that
> is put in loop. The result is that all packets we send are received
> (unmodified) back on the same interface.
> The second application is listening on the same Ethernet interface
> also via a raw Ethernet socket.
> Both application are plain Linux application so no Xenomai code is used.
>
> One side effect of using raw Ethernet sockets is that all packets sent
> on one socket will also be received by all other raw Ethernet sockets.
> This means that the listening application will receive each packet 2
> times: once while sending and a second time when it is received via
> the loop. (A side question: can the behavior be disabled somehow? We
> basically do not want to receive all packets we send ...)
>
> After a very short time (sending something like 30000 packets), both
> applications block completely and 60 seconds later an indication is
> displayed on the console that the kernel is locked.
>
> [ =A0805.307213] BUG: soft lockup - CPU#0 stuck for 61s! [send_eth_socket=
:1907]
> [ =A0805.389519] Modules linked in: reboot_helper dpll_si53xx crave ndps_=
a_cpld
> [ =A0805.471880] NIP: c000cc4c LR: 00000000 CTR: 00000000
> [ =A0805.531274] REGS: c1f87040 TRAP: 0000 =A0 Not tainted
> (2.6.35.7-hg98224f47aa52-dirty)
> [ =A0805.623992] MSR: 00029002 <EE,ME,CE> =A0CR: 00000000 =A0XER: 0000000=
0
> [ =A0805.696972] TASK =3D ec7116d0[1907] 'send_eth_socket' THREAD: ec6aa0=
00 CPU: 0
> [ =A0805.778248] GPR00: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [ =A0805.878359] GPR08: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [ =A0805.978452] GPR16: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [ =A0806.078571] GPR24: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [ =A0806.180773] NIP [c000cc4c] udelay+0x24/0x30
> [ =A0806.230782] LR [00000000] (null)
> [ =A0806.269334] Call Trace:
> [ =A0806.298521] [efff3b50] [c00071b4] show_stack+0x78/0x18c (unreliable)
> [ =A0806.374600] [efff3b90] [c00078c4] show_regs+0x200/0x2ec
> [ =A0806.437125] [efff3bc0] [c00658d4] softlockup_tick+0x1dc/0x23c
> [ =A0806.505897] [efff3bf0] [c003cc50] run_local_timers+0x1c/0x2c
> [ =A0806.573626] [efff3c00] [c003cca4] update_process_times+0x44/0x80
> [ =A0806.645528] [efff3c20] [c0059bc4] tick_sched_timer+0xd0/0x128
> [ =A0806.714307] [efff3c50] [c004d8f0] __run_hrtimer+0x68/0x14c
> [ =A0806.779958] [efff3c70] [c004efa4] hrtimer_interrupt+0x1d8/0x41c
> [ =A0806.850812] [efff3cf0] [c000d8d8] timer_interrupt+0x1b4/0x238
> [ =A0806.919586] [efff3d10] [c0009ac4] __ipipe_do_timer+0x44/0x54
> [ =A0806.987315] [efff3d20] [c006d448] __ipipe_sync_stage+0x1d0/0x27c
> [ =A0807.059212] [efff3d60] [c0009728] __ipipe_grab_timer+0x104/0x12c
> [ =A0807.131112] [efff3d70] [c00129e0] __ipipe_ret_from_except+0x0/0xc
> [ =A0807.204063] --- Exception: 901 at _raw_spin_lock+0x30/0x3c
> [ =A0807.204068] =A0 =A0 LR =3D tpacket_rcv+0x264/0x570
> [ =A0807.320754] [efff3e30] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable=
)
> [ =A0807.397875] [efff3e80] [c02c43b0] __netif_receive_skb+0x2b4/0x2f0
> [ =A0807.470811] [efff3eb0] [c02c4fa0] netif_receive_skb+0x98/0xac
> [ =A0807.539583] [efff3ee0] [c0292838] ingress_rx_default_dqrr+0x428/0x4b=
4
> [ =A0807.616693] [efff3f10] [c02ac2a8] qman_poll_dqrr+0x1e0/0x284
> [ =A0807.684426] [efff3f50] [c0294088] dpaa_eth_poll+0x34/0xd0
> [ =A0807.749031] [efff3f70] [c02c5280] net_rx_action+0xc0/0x1e8
> [ =A0807.814683] [efff3fa0] [c0035ab0] __do_softirq+0x138/0x210
> [ =A0807.880333] [efff3ff0] [c00115e8] call_do_softirq+0x14/0x24
> [ =A0807.947022] [ec6abab0] [c000480c] do_softirq+0xb4/0xec
> [ =A0808.008503] --- Exception: ec6abbb0 at 0xec6abb70
> [ =A0808.008507] =A0 =A0 LR =3D 0xec4e6c50
> [ =A0808.102274] [ec6abad0] [c00357cc] irq_exit+0x60/0xb8 (unreliable)
> [ =A0808.175227] [ec6abae0] [c0009b5c] __ipipe_do_IRQ+0x88/0xc0
> [ =A0808.240872] [ec6abb00] [c006d468] __ipipe_sync_stage+0x1f0/0x27c
> [ =A0808.312771] [ec6abb40] [c00095f4] __ipipe_handle_irq+0x1b8/0x1e8
> [ =A0808.384669] [ec6abb70] [c00098dc] __ipipe_grab_irq+0x18c/0x1bc
> [ =A0808.454482] [ec6abba0] [c00129e0] __ipipe_ret_from_except+0x0/0xc
> [ =A0808.527425] --- Exception: 501 at _raw_spin_lock+0x14/0x3c
> [ =A0808.527430] =A0 =A0 LR =3D tpacket_rcv+0x264/0x570
> [ =A0808.644114] [ec6abc60] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable=
)
> [ =A0808.721232] [ec6abcb0] [c02c6238] dev_hard_start_xmit+0x164/0x414
> [ =A0808.794171] [ec6abcf0] [c0325b94] packet_sendmsg+0x8c0/0x984
> [ =A0808.861901] [ec6abd70] [c02b32f0] sock_sendmsg+0x90/0xb4
> [ =A0808.925465] [ec6abe40] [c02b3ea8] sys_sendto+0xd0/0x114
> [ =A0808.987988] [ec6abf10] [c02b522c] sys_socketcall+0x148/0x210
> [ =A0809.055718] [ec6abf40] [c0011d0c] ret_from_syscall+0x0/0x3c
> [ =A0809.122407] --- Exception: c01 at 0x48051f00
> [ =A0809.122411] =A0 =A0 LR =3D 0x4808e030
> [ =A0809.210966] Instruction dump:
> [ =A0809.246401] 7d204850 7f891840 419cfff0 7c421378 4e800020 3d20c04c
> 800967e0 7c0301d6
> [ =A0809.339215] 7d2c42a6 48000008 7c210b78 <7d6c42a6> <7d695850>
> 7f8b0040 419cfff0 7c421378
> [ =A0874.025894] BUG: soft lockup - CPU#0 stuck for 61s! [send_eth_socket=
:1907]
> [ =A0874.108198] Modules linked in: reboot_helper dpll_si53xx crave ndps_=
a_cpld
> [ =A0874.190551] NIP: c000cc48 LR: 00000000 CTR: 00000000
> [ =A0874.249937] REGS: c1f87040 TRAP: 0000 =A0 Not tainted
> (2.6.35.7-hg98224f47aa52-dirty)
> [ =A0874.342658] MSR: 00029002 <EE,ME,CE> =A0CR: 00000000 =A0XER: 0000000=
0
> [ =A0874.415638] TASK =3D ec7116d0[1907] 'send_eth_socket' THREAD: ec6aa0=
00 CPU: 0
> [ =A0874.496907] GPR00: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [ =A0874.597018] GPR08: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [ =A0874.697124] GPR16: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [ =A0874.797235] GPR24: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [ =A0874.899421] NIP [c000cc40] udelay+0x18/0x30
> [ =A0874.949434] LR [00000000] (null)
> [ =A0874.987986] Call Trace:
> [ =A0875.017170] [efff3b50] [c00071b4] show_stack+0x78/0x18c (unreliable)
> [ =A0875.093240] [efff3b90] [c00078c4] show_regs+0x200/0x2ec
> [ =A0875.155763] [efff3bc0] [c00658d4] softlockup_tick+0x1dc/0x23c
> [ =A0875.224534] [efff3bf0] [c003cc50] run_local_timers+0x1c/0x2c
> [ =A0875.292265] [efff3c00] [c003cca4] update_process_times+0x44/0x80
> [ =A0875.364164] [efff3c20] [c0059bc4] tick_sched_timer+0xd0/0x128
> [ =A0875.432936] [efff3c50] [c004d8f0] __run_hrtimer+0x68/0x14c
> [ =A0875.498584] [efff3c70] [c004efa4] hrtimer_interrupt+0x1d8/0x41c
> [ =A0875.569437] [efff3cf0] [c000d8d8] timer_interrupt+0x1b4/0x238
> [ =A0875.638211] [efff3d10] [c0009ac4] __ipipe_do_timer+0x44/0x54
> [ =A0875.705941] [efff3d20] [c006d448] __ipipe_sync_stage+0x1d0/0x27c
> [ =A0875.777839] [efff3d60] [c0009728] __ipipe_grab_timer+0x104/0x12c
> [ =A0875.849736] [efff3d70] [c00129e0] __ipipe_ret_from_except+0x0/0xc
> [ =A0875.922680] --- Exception: 901 at _raw_spin_lock+0x30/0x3c
> [ =A0875.922684] =A0 =A0 LR =3D tpacket_rcv+0x264/0x570
> [ =A0876.039367] [efff3e30] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable=
)
> [ =A0876.116479] [efff3e80] [c02c43b0] __netif_receive_skb+0x2b4/0x2f0
> [ =A0876.189418] [efff3eb0] [c02c4fa0] netif_receive_skb+0x98/0xac
> [ =A0876.258189] [efff3ee0] [c0292838] ingress_rx_default_dqrr+0x428/0x4b=
4
> [ =A0876.335297] [efff3f10] [c02ac2a8] qman_poll_dqrr+0x1e0/0x284
> [ =A0876.403025] [efff3f50] [c0294088] dpaa_eth_poll+0x34/0xd0
> [ =A0876.467632] [efff3f70] [c02c5280] net_rx_action+0xc0/0x1e8
> [ =A0876.533280] [efff3fa0] [c0035ab0] __do_softirq+0x138/0x210
> [ =A0876.598926] [efff3ff0] [c00115e8] call_do_softirq+0x14/0x24
> [ =A0876.665618] [ec6abab0] [c000480c] do_softirq+0xb4/0xec
> [ =A0876.727097] --- Exception: ec6abbb0 at 0xec6abb70
> [ =A0876.727101] =A0 =A0 LR =3D 0xec4e6c50
> [ =A0876.820868] [ec6abad0] [c00357cc] irq_exit+0x60/0xb8 (unreliable)
> [ =A0876.893814] [ec6abae0] [c0009b5c] __ipipe_do_IRQ+0x88/0xc0
> [ =A0876.959459] [ec6abb00] [c006d468] __ipipe_sync_stage+0x1f0/0x27c
> [ =A0877.031358] [ec6abb40] [c00095f4] __ipipe_handle_irq+0x1b8/0x1e8
> [ =A0877.103256] [ec6abb70] [c00098dc] __ipipe_grab_irq+0x18c/0x1bc
> [ =A0877.173069] [ec6abba0] [c00129e0] __ipipe_ret_from_except+0x0/0xc
> [ =A0877.246012] --- Exception: 501 at _raw_spin_lock+0x14/0x3c
> [ =A0877.246017] =A0 =A0 LR =3D tpacket_rcv+0x264/0x570
> [ =A0877.362701] [ec6abc60] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable=
)
> [ =A0877.439819] [ec6abcb0] [c02c6238] dev_hard_start_xmit+0x164/0x414
> [ =A0877.512758] [ec6abcf0] [c0325b94] packet_sendmsg+0x8c0/0x984
> [ =A0877.580487] [ec6abd70] [c02b32f0] sock_sendmsg+0x90/0xb4
> [ =A0877.644052] [ec6abe40] [c02b3ea8] sys_sendto+0xd0/0x114
> [ =A0877.706575] [ec6abf10] [c02b522c] sys_socketcall+0x148/0x210
> [ =A0877.774306] [ec6abf40] [c0011d0c] ret_from_syscall+0x0/0x3c
> [ =A0877.840994] --- Exception: c01 at 0x48051f00
> [ =A0877.840998] =A0 =A0 LR =3D 0x4808e030
> [ =A0877.929553] Instruction dump:
> [ =A0877.964988] 419cfff0 7c421378 4e800020 3d20c04c 800967e0 7c0301d6
> 7d2c42a6 48000008
> [ =A0878.057802] 7c210b78 7d6c42a6 7d695850 7f8b0040 419cfff0 7c421378
> 4e800020 3d20c04a
>
> I do not completely understand this dump, but it looks like both the
> receive direction (running in the context of a softirq) and my
> transmitting application are blocked on the spinlock used in the
> tpacket_rcv function:
>
> [ =A0876.039367] [efff3e30] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable=
)
> [ =A0876.116479] [efff3e80] [c02c43b0] __netif_receive_skb+0x2b4/0x2f0
> [ =A0876.189418] [efff3eb0] [c02c4fa0] netif_receive_skb+0x98/0xac
> [ =A0876.258189] [efff3ee0] [c0292838] ingress_rx_default_dqrr+0x428/0x4b=
4
> [ =A0876.335297] [efff3f10] [c02ac2a8] qman_poll_dqrr+0x1e0/0x284
> [ =A0876.403025] [efff3f50] [c0294088] dpaa_eth_poll+0x34/0xd0
> [ =A0876.467632] [efff3f70] [c02c5280] net_rx_action+0xc0/0x1e8
> [ =A0876.533280] [efff3fa0] [c0035ab0] __do_softirq+0x138/0x210
> [ =A0876.598926] [efff3ff0] [c00115e8] call_do_softirq+0x14/0x24
> [ =A0876.665618] [ec6abab0] [c000480c] do_softirq+0xb4/0xec
>
> and
>
> [ =A0877.362701] [ec6abc60] [c0325e48] tpacket_rcv+0xf4/0x570 (unreliable=
)
> [ =A0877.439819] [ec6abcb0] [c02c6238] dev_hard_start_xmit+0x164/0x414
> [ =A0877.512758] [ec6abcf0] [c0325b94] packet_sendmsg+0x8c0/0x984
> [ =A0877.580487] [ec6abd70] [c02b32f0] sock_sendmsg+0x90/0xb4
> [ =A0877.644052] [ec6abe40] [c02b3ea8] sys_sendto+0xd0/0x114
> [ =A0877.706575] [ec6abf10] [c02b522c] sys_socketcall+0x148/0x210
> [ =A0877.774306] [ec6abf40] [c0011d0c] ret_from_syscall+0x0/0x3c
>
> Is my analysis correct?
> If yes, can this have anything to do with the IPIPE mechanism we are
> using (maybe a know issue??).
>
> Any help would be much appreciated.
>
> Thanks,
> Ronny
>

Hello

I did a new test (this time with an older kernel Linux version
2.6.34.6): same tests were executed but this time on a pure Linux
build (no IPIPE included). The issue cannot be reproduced anymore in
this environment. My test builds keep on running forever.

My next steps are:
- Running the same test on 2.6.35.7 without IPIPE. This enviroment is
currently building.
- Include only IPIPE and no Xenomai and redo the test.

Best regards
Ronny

