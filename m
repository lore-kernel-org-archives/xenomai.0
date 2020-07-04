MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Sat, 4 Jul 2020 09:56:59 +0800
Message-ID: <CAAvDm6bA37PeCYST66hZniEFFLG1e7Sry408RyGxryhD2iehQA@mail.gmail.com>
Subject: How can I investigate the cause of "watchdog: BUG: soft lockup"?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi, list
I encountered the error of "watchdog: BUG: soft lockup" when I sent
data through the can bus.
Could you please give me some hint on how to investigate the cause deeply?
Thank you for your attention to this matter.

Here is the full log:
Jul  3 10:06:16 yx kernel: [  140.313856] CAN[0][0] RX: FIFO overrun
Jul  3 10:06:59 yx kernel: [  183.323792] CAN[0][0] RX: FIFO overrun
Jul  3 10:07:42 yx kernel: [  226.329465] CAN[0][0] RX: FIFO overrun
Jul  3 10:08:24 yx kernel: [  268.362822] CAN[0][0] RX: FIFO overrun
Jul  3 10:09:07 yx kernel: [  311.372488] CAN[0][0] RX: FIFO overrun
Jul  3 10:09:50 yx kernel: [  354.377996] CAN[0][0] RX: FIFO overrun
Jul  3 10:10:32 yx kernel: [  396.411726] CAN[0][0] RX: FIFO overrun
Jul  3 10:11:15 yx kernel: [  439.421156] CAN[0][0] RX: FIFO overrun
Jul  3 10:11:58 yx kernel: [  482.426522] CAN[0][0] RX: FIFO overrun
Jul  3 10:12:40 yx kernel: [  524.460688] CAN[0][0] RX: FIFO overrun
Jul  3 10:13:23 yx kernel: [  567.469857] CAN[0][0] RX: FIFO overrun
Jul  3 10:14:06 yx kernel: [  610.475021] CAN[0][0] RX: FIFO overrun
Jul  3 10:14:48 yx kernel: [  652.509597] CAN[0][0] RX: FIFO overrun
Jul  3 10:15:31 yx kernel: [  695.518491] CAN[0][0] RX: FIFO overrun
Jul  3 10:16:14 yx kernel: [  738.523551] CAN[0][0] RX: FIFO overrun
Jul  3 10:16:55 yx kernel: [  779.558139] CAN[0][0] RX: FIFO overrun
Jul  3 10:17:38 yx kernel: [  822.566773] CAN[0][0] RX: FIFO overrun
Jul  3 10:18:21 yx kernel: [  865.571697] CAN[0][0] RX: FIFO overrun
Jul  3 10:19:03 yx kernel: [  907.607049] CAN[0][0] RX: FIFO overrun
Jul  3 10:19:46 yx kernel: [  950.615449] CAN[0][0] RX: FIFO overrun
Jul  3 10:20:29 yx kernel: [  993.620196] CAN[0][0] RX: FIFO overrun
Jul  3 10:21:11 yx kernel: [ 1035.655974] CAN[0][0] RX: FIFO overrun
Jul  3 10:21:54 yx kernel: [ 1078.664116] CAN[0][0] RX: FIFO overrun
Jul  3 10:22:36 yx kernel: [ 1120.688506] CAN[0][0] RX: FIFO overrun
Jul  3 10:23:31 yx kernel: [ 1176.166058] watchdog: BUG: soft lockup -
CPU#0 stuck for 22s! [rt_cansend:1837]
Jul  3 10:23:31 yx kernel: [ 1176.166066] Modules linked in: bnep
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
nls_iso8859_1 snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi intel_rapl
intel_soc_dts_thermal intel_soc_dts_iosf intel_powerclamp coretemp
kvm_intel snd_seq punit_atom_debug crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel snd_seq_device cryptd intel_cstate snd_timer
hci_uart snd lpc_ich advcan(OE) mei_txe btqca soundcore mei btbcm
btintel bluetooth ecdh_generic rfkill_gpio pwm_lpss_platform mac_hid
pwm_lpss parport_pc ppdev lp parport autofs4 i915 kvmgt vfio_mdev mdev
vfio_iommu_type1 vfio kvm irqbypass drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops igb drm dca ahci i2c_algo_bit
libahci video i2c_hid hid
Jul  3 10:23:31 yx kernel: [ 1176.166204] CPU: 0 PID: 1837 Comm:
rt_cansend Tainted: G           OE     4.19.84-solve-alc-failure #1
Jul  3 10:23:31 yx kernel: [ 1176.166209] I-pipe domain: Linux
Jul  3 10:23:31 yx kernel: [ 1176.166218] RIP:
0010:queued_spin_lock_slowpath+0xd9/0x1a0
Jul  3 10:23:31 yx kernel: [ 1176.166223] Code: 48 03 34 c5 00 67 37
91 48 89 16 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 32
48 85 f6 74 07 0f 0d 0e eb 02 f3 90 <8b> 07 66 85 c0 75 f7 41 89 c0 66
45 31 c0 41 39 c8 0f 84 96 00 00
Jul  3 10:23:31 yx kernel: [ 1176.166226] RSP: 0018:ffffbe6f4c17bd08
EFLAGS: 00000202 ORIG_RAX: 00000000ffffff13
Jul  3 10:23:31 yx kernel: [ 1176.166231] RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000000000
Jul  3 10:23:31 yx kernel: [ 1176.166234] RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000000000000
Jul  3 10:23:31 yx kernel: [ 1176.166236] RBP: ffffbe6f4c17bd08 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:23:31 yx kernel: [ 1176.166239] R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000000
Jul  3 10:23:31 yx kernel: [ 1176.166241] R13: 0000000000000000 R14:
0000000000000000 R15: 0000000000000000
Jul  3 10:23:31 yx kernel: [ 1176.166244] FS:  00007ff04533c940(0000)
GS:ffff96003ba00000(0000) knlGS:0000000000000000
Jul  3 10:23:31 yx kernel: [ 1176.166247] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jul  3 10:23:31 yx kernel: [ 1176.166250] CR2: 00007f799c003000 CR3:
00000000ab0fe000 CR4: 00000000001006f0
Jul  3 10:23:31 yx kernel: [ 1176.166252] Call Trace:
Jul  3 10:23:31 yx kernel: [ 1176.166261]  _raw_spin_lock+0x20/0x30
Jul  3 10:23:31 yx kernel: [ 1176.166270]  can_write+0x6c/0x2c0 [advcan]
Jul  3 10:23:31 yx kernel: [ 1176.166276]  ? dequeue_signal+0xae/0x1a0
Jul  3 10:23:31 yx kernel: [ 1176.166281]  ? recalc_sigpending+0x1b/0x50
Jul  3 10:23:31 yx kernel: [ 1176.166286]  ? __set_task_blocked+0x3c/0xa0
Jul  3 10:23:31 yx kernel: [ 1176.166292]  __vfs_write+0x3a/0x190
Jul  3 10:23:31 yx kernel: [ 1176.166298]  ? apparmor_file_permission+0x1a/0x20
Jul  3 10:23:31 yx kernel: [ 1176.166302]  ? security_file_permission+0x3b/0xc0
Jul  3 10:23:31 yx kernel: [ 1176.166307]  vfs_write+0xb8/0x1b0
Jul  3 10:23:31 yx kernel: [ 1176.166312]  ksys_write+0x5c/0xe0
Jul  3 10:23:31 yx kernel: [ 1176.166316]  __x64_sys_write+0x1a/0x20
Jul  3 10:23:31 yx kernel: [ 1176.166321]  do_syscall_64+0x87/0x250
Jul  3 10:23:31 yx kernel: [ 1176.166326]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul  3 10:23:31 yx kernel: [ 1176.166330] RIP: 0033:0x7ff04885d4bd
Jul  3 10:23:31 yx kernel: [ 1176.166334] Code: bf 20 00 00 75 10 b8
01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff
ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff
ff 48 89 d0 48 83 c4 08 48 3d 01
Jul  3 10:23:31 yx kernel: [ 1176.166337] RSP: 002b:00007ff04533ba70
EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Jul  3 10:23:31 yx kernel: [ 1176.166342] RAX: ffffffffffffffda RBX:
000000000153ca00 RCX: 00007ff04885d4bd
Jul  3 10:23:31 yx kernel: [ 1176.166344] RDX: 0000000000000001 RSI:
00007ff04533bac0 RDI: 000000000000000e
Jul  3 10:23:31 yx kernel: [ 1176.166347] RBP: 00007ff04533bbb0 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:23:31 yx kernel: [ 1176.166349] R10: 0000000000000000 R11:
0000000000000246 R12: 00007ff0491783e0
Jul  3 10:23:31 yx kernel: [ 1176.166352] R13: 00007ffc5d6b9b1f R14:
00007ff04533cc00 R15: 00000000004041b0
Jul  3 10:23:32 yx kernel: [ 1176.170065] watchdog: BUG: soft lockup -
CPU#3 stuck for 22s! [rt_cansend:1835]
Jul  3 10:23:32 yx kernel: [ 1176.170075] Modules linked in: bnep
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
nls_iso8859_1 snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi intel_rapl
intel_soc_dts_thermal intel_soc_dts_iosf intel_powerclamp coretemp
kvm_intel snd_seq punit_atom_debug crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel snd_seq_device cryptd intel_cstate snd_timer
hci_uart snd lpc_ich advcan(OE) mei_txe btqca soundcore mei btbcm
btintel bluetooth ecdh_generic rfkill_gpio pwm_lpss_platform mac_hid
pwm_lpss parport_pc ppdev lp parport autofs4 i915 kvmgt vfio_mdev mdev
vfio_iommu_type1 vfio kvm irqbypass drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops igb drm dca ahci i2c_algo_bit
libahci video i2c_hid hid
Jul  3 10:23:32 yx kernel: [ 1176.170221] CPU: 3 PID: 1835 Comm:
rt_cansend Tainted: G           OEL    4.19.84-bros-slove-alc-failure
#1
Jul  3 10:23:32 yx kernel: [ 1176.170226] I-pipe domain: Linux
Jul  3 10:23:32 yx kernel: [ 1176.170236] RIP:
0010:queued_spin_lock_slowpath+0x13f/0x1a0
Jul  3 10:23:32 yx kernel: [ 1176.170242] Code: 6b ff ff ff eb e4 ba
00 01 00 00 8b 07 30 e4 09 d0 a9 00 01 ff ff 0f 85 fe fe ff ff 85 c0
74 0e 8b 07 84 c0 74 08 f3 90 8b 07 <84> c0 75 f8 b8 01 00 00 00 66 89
07 5d c3 f3 90 48 8b 32 48 85 f6
Jul  3 10:23:32 yx kernel: [ 1176.170245] RSP: 0018:ffffbe6f4c16bd08
EFLAGS: 00000202 ORIG_RAX: 00000000ffffff13
Jul  3 10:23:32 yx kernel: [ 1176.170250] RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000000000
Jul  3 10:23:32 yx kernel: [ 1176.170252] RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000000000000
Jul  3 10:23:32 yx kernel: [ 1176.170255] RBP: ffffbe6f4c16bd08 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:23:32 yx kernel: [ 1176.170257] R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000000
Jul  3 10:23:32 yx kernel: [ 1176.170259] R13: 0000000000000000 R14:
0000000000000000 R15: 0000000000000000
Jul  3 10:23:32 yx kernel: [ 1176.170263] FS:  00007ff045526940(0000)
GS:ffff96003bb80000(0000) knlGS:0000000000000000
Jul  3 10:23:32 yx kernel: [ 1176.170266] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jul  3 10:23:32 yx kernel: [ 1176.170268] CR2: 000000c8203a5000 CR3:
00000000ab0fe000 CR4: 00000000001006e0
Jul  3 10:23:32 yx kernel: [ 1176.170271] Call Trace:
Jul  3 10:23:32 yx kernel: [ 1176.170282]  _raw_spin_lock+0x20/0x30
Jul  3 10:23:32 yx kernel: [ 1176.170292]  can_write+0x6c/0x2c0 [advcan]
Jul  3 10:23:32 yx kernel: [ 1176.170298]  ? dequeue_signal+0xae/0x1a0
Jul  3 10:23:32 yx kernel: [ 1176.170303]  ? recalc_sigpending+0x1b/0x50
Jul  3 10:23:32 yx kernel: [ 1176.170308]  ? __set_task_blocked+0x3c/0xa0
Jul  3 10:23:32 yx kernel: [ 1176.170315]  __vfs_write+0x3a/0x190
Jul  3 10:23:32 yx kernel: [ 1176.170321]  ? apparmor_file_permission+0x1a/0x20
Jul  3 10:23:32 yx kernel: [ 1176.170325]  ? security_file_permission+0x3b/0xc0
Jul  3 10:23:32 yx kernel: [ 1176.170330]  vfs_write+0xb8/0x1b0
Jul  3 10:23:32 yx kernel: [ 1176.170335]  ksys_write+0x5c/0xe0
Jul  3 10:23:32 yx kernel: [ 1176.170339]  __x64_sys_write+0x1a/0x20
Jul  3 10:23:32 yx kernel: [ 1176.170345]  do_syscall_64+0x87/0x250
Jul  3 10:23:32 yx kernel: [ 1176.170349]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul  3 10:23:32 yx kernel: [ 1176.170354] RIP: 0033:0x7ff04885d4bd
Jul  3 10:23:32 yx kernel: [ 1176.170358] Code: bf 20 00 00 75 10 b8
01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff
ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff
ff 48 89 d0 48 83 c4 08 48 3d 01
Jul  3 10:23:32 yx kernel: [ 1176.170361] RSP: 002b:00007ff045525530
EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Jul  3 10:23:32 yx kernel: [ 1176.170366] RAX: ffffffffffffffda RBX:
000000000000ffdc RCX: 00007ff04885d4bd
Jul  3 10:23:32 yx kernel: [ 1176.170368] RDX: 0000000000000001 RSI:
00007ff045525580 RDI: 000000000000000e
Jul  3 10:23:32 yx kernel: [ 1176.170371] RBP: 00007ff045525670 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:23:32 yx kernel: [ 1176.170373] R10: 00007ff030000078 R11:
0000000000000246 R12: 00007ff045526878
Jul  3 10:23:32 yx kernel: [ 1176.170379] R13: 00007ff045525be0 R14:
000000000000001c R15: 0000000000000007
Jul  3 10:23:59 yx kernel: [ 1204.166060] watchdog: BUG: soft lockup -
CPU#0 stuck for 22s! [rt_cansend:1837]
Jul  3 10:23:59 yx kernel: [ 1204.166067] Modules linked in: bnep
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
nls_iso8859_1 snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi intel_rapl
intel_soc_dts_thermal intel_soc_dts_iosf intel_powerclamp coretemp
kvm_intel snd_seq punit_atom_debug crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel snd_seq_device cryptd intel_cstate snd_timer
hci_uart snd lpc_ich advcan(OE) mei_txe btqca soundcore mei btbcm
btintel bluetooth ecdh_generic rfkill_gpio pwm_lpss_platform mac_hid
pwm_lpss parport_pc ppdev lp parport autofs4 i915 kvmgt vfio_mdev mdev
vfio_iommu_type1 vfio kvm irqbypass drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops igb drm dca ahci i2c_algo_bit
libahci video i2c_hid hid
Jul  3 10:23:59 yx kernel: [ 1204.166207] CPU: 0 PID: 1837 Comm:
rt_cansend Tainted: G           OEL    4.19.84-bros-slove-alc-failure
#1
Jul  3 10:23:59 yx kernel: [ 1204.166212] I-pipe domain: Linux
Jul  3 10:23:59 yx kernel: [ 1204.166221] RIP:
0010:queued_spin_lock_slowpath+0xd9/0x1a0
Jul  3 10:23:59 yx kernel: [ 1204.166226] Code: 48 03 34 c5 00 67 37
91 48 89 16 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 32
48 85 f6 74 07 0f 0d 0e eb 02 f3 90 <8b> 07 66 85 c0 75 f7 41 89 c0 66
45 31 c0 41 39 c8 0f 84 96 00 00
Jul  3 10:23:59 yx kernel: [ 1204.166228] RSP: 0018:ffffbe6f4c17bd08
EFLAGS: 00000202 ORIG_RAX: 00000000ffffff13
Jul  3 10:23:59 yx kernel: [ 1204.166233] RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000000000
Jul  3 10:23:59 yx kernel: [ 1204.166236] RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000000000000
Jul  3 10:23:59 yx kernel: [ 1204.166238] RBP: ffffbe6f4c17bd08 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:23:59 yx kernel: [ 1204.166240] R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000000
Jul  3 10:23:59 yx kernel: [ 1204.166243] R13: 0000000000000000 R14:
0000000000000000 R15: 0000000000000000
Jul  3 10:23:59 yx kernel: [ 1204.166246] FS:  00007ff04533c940(0000)
GS:ffff96003ba00000(0000) knlGS:0000000000000000
Jul  3 10:23:59 yx kernel: [ 1204.166249] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jul  3 10:23:59 yx kernel: [ 1204.166251] CR2: 00007f799c003000 CR3:
00000000ab0fe000 CR4: 00000000001006f0
Jul  3 10:23:59 yx kernel: [ 1204.166253] Call Trace:
Jul  3 10:23:59 yx kernel: [ 1204.166263]  _raw_spin_lock+0x20/0x30
Jul  3 10:23:59 yx kernel: [ 1204.166272]  can_write+0x6c/0x2c0 [advcan]
Jul  3 10:23:59 yx kernel: [ 1204.166277]  ? dequeue_signal+0xae/0x1a0
Jul  3 10:23:59 yx kernel: [ 1204.166283]  ? recalc_sigpending+0x1b/0x50
Jul  3 10:23:59 yx kernel: [ 1204.166287]  ? __set_task_blocked+0x3c/0xa0
Jul  3 10:23:59 yx kernel: [ 1204.166293]  __vfs_write+0x3a/0x190
Jul  3 10:23:59 yx kernel: [ 1204.166299]  ? apparmor_file_permission+0x1a/0x20
Jul  3 10:23:59 yx kernel: [ 1204.166303]  ? security_file_permission+0x3b/0xc0
Jul  3 10:23:59 yx kernel: [ 1204.166308]  vfs_write+0xb8/0x1b0
Jul  3 10:23:59 yx kernel: [ 1204.166313]  ksys_write+0x5c/0xe0
Jul  3 10:23:59 yx kernel: [ 1204.166318]  __x64_sys_write+0x1a/0x20
Jul  3 10:23:59 yx kernel: [ 1204.166322]  do_syscall_64+0x87/0x250
Jul  3 10:23:59 yx kernel: [ 1204.166327]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul  3 10:23:59 yx kernel: [ 1204.166331] RIP: 0033:0x7ff04885d4bd
Jul  3 10:23:59 yx kernel: [ 1204.166335] Code: bf 20 00 00 75 10 b8
01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff
ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff
ff 48 89 d0 48 83 c4 08 48 3d 01
Jul  3 10:23:59 yx kernel: [ 1204.166338] RSP: 002b:00007ff04533ba70
EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Jul  3 10:23:59 yx kernel: [ 1204.166343] RAX: ffffffffffffffda RBX:
000000000153ca00 RCX: 00007ff04885d4bd
Jul  3 10:23:59 yx kernel: [ 1204.166345] RDX: 0000000000000001 RSI:
00007ff04533bac0 RDI: 000000000000000e
Jul  3 10:23:59 yx kernel: [ 1204.166347] RBP: 00007ff04533bbb0 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:23:59 yx kernel: [ 1204.166350] R10: 0000000000000000 R11:
0000000000000246 R12: 00007ff0491783e0
Jul  3 10:23:59 yx kernel: [ 1204.166352] R13: 00007ffc5d6b9b1f R14:
00007ff04533cc00 R15: 00000000004041b0
Jul  3 10:24:00 yx kernel: [ 1204.170062] watchdog: BUG: soft lockup -
CPU#3 stuck for 22s! [rt_cansend:1835]
Jul  3 10:24:00 yx kernel: [ 1204.170070] Modules linked in: bnep
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
nls_iso8859_1 snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi intel_rapl
intel_soc_dts_thermal intel_soc_dts_iosf intel_powerclamp coretemp
kvm_intel snd_seq punit_atom_debug crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel snd_seq_device cryptd intel_cstate snd_timer
hci_uart snd lpc_ich advcan(OE) mei_txe btqca soundcore mei btbcm
btintel bluetooth ecdh_generic rfkill_gpio pwm_lpss_platform mac_hid
pwm_lpss parport_pc ppdev lp parport autofs4 i915 kvmgt vfio_mdev mdev
vfio_iommu_type1 vfio kvm irqbypass drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops igb drm dca ahci i2c_algo_bit
libahci video i2c_hid hid
Jul  3 10:24:00 yx kernel: [ 1204.170209] CPU: 3 PID: 1835 Comm:
rt_cansend Tainted: G           OEL    4.19.84-bros-slove-alc-failure
#1
Jul  3 10:24:00 yx kernel: [ 1204.170214] I-pipe domain: Linux
Jul  3 10:24:00 yx kernel: [ 1204.170223] RIP:
0010:queued_spin_lock_slowpath+0x13f/0x1a0
Jul  3 10:24:00 yx kernel: [ 1204.170228] Code: 6b ff ff ff eb e4 ba
00 01 00 00 8b 07 30 e4 09 d0 a9 00 01 ff ff 0f 85 fe fe ff ff 85 c0
74 0e 8b 07 84 c0 74 08 f3 90 8b 07 <84> c0 75 f8 b8 01 00 00 00 66 89
07 5d c3 f3 90 48 8b 32 48 85 f6
Jul  3 10:24:00 yx kernel: [ 1204.170231] RSP: 0018:ffffbe6f4c16bd08
EFLAGS: 00000202 ORIG_RAX: 00000000ffffff13
Jul  3 10:24:00 yx kernel: [ 1204.170236] RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000000000
Jul  3 10:24:00 yx kernel: [ 1204.170238] RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000000000000
Jul  3 10:24:00 yx kernel: [ 1204.170241] RBP: ffffbe6f4c16bd08 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:24:00 yx kernel: [ 1204.170243] R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000000
Jul  3 10:24:00 yx kernel: [ 1204.170245] R13: 0000000000000000 R14:
0000000000000000 R15: 0000000000000000
Jul  3 10:24:00 yx kernel: [ 1204.170249] FS:  00007ff045526940(0000)
GS:ffff96003bb80000(0000) knlGS:0000000000000000
Jul  3 10:24:00 yx kernel: [ 1204.170251] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jul  3 10:24:00 yx kernel: [ 1204.170254] CR2: 000000c8203a5000 CR3:
00000000ab0fe000 CR4: 00000000001006e0
Jul  3 10:24:00 yx kernel: [ 1204.170256] Call Trace:
Jul  3 10:24:00 yx kernel: [ 1204.170265]  _raw_spin_lock+0x20/0x30
Jul  3 10:24:00 yx kernel: [ 1204.170274]  can_write+0x6c/0x2c0 [advcan]
Jul  3 10:24:00 yx kernel: [ 1204.170280]  ? dequeue_signal+0xae/0x1a0
Jul  3 10:24:00 yx kernel: [ 1204.170285]  ? recalc_sigpending+0x1b/0x50
Jul  3 10:24:00 yx kernel: [ 1204.170290]  ? __set_task_blocked+0x3c/0xa0
Jul  3 10:24:00 yx kernel: [ 1204.170296]  __vfs_write+0x3a/0x190
Jul  3 10:24:00 yx kernel: [ 1204.170302]  ? apparmor_file_permission+0x1a/0x20
Jul  3 10:24:00 yx kernel: [ 1204.170306]  ? security_file_permission+0x3b/0xc0
Jul  3 10:24:00 yx kernel: [ 1204.170311]  vfs_write+0xb8/0x1b0
Jul  3 10:24:00 yx kernel: [ 1204.170316]  ksys_write+0x5c/0xe0
Jul  3 10:24:00 yx kernel: [ 1204.170320]  __x64_sys_write+0x1a/0x20
Jul  3 10:24:00 yx kernel: [ 1204.170325]  do_syscall_64+0x87/0x250
Jul  3 10:24:00 yx kernel: [ 1204.170330]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul  3 10:24:00 yx kernel: [ 1204.170334] RIP: 0033:0x7ff04885d4bd
Jul  3 10:24:00 yx kernel: [ 1204.170338] Code: bf 20 00 00 75 10 b8
01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff
ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff
ff 48 89 d0 48 83 c4 08 48 3d 01
Jul  3 10:24:00 yx kernel: [ 1204.170341] RSP: 002b:00007ff045525530
EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Jul  3 10:24:00 yx kernel: [ 1204.170346] RAX: ffffffffffffffda RBX:
000000000000ffdc RCX: 00007ff04885d4bd
Jul  3 10:24:00 yx kernel: [ 1204.170348] RDX: 0000000000000001 RSI:
00007ff045525580 RDI: 000000000000000e
Jul  3 10:24:00 yx kernel: [ 1204.170350] RBP: 00007ff045525670 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:24:00 yx kernel: [ 1204.170353] R10: 00007ff030000078 R11:
0000000000000246 R12: 00007ff045526878
Jul  3 10:24:00 yx kernel: [ 1204.170355] R13: 00007ff045525be0 R14:
000000000000001c R15: 0000000000000007
Jul  3 10:24:08 yx kernel: [ 1212.410060] rcu: INFO: rcu_sched
self-detected stall on CPU
Jul  3 10:24:08 yx kernel: [ 1212.410075] rcu: 0-....: (14999 ticks
this GP) idle=8de/1/0x4000000000000002 softirq=15317/15317 fqs=7496
Jul  3 10:24:08 yx kernel: [ 1212.410079] rcu: (t=15000 jiffies g=17909 q=591)
Jul  3 10:24:08 yx kernel: [ 1212.410087] NMI backtrace for cpu 0
Jul  3 10:24:08 yx kernel: [ 1212.410092] CPU: 0 PID: 1837 Comm:
rt_cansend Tainted: G           OEL    4.19.84-bros-slove-alc-failure
#1
Jul  3 10:24:08 yx kernel: [ 1212.410096] I-pipe domain: Linux
Jul  3 10:24:08 yx kernel: [ 1212.410099] Call Trace:
Jul  3 10:24:08 yx kernel: [ 1212.410103]  <IRQ>
Jul  3 10:24:08 yx kernel: [ 1212.410113]  dump_stack+0x9e/0xc8
Jul  3 10:24:08 yx kernel: [ 1212.410118]  nmi_cpu_backtrace+0x95/0xa0
Jul  3 10:24:08 yx kernel: [ 1212.410123]  ? lapic_can_unplug_cpu+0xb0/0xb0
Jul  3 10:24:08 yx kernel: [ 1212.410128]
nmi_trigger_cpumask_backtrace+0x90/0xd0
Jul  3 10:24:08 yx kernel: [ 1212.410132]
arch_trigger_cpumask_backtrace+0x19/0x20
Jul  3 10:24:08 yx kernel: [ 1212.410137]  rcu_dump_cpu_stacks+0x94/0xc8
Jul  3 10:24:08 yx kernel: [ 1212.410141]  rcu_check_callbacks+0x707/0x870
Jul  3 10:24:08 yx kernel: [ 1212.410148]  ? tick_sched_do_timer+0x60/0x60
Jul  3 10:24:08 yx kernel: [ 1212.410152]  update_process_times+0x3d/0x70
Jul  3 10:24:08 yx kernel: [ 1212.410157]  tick_sched_handle+0x29/0x60
Jul  3 10:24:08 yx kernel: [ 1212.410161]  tick_sched_timer+0x3c/0x80
Jul  3 10:24:08 yx kernel: [ 1212.410166]  __hrtimer_run_queues+0x106/0x270
Jul  3 10:24:08 yx kernel: [ 1212.410171]  hrtimer_interrupt+0x116/0x240
Jul  3 10:24:08 yx kernel: [ 1212.410177]  smp_apic_timer_interrupt+0x59/0x130
Jul  3 10:24:08 yx kernel: [ 1212.410182]  ?
smp_call_function_single_interrupt+0xd0/0xd0
Jul  3 10:24:08 yx kernel: [ 1212.410186]  __ipipe_do_IRQ+0x31/0x40
Jul  3 10:24:08 yx kernel: [ 1212.410192]  __ipipe_do_sync_stage+0x173/0x180
Jul  3 10:24:08 yx kernel: [ 1212.410196]  __ipipe_do_sync_pipeline+0x9b/0xa0
Jul  3 10:24:08 yx kernel: [ 1212.410201]  dispatch_irq_head+0xe6/0x110
Jul  3 10:24:08 yx kernel: [ 1212.410205]  __ipipe_dispatch_irq+0xd9/0x1c0
Jul  3 10:24:08 yx kernel: [ 1212.410210]  __ipipe_handle_irq+0x86/0x1e0
Jul  3 10:24:08 yx kernel: [ 1212.410215]  apic_timer_interrupt+0x12/0x40
Jul  3 10:24:08 yx kernel: [ 1212.410218]  </IRQ>
Jul  3 10:24:08 yx kernel: [ 1212.410223] RIP:
0010:queued_spin_lock_slowpath+0xd9/0x1a0
Jul  3 10:24:08 yx kernel: [ 1212.410228] Code: 48 03 34 c5 00 67 37
91 48 89 16 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 32
48 85 f6 74 07 0f 0d 0e eb 02 f3 90 <8b> 07 66 85 c0 75 f7 41 89 c0 66
45 31 c0 41 39 c8 0f 84 96 00 00
Jul  3 10:24:08 yx kernel: [ 1212.410231] RSP: 0018:ffffbe6f4c17bd08
EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
Jul  3 10:24:08 yx kernel: [ 1212.410236] RAX: 0000000000040101 RBX:
0000000000000001 RCX: 0000000000040000
Jul  3 10:24:08 yx kernel: [ 1212.410238] RDX: ffff96003ba350c0 RSI:
0000000000000000 RDI: ffffffffc069cc20
Jul  3 10:24:08 yx kernel: [ 1212.410241] RBP: ffffbe6f4c17bd08 R08:
00007ff04533bac1 R09: ffff96001e06ac68
Jul  3 10:24:08 yx kernel: [ 1212.410243] R10: ffff95ff34a27f38 R11:
0000000000000000 R12: 0000000000000000
Jul  3 10:24:08 yx kernel: [ 1212.410246] R13: 00007ff04533bac0 R14:
ffff95ff34a27f00 R15: 00007ff04533bac0
Jul  3 10:24:08 yx kernel: [ 1212.410255]  _raw_spin_lock+0x20/0x30
Jul  3 10:24:08 yx kernel: [ 1212.410262]  can_write+0x6c/0x2c0 [advcan]
Jul  3 10:24:08 yx kernel: [ 1212.410267]  ? dequeue_signal+0xae/0x1a0
Jul  3 10:24:08 yx kernel: [ 1212.410273]  ? recalc_sigpending+0x1b/0x50
Jul  3 10:24:08 yx kernel: [ 1212.410277]  ? __set_task_blocked+0x3c/0xa0
Jul  3 10:24:08 yx kernel: [ 1212.410283]  __vfs_write+0x3a/0x190
Jul  3 10:24:08 yx kernel: [ 1212.410289]  ? apparmor_file_permission+0x1a/0x20
Jul  3 10:24:08 yx kernel: [ 1212.410293]  ? security_file_permission+0x3b/0xc0
Jul  3 10:24:08 yx kernel: [ 1212.410298]  vfs_write+0xb8/0x1b0
Jul  3 10:24:08 yx kernel: [ 1212.410302]  ksys_write+0x5c/0xe0
Jul  3 10:24:08 yx kernel: [ 1212.410307]  __x64_sys_write+0x1a/0x20
Jul  3 10:24:08 yx kernel: [ 1212.410312]  do_syscall_64+0x87/0x250
Jul  3 10:24:08 yx kernel: [ 1212.410317]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul  3 10:24:08 yx kernel: [ 1212.410321] RIP: 0033:0x7ff04885d4bd
Jul  3 10:24:08 yx kernel: [ 1212.410325] Code: bf 20 00 00 75 10 b8
01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff
ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff
ff 48 89 d0 48 83 c4 08 48 3d 01
Jul  3 10:24:08 yx kernel: [ 1212.410327] RSP: 002b:00007ff04533ba70
EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Jul  3 10:24:08 yx kernel: [ 1212.410332] RAX: ffffffffffffffda RBX:
000000000153ca00 RCX: 00007ff04885d4bd
Jul  3 10:24:08 yx kernel: [ 1212.410334] RDX: 0000000000000001 RSI:
00007ff04533bac0 RDI: 000000000000000e
Jul  3 10:24:08 yx kernel: [ 1212.410337] RBP: 00007ff04533bbb0 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:24:08 yx kernel: [ 1212.410339] R10: 0000000000000000 R11:
0000000000000246 R12: 00007ff0491783e0
Jul  3 10:24:08 yx kernel: [ 1212.410342] R13: 00007ffc5d6b9b1f R14:
00007ff04533cc00 R15: 00000000004041b0
Jul  3 10:24:08 yx kernel: [ 1212.410351] Sending NMI from CPU 0 to CPUs 3:
Jul  3 10:24:08 yx kernel: [ 1212.414061] NMI backtrace for cpu 3
Jul  3 10:24:08 yx kernel: [ 1212.414064] CPU: 3 PID: 1835 Comm:
rt_cansend Tainted: G           OEL    4.19.84-bros-slove-alc-failure
#1
Jul  3 10:24:08 yx kernel: [ 1212.414068] I-pipe domain: Linux
Jul  3 10:24:08 yx kernel: [ 1212.414070] RIP:
0010:queued_spin_lock_slowpath+0x13f/0x1a0
Jul  3 10:24:08 yx kernel: [ 1212.414073] Code: 6b ff ff ff eb e4 ba
00 01 00 00 8b 07 30 e4 09 d0 a9 00 01 ff ff 0f 85 fe fe ff ff 85 c0
74 0e 8b 07 84 c0 74 08 f3 90 8b 07 <84> c0 75 f8 b8 01 00 00 00 66 89
07 5d c3 f3 90 48 8b 32 48 85 f6
Jul  3 10:24:08 yx kernel: [ 1212.414075] RSP: 0018:ffffbe6f4c16bd08
EFLAGS: 00000202
Jul  3 10:24:08 yx kernel: [ 1212.414078] RAX: 0000000000040101 RBX:
0000000000000001 RCX: ffffbe6f4c16bec8
Jul  3 10:24:08 yx kernel: [ 1212.414080] RDX: 0000000000000000 RSI:
0000000000000000 RDI: ffffffffc069cc20
Jul  3 10:24:08 yx kernel: [ 1212.414082] RBP: ffffbe6f4c16bd08 R08:
00007ff045525581 R09: ffff96001e06ac68
Jul  3 10:24:08 yx kernel: [ 1212.414084] R10: ffff95ff34a27f38 R11:
0000000000000000 R12: 0000000000000000
Jul  3 10:24:08 yx kernel: [ 1212.414086] R13: 00007ff045525580 R14:
ffff95ff34a27f00 R15: 00007ff045525580
Jul  3 10:24:08 yx kernel: [ 1212.414088] FS:  00007ff045526940(0000)
GS:ffff96003bb80000(0000) knlGS:0000000000000000
Jul  3 10:24:08 yx kernel: [ 1212.414090] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jul  3 10:24:08 yx kernel: [ 1212.414092] CR2: 000000c8203a5000 CR3:
00000000ab0fe000 CR4: 00000000001006e0
Jul  3 10:24:08 yx kernel: [ 1212.414093] Call Trace:
Jul  3 10:24:08 yx kernel: [ 1212.414095]  _raw_spin_lock+0x20/0x30
Jul  3 10:24:08 yx kernel: [ 1212.414097]  can_write+0x6c/0x2c0 [advcan]
Jul  3 10:24:08 yx kernel: [ 1212.414099]  ? dequeue_signal+0xae/0x1a0
Jul  3 10:24:08 yx kernel: [ 1212.414100]  ? recalc_sigpending+0x1b/0x50
Jul  3 10:24:08 yx kernel: [ 1212.414102]  ? __set_task_blocked+0x3c/0xa0
Jul  3 10:24:08 yx kernel: [ 1212.414104]  __vfs_write+0x3a/0x190
Jul  3 10:24:08 yx kernel: [ 1212.414106]  ? apparmor_file_permission+0x1a/0x20
Jul  3 10:24:08 yx kernel: [ 1212.414107]  ? security_file_permission+0x3b/0xc0
Jul  3 10:24:08 yx kernel: [ 1212.414109]  vfs_write+0xb8/0x1b0
Jul  3 10:24:08 yx kernel: [ 1212.414111]  ksys_write+0x5c/0xe0
Jul  3 10:24:08 yx kernel: [ 1212.414113]  __x64_sys_write+0x1a/0x20
Jul  3 10:24:08 yx kernel: [ 1212.414114]  do_syscall_64+0x87/0x250
Jul  3 10:24:08 yx kernel: [ 1212.414116]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul  3 10:24:08 yx kernel: [ 1212.414118] RIP: 0033:0x7ff04885d4bd
Jul  3 10:24:08 yx kernel: [ 1212.414120] Code: bf 20 00 00 75 10 b8
01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff
ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff
ff 48 89 d0 48 83 c4 08 48 3d 01
Jul  3 10:24:08 yx kernel: [ 1212.414122] RSP: 002b:00007ff045525530
EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Jul  3 10:24:08 yx kernel: [ 1212.414126] RAX: ffffffffffffffda RBX:
000000000000ffdc RCX: 00007ff04885d4bd
Jul  3 10:24:08 yx kernel: [ 1212.414128] RDX: 0000000000000001 RSI:
00007ff045525580 RDI: 000000000000000e
Jul  3 10:24:08 yx kernel: [ 1212.414130] RBP: 00007ff045525670 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:24:08 yx kernel: [ 1212.414132] R10: 00007ff030000078 R11:
0000000000000246 R12: 00007ff045526878
Jul  3 10:24:08 yx kernel: [ 1212.414134] R13: 00007ff045525be0 R14:
000000000000001c R15: 0000000000000007
Jul  3 10:24:35 yx kernel: [ 1240.166063] watchdog: BUG: soft lockup -
CPU#0 stuck for 22s! [rt_cansend:1837]
Jul  3 10:24:35 yx kernel: [ 1240.166071] Modules linked in: bnep
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
nls_iso8859_1 snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi intel_rapl
intel_soc_dts_thermal intel_soc_dts_iosf intel_powerclamp coretemp
kvm_intel snd_seq punit_atom_debug crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel snd_seq_device cryptd intel_cstate snd_timer
hci_uart snd lpc_ich advcan(OE) mei_txe btqca soundcore mei btbcm
btintel bluetooth ecdh_generic rfkill_gpio pwm_lpss_platform mac_hid
pwm_lpss parport_pc ppdev lp parport autofs4 i915 kvmgt vfio_mdev mdev
vfio_iommu_type1 vfio kvm irqbypass drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops igb drm dca ahci i2c_algo_bit
libahci video i2c_hid hid
Jul  3 10:24:35 yx kernel: [ 1240.166211] CPU: 0 PID: 1837 Comm:
rt_cansend Tainted: G           OEL    4.19.84-bros-slove-alc-failure
#1
Jul  3 10:24:35 yx kernel: [ 1240.166215] I-pipe domain: Linux
Jul  3 10:24:35 yx kernel: [ 1240.166224] RIP:
0010:queued_spin_lock_slowpath+0xd9/0x1a0
Jul  3 10:24:35 yx kernel: [ 1240.166229] Code: 48 03 34 c5 00 67 37
91 48 89 16 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 32
48 85 f6 74 07 0f 0d 0e eb 02 f3 90 <8b> 07 66 85 c0 75 f7 41 89 c0 66
45 31 c0 41 39 c8 0f 84 96 00 00
Jul  3 10:24:35 yx kernel: [ 1240.166232] RSP: 0018:ffffbe6f4c17bd08
EFLAGS: 00000202 ORIG_RAX: 00000000ffffff13
Jul  3 10:24:35 yx kernel: [ 1240.166237] RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000000000
Jul  3 10:24:35 yx kernel: [ 1240.166239] RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000000000000
Jul  3 10:24:35 yx kernel: [ 1240.166242] RBP: ffffbe6f4c17bd08 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:24:35 yx kernel: [ 1240.166244] R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000000
Jul  3 10:24:35 yx kernel: [ 1240.166246] R13: 0000000000000000 R14:
0000000000000000 R15: 0000000000000000
Jul  3 10:24:35 yx kernel: [ 1240.166250] FS:  00007ff04533c940(0000)
GS:ffff96003ba00000(0000) knlGS:0000000000000000
Jul  3 10:24:35 yx kernel: [ 1240.166252] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jul  3 10:24:35 yx kernel: [ 1240.166255] CR2: 00007f799c003000 CR3:
00000000ab0fe000 CR4: 00000000001006f0
Jul  3 10:24:35 yx kernel: [ 1240.166257] Call Trace:
Jul  3 10:24:35 yx kernel: [ 1240.166266]  _raw_spin_lock+0x20/0x30
Jul  3 10:24:35 yx kernel: [ 1240.166275]  can_write+0x6c/0x2c0 [advcan]
Jul  3 10:24:35 yx kernel: [ 1240.166281]  ? dequeue_signal+0xae/0x1a0
Jul  3 10:24:35 yx kernel: [ 1240.166286]  ? recalc_sigpending+0x1b/0x50
Jul  3 10:24:35 yx kernel: [ 1240.166291]  ? __set_task_blocked+0x3c/0xa0
Jul  3 10:24:35 yx kernel: [ 1240.166297]  __vfs_write+0x3a/0x190
Jul  3 10:24:35 yx kernel: [ 1240.166303]  ? apparmor_file_permission+0x1a/0x20
Jul  3 10:24:35 yx kernel: [ 1240.166307]  ? security_file_permission+0x3b/0xc0
Jul  3 10:24:35 yx kernel: [ 1240.166312]  vfs_write+0xb8/0x1b0
Jul  3 10:24:35 yx kernel: [ 1240.166316]  ksys_write+0x5c/0xe0
Jul  3 10:24:35 yx kernel: [ 1240.166321]  __x64_sys_write+0x1a/0x20
Jul  3 10:24:35 yx kernel: [ 1240.166326]  do_syscall_64+0x87/0x250
Jul  3 10:24:35 yx kernel: [ 1240.166331]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul  3 10:24:35 yx kernel: [ 1240.166335] RIP: 0033:0x7ff04885d4bd
Jul  3 10:24:35 yx kernel: [ 1240.166339] Code: bf 20 00 00 75 10 b8
01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff
ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff
ff 48 89 d0 48 83 c4 08 48 3d 01
Jul  3 10:24:35 yx kernel: [ 1240.166342] RSP: 002b:00007ff04533ba70
EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Jul  3 10:24:35 yx kernel: [ 1240.166346] RAX: ffffffffffffffda RBX:
000000000153ca00 RCX: 00007ff04885d4bd
Jul  3 10:24:35 yx kernel: [ 1240.166349] RDX: 0000000000000001 RSI:
00007ff04533bac0 RDI: 000000000000000e
Jul  3 10:24:35 yx kernel: [ 1240.166351] RBP: 00007ff04533bbb0 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:24:35 yx kernel: [ 1240.166354] R10: 0000000000000000 R11:
0000000000000246 R12: 00007ff0491783e0
Jul  3 10:24:35 yx kernel: [ 1240.166356] R13: 00007ffc5d6b9b1f R14:
00007ff04533cc00 R15: 00000000004041b0
Jul  3 10:24:36 yx kernel: [ 1240.170065] watchdog: BUG: soft lockup -
CPU#3 stuck for 22s! [rt_cansend:1835]
Jul  3 10:24:36 yx kernel: [ 1240.170073] Modules linked in: bnep
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
nls_iso8859_1 snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi intel_rapl
intel_soc_dts_thermal intel_soc_dts_iosf intel_powerclamp coretemp
kvm_intel snd_seq punit_atom_debug crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel snd_seq_device cryptd intel_cstate snd_timer
hci_uart snd lpc_ich advcan(OE) mei_txe btqca soundcore mei btbcm
btintel bluetooth ecdh_generic rfkill_gpio pwm_lpss_platform mac_hid
pwm_lpss parport_pc ppdev lp parport autofs4 i915 kvmgt vfio_mdev mdev
vfio_iommu_type1 vfio kvm irqbypass drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops igb drm dca ahci i2c_algo_bit
libahci video i2c_hid hid
Jul  3 10:24:36 yx kernel: [ 1240.170212] CPU: 3 PID: 1835 Comm:
rt_cansend Tainted: G           OEL    4.19.84-bros-slove-alc-failure
#1
Jul  3 10:24:36 yx kernel: [ 1240.170218] I-pipe domain: Linux
Jul  3 10:24:36 yx kernel: [ 1240.170226] RIP:
0010:queued_spin_lock_slowpath+0x13f/0x1a0
Jul  3 10:24:36 yx kernel: [ 1240.170231] Code: 6b ff ff ff eb e4 ba
00 01 00 00 8b 07 30 e4 09 d0 a9 00 01 ff ff 0f 85 fe fe ff ff 85 c0
74 0e 8b 07 84 c0 74 08 f3 90 8b 07 <84> c0 75 f8 b8 01 00 00 00 66 89
07 5d c3 f3 90 48 8b 32 48 85 f6
Jul  3 10:24:36 yx kernel: [ 1240.170234] RSP: 0018:ffffbe6f4c16bd08
EFLAGS: 00000202 ORIG_RAX: 00000000ffffff13
Jul  3 10:24:36 yx kernel: [ 1240.170239] RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000000000
Jul  3 10:24:36 yx kernel: [ 1240.170241] RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000000000000
Jul  3 10:24:36 yx kernel: [ 1240.170243] RBP: ffffbe6f4c16bd08 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:24:36 yx kernel: [ 1240.170246] R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000000
Jul  3 10:24:36 yx kernel: [ 1240.170248] R13: 0000000000000000 R14:
0000000000000000 R15: 0000000000000000
Jul  3 10:24:36 yx kernel: [ 1240.170251] FS:  00007ff045526940(0000)
GS:ffff96003bb80000(0000) knlGS:0000000000000000
Jul  3 10:24:36 yx kernel: [ 1240.170254] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Jul  3 10:24:36 yx kernel: [ 1240.170257] CR2: 000000c8203a5000 CR3:
00000000ab0fe000 CR4: 00000000001006e0
Jul  3 10:24:36 yx kernel: [ 1240.170259] Call Trace:
Jul  3 10:24:36 yx kernel: [ 1240.170268]  _raw_spin_lock+0x20/0x30
Jul  3 10:24:36 yx kernel: [ 1240.170276]  can_write+0x6c/0x2c0 [advcan]
Jul  3 10:24:36 yx kernel: [ 1240.170282]  ? dequeue_signal+0xae/0x1a0
Jul  3 10:24:36 yx kernel: [ 1240.170288]  ? recalc_sigpending+0x1b/0x50
Jul  3 10:24:36 yx kernel: [ 1240.170292]  ? __set_task_blocked+0x3c/0xa0
Jul  3 10:24:36 yx kernel: [ 1240.170298]  __vfs_write+0x3a/0x190
Jul  3 10:24:36 yx kernel: [ 1240.170304]  ? apparmor_file_permission+0x1a/0x20
Jul  3 10:24:36 yx kernel: [ 1240.170309]  ? security_file_permission+0x3b/0xc0
Jul  3 10:24:36 yx kernel: [ 1240.170313]  vfs_write+0xb8/0x1b0
Jul  3 10:24:36 yx kernel: [ 1240.170318]  ksys_write+0x5c/0xe0
Jul  3 10:24:36 yx kernel: [ 1240.170323]  __x64_sys_write+0x1a/0x20
Jul  3 10:24:36 yx kernel: [ 1240.170327]  do_syscall_64+0x87/0x250
Jul  3 10:24:36 yx kernel: [ 1240.170332]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul  3 10:24:36 yx kernel: [ 1240.170336] RIP: 0033:0x7ff04885d4bd
Jul  3 10:24:36 yx kernel: [ 1240.170340] Code: bf 20 00 00 75 10 b8
01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff
ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff
ff 48 89 d0 48 83 c4 08 48 3d 01
Jul  3 10:24:36 yx kernel: [ 1240.170343] RSP: 002b:00007ff045525530
EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Jul  3 10:24:36 yx kernel: [ 1240.170347] RAX: ffffffffffffffda RBX:
000000000000ffdc RCX: 00007ff04885d4bd
Jul  3 10:24:36 yx kernel: [ 1240.170350] RDX: 0000000000000001 RSI:
00007ff045525580 RDI: 000000000000000e
Jul  3 10:24:36 yx kernel: [ 1240.170352] RBP: 00007ff045525670 R08:
0000000000000000 R09: 0000000000000000
Jul  3 10:24:36 yx kernel: [ 1240.170355] R10: 00007ff030000078 R11:
0000000000000246 R12: 00007ff045526878
Jul  3 10:24:36 yx kernel: [ 1240.170357] R13: 00007ff045525be0 R14:
000000000000001c R15: 0000000000000007

