Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5115A6
	for <xenomai@lists.linux.dev>; Sat, 27 Aug 2022 08:42:57 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id E3DE0C3792
	for <xenomai@lists.linux.dev>; Sat, 27 Aug 2022 08:34:31 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id F3EB5C0004;
	Sat, 27 Aug 2022 08:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1661589264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1UOKmKECG7lzKX6k2FQ9malMPg02GQwu8rzAb0tIE8=;
	b=AHvHaMH41IJI0vOLkE/OkI6mDYhdNf8nIcTNFNUJIJKx8y0W4ZRW4YBcRIp6f5FhQINhln
	VfRxxoHGU57Y1QIaxnncwRa8HENwwjpk0pH1lwcZDuEVdfWA/uXg6yfWln0F2V5Iyc85O5
	G/nf3rV0lBieYeFr/qZHFpClo/kIR1sgwkIMWQhdw1/vqZe6CLF/T5+bpD1XnJmV+SjzQc
	wKHWuXsAK0GbxrSNx5Ylw9XFP2VTDeTlHtq8t3Zxr8/QpIRw+/txEQw/km0kjXxxdQN7VM
	HPvdAUcJqXo+DwNAFQkYlTjjhFsOy/K/nYMQvaCkUmFejsRGd1wa4GLUm4VtJQ==
References: <MW3PR12MB4460264EEABB2C91E529440BC2759@MW3PR12MB4460.namprd12.prod.outlook.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: PCI probe fails (Cobalt 3.2.2 / Dovetail 5.15.y-dovetail)
Date: Sat, 27 Aug 2022 10:13:30 +0200
In-reply-to: <MW3PR12MB4460264EEABB2C91E529440BC2759@MW3PR12MB4460.namprd12.prod.outlook.com>
Message-ID: <87tu5yaxv5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Kendall,

"Auel, Kendall" <Kendall.Auel@3DSystems.Com> writes:

> I'm porting a working PCI device driver from Cobalt/IPipe to
> Cobalt/Dovetail and everything builds normally. When I attempt to
> install the driver I get the error pasted below. I tried sending the
> IRQF_SHARED flag in rtdm_irq_request but it didn't help (the flag was
> ignored perhaps?). Any thoughts on what to try next? I suppose I'll
> trace through the cobalt code and into dovetail to see why the shared
> flag didn't take and why xnintr_destroy is being called.
>
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: genirq: Flags mismatch irq 16. 00=
210000 (bolt) vs. 00000080 (i801_smbus)=20
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: ------------[ cut here ]---------=
---
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: Trying to free already-free IRQ 16
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: WARNING: CPU: 3 PID: 47441 at ker=
nel/irq/manage.c:1942 free_irq+0x249/0x470
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: Modules linked in: bolt_driver(OE=
+) evbus_driver(OE) nls_iso8859_1 i915 intel_rapl_msr intel_rapl_common x86=
_pkg_temp_thermal intel_>
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: CPU: 3 PID: 47441 Comm: insmod Ta=
inted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 5.15.57-bolt #1
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: Hardware name: Default string Def=
ault string/Default string, BIOS 1.01B 09/21/2020
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: IRQ stage: Linux
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: RIP: 0010:free_irq+0x249/0x470
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: Code: 41 0f b1 94 24 c0 00 00 00 =
0f 85 c0 01 00 00 9c 41 59 e9 76 fe ff ff 44 89 fe 48 c7 c7 18 d2 b2 82 4c =
89 4d c8 e8 a3 58 9f 00 >
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: RSP: 0018:ffffa52ec15579b0 EFLAGS=
: 00010082
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: RAX: 0000000000000000 RBX: ffffff=
ffc0a23aa0 RCX: 0000000000000027
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: RDX: 0000000000000027 RSI: 800000=
00ffffe62f RDI: ffff8ac67659f4c8
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: RBP: ffffa52ec15579e8 R08: ffff8a=
c67659f4c0 R09: 0000000000000001
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: R10: 0000000000000001 R11: ffffff=
ff8335689a R12: ffff8ac5001f6000
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: R13: ffff8ac5001f6180 R14: ffff8a=
c500cfec80 R15: 0000000000000010
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: FS: =C2=A000007f1174eda540(0000) =
GS:ffff8ac676580000(0000) knlGS:0000000000000000
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: CS: =C2=A00010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: CR2: 000055ba0acd3c28 CR3: 000000=
01025ec002 CR4: 00000000003706e0
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: Call Trace:
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: =C2=A0<TASK>
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: =C2=A0xnintr_detach+0x25/0x30
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: =C2=A0xnintr_destroy+0xe/0x20
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: =C2=A0rtdm_irq_request_affine+0x8=
2/0xa0
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: =C2=A0rtdm_irq_request+0x10/0x20
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: =C2=A0bolt_pci_probe+0x192/0x240 =
[bolt_driver]
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: =C2=A0local_pci_probe+0x48/0x90
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: =C2=A0pci_device_probe+0x113/0x1c0
> Aug 26 11:21:26 xeno-mx3110h-01 kernel: =C2=A0really_probe+0x1a4/0x3e0
>
>

There are multiple issues:

- Dovetail does allow sharing lines for oob interrupts [1], _only_ if
  IRQF_OOB|IRQF_SHARED are set for all handlers attached to the shared
  IRQ line. "genirq: Flags mismatch" reports an issue with this. The
  smbus handler was set to IRQF_SHARED (0x00000080), whilst the 'bolt'
  IRQ handler was given IRQF_OOB[|IRQF_NO_THREAD]. In order to share
  this line with the 'bolt' device, you would need to enable IRQF_OOB on
  the smbus handler as well.

- Now, enabling IRQF_SHARED on an oob line is not possible with the
  current implementation of xnintr_attach() in 3.2.2, which forces the
  irqflags to IRQF_OOB. At the very least, you would need a way to pass
  IRQF_OOB|IRQF_SHARED there.

- xnintr_destroy() assumes the IRQ was successfully attached/requested,
  as it attempts to free it. Cobalt/I-pipe had a state bit guarding this
  condition, which does not exist in the Dovetail-based version of
  Cobalt. As a result, rtdm_irq_request_affine() calls xnintr_destroy()
  unconditionally to cleanup the mess after xnintr_attach() failed,
  causing this report: "Trying to free already-free IRQ 16".

Do you actually have to share IRQ16 between the bolt and smbus devices?
Although possible via some ugly hack, sharing IRQs between rt and non-rt
devices is a real problem.

[1]
https://evlproject.org/dovetail/pipeline/irq_handling/#request-oob-irq

--=20
Philippe.
