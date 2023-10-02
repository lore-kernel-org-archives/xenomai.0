Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED129B0
	for <xenomai@lists.linux.dev>; Mon,  2 Oct 2023 12:35:02 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202310021234546944ecf648cbf2b526
        for <xenomai@lists.linux.dev>;
        Mon, 02 Oct 2023 14:34:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=YPeBY0nveYxBQDbnYqKSI87ezEsNZ3f9yTmPS9UQVto=;
 b=mXfeAWdUeJoRJYkX0WhenYGZWstTqf93zHYO/tax2v+s5+VlVCHOCEutoT7q+4TEoRaIw7
 MHJFeHeYpajHPgTaEHi/L8XL9BUT8uia7YspBp6qJuunC4f6XALfhgoFvXPMkE0tprTDaOaN
 oacVn4XbgLArgF0yFWPqj+zGW7gE4=;
Message-ID: <1cd875106cdf555e52734462a9d846ffd3549556.camel@siemens.com>
Subject: Dovetail 6.1.54: IRQ handler enables HW irqs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, rpm@xenomai.org
Date: Mon, 02 Oct 2023 14:34:54 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe, Hi Jan,

I'm currently testing the latest Dovetail 6.1.x release, which is
6.1.54 to my best knowledge.=20

After updating I run into the following problem. There have been recent
changes to the handling of per-cpu IRQs, that might be related.

The problem occurs when using stress-ng to simulate system load when
running on VirtualBox as VMM on a Windows Host. The Linux host is still
running the test but might be affected too.

The machine "dies"/"hangs" a few seconds after the first reporting.

[   71.553200] ------------[ cut here ]------------
[   71.557426] irq 21 handler ahci_single_level_irq_intr+0x0/0x60 [libahci]=
 enabled interrupts
[   71.565260] WARNING: CPU: 1 PID: 192 at kernel/irq/handle.c:168 __handle=
_irq_event_percpu+0x14c/0x180
[   71.573165] Modules linked in: intel_rapl_msr intel_rapl_common=20
intel_pmc_core ghash_clmulni_intel sha512_ssse3 sha512_generic vmwgfx=20
drm_ttm_helper snd_intel8x0 ttm snd_ac97_codec aesni_intel crypto_simd=20
ac97_bus cryptd drm_kms_helper rapl snd_pcm fb_sys_fops syscopyarea=20
snd_timer pcspkr sysfillrect snd sysimgblt vboxguest soundcore ac button=
=20
joydev evdev serio_raw sg binfmt_misc loop fuse efi_pstore drm dm_mod=20
dax configfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16=20
mbcache jbd2 hid_generic usbhid sd_mod t10_pi hid crc64_rocksoft crc64=20
sr_mod crc_t10dif cdrom crct10dif_generic ata_generic ahci ata_piix=20
libahci ohci_pci ohci_hcd ehci_pci ehci_hcd libata crct10dif_pclmul=20
usbcore crct10dif_common scsi_mod video crc32_pclmul psmouse e1000=20
scsi_common i2c_piix4 crc32c_intel usb_common battery wmi
[   71.590746] stress-ng-iomix (639): drop_caches: 3
[   71.625329] CPU: 1 PID: 192 Comm: jbd2/sda1-8 Not tainted 6.1.54-xenomai=
-0 #1
[   71.625336] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS Virt=
ualBox 12/01/2006
[   71.625339] RIP: 0010:__handle_irq_event_percpu+0x14c/0x180
[   71.625348] Code: 44 00 00 e9 0d ff ff ff 80 3d 6a de 8e 01 00 75 1b=20
48 8b 13 44 89 ee 48 c7 c7 08 79 f4 a9 c6 05 54 de 8e 01 01 e8 24 64 f8=20
ff <0f> 0b fa e9 01 ff ff ff f0 48 0f ba 6b 40 01 0f 82 c5 fe ff ff e9
[   71.625352] RSP: 0000:ffff98c4000e0f58 EFLAGS: 00010282
[   71.625356] RAX: 0000000000000000 RBX: ffff88bbc134e380 RCX: 00000000000=
00000
[   71.625359] RDX: 0000000000010003 RSI: ffffffffa9f8477e RDI: 00000000fff=
fffff
[   71.625362] RBP: 0000000000000001 R08: 0000000000000000 R09: ffff98c4000=
e0dc0
[   71.625364] R10: 0000000000000003 R11: ffffffffaa6d1048 R12: 00000000000=
00000
[   71.625366] R13: 0000000000000015 R14: ffff88bc352f5800 R15: 00000000000=
00000
[   71.625371] FS:  0000000000000000(0000) GS:ffff88bc3dc80000(0000) knlGS:=
0000000000000000
[   71.625375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   71.625377] CR2: 00007f7072a14e80 CR3: 0000000007b7e002 CR4: 00000000000=
306e0
[   71.625380] Call Trace:
[   71.625383]  <IRQ>
[   71.625388]  ? __warn+0x7d/0xc0
[   71.625396]  ? __handle_irq_event_percpu+0x14c/0x180
[   71.625400]  ? report_bug+0xe6/0x170
[   71.625405]  ? handle_bug+0x3c/0x70
[   71.625409]  ? exc_invalid_op+0x13/0x60
[   71.625413]  ? asm_exc_invalid_op+0x16/0x20
[   71.625419]  ? __handle_irq_event_percpu+0x14c/0x180
[   71.625423]  ? __handle_irq_event_percpu+0x14c/0x180
[   71.625426]  handle_irq_event+0x34/0x70
[   71.625430]  handle_fasteoi_irq+0x90/0x1e0
[   71.625435]  __common_interrupt+0x66/0x100
[   71.625440]  common_interrupt+0xb4/0xd0
[   71.625446]  </IRQ>
[   71.625447]  <TASK>
[   71.625449]  asm_common_interrupt+0x22/0x40
[   71.625453] RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40
[   71.625459] Code: 00 00 31 c0 eb f1 66 66 2e 0f 1f 84 00 00 00 00 00=20
0f 1f 44 00 00 e8 6a 06 00 00 90 f7 c6 00 02 00 00 74 01 fb bf 01 00 00=20
00 <e8> 82 6d 6f ff 65 8b 05 2b f9 84 56 85 c0 74 05 c3 cc cc cc cc 0f
[   71.625462] RSP: 0000:ffff98c400607990 EFLAGS: 00010206
[   71.625466] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88bbc24=
41828
[   71.625468] RDX: ffff88bbf6036040 RSI: 0000000000000293 RDI: 00000000000=
00001
[   71.625470] RBP: 0000000000000293 R08: 0000000000000001 R09: 00000000749=
c8fff
[   71.625472] R10: ffff88bbc18d8000 R11: 0000000000000000 R12: ffff88bbf60=
34000
[   71.625474] R13: ffff88bbc18da000 R14: ffff88bbc18d8000 R15: ffff98c4006=
07a88
[   71.625479]  ata_scsi_queuecmd+0x4f/0x80 [libata]
[   71.625519]  scsi_queue_rq+0x2c0/0xbc0 [scsi_mod]
[   71.625547]  blk_mq_dispatch_rq_list+0x211/0x970
[   71.625554]  ? sbitmap_get+0x90/0x1b0
[   71.625560]  blk_mq_do_dispatch_sched+0x324/0x3c0
[   71.625567]  __blk_mq_sched_dispatch_requests+0xec/0x130
[   71.625573]  blk_mq_sched_dispatch_requests+0x30/0x60
[   71.625577]  __blk_mq_run_hw_queue+0x34/0x90
[   71.625583]  blk_mq_sched_insert_requests+0x6b/0x150
[   71.625588]  blk_mq_flush_plug_list.part.0+0x134/0x2d0
[   71.625593]  __blk_flush_plug+0xf1/0x150
[   71.625597]  ? submit_bio_noacct_nocheck+0x32e/0x370
[   71.625601]  ? preempt_count_add+0x6a/0xa0
[   71.625605]  blk_finish_plug+0x25/0x40
[   71.625610]  jbd2_journal_commit_transaction+0x1001/0x1a70 [jbd2]
[   71.858415]  ? _raw_spin_unlock+0x15/0x30
[   71.861278]  ? finish_task_switch.isra.0+0x94/0x2f0
[   71.864680]  kjournald2+0xa9/0x280 [jbd2]
[   71.867591]  ? cpuusage_read+0x10/0x10
[   71.870292]  ? jbd2_fc_wait_bufs+0xa0/0xa0 [jbd2]
[   71.873481]  kthread+0xe9/0x110
[   71.875779]  ? kthread_complete_and_exit+0x20/0x20
[   71.878792]  ret_from_fork+0x22/0x30
[   71.881232]  </TASK>
[   71.882849] ---[ end trace 0000000000000000 ]---
