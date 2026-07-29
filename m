Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2343DA20
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312306; cv=none; b=W4TTW+rVSyr5IrjpYRiRigii6PutAjjsNZy5etFCcLdnCqOrsYwC5sTi7RlU34vn+yadz+ihDYsqalkLGYgBwhRz41BBwbWLfOFyPi84NoBQt79xLHYIalMeQLRGzDOYXbFDMzSejRr1WuZOba/hPJlPr4inp5fyOUF9wCmKMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312306; c=relaxed/simple;
	bh=UpwA5I1BYzpYhlp+Y5c83XwkRh938i6Bno2khkBe+Q8=;
	h=From:Content-Type:Message-Id:Cc:Subject:References:In-Reply-To:
	 Date:To:Mime-Version; b=VxeV99CV8tzSsmmTPfHIVugUA8VTJugL4hmoEn32f72vteBNV7eHEey3uYIPzAXzWwm7bfWHpmVgBBjowpelSfuCgS2yEKfVvY2fmZwkS5+Z0tmRUdstc6UYqKcQulMgBgMy4rYIL1pitBAO5G88Gopolk7d1u3uIxQp3aaBMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1005369|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.17847-0.0013749-0.820155;FP=14688771170266280826|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.iYC.bh2_1785312289;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.iYC.bh2_1785312289 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 16:04:50 +0800
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
X-Lms-Return-Path: <lba+16a69b41d+59d305+lists.linux.dev+liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.2cdf3bbf.6288.45f6.b5d6.9760f144d99c@feishu.cn>
Cc: "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>, 
	=?utf-8?q?=E6=9D=8E=E5=B0=8F=E5=AE=81?= <lixiaoning@sinsegye.com.cn>, 
	=?utf-8?q?=E9=A9=AC=E5=90=9B?= <majun@sinsegye.com.cn>
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.38eb388a.cbef.4959.96f3.b61a0b0ee8f9@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5cc6cb43.b732.48d7.97db.585e1489779a@feishu.cn> <480ff592-a77e-4d9b-957b-aa856e41821e@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5571d0ff.0b5a.4df0.8cd4.bf262a5fca73@feishu.cn> <08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn>
	<5905a920-e911-48bd-9959-d8702b512272@siemens.com>
In-Reply-To: <5905a920-e911-48bd-9959-d8702b512272@siemens.com>
Date: Wed, 29 Jul 2026 16:04:44 +0800
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0

Thank you for your reply. Regarding kernel ftrace, do you have any suggesti=
ons on which parts I should mainly trace? If I enable tracing for everythin=
g, the output file will become extremely large

> From: "Jan Kiszka"<jan.kiszka@siemens.com>
> Date:=C2=A0 Wed, Jul 29, 2026, 15:54
> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 =
on Intel Ultra 5 125H
> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>
> On 29.07.26 08:57, =E5=88=98=E6=9D=A8 wrote:
> > Hi,
> > =C2=A0=C2=A0 We have already conducted long-term tests on the following=
 hardware platforms using kernel 6.12.55 with Xenomai 3.3.1: N100, N97, J64=
12, i5-12400, and AMD Ryzen 7 8845HS. I am using the 6.12.y-cip-dovetail-re=
base=C2=A0branch, and the latest kernel version available in this branch is=
 6.12.90. I can use the xenomai-
>=C2=A0
> Ups, I guess I need to re-sync the v6.12.y-cip-dovetail to -rebase soon..=
.
>=C2=A0
> > image=C2=A0provided officially by Xenomai. Could you please provide a d=
ownload link for the xenomai-image=C2=A0corresponding to the 6.12 kernel ve=
rsion?
>=C2=A0
> We do not offer pre-built images, but it should be rather simple to
> generate one yourself, just following the README.
>=C2=A0
> > If we completely disable the NVIDIA driver, our test programs may not r=
un properly. I will disable the nvidia_uvm=C2=A0driver later for further ve=
rification.
> > For the 6.18 kernel, I compiled it from the 6.18.y-dovetail-rebase=C2=
=A0branch. The 6.18 kernel exhibits the same issue: the system hangs after =
running for a certain period. However, when using the 6.18 kernel, SSH rema=
ins accessible even after the hang.
> >=C2=A0
>=C2=A0
> Then you could try to let tracing run during the test and extract an
> event trace after the hang. Maybe that reveal how the core(s) lock up,
> over which exact workload.
>=C2=A0
> Jan
>=C2=A0
> --=C2=A0
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=C2=A0
