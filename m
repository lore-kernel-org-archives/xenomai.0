Message-ID: <46FA850A.8040201@domain.hid>
Date: Wed, 26 Sep 2007 18:12:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [BUG] sep-related oops on 2.6.20
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Hi,

[  765.881682] general protection fault: 0000 [#2]
[  765.881686] SMP 
[  765.881692] Modules linked in: xeno_timerbench sky2 xeno_rtdm xeno_native xeno_nucleus ipv6 binfmt_misc rfcomm l2cap bluetooth i915 drm ppdev capability commoncap dock button video sbs battery i2c_ec i2c_core ac af_packet nls_utf8 ntfs sbp2 lp fuse usbhid hid snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss tsdev snd_seq_midi joydev snd_rawmidi snd_seq_midi_event snd_seq evdev snd_timer snd_seq_device pcmcia ehci_hcd irda iTCO_wdt iTCO_vendor_support ohci1394 sdhci uhci_hcd parport_pc parport ata_generic generic piix ieee1394 intel_agp agpgart mmc_core usbcore serio_raw yenta_socket rsrc_nonstatic pcmcia_core pcspkr psmouse shpchp pci_hotplug crc_ccitt snd soundcore snd_page_alloc ext3 jbd mbcache sr_mod cdrom sd_mod sg ata_piix ahci libata scsi_mod fan
[  765.881825] CPU:    1
[  765.881826] EIP:    0060:[<c01032eb>]    Not tainted VLI
[  765.881827] EFLAGS: 00010246   (2.6.20 #10)
[  765.881835] EIP is at sysenter_exit+0x13/0x18
[  765.881839] eax: 00000000   ebx: b7dda374   ecx: b7dda2b0   edx: ffffe410
[  765.881843] esi: 0000267f   edi: b7dda374   ebp: 00000000   esp: eada3fb8
[  765.881846] ds: 007b   es: 007b   ss: 0068
[  765.881851] Process sampling-14203 (pid: 14205, ti=eada2000 task=dfe52070 task.ti=eada2000)
[  765.881854] Stack: b7dda374 b7f81f1c 00000000 0000267f b7dda374 b7dda2d8 00000000 0801007b 
[  765.881869]        ffff007b c0100033 0801022b ffffe410 00000073 00000206 b7dda2b0 0000007b 
[  765.881882]        5a5a5a5a a55a5a5a 
[  765.881887] Call Trace:
[  765.881890]  [<c010462f>] show_trace_log_lvl+0x1f/0x40
[  765.881896]  [<c0104701>] show_stack_log_lvl+0xb1/0xe0
[  765.881902]  [<c01048f4>] show_registers+0x1c4/0x340
[  765.881907]  [<c0104b97>] die+0x127/0x280
[  765.881912]  [<c0105d69>] do_general_protection+0x199/0x1d0
[  765.881917]  [<c0113444>] __ipipe_handle_exception+0x84/0x1b0
[  765.881925]  [<c02efccd>] error_code+0x81/0x90
[  765.881931]  =======================
[  765.881933] Code: 0c bc 04 00 fb 8b 4d 08 66 f7 c1 ff fe 0f 85 6d 01 00 00 e8 e8 fc 00 00 8b 44 24 18 8b 54 24 2c 8b 4c 24 38 31 ed 8e 6c 24 24 fb <0f> 35 8d 76 00 50 fc 0f a8 06 1e 50 55 57 56 52 51 53 ba 7b 00 
[  765.882012] EIP: [<c01032eb>] sysenter_exit+0x13/0x18 SS:ESP 0068:eada3fb8

Any bells ringing for someone?

This happens only with --enable-x86-sep, not when going via int80 into the kernel. Setup is 2.6.20 with ipipe-1.8-08 (I switched back from 2.6.20.20 to exclude issues due to my adopted patch) and Xenomai trunk. To trigger this, I have to run "latency -c1" (-c0 doesn't cause this) and switch between X and text mode (which triggers some hw-related latencies, still meditating over this correlation...).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

