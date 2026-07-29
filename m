Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807D492512
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332144; cv=none; b=bIM9KNnBnCJJjlBFE2mnpYDQ4KbOK5d7Yxz2LcIsY0UICE503K1vT0vCTEYsNfK9Nd+MuVI0RSeuycJcHsjl4pcVRWMfLLvtMuT5sRe6XlYlQKl85n/UZeGdT+X/hkXI731sxTS7dvwyyvugzqV9is0KXVzFUOKem3Fnk0PMVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332144; c=relaxed/simple;
	bh=CUcTMBAYucXcOK1x79qjsGgOUfUvWb5u9SuCZL0e8DE=;
	h=Message-Id:To:Date:Subject:From:Mime-Version:References:
	 In-Reply-To:Content-Type:Cc; b=nQsLA5a4K7ZNdJeQoy5ii7hrO92Eun568t9kTyh0KUrZ426dAAXgj16ULa2AACbIiVIXArhg6SAR3qzXyXBayrVujm7XwakeK6qfH4EwwMOfvP5036SbiABf3IKPExrBuVL4l0eRQvLouiSRA0zcOQHz8VJt8xUp8lKmMJak2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07888697|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00461104-0.000367616-0.995021;FP=10082010676427665914|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.iYZ409c_1785332133;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.iYZ409c_1785332133 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 21:35:34 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.06d37e0f.d9fe.473b.a955.bacccbca8173@feishu.cn>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
X-Lms-Return-Path: <lba+16a6a01a3+2599d3+sinsegye.com.cn+liuyang@sinsegye.com.cn>
Date: Wed, 29 Jul 2026 21:35:31 +0800
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.38eb388a.cbef.4959.96f3.b61a0b0ee8f9@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5cc6cb43.b732.48d7.97db.585e1489779a@feishu.cn> <480ff592-a77e-4d9b-957b-aa856e41821e@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5571d0ff.0b5a.4df0.8cd4.bf262a5fca73@feishu.cn> <08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn> <5905a920-e911-48bd-9959-d8702b512272@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.2cdf3bbf.6288.45f6.b5d6.9760f144d99c@feishu.cn>
	<2b95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siemens.com>
	<ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.09468bbe.a918.4120.abc3.991d1d35a187@feishu.cn>
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.09468bbe.a918.4120.abc3.991d1d35a187@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>, 
	=?utf-8?q?=E6=9D=8E=E5=B0=8F=E5=AE=81?= <lixiaoning@sinsegye.com.cn>, 
	=?utf-8?q?=E9=A9=AC=E5=90=9B?= <majun@sinsegye.com.cn>

Thank you. I will test according to your suggestions and collect the logs.

> From: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> Date:=C2=A0 Wed, Jul 29, 2026, 19:22
> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 =
on Intel Ultra 5 125H
> To: "Jan Kiszka"<jan.kiszka@siemens.com>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sinsegy=
e.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> Thank you. I will test according to your suggestions and collect the logs=
.
> From: "Jan Kiszka"<jan.kiszka@siemens.com>
> Date:=C2=A0 Wed, Jul 29, 2026, 17:26
> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 =
on Intel Ultra 5 125H
> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sinsegy=
e.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> On 29.07.26 10:04, =E5=88=98=E6=9D=A8 wrote:
> > Thank you for your reply. Regarding kernel ftrace, do you have any sugg=
estions on which parts I should mainly trace? If I enable tracing for every=
thing, the output file will become extremely large
> >=C2=A0
>=C2=A0
>=C2=A0
> Baseline trace:
> - cobalt*
> - sched*
> - irq and irq_vectors
> - signal*
>=C2=A0
>=C2=A0
> You could use continuous tracing into RAM (without writing it to disk)
> and trigger the stop rcu_stall_warning:
>=C2=A0
>=C2=A0
> echo traceoff > /sys/kernel/tracing/events/rcu/rcu_stall_warning/trigger
> (untested, might be wrong)
>=C2=A0
>=C2=A0
> If the trace is then actually stopped after the error, you can safe it
> from /sys/kernel/tracing/trace, or via trace-cmd.
>=C2=A0
>=C2=A0
> If the events are still too many, drop irqs first.
>=C2=A0
>=C2=A0
> Jan
>=C2=A0
>=C2=A0
> --=C2=A0
> Siemens AG, Foundational Technologies
> Linux Expert Center
