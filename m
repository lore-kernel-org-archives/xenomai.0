Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D297C
	for <xenomai@lists.linux.dev>; Sun, 23 Jul 2023 09:39:52 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id B6345C2EDF
	for <xenomai@lists.linux.dev>; Sun, 23 Jul 2023 09:36:41 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A60B21C0004;
	Sun, 23 Jul 2023 09:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1690104994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc7GHTuKvzGRrARznURResUkRzkit7kyuymQg9VIias=;
	b=UV8aEMxBGfU3WWaWUcI8IT0cLzs27ANGZBIFCWuHxx+cTPNRAPhJhr9aQRDy2oMf4/q3Et
	lP2y1oRPBGjZLushw5lBMsgP2g8UnTPJPpp34xAuWRCwneNzS9Ln9ohfXTe5w/f6rw7Afu
	aXFQ7QcWJT5p8hBb2K4bUJIt33wydxHVRypjW7iu80s3Bh5j/NEWzscopnRMts1LVwkn+4
	bSq0Qe09T24UskUZ5n0wqV6yFYlHXPXgzyVrIY2TknUX4NoK9NJbN3M6OoL1eYbHg0xUoS
	+7ysIBL0p/ebDoLIqboNyxp/YPAa8RvXha0WSVNkMgK8UQ9QhGnO7hxlAqi0hA==
References: <ecada31f7d6376ed073cb485bd21457e1358d357.camel@siemens.com>
 <87ttub8sx1.fsf@xenomai.org>
 <621694c10b6c86f1b914779305934a2a714a7ef1.camel@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: dovetail: IO-APIC IRQ storm
Date: Sun, 23 Jul 2023 11:25:20 +0200
In-reply-to: <621694c10b6c86f1b914779305934a2a714a7ef1.camel@siemens.com>
Message-ID: <87fs5f0y2p.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2023-07-10 at 21:20 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>=20
>> > Hi Philippe,
>> >=20
>> > it seems I'm facing a problem with dovetail on x86 related to IRQs
>> > routed through the IO-APIC.
>> >=20
>> > Note the=C2=A0stack trace below, it seems that once we ACK the IRQ in
>> > ioapic_ack_level() by calling __ack_APIC_irq() we immediately get the
>> > next IRQ.
>> >=20
>> > cat /proc/interrupts delivers (minimized to the relevant IRQ):
>> >=20
>> >           CPU0       CPU1       CPU2       CPU3
>> > 21:          0       2392          0          0   IO-APIC     21 -fast=
eoi   ahci[0000:00:0d.0], snd_intel8x0
>> >=20
>> > Seems IRQ masking does not work as expected. I have to add more
>> > debugging code but it looks like an IRQ storm for now. I have the
>> > following options in mind right now, but there might be more:
>> >=20
>> > - Masking of the AHCI IRQ does not work as expected
>>=20
>> The ioapic backend code is unchanged for mask_ioapic_irq() aside of the
>> conversion to hard spinlocking, so maybe the generic portion there
>> unexpectedly detecting a masked line, blocking the actual masking?
>>=20
>> void mask_irq(struct irq_desc *desc)
>> {
>> 	if (irqd_irq_masked(&desc->irq_data))
>> 		return;
>
> I added a WARN() here, so whenever we skip calling the low level
> chip.irq_mask() function I get notified.=20
>
> This happens from time to time for my affected IRQ 21.
>
> When it happens, the unmask_irq() also skips calling the
> chip.irq_unmask() function.
>
> Warning from mask_irq:
>
> [ 1914.059288] ------------[ cut here ]------------
> [ 1914.059304] IRQ(21) already masked.
> [ 1914.059330] WARNING: CPU: 2 PID: 567 at kernel/irq/chip.c:430 mask_irq=
+0x4b/0x60
> [ 1914.059375] Modules linked in: intel_rapl_msr intel_rapl_common
> ghash_clmulni_intel sha512_ssse3 sha512_generic vmwgfx snd_pcm
> drm_ttm_helper ttm snd_timer snd drm_kms_helper soundcore aesni_intel
> crypto_simd fb_sys_fops cryptd pcspkr syscopyarea sysfillrect
> sysimgblt vboxguest ac button joydev evdev serio_raw sg binfmt_misc
> loop dm_mod fuse efi_pstore drm dax configfs ip_tables x_tables
> autofs4 ext4 crc32c_generic crc16 mbcache jbd2 hid_generic usbhid hid
> sd_mod t10_pi crc64_rocksoft crc64 crc_t10dif sr_mod cdrom
> crct10dif_generic ata_generic ohci_pci ahci ata_piix libahci
> crct10dif_pclmul crct10dif_common libata crc32_pclmul ehci_pci
> ohci_hcd ehci_hcd crc32c_intel psmouse scsi_mod e1000 usbcore
> i2c_piix4 usb_common scsi_common video wmi
> [ 1914.060573] CPU: 2 PID: 567 Comm: stress-ng-cpu Tainted: G        W   =
       6.1.37-xenomai-1 #1
> [ 1914.060587] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS Vi=
rtualBox 12/01/2006
> [ 1914.060598] IRQ stage: Xenomai
> [ 1914.060621] RIP: 0010:mask_irq+0x4b/0x60
> [ 1914.060635] Code: 74 13 48 8d 7f 28 e8 b4 94 cf 00 48 8b 43 38 81 08 0=
0 00 02 00 5b e9 e4 96 cf 00 8b 77 2c 48 c7 c7 ee 47 4f 9a e8 85 ff f7 ff <=
0f> 0b 5b e9 cd 96 cf 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f
> [ 1914.060638] RSP: 0000:ffffc1420103bd78 EFLAGS: 00010082
> [ 1914.060737] RAX: 0000000000000000 RBX: ffffa061f6252200 RCX: 000000000=
0000000
> [ 1914.060750] RDX: 0000000003000002 RSI: ffffffff9a533156 RDI: 00000000f=
fffffff
> [ 1914.060763] RBP: ffffa061f62522c8 R08: 8000000100000356 R09: 000000000=
0000001
> [ 1914.060842] R10: 3fffffffffffffff R11: ffffffff9c194a16 R12: ffffffff9=
ae3c8c0
> [ 1914.060855] R13: ffffa061f6252200 R14: 0000000000000000 R15: ffffa061f=
6252200
> [ 1914.060932] FS:  00007f41397e6740(0000) GS:ffffa0623dd00000(0000) knlG=
S:0000000000000000
> [ 1914.060947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1914.060960] CR2: 00007fff3e274dc3 CR3: 0000000002d7c000 CR4: 000000000=
00506e0
> [ 1914.061010] Call Trace:
> [ 1914.061038]  <TASK>
> [ 1914.061053]  ? __warn+0x7d/0xc0
> [ 1914.061071]  ? mask_irq+0x4b/0x60
> [ 1914.061084]  ? report_bug+0xe6/0x170
> [ 1914.061130]  ? handle_bug+0x4e/0xb0
> [ 1914.061146]  ? exc_invalid_op+0xca/0xe0
> [ 1914.061191]  ? asm_exc_invalid_op+0x16/0x20
> [ 1914.061252]  ? mask_irq+0x4b/0x60
> [ 1914.061268]  ? mask_irq+0x4b/0x60
> [ 1914.061295]  handle_fasteoi_irq+0x1ba/0x200
> [ 1914.061311]  generic_pipeline_irq_desc+0xb0/0x160
> [ 1914.061327]  arch_handle_irq+0x5d/0x1e0
> [ 1914.061375]  arch_pipeline_entry+0x3b/0x110
> [ 1914.061399]  asm_common_interrupt+0x22/0x40
> [ 1914.061414] RIP: 0010:arch_do_IRQ_pipelined+0x0/0x770
> [ 1914.061428] Code: 96 0d 36 01 53 48 89 fb 31 f6 bf b0 00 00 00 48 8b 0=
0 e8 c3 be d9 00 48 89 df 5b e9 ca 80 0a 00 31 ff e9 d3 3f ff ff 0f 1f 00 <=
0f> 1f 44 00 00 41 55 65 48 8b 04 25 00 ed 01 00 41 54 55 48 c7 c5
> [ 1914.061441] RSP: 0000:ffffc1420103bed0 EFLAGS: 00000246
> [ 1914.061488] RAX: 00000000cd4094af RBX: ffffffff9accfdf0 RCX: 00000000e=
6765107
> [ 1914.061500] RDX: 0000000000e2d1cb RSI: 000000005e7e250c RDI: ffffa061f=
6252200
> [ 1914.061520] RBP: 00000000000501e0 R08: 0000000000000000 R09: 000000000=
0000040
> [ 1914.061527] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa061c=
25f4bc0
> [ 1914.061527] R13: 0000000000000015 R14: 000000000000002f R15: 000000000=
0000000
> [ 1914.061527]  sync_current_irq_stage+0x1b5/0x260
> [ 1914.061527]  handle_irq_pipelined_finish+0x9f/0x190
> [ 1914.061527]  arch_pipeline_entry+0xd6/0x110
> [ 1914.061527]  asm_common_interrupt+0x22/0x40
> [ 1914.061527] RIP: 0033:0x55f685717ff1
> [ 1914.061527] Code: Unable to access opcode bytes at 0x55f685717fc7.
> [ 1914.061527] RSP: 002b:00007fff3e272940 EFLAGS: 00000202
> [ 1914.061527] RAX: 400fe7a4791f144c RBX: 0000000000000176 RCX: 000ffffff=
fffffff
> [ 1914.061527] RDX: 8000000000000000 RSI: 0000000000000400 RDI: 000000000=
0000020
> [ 1914.061527] RBP: 00007fff3e2729c0 R08: ffff000000000000 R09: 000000000=
0000001
> [ 1914.061527] R10: 000fe7a4791f144c R11: 000c4a0f3df91177 R12: 00007fff3=
e2729d0
> [ 1914.061527] R13: 000000000000001f R14: 8000000000000000 R15: 00007fff3=
e272b90
> [ 1914.061527]  </TASK>
> [ 1914.061527] ---[ end trace 0000000000000000 ]---
>
> Warning from unmask_irq:
>
> [ 1914.061527] ------------[ cut here ]------------
> [ 1914.061527] IRQ(21) already unmasked.
> [ 1914.061527] WARNING: CPU: 2 PID: 567 at kernel/irq/chip.c:443 unmask_i=
rq+0x4b/0x60
> [ 1914.061527] Modules linked in: intel_rapl_msr intel_rapl_common
> ghash_clmulni_intel sha512_ssse3 sha512_generic vmwgfx snd_pcm
> drm_ttm_helper ttm snd_timer snd drm_kms_helper soundcore aesni_intel
> crypto_simd fb_sys_fops cryptd pcspkr syscopyarea sysfillrect
> sysimgblt vboxguest ac button joydev evdev serio_raw sg binfmt_misc
> loop dm_mod fuse efi_pstore drm dax configfs ip_tables x_tables
> autofs4 ext4 crc32c_generic crc16 mbcache jbd2 hid_generic usbhid hid
> sd_mod t10_pi crc64_rocksoft crc64 crc_t10dif sr_mod cdrom
> crct10dif_generic ata_generic ohci_pci ahci ata_piix libahci
> crct10dif_pclmul crct10dif_common libata crc32_pclmul ehci_pci
> ohci_hcd ehci_hcd crc32c_intel psmouse scsi_mod e1000 usbcore
> i2c_piix4 usb_common scsi_common video wmi
> [ 1914.061527] CPU: 2 PID: 567 Comm: stress-ng-cpu Tainted: G        W   =
       6.1.37-xenomai-1 #1
> [ 1914.061527] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS Vi=
rtualBox 12/01/2006
> [ 1914.061527] IRQ stage: Linux
> [ 1914.061527] RIP: 0010:unmask_irq+0x4b/0x60
> [ 1914.061527] Code: 74 13 48 8d 7f 28 e8 44 93 cf 00 48 8b 43 38 81 20 f=
f ff fd ff 5b e9 74 95 cf 00 8b 77 2c 48 c7 c7 07 48 4f 9a e8 15 fe f7 ff <=
0f> 0b 5b e9 5d 95 cf 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f
> [ 1914.061527] RSP: 0000:ffffc1420010cee8 EFLAGS: 00010082
> [ 1914.061527] RAX: 0000000000000000 RBX: ffffa061f6252200 RCX: 000000000=
0000000
> [ 1914.061527] RDX: 0000000000010103 RSI: ffffffff9a533156 RDI: 00000000f=
fffffff
> [ 1914.061527] RBP: ffffa061f62522c8 R08: 800000010000038d R09: 000000000=
0000001
> [ 1914.061527] R10: 3fffffffffffffff R11: ffffffff9c195a8e R12: ffffffff9=
ae3c8c0
> [ 1914.061527] R13: 0000000000000000 R14: 000000000000002f R15: 000000000=
0000000
> [ 1914.061527] FS:  00007f41397e6740(0000) GS:ffffa0623dd00000(0000) knlG=
S:0000000000000000
> [ 1914.061527] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1914.061527] CR2: 00007fff3e274dc3 CR3: 0000000002d7c000 CR4: 000000000=
00506e0
> [ 1914.061527] Call Trace:
> [ 1914.061527]  <IRQ>
> [ 1914.061527]  ? __warn+0x7d/0xc0
> [ 1914.061527]  ? unmask_irq+0x4b/0x60
> [ 1914.061527]  ? report_bug+0xe6/0x170
> [ 1914.061527]  ? handle_bug+0x4e/0xb0
> [ 1914.061527]  ? exc_invalid_op+0xca/0xe0
> [ 1914.061527]  ? asm_exc_invalid_op+0x16/0x20
> [ 1914.061527]  ? unmask_irq+0x4b/0x60
> [ 1914.061527]  ? unmask_irq+0x4b/0x60
> [ 1914.061527]  handle_fasteoi_irq+0x15a/0x200
> [ 1914.061527]  arch_do_IRQ_pipelined+0xc3/0x770
> [ 1914.061527]  sync_current_irq_stage+0x1b5/0x260
> [ 1914.061527]  inband_irq_enable+0x46/0x60
> [ 1914.061527]  __do_softirq+0x84/0x2fc
> [ 1914.061527]  __irq_exit_rcu+0xdc/0x140
> [ 1914.061527]  arch_do_IRQ_pipelined+0x13b/0x770
> [ 1914.061527]  </IRQ>
> [ 1914.061527]  <TASK>
> [ 1914.061527]  sync_current_irq_stage+0x1b5/0x260
> [ 1914.061527]  handle_irq_pipelined_finish+0x9f/0x190
> [ 1914.061527]  arch_pipeline_entry+0xd6/0x110
> [ 1914.061527]  asm_common_interrupt+0x22/0x40
> [ 1914.061527] RIP: 0033:0x55f685717ff1
> [ 1914.061527] Code: ff 7f 00 00 31 c0 e9 8e f0 ff ff 66 2e 0f 1f 84 00 0=
0 00 00 00 0f 1f 40 00 f3 0f 1e fa 48 83 ec 28 0f 29 04 24 0f ae 5c 24 1c <=
48> 8b 4c 24 08 4c 8b 04 24 48 b8 ff ff ff ff ff ff 00 00 48 21 c8
> [ 1914.061527] RSP: 002b:00007fff3e272940 EFLAGS: 00000202
> [ 1914.061527] RAX: 400fe7a4791f144c RBX: 0000000000000176 RCX: 000ffffff=
fffffff
> [ 1914.061527] RDX: 8000000000000000 RSI: 0000000000000400 RDI: 000000000=
0000020
> [ 1914.061527] RBP: 00007fff3e2729c0 R08: ffff000000000000 R09: 000000000=
0000001
> [ 1914.061527] R10: 000fe7a4791f144c R11: 000c4a0f3df91177 R12: 00007fff3=
e2729d0
> [ 1914.061527] R13: 000000000000001f R14: 8000000000000000 R15: 00007fff3=
e272b90
> [ 1914.061527]  </TASK>
> [ 1914.061527] ---[ end trace 0000000000000000 ]---
>
> It seems that for some reason the "software state" runs out of sync, we
> skip the IRQ masking, call the io-apic EOI function, ACK the IRQ at the
> IO-APIC and with some luck we immediately have to handle the next IRQ.
>
> Philippe, do you agree?

The issue seems different than a virtual state breakage: for some reason
IRQ21 is delivered by the hw although it was supposedly masked which is
not depending on the inband stall bit. From that point, the whole logic
runs amok.

I have not been able to reproduce the issue so far with the xenomai4/evl
core on top of dovetail 6.1.37 running on my fresh virtualbox install
here. Can you share the kernel config and maybe the OVA export file of
your VM? Also, does the issue happen without enabling Cobalt?

--=20
Philippe.
