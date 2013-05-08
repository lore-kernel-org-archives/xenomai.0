MIME-Version: 1.0
In-Reply-To: <518ABA3D.5070106@xenomai.org>
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>
	<518A5F0C.50403@xenomai.org>
	<CAPpP=rNt32NFsF5LhJybpcBRfm33za8kP2tQj+t4Vs9-hkH48w@mail.gmail.com>
	<518ABA3D.5070106@xenomai.org>
Date: Wed, 8 May 2013 23:30:04 +0200
Message-ID: <CAPpP=rOQm+GBuoB5KuAiAo5nG=HzggXb7CyLaP-SHAwebykPUw@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Thank you, I'll try to implement it with the messages queue and socket XDDP.
I think it's safer than the older method (ie by creating two thread each
call to select). It worked but an exception happened after a while .

[ 5011.991938] BUG: Unhandled exception over domain Xenomai at 0xc1334a4e -
switching to ROOT
[ 5011.991943] Pid: 30922, comm: RECOR Tainted: G           O 3.5.7-xenomai
#1
[ 5011.991944] Call Trace:
[ 5011.991961]  [<c101dee4>] __ipipe_handle_exception+0x204/0x210
[ 5011.991965]  [<c1334a4e>] ? strncpy+0x1e/0x40
[ 5011.991969]  [<c16134ef>] error_code+0x5f/0x6c
[ 5011.991971]  [<c1334a4e>] ? strncpy+0x1e/0x40
[ 5011.991977]  [<c1164841>] __pthread_set_name_np+0x81/0xb0
[ 5011.992006]  [<c10b6300>] ? __ipipe_post_work_root+0x90/0xe0
[ 5011.992009]  [<c1612ae4>] ? _raw_spin_unlock_irqrestore+0x24/0x50
[ 5011.992013]  [<c110c918>] hisyscall_event+0x178/0x380
[ 5011.992017]  [<c10b751a>] ipipe_syscall_hook+0x3a/0x50
[ 5011.992020]  [<c10b5e0d>] __ipipe_notify_syscall+0x9d/0x100
[ 5011.992023]  [<c101e077>] __ipipe_syscall_root+0x37/0xd0
[ 5011.992027]  [<c1618ef8>] sysenter_past_esp+0x55/0x6c
[ 5011.992031] BUG: unable to handle kernel NULL pointer dereference at
000002f4
[ 5011.992061] IP: [<c1334a4e>] strncpy+0x1e/0x40
[ 5011.992092] *pdpt = 000000001f113001 *pde = 0000000000000000
[ 5011.992114] Oops: 0002 [#1] PREEMPT SMP
[ 5011.992132] Modules linked in: de_pilote(O) pml_pilote(O) rt_e1000e(O)
rt_loopback(O) rtnet(O) nls_iso8859_1 nls_cp437 vfat fat usb_storage
tda1004x saa7134_dvb videobuf_dvb dvb_core saa7134_alsa snd_hda_codec_hdmi
snd_hda_codec_realtek tda827x tda8290 tuner coretemp kvm aesni_intel cryptd
aes_i586 mxm_wmi hid_generic eeepc_wmi asus_wmi sparse_keymap snd_usb_audio
rfcomm snd_hda_intel snd_hda_codec saa7134 bnep serio_raw arc4 bluetooth
snd_pcm microcode snd_hwdep snd_usbmidi_lib snd_seq_midi snd_seq_midi_event
parport_pc ath9k ppdev mac80211 rc_core snd_rawmidi snd_seq videobuf_dma_sg
videobuf_core v4l2_common snd_timer ath9k_common videodev snd_seq_device
tveeprom ath9k_hw ath lpc_ich usbhid hid cfg80211 snd mac_hid radeon ttm
i915 binfmt_misc drm_kms_helper wmi soundcore drm snd_page_alloc mei
i2c_algo_bit video lp parport 8139too 8139cp [last unloaded: de_pilote]
[ 5011.992474]
[ 5011.992481] Pid: 30922, comm: RECOR Tainted: G           O 3.5.7-xenomai
#1 System manufacturer System Product Name/P8Z77-V
[ 5011.992520] EIP: 0060:[<c1334a4e>] EFLAGS: 00210216 CPU: 0
[ 5011.992538] EIP is at strncpy+0x1e/0x40
[ 5011.992551] EAX: 00000273 EBX: 000002f4 ECX: 0000000f EDX: ef5e1efc
[ 5011.992571] ESI: ef5e1efd EDI: 000002f4 EBP: ef5e1ef4 ESP: ef5e1ee8
[ 5011.992591]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[ 5011.992608] CR0: 8005003b CR2: 000002f4 CR3: 1f112000 CR4: 001007f0
[ 5011.992628] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[ 5011.992648] DR6: ffff0ff0 DR7: 00000400
[ 5011.992661] Process RECOR (pid: 30922, ti=ef5e0000 task=ec5b4ce0
task.ti=ef5e0000)
[ 5011.992685] I-pipe domain Linux
[ 5011.992695] Stack:
[ 5011.992702]  f8436800 00000000 00000000 ef5e1f2c c1164841 656c6573
6c5f7463 78756e69
[ 5011.992737]  c10b6300 ef5e1f14 c1612ae4 ef5e1f3c 00064f4c b6c31b40
ec437c00 0000000a
[ 5011.992771]  00000000 ef5e1f60 c110c918 ef5e1fb4 df1359b0 ef5e1f84
ef5e1fb4 00000038
[ 5011.992806] Call Trace:
[ 5011.992817]  [<c1164841>] __pthread_set_name_np+0x81/0xb0
[ 5011.992857]  [<c10b6300>] ? __ipipe_post_work_root+0x90/0xe0
[ 5011.992876]  [<c1612ae4>] ? _raw_spin_unlock_irqrestore+0x24/0x50
[ 5011.992898]  [<c110c918>] hisyscall_event+0x178/0x380
[ 5011.992925]  [<c10b751a>] ipipe_syscall_hook+0x3a/0x50
[ 5011.992968]  [<c10b5e0d>] __ipipe_notify_syscall+0x9d/0x100
[ 5011.992988]  [<c101e077>] __ipipe_syscall_root+0x37/0xd0
[ 5011.993007]  [<c1618ef8>] sysenter_past_esp+0x55/0x6c
[ 5011.993023] Code: 7d fc 89 ec 5d c3 8d b4 26 00 00 00 00 55 89 e5 83 ec
0c 89 5d f4 89 75 f8 89 7d fc 3e 8d 74 26 00 89 c3 89 d6 89 c7 49 78 08 ac
<aa> 84 c0 75 f7 f3 aa 89 d8 8b 75 f8 8b 5d f4 8b 7d fc 89 ec 5d
[ 5011.993183] EIP: [<c1334a4e>] strncpy+0x1e/0x40 SS:ESP 0068:ef5e1ee8
[ 5011.993207] CR2: 00000000000002f4
[ 5011.996438] ---[ end trace 5b267698c8ec1270 ]---


This may be due, as you said, that pthread_create switches to secondary.
