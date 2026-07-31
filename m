Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A44353A92
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478052; cv=none; b=e+HoN0bW1CZzQxgR+Svjz5uHSTBigYhOZGA3DII22zoyPhbbt4y7++g/mkKEfQgx31dVS+8dktGrRaqTq60TDOag9RCYI3m+9uH6Nnxg/YSPFhAmlsCFQmC4irc8M0J/asqqPWl8tbC9ziZg9zuz0A29qZ2O4PiueDJqkdJVQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478052; c=relaxed/simple;
	bh=U74J8K3oOvLPfaqygv682Bmn1hWHLwXNAjCofdIOVwQ=;
	h=Subject:In-Reply-To:Date:Message-Id:To:Cc:From:Mime-Version:
	 References:Content-Type; b=WezxG1ovsbXdwvHaR+S445i5XXYYbowoiUIfIrkEHe5ffxRUFqiRqvrzaZCAaVssNfysGFAsO77mdrxAmhAnh+CxjM9fVliM3X5amiRlIE9GQt5VjQc4K99NL9sIoZt4cthzOI9WZ+3zZLUK75H2kLkmpAxTTZf7xi0gxEy6gCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08640271|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00205169-0.00026103-0.997687;FP=12388133373641308532|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.ia9RDip_1785477720;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.ia9RDip_1785477720 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 14:02:00 +0800
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
In-Reply-To: <1c7d4293-6754-4690-bf73-aba6e17d0c0e@siemens.com>
X-Lms-Return-Path: <lba+16a6c3a56+95e55d+siemens.com+liuyang@sinsegye.com.cn>
Date: Fri, 31 Jul 2026 14:01:57 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.c699737c.9d30.43b7.9ed8.a2a9042fb8f3@feishu.cn>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>, 
	=?utf-8?q?=E6=9D=8E=E5=B0=8F=E5=AE=81?= <lixiaoning@sinsegye.com.cn>, 
	=?utf-8?q?=E9=A9=AC=E5=90=9B?= <majun@sinsegye.com.cn>
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn> <480ff592-a77e-4d9b-957b-aa856e41821e@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5571d0ff.0b5a.4df0.8cd4.bf262a5fca73@feishu.cn> <08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn> <5905a920-e911-48bd-9959-d8702b512272@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.2cdf3bbf.6288.45f6.b5d6.9760f144d99c@feishu.cn> <2b95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.09468bbe.a918.4120.abc3.991d1d35a187@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.06d37e0f.d9fe.473b.a955.bacccbca8173@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.8107967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feishu.cn>
	<1c7d4293-6754-4690-bf73-aba6e17d0c0e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Jan,
=C2=A0=C2=A0=C2=A0 No Xenomai user=E2=80=91space programs are running on th=
e customer=E2=80=99s system.

> From: "Jan Kiszka"<jan.kiszka@siemens.com>
> Date:=C2=A0 Fri, Jul 31, 2026, 13:44
> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 =
on Intel Ultra 5 125H
> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sinsegy=
e.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> On 31.07.26 06:25, =E5=88=98=E6=9D=A8 wrote:
> > Hello,
> > I am using Linux kernel 6.18 with Xenomai 3.3.1. I have set i915.modese=
t=3D0=C2=A0in GRUB to prevent the i915 driver from loading.
> > Since trace=E2=80=91cmd logs cannot be dumped when the kernel hangs, I =
configured the following sysctl parameters:
> > plaintext
> >=C2=A0
> > sudo=C2=A0sysctl -w kernel.panic_on_rcu_stall=3D1
> > sudo=C2=A0sysctl -w kernel.ftrace_dump_on_oops=3D1
> > sudo=C2=A0sysctl -w kernel.panic=3D0
> >=C2=A0
> > The full serial log is attached. Could you please help analyze whether =
the log contains sufficient information for troubleshooting? Thank you.
>=C2=A0
> I'm missing cobalt events other cores and an annotation inside the trace
> where the error was noticed. That's why I proposed a different recording
> method.
>=C2=A0
> Also, as the RCU stall detection may be delayed too much to still see
> normal operation in the trace, you might have to tune the timeout
> (https://docs.kernel.org/RCU/stallwarn.html#fine-tuning-the-rcu-cpu-stall=
-detector)
> until we find an earlier problem indicator.
>=C2=A0
> Jan
>=C2=A0
> --=C2=A0
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=C2=A0
