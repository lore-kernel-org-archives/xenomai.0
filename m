Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E53451BA
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478441; cv=none; b=KP9DZntWhvBa8kAR9fckHnninxEx1MG0aqeX40iBMuMeis8ypJyCP2J7d0u4WNamf2R/hXTFTnxkalfkfVIs3Z0pjvojrO1IIsAsTaYv/I1dGOR2IRGqkXTM4DUIEWQUiuo2/unqR/uPVjLoUCEeOOWp/xcUQrE8yD3RsjLc2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478441; c=relaxed/simple;
	bh=8nFJQtCGkUysVz/MIQ1DSACmPbFbZtL38YJkcPJpiY4=;
	h=References:In-Reply-To:Date:Message-Id:To:Subject:From:Cc:
	 Mime-Version:Content-Type; b=iihd3HrINQeq+API5OJR3XA7H9xRlWZVJuUxrKSaAHzM5+2CDm1abOt5KHRKUvp0OW1ZUPccM4Pcs2VSj8AvDeosw9nPdrlMtrJbm8mdu6/2RO5KCbfGnx1DpplJHBv3GuUCb79UJE2kxAVMg5Zvd5qZGiE7EQjXxG9/w0STWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0757356|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00650473-6.83659e-05-0.993427;FP=12387570389194715510|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.ia8lI9F_1785478428;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.ia8lI9F_1785478428 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 14:13:49 +0800
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn> <08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn> <5905a920-e911-48bd-9959-d8702b512272@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.2cdf3bbf.6288.45f6.b5d6.9760f144d99c@feishu.cn> <2b95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.09468bbe.a918.4120.abc3.991d1d35a187@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.06d37e0f.d9fe.473b.a955.bacccbca8173@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.8107967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feishu.cn> <1c7d4293-6754-4690-bf73-aba6e17d0c0e@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.c699737c.9d30.43b7.9ed8.a2a9042fb8f3@feishu.cn>
	<67ed5d8f-0a4c-432b-ab59-a4cbcbe91a34@siemens.com>
In-Reply-To: <67ed5d8f-0a4c-432b-ab59-a4cbcbe91a34@siemens.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:13:45 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.feee15f9.216e.4b39.b573.9ad554d5eb50@feishu.cn>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Cc: "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>, 
	=?utf-8?q?=E6=9D=8E=E5=B0=8F=E5=AE=81?= <lixiaoning@sinsegye.com.cn>, 
	=?utf-8?q?=E9=A9=AC=E5=90=9B?= <majun@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16a6c3d1a+e5073f+sinsegye.com.cn+liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8

Yes, I have only installed the kernel with Dovetail and Cobalt patches. No =
user-space programs linked against Cobalt are running.

Liuyang

> From: "Jan Kiszka"<jan.kiszka@siemens.com>
> Date:=C2=A0 Fri, Jul 31, 2026, 14:10
> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 =
on Intel Ultra 5 125H
> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sinsegy=
e.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> On 31.07.26 08:01, =E5=88=98=E6=9D=A8 wrote:
> > Hello Jan,
> > =C2=A0=C2=A0=C2=A0 No Xenomai user=E2=80=91space programs are running o=
n the customer=E2=80=99s system.
> >=C2=A0
>=C2=A0
> So, you are getting a stall in the absence of any Xenomai load, but
> while running a Xenomai-enabled kernel?
>=C2=A0
> Another thing you can try is turning on debugging switches of the
> kernel, specifically
>=C2=A0
> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master=
/cfg/lock-debugging.cfg?ref_type=3Dheads
>=C2=A0
> Jan
>=C2=A0
> >> From: "Jan Kiszka"<jan.kiszka@siemens.com>
> >> Date:=C2=A0 Fri, Jul 31, 2026, 13:44
> >> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3=
.1 on Intel Ultra 5 125H
> >> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> >> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<=
songjianwei@sinsegye.com.cn>, "=E6=9D=8E=E5=B0=8F=E5=AE=81"<lixiaoning@sins=
egye.com.cn>, "=E9=A9=AC=E5=90=9B"<majun@sinsegye.com.cn>
> >> On 31.07.26 06:25, =E5=88=98=E6=9D=A8 wrote:
> >>> Hello,
> >>> I am using Linux kernel 6.18 with Xenomai 3.3.1. I have set i915.mode=
set=3D0=C2=A0in GRUB to prevent the i915 driver from loading.
> >>> Since trace=E2=80=91cmd logs cannot be dumped when the kernel hangs, =
I configured the following sysctl parameters:
> >>> plaintext
> >>> =C2=A0
> >>> sudo=C2=A0sysctl -w kernel.panic_on_rcu_stall=3D1
> >>> sudo=C2=A0sysctl -w kernel.ftrace_dump_on_oops=3D1
> >>> sudo=C2=A0sysctl -w kernel.panic=3D0
> >>> =C2=A0
> >>> The full serial log is attached. Could you please help analyze whethe=
r the log contains sufficient information for troubleshooting? Thank you.
> >> =C2=A0
> >> I'm missing cobalt events other cores and an annotation inside the tra=
ce
> >> where the error was noticed. That's why I proposed a different recordi=
ng
> >> method.
> >> =C2=A0
> >> Also, as the RCU stall detection may be delayed too much to still see
> >> normal operation in the trace, you might have to tune the timeout
> >> (https://docs.kernel.org/RCU/stallwarn.html#fine-tuning-the-rcu-cpu-st=
all-detector)
> >> until we find an earlier problem indicator.
> >> =C2=A0
> >> Jan
> >> =C2=A0
> >> --=C2=A0
> >> Siemens AG, Foundational Technologies
> >> Linux Expert Center
> >> =C2=A0
>=C2=A0
>=C2=A0
> --=C2=A0
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=C2=A0
