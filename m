Subject: Re: Xenomai-v3.1 Watchdog detected hard lockup
References: <CAAvDm6bRTpGEExXsU_aivN4PPB2z=-FXjrVjTkvegn47AritqQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77d20356-98c9-4f0c-7d7d-3169660759a4@siemens.com>
Date: Wed, 15 Jul 2020 13:52:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6bRTpGEExXsU_aivN4PPB2z=-FXjrVjTkvegn47AritqQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 15.07.20 08:51, 孙世龙 sunshilong via Xenomai wrote:
> Hi, list
> 
> A hard lockup reproducibly occurs on a PC with software
> configuration:
> --ipipe-core-4.19.84-x86-8.patch
> --Xenomai-V3.1
> --kernel 4.19.82
> The patch of Ipipe applied cleanly and there were no build errors.
> 
> The ssh connections are lost and the keyboard doesn't respond when the hard
> lockup occurs.
> 
> I developed a realtime application to receive and send data through
> RT-CAN. And the procedure of sending data is triggered by the Xenomai
> timer every 10ms.
> What surprised me is that the log (
> [Xenomai] watchdog triggered on CPU #1 -- runaway thread
> 'timer-internal' signaled, full log is seen at the footnote) indicates
> that the timer-internal thread, which is created by the Xenomai
> copperplate layer, is killed by the Xenomai watchdog when the lockup
> occurs.

Wild guess from the hips: Could it be that the time is accidentally
programmed to way higher rate, thus firing all the time?

The Xenomai watchdog jumps in when there are Xenomai threads dominating
a CPU core. In theory, the watchdog could it the wrong task, one that is
only triggered from time to time by the one that is actually causing the
endless loop. But generally the situation is simpler and clearer.

In this case, we are talking about a server thread, but its wakeup
frequency is application controlled. So that would be the first thing to
check.

Jan

> Do you think the hard lockup have some direct or indirect relations
> with killing the timer-internal thread?
> 
> If I don't run the said realtime application, no "hard lockup" message
> has been seen no matter how long the platform runs.
> But if the aforementioned application has been started,  the hard lockup
> occurs every half an hour to three hours.
> 
> Could you please shed some light on this problem?
> Any advice on how to proceed?
> 
> Thank you for your attention to this matter.
> 
> Here is the full log:
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713376] NMI watchdog:
> Watchdog detected hard LOCKUP on cpu 0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713380] Modules linked in:
> xeno_can_xilinx(OE) xeno_can(E) xeno_fpga_axi(OE) rfcomm bnep smsc95xx
> usbnet mii snd_soc_skl snd_soc_skl_ipc snd_soc_sst_ipc snd_soc_sst_dsp
> snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi nls_iso8859_1
> snd_soc_core snd_compress ac97_bus 8250_dw snd_hda_codec_hdmi
> snd_pcm_dmaengine snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
> snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi intel_rapl
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_seq
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc snd_seq_device
> snd_timer btusb btrtl btbcm btintel snd bluetooth ecdh_generic
> aesni_intel aes_x86_64 crypto_simd cryptd soundcore glue_helper
> intel_cstate wmi_bmof intel_rapl_perf arc4 iwlmvm mac80211 iwlwifi
> idma64 virt_dma cfg80211 mei_me mei intel_lpss_pci
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713429]  mac_hid
> intel_lpss intel_pch_thermal parport_pc ppdev lp parport autofs4
> mmc_block e1000e ahci libahci sdhci_pci cqhci sdhci i915 kvmgt
> vfio_mdev mdev vfio_iommu_type1 vfio kvm irqbypass video i2c_algo_bit
> drm_kms_helper syscopyarea sysfillrect sysimgblt wmi fb_sys_fops drm
> [last unloaded: xeno_can]
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713460] CPU: 0 PID: 0
> Comm: swapper/0 Tainted: G        W  OE     4.19.84-x86-20200528 #2
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713461] Hardware name:
> Intel(R) Client Systems CM8CCB4R/CM8CCB4R, BIOS
> CBWHL357.0058.2020.0107.1849 01/07/2020
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713462] I-pipe domain: Xenomai
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713462] RIP:
> 0010:load_new_mm_cr3+0x41/0xf0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713463] Code: 1a 01 48 01
> fa 73 25 48 bf 00 00 00 00 00 00 00 80 48 0b 3d 01 20 1d 01 83 c6 01
> 0f b7 f6 48 01 d0 48 09 f7 48 09 c7 0f 22 df <5d> c3 48 c7 c0 00 00 00
> 80 48 2b 05 3f a1 10 01 eb cb 0f 1f 44 00
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713464] RSP:
> 0018:ffff964630c03e08 EFLAGS: 00000082
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713466] RAX:
> 000000016672e000 RBX: ffff9645e2502800 RCX: 00000000000019f2
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713467] RDX:
> ffff9646a672e000 RSI: 0000000000000002 RDI: 800000016672e002
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713468] RBP:
> ffff964630c03e08 R08: ffff964627bebd00 R09: ffff964630c3e4f0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713468] R10:
> ffff964630c03e78 R11: 0000000000000040 R12: ffffffff86288260
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713469] R13:
> 0000000000000001 R14: ffff96462672e960 R15: 0000000000000001
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713470] FS:
> 0000000000000000(0000) GS:ffff964630c00000(0000)
> knlGS:0000000000000000
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713471] CS:  0010 DS: 0000
> ES: 0000 CR0: 0000000080050033
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713472] CR2:
> 00007f1037c6f020 CR3: 000000016672e002 CR4: 00000000003606f0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713472] Call Trace:
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713473]  <IRQ>
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713474]
> switch_mm_irqs_off+0x31b/0x4e0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713475]  xnarch_switch_to+0x2f/0x80
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713476]
> ___xnsched_run.part.74+0x154/0x480
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713476]  ___xnsched_run+0x35/0x50
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713477]
> xnintr_irq_handler+0x346/0x4c0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713478]  ?
> xnintr_core_clock_handler+0x1b6/0x360
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713479]
> dispatch_irq_head+0x8e/0x110
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713479]  ?
> xnintr_irq_handler+0x5/0x4c0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713481]  ?
> dispatch_irq_head+0x8e/0x110
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713482]
> __ipipe_dispatch_irq+0xd9/0x1c0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713483]
> __ipipe_handle_irq+0x86/0x1e0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713483]  common_interrupt+0xf/0x2c
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713484]  </IRQ>
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713485] RIP:
> 0010:timekeeping_max_deferment+0x2b/0x30
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713486] Code: bb d5 8f 00
> 55 48 89 e5 8b 15 11 c0 52 01 f6 c2 01 75 15 48 8b 05 0d c0 52 01 48
> 8b 40 18 39 15 fb bf 52 01 75 e2 5d c3 f3 90 <eb> dc 0f 1f 00 e8 8b d5
> 8f 00 55 48 c7 07 00 00 00 00 48 c7 47 08
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713487] RSP:
> 0018:ffffffff86203dd8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffdc
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713489] RAX:
> 0000000e1cc1b900 RBX: 000042464e21d06b RCX: 0000000000000202
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713489] RDX:
> 0000000000ee83ed RSI: 0000000000000000 RDI: 0000000000000001
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713490] RBP:
> ffffffff86203dd8 R08: 0000000000000246 R09: 000042546ae3896b
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713491] R10:
> 00000000000002ca R11: 0000000000000020 R12: 000042546ae3896b
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713492] R13:
> ffff964630c1c280 R14: 0000000000000000 R15: 0000000000000000
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713493]
> tick_nohz_next_event+0x99/0x180
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713493]
> tick_nohz_idle_stop_tick+0x15c/0x290
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713494]  ? mwait_idle+0x6e/0x1e0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713495]  ?
> tsc_verify_tsc_adjust+0x3b/0xf0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713496]  do_idle+0xa7/0x160
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713497]  cpu_startup_entry+0x73/0x80
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713497]  rest_init+0xa7/0xb0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713498]  start_kernel+0x53f/0x560
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713499]
> x86_64_start_reservations+0x24/0x26
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713500]
> x86_64_start_kernel+0x74/0x77
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713500]
> secondary_startup_64+0xa4/0xb0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713518] NMI watchdog:
> Watchdog detected hard LOCKUP on cpu 1
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713519] Modules linked in:
> xeno_can_xilinx(OE) xeno_can(E) xeno_fpga_axi(OE) rfcomm bnep smsc95xx
> usbnet mii snd_soc_skl snd_soc_skl_ipc snd_soc_sst_ipc snd_soc_sst_dsp
> snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi nls_iso8859_1
> snd_soc_core snd_compress ac97_bus 8250_dw snd_hda_codec_hdmi
> snd_pcm_dmaengine snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
> snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi intel_rapl
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel snd_seq
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc snd_seq_device
> snd_timer btusb btrtl btbcm btintel snd bluetooth ecdh_generic
> aesni_intel aes_x86_64 crypto_simd cryptd soundcore glue_helper
> intel_cstate wmi_bmof intel_rapl_perf arc4 iwlmvm mac80211 iwlwifi
> idma64 virt_dma cfg80211 mei_me mei intel_lpss_pci
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713564]  mac_hid
> intel_lpss intel_pch_thermal parport_pc ppdev lp parport autofs4
> mmc_block e1000e ahci libahci sdhci_pci cqhci sdhci i915 kvmgt
> vfio_mdev mdev vfio_iommu_type1 vfio kvm irqbypass video i2c_algo_bit
> drm_kms_helper syscopyarea sysfillrect sysimgblt wmi fb_sys_fops drm
> [last unloaded: xeno_can]
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713586] CPU: 1 PID: 4631
> Comm: timer-internal Tainted: G        W  OE     4.19.84-x86-20200528
> #2
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713587] Hardware name:
> Intel(R) Client Systems CM8CCB4R/CM8CCB4R, BIOS
> CBWHL357.0058.2020.0107.1849 01/07/2020
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713588] I-pipe domain: Xenomai
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713588] RIP: 0033:0x7ffe88f86adf
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713590] Code: 32 48 29 d0
> 48 23 05 d0 c5 ff ff 8b 15 d2 c5 ff ff 48 0f af c2 e9 d0 fe ff ff 31
> d2 e9 fd fe ff ff f3 90 e9 30 fe ff ff f3 90 <e9> 0f ff ff ff 31 c0 eb
> a3 31 c0 eb cd 0f 1f 40 00 55 48 85 ff 48
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713590] RSP:
> 002b:00007fd87c44bab0 EFLAGS: 00000202
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713592] RAX:
> 00007ffe88f868f0 RBX: 0000000000000000 RCX: 00007fd87bbf62c0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713593] RDX:
> 0000000000000000 RSI: 00007fd87c44bae0 RDI: 0000000000000000
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713594] RBP:
> 00007fd87c44bab0 R08: 0000000000ee83ed R09: 00007fd87c44c700
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713595] R10:
> 0000000000000001 R11: 0000000000000206 R12: 00007fd87c44bcb0
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713595] R13:
> 00007fd87c44bcc0 R14: 00007fd879d15fd8 R15: 00007fd879d15ed8
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713596] FS:
> 00007fd87c44c700 GS:  0000000000000000
> Jul  7 14:50:47 bzk-CM8CCB4R kernel: [72873.713597] [Xenomai] watchdog
> triggered on CPU #1 -- runaway thread 'timer-internal' signaled
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

