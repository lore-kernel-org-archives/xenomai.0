Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567528F4
	for <xenomai@lists.linux.dev>; Sun, 22 Sep 2024 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726993787; cv=none; b=rwnvnXERI8/q5bGmZQwqpm2zDjC7y6cYj4b0LceYNs5k71XdtvCMojW1oNcAv6aZAy7aycPwXWZtTE2rTqbsE4F2wZTt80L9g2JmeZlW7HuuAaV1JBBu7NjOSx8C4Yoazs7EMsd7X8k3smtRVPk67sa+M8KnTyMLWixM0pmmzy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726993787; c=relaxed/simple;
	bh=em9von8MmhzBRt7YLk/oL6jUaLm0qmSBmdg3jYNeo/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rw25OYJ5O28W99FkiM10fIwxTEBGI+4833QcRM5si6IWq7QKjNXsGPZMAz9f5rqCM4MK8nvnSzSbVhxX9Le9CdH+5LhKT/soQxliHEsaPQu3T4KaTIHvGZxYj7qCnRftm+rF3NtkBRqU2yip2dIyky9sBdyeTmD5VQB6+iw5cCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=k0QoU4Oq; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="k0QoU4Oq"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024092208293144b58a3431e3c47970
        for <xenomai@lists.linux.dev>;
        Sun, 22 Sep 2024 10:29:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=em9von8MmhzBRt7YLk/oL6jUaLm0qmSBmdg3jYNeo/4=;
 b=k0QoU4OqwTN5owh0fuNwOT1tv5atfuqwL72kcKLvJnwRB+pg11JuOJyJjZl93gbVKCgpFp
 MQZhq0W7LmxJCm67qDgrZOD/vEp/kZ4G7lav9YuhCH4UMUJq6+jScMwxegZ9JseKLWokZDFm
 U4TpoO75c95xeKTJq0y1sdhLA+kC3F1562jERtn5keKCIdBGxidWADBDroqMF9+mOyfNgyE/
 vDFfAL23XMNGBiyaSx0zL5z/lvzyCRLML+Hf3X7DCNAQ6VW+j8q8UoAc3Q/UMdA+dp6PtGjC
 gNLZR5AQqIPu3KO/IGnKxZku/ODOJXg+kcXJbDNQqs3hMVPDTQdxe0vw==;
Message-ID: <371920ecf82a06c9dbbbf9fa78ec16c6ef9137a8.camel@siemens.com>
Subject: Re: Xenomai Freezing test with I-PIPE and Dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?UTF-8?Q?=EC=9E=84=EC=A4=80=EC=88=98=28Junesoo?= "Im)"
 =?UTF-8?Q?=EC=88=98=EC=84=9D_?=
 =?UTF-8?Q?=EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=8A=A4?=
	 <junesoo.im@doosan.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Cc: =?UTF-8?Q?=EB=B0=95=EA=B2=BD=ED=9B=88=28Kyunghoon?= "Park)"
 =?UTF-8?Q?=ED=8C=80=EC=9E=A5_?=
 =?UTF-8?Q?=EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=8A=A4?=
	 <kyunghoon2.park@doosan.com>, 
 =?UTF-8?Q?=EA=B9=80=EA=B7=9C=ED=98=84=28Kyuhyeon?= "Kim) -"
 =?UTF-8?Q?=EC=86=8C=ED=83=80=ED=85=8D=EC=BD=94=EB=A6=AC=EC=95=84?=
	 <kyuhyeon.kim@doosan.com>, "Nguyen Thanh Tung(Tung Nguyenthanh)"
 =?UTF-8?Q?=EC=86=8C=ED=83=80=ED=85=8D=EC=BD=94=EB=A6=AC=EC=95=84?=
	 <tung3.nguyenthanh@doosan.com>
Date: Sun, 22 Sep 2024 10:29:29 +0200
In-Reply-To: <SL2P216MB2274F79427AA646E9CE1BB98E06C2@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
References: 
	<SL2P216MB2274755998FD757C16569E24E09D2@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
	 <82a7d428-9166-480e-be11-43ff61371bfc@siemens.com>
	 <SL2P216MB2274F79427AA646E9CE1BB98E06C2@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
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

On Fri, 2024-09-20 at 09:13 +0000, =EC=9E=84=EC=A4=80=EC=88=98(Junesoo Im) =
=EC=88=98=EC=84=9D =EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=8A=A4 w=
rote:
> [=C2=A0=C2=A0=C2=A0 8.304108] kernel tried to execute NX-protected page -=
 exploit attempt? (uid: 0)
> [=C2=A0=C2=A0=C2=A0 8.304109] BUG: unable to handle page fault for addres=
s: ffff90a1c8c69e40
> [=C2=A0=C2=A0=C2=A0 8.304110] #PF: supervisor instruction fetch in kernel=
 mode
> [=C2=A0=C2=A0=C2=A0 8.304110] #PF: error_code(0x0011) - permissions viola=
tion
> [=C2=A0=C2=A0=C2=A0 8.304111] PGD 29c01067 P4D 29c01067 PUD 100c32063 PMD=
 8000000108c000e3=20
> [=C2=A0=C2=A0=C2=A0 8.304113] Oops: 0011 [#1] PREEMPT SMP PTI IRQ_PIPELIN=
E
> [=C2=A0=C2=A0=C2=A0 8.304114] CPU: 0 PID: 745 Comm: test_syscall_rt Taint=
ed: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 O=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 5.10.223+ #11
> [=C2=A0=C2=A0=C2=A0 8.304115] Hardware name: Default string Default strin=
g/Default string, BIOS 5.0.1.2 01/25/2021
> [=C2=A0=C2=A0=C2=A0 8.304115] IRQ stage: Linux
> [=C2=A0=C2=A0=C2=A0 8.304116] RIP: 0010:0xffff90a1c8c69e40
> [=C2=A0=C2=A0=C2=A0 8.304117] Code: 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 <00> 00 00 00 00 00 00 00 60 00 00 00 00 00 00 00 08 c0 4c c1=
 4e ad
> [=C2=A0=C2=A0=C2=A0 8.304117] RSP: 0018:ffffad4ec0003f50 EFLAGS: 00010246
> [=C2=A0=C2=A0=C2=A0 8.304118] RAX: ffff90a1c8c69e40 RBX: ffffad4ec1fafd90=
 RCX: 00000000cd46ea8f
> [=C2=A0=C2=A0=C2=A0 8.304119] RDX: ffffad4ec1fafd98 RSI: ffffffff94394069=
 RDI: ffffad4ec1fafd90
> [=C2=A0=C2=A0=C2=A0 8.304119] RBP: ffffad4ec0003f70 R08: 0000000000000001=
 R09: 0000000000000000
> [=C2=A0=C2=A0=C2=A0 8.304120] R10: 0000000000000000 R11: 0000000000000000=
 R12: 0000000000400140
> [=C2=A0=C2=A0=C2=A0 8.304120] R13: 0000000000400140 R14: 0000000000000078=
 R15: ffffffff92f44c60
> [=C2=A0=C2=A0=C2=A0 8.304121] FS:=C2=A0 00007f79e844f740(0000) GS:ffff90a=
325e00000(0000) knlGS:0000000000000000
> [=C2=A0=C2=A0=C2=A0 8.304121] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
> [=C2=A0=C2=A0=C2=A0 8.304122] CR2: ffff90a1c8c69e40 CR3: 00000001039d4006=
 CR4: 00000000003706f0
> [=C2=A0=C2=A0=C2=A0 8.304123] DR0: 0000000000000000 DR1: 0000000000000000=
 DR2: 0000000000000000
> [=C2=A0=C2=A0=C2=A0 8.304123] DR3: 0000000000000000 DR6: 00000000fffe0ff0=
 DR7: 0000000000000400
> [=C2=A0=C2=A0=C2=A0 8.304124] Call Trace:
> [=C2=A0=C2=A0=C2=A0 8.304124]=C2=A0 <IRQ>
> [=C2=A0=C2=A0=C2=A0 8.304124]=C2=A0 ? show_regs.cold+0x1a/0x1f
> [=C2=A0=C2=A0=C2=A0 8.304125]=C2=A0 ? __die_body+0x20/0x70
> [=C2=A0=C2=A0=C2=A0 8.304125]=C2=A0 ? __die+0x2b/0x40
> [=C2=A0=C2=A0=C2=A0 8.304126]=C2=A0 ? no_context.isra.0+0x13a/0x370
> [=C2=A0=C2=A0=C2=A0 8.304126]=C2=A0 ? debug_smp_processor_id+0x17/0x20
> [=C2=A0=C2=A0=C2=A0 8.304127]=C2=A0 ? __bad_area_nosemaphore+0x17c/0x1f0
> [=C2=A0=C2=A0=C2=A0 8.304127]=C2=A0 ? rcu_is_watching+0x21/0x30
> [=C2=A0=C2=A0=C2=A0 8.304128]=C2=A0 ? bad_area_nosemaphore+0x16/0x20
> [=C2=A0=C2=A0=C2=A0 8.304128]=C2=A0 ? do_kern_addr_fault+0x83/0xb0
> [=C2=A0=C2=A0=C2=A0 8.304129]=C2=A0 ? exc_page_fault+0x12c/0x220
> [=C2=A0=C2=A0=C2=A0 8.304129]=C2=A0 ? asm_exc_page_fault+0x1e/0x30
> [=C2=A0=C2=A0=C2=A0 8.304130]=C2=A0 ? handle_oob_irq+0x140/0x140
> [=C2=A0=C2=A0=C2=A0 8.304130]=C2=A0 ? irq_work_single+0x47/0x80
> [=C2=A0=C2=A0=C2=A0 8.304131]=C2=A0 irq_work_run_list+0x32/0x50
> [=C2=A0=C2=A0=C2=A0 8.304131]=C2=A0 irq_work_run+0x32/0x80
> [=C2=A0=C2=A0=C2=A0 8.304132]=C2=A0 inband_work_interrupt+0xe/0x20

This looks very similar to an issue that we fixed recently. See=20
https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc854956f3e78bb60.ca=
mel@siemens.com/T/#t

and

https://source.denx.de/Xenomai/xenomai/-/commit/95ccd795ec5db6c2d4d867b0f29=
fae964cffcf82

I can't tell if it will fix the other ipipe based problem you posted.
Can you please re-test with xenomai next branch? next contains the
necessary fix already.

There is already a pending backport request. Once Jan is back he will
update stable branches accordingly.

Florian

> [=C2=A0=C2=A0=C2=A0 8.304132]=C2=A0 handle_synthetic_irq+0xbb/0x230
> [=C2=A0=C2=A0=C2=A0 8.304133]=C2=A0 asm_call_irq_on_stack+0xf/0x20
> [=C2=A0=C2=A0=C2=A0 8.304133]=C2=A0 </IRQ>
> [=C2=A0=C2=A0=C2=A0 8.304134]=C2=A0 arch_do_IRQ_pipelined+0x16f/0x270
> [=C2=A0=C2=A0=C2=A0 8.304134]=C2=A0 sync_current_irq_stage+0x1c8/0x2d0
> [=C2=A0=C2=A0=C2=A0 8.304135]=C2=A0 ? rcu_is_watching+0x21/0x30
> [=C2=A0=C2=A0=C2=A0 8.304135]=C2=A0 __inband_irq_enable+0x50/0x70
> [=C2=A0=C2=A0=C2=A0 8.304136]=C2=A0 inband_irq_restore+0x25/0x30
> [=C2=A0=C2=A0=C2=A0 8.304136]=C2=A0 _raw_spin_unlock_irqrestore+0x3c/0x70
> [=C2=A0=C2=A0=C2=A0 8.304137]=C2=A0 __set_cpus_allowed_ptr+0xac/0x230
> [=C2=A0=C2=A0=C2=A0 8.304137]=C2=A0 sched_setaffinity+0x3cf/0x770
> [=C2=A0=C2=A0=C2=A0 8.304138]=C2=A0 __x64_sys_sched_setaffinity+0x5d/0x70
> [=C2=A0=C2=A0=C2=A0 8.304138]=C2=A0 do_syscall_64+0x41/0xa0
> [=C2=A0=C2=A0=C2=A0 8.304139]=C2=A0 entry_SYSCALL_64_after_hwframe+0x67/0=
xd1
> [=C2=A0=C2=A0=C2=A0 8.304139] RIP: 0033:0x7f79e855484b
> [=C2=A0=C2=A0=C2=A0 8.304140] Code: 8b 15 49 96 0e 00 f7 d8 41 b9 ff ff f=
f ff 64 89 02 44 89 c8 c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 cb 0=
0 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2d 41 89 c0 83 f8 ff 74 18 64 c7 04 25=
 38 00
> [=C2=A0=C2=A0=C2=A0 8.304141] RSP: 002b:00007fff47506308 EFLAGS: 00000202=
 ORIG_RAX: 00000000000000cb
> [=C2=A0=C2=A0=C2=A0 8.304142] RAX: ffffffffffffffda RBX: 00007fff47506360=
 RCX: 00007f79e855484b
> [=C2=A0=C2=A0=C2=A0 8.304142] RDX: 00007f79e7b57bf0 RSI: 0000000000000080=
 RDI: 000000000000036d
> [=C2=A0=C2=A0=C2=A0 8.304143] RBP: 00007f79e7b57bc8 R08: 0000000000000000=
 R09: 00007f79e863e240
> [=C2=A0=C2=A0=C2=A0 8.304143] R10: 00007fff47506090 R11: 0000000000000202=
 R12: 000055ff0148f510
> [=C2=A0=C2=A0=C2=A0 8.304144] R13: 00007fff47506510 R14: 0000000000000000=
 R15: 0000000000000000
> [=C2=A0=C2=A0=C2=A0 8.304144] Modules linked in: snd_hda_codec_hdmi snd_h=
da_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_inte=
l_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_pcm intel_rapl_msr snd_se=
q_midi intel_rapl_common snd_seq_midi_event x86_pkg_temp_thermal intel_powe=
rclamp coretemp snd_rawmidi kvm_intel mei_hdcp kvm crct10dif_pclmul snd_seq=
 ghash_clmulni_intel snd_seq_device snd_timer aesni_intel crypto_simd crypt=
d snd glue_helper i915 rapl intel_cstate soundcore mei_me drm_kms_helper me=
i cec i2c_algo_bit fb_sys_fops syscopyarea sysfillrect atemsys(O) intel_pch=
_thermal sysimgblt wmi video sch_fq_codel ipmi_devintf ipmi_msghandler msr =
parport_pc ppdev lp parport ramoops drm reed_solomon drm_panel_orientation_=
quirks efi_pstore ip_tables x_tables autofs4 crc32_pclmul i2c_i801 i2c_smbu=
s r8169 realtek ahci libahci intel_lpss_pci intel_lpss idma64
> [=C2=A0=C2=A0=C2=A0 8.304177] CR2: ffff90a1c8c69e40
> able: Directory [=C2=A0=C2=A0=C2=A0 8.797351] ---[ end trace 9a257b32444e=
89fd ]---
> [=C2=A0=C2=A0=C2=A0 8.797351] RIP: 0010:0xffff90a1c8c69e40
> [=C2=A0=C2=A0=C2=A0 8.797352] Code: 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 <00> 00 00 00 00 00 00 00 70 00 00 00 00 00 00 00 08 c0 4c c1=
 4e ad
> [=C2=A0=C2=A0=C2=A0 8.797353] RSP: 0018:ffffad4ec0003f50 EFLAGS: 00010246
> [=C2=A0=C2=A0=C2=A0 8.797354] RAX: ffff90a1c8c69e40 RBX: ffffad4ec1fafd90=
 RCX: 00000000cd46ea8f
> [=C2=A0=C2=A0=C2=A0 8.797354] RDX: ffffad4ec1fafd98 RSI: ffffffff94394069=
 RDI: ffffad4ec1fafd90
> [=C2=A0=C2=A0=C2=A0 8.797355] RBP: ffffad4ec0003f70 R08: 0000000000000001=
 R09: 0000000000000000
> [=C2=A0=C2=A0=C2=A0 8.797355] R10: 0000000000000000 R11: 0000000000000000=
 R12: 0000000000400140
> [=C2=A0=C2=A0=C2=A0 8.797356] R13: 0000000000400140 R14: 0000000000000078=
 R15: ffffffff92f44c60
> [=C2=A0=C2=A0=C2=A0 8.797357] FS:=C2=A0 00007f79e844f740(0000) GS:ffff90a=
325e00000(0000) knlGS:0000000000000000
> [=C2=A0=C2=A0=C2=A0 8.797357] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
> [=C2=A0=C2=A0=C2=A0 8.797358] CR2: ffff90a1c8c69e40 CR3: 00000001039d4006=
 CR4: 00000000003706f0
> [=C2=A0=C2=A0=C2=A0 8.797358] DR0: 0000000000000000 DR1: 0000000000000000=
 DR2: 0000000000000000
> [=C2=A0=C2=A0=C2=A0 8.797359] DR3: 0000000000000000 DR6: 00000000fffe0ff0=
 DR7: 0000000000000400
> [=C2=A0=C2=A0=C2=A0 8.797360] Kernel panic - not syncing: Fatal exception=
 in interrupt
> [=C2=A0=C2=A0=C2=A0 8.797402] Kernel Offset: 0x11e00000 from 0xffffffff81=
000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> ```

