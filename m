Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068593AE1A9
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785308274; cv=none; b=FHsEJZp/wWMwdxnrxi8qo1RFZg5y1gmPoO/d36XVU9duTJuzc6fIYaK7MS9xzlXm3WapXURK1Vijhov1B+Nsk+0miTrFG/RYz7ZWUc5zxAuj82B+V7Iyxk+4GNy4+1IxAzZHRkHHCpYDckbp9/YPFwwPFlfPnMlmAm+B1dRxGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785308274; c=relaxed/simple;
	bh=jfyhT4m4M3eJv6thcNAsJ1LGjg69tqAYtLPuoFvm9D0=;
	h=Date:Message-Id:Subject:In-Reply-To:References:To:Cc:From:
	 Mime-Version:Content-Type; b=FddAgF5UZvM6XGPBDFklRpxZqmkdUl2dJhGuJklzFnv6omFcBJPIWvmz8w5A4uXZiAWZFa9OlNJhjrpYvCzBW5QEDoQ7QwGAV2Ca+u8Xjk2oEcQe6dibRQm9ltP0sQHoG15/EvXcy7pk3SommaQ6eg0/mQKCs/0+ZN0dr+6f4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436675|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.762571-0.000180022-0.237248;FP=14833448277501306330|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.iY4jTaw_1785308259;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.iY4jTaw_1785308259 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 14:57:40 +0800
Date: Wed, 29 Jul 2026 14:57:36 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn>
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.38eb388a.cbef.4959.96f3.b61a0b0ee8f9@feishu.cn> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5cc6cb43.b732.48d7.97db.585e1489779a@feishu.cn> <480ff592-a77e-4d9b-957b-aa856e41821e@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5571d0ff.0b5a.4df0.8cd4.bf262a5fca73@feishu.cn>
	<08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com>
	<ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn>
X-Lms-Return-Path: <lba+16a69a461+31606e+siemens.com+liuyang@sinsegye.com.cn>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
=C2=A0=C2=A0 We have already conducted long-term tests on the following har=
dware platforms using kernel 6.12.55 with Xenomai 3.3.1: N100, N97, J6412, =
i5-12400, and AMD Ryzen 7 8845HS. I am using the 6.12.y-cip-dovetail-rebase=
=C2=A0branch, and the latest kernel version available in this branch is 6.1=
2.90. I can use the xenomai-image=C2=A0provided officially by Xenomai. Coul=
d you please provide a download link for the xenomai-image=C2=A0correspondi=
ng to the 6.12 kernel version?
If we completely disable the NVIDIA driver, our test programs may not run p=
roperly. I will disable the nvidia_uvm=C2=A0driver later for further verifi=
cation.
For the 6.18 kernel, I compiled it from the 6.18.y-dovetail-rebase=C2=A0bra=
nch. The 6.18 kernel exhibits the same issue: the system hangs after runnin=
g for a certain period. However, when using the 6.18 kernel, SSH remains ac=
cessible even after the hang.

Thanks
> From: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> Date:=C2=A0 Wed, Jul 29, 2026, 14:44
> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 =
on Intel Ultra 5 125H
> To: "Jan Kiszka"<jan.kiszka@siemens.com>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>
> Hi,
> =C2=A0=C2=A0 We have already conducted long-term tests on the following h=
ardware platforms using kernel 6.12.55 with Xenomai 3.3.1: N100, N97, J6412=
, i5-12400, and AMD Ryzen 7 8845HS. I am using the 6.12.y-cip-dovetail-reba=
se=C2=A0branch, and the latest kernel version available in this branch is 6=
.12.90. I can use the xenomai-image=C2=A0provided officially by Xenomai. Co=
uld you please provide a download link for the xenomai-image=C2=A0correspon=
ding to the 6.12 kernel version?
> If we completely disable the NVIDIA driver, our test programs may not run=
 properly. I will disable the nvidia_uvm=C2=A0driver later for further veri=
fication.
> For the 6.18 kernel, I compiled it from the 6.18.y-dovetail-rebase=C2=A0b=
ranch. The 6.18 kernel exhibits the same issue: the system hangs after runn=
ing for a certain period. However, when using the 6.18 kernel, SSH remains =
accessible even after the hang.
>=C2=A0
>=C2=A0
> Thanks
> From: "Jan Kiszka"<jan.kiszka@siemens.com>
> Date:=C2=A0 Wed, Jul 29, 2026, 14:32
> Subject:=C2=A0 Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 =
on Intel Ultra 5 125H
> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>
> Cc: "xenomai"<xenomai@lists.linux.dev>, "=E5=AE=8B=E5=81=A5=E7=8E=AE"<son=
gjianwei@sinsegye.com.cn>
> On 29.07.26 08:05, =E5=88=98=E6=9D=A8 wrote:
> > Hi.
> > =C2=A0=C2=A0 =C2=A0I have already performed the following tests:
> > 1. Linux 6.18.20 + Xenomai 3.3.1: the system hangs during boot, but SSH=
 login is still possible.
> > 2. Linux 6.12.90 + Xenomai 3.3.1: the system completely freezes (hard l=
ock).
>=C2=A0
> Self-ported? Latest 6.12 is only v6.12.85-cip22-dovetail1
>=C2=A0
> > 3. Linux 6.12.55 + GRUB configuration with xenomai.state=3Ddisabled: th=
e system freezes.
> > 4. Linux 6.12.55 without Dovetail and Cobalt: the system runs normally.
> > 5.Linux 6.12.55 + xenomai 3.3.1=C2=A0 Using the Xe driver instead of i9=
15 =C2=A0 the system freezes.
> > 6.Linux 6.12.55 + xenomai 3.3.1 and nvidia_uvn.ko with uvm_disable_hmm=
=3D1 uvm_perf_prefetch_enable=3D0 =C2=A0=C2=A0 the system freezes.
>=C2=A0
> That's quite a lot of variations. Pick the simplest one, with least
> dependencies on special things, reproduce the issue and compare to a
> working setup, I would say. Such hard freezes left and right are
> unusual, and there must be one more or less special variable that
> triggers them. E.g., if you just use our x86 6.12 image from
> xenomai-images, does that run the basic tests on your hardware?
>=C2=A0
> >=C2=A0
> > CONFIG_XENO_OPT_WATCHDOG is enbale and set to 30.
> >=C2=A0
> > On Ubuntu 24.04, I monitored the CPU; the CPU utilisation is around 30%=
. A Gemini 360L camera is connected to the USB controller. I ran nvidia-smi=
=C2=A0and obtained the following output (please provide the output if you n=
eed further analysis).
> > There is also an f81601a CAN interface connected to the machine, which =
uses CAN FD to connect six motors.
>=C2=A0
> Does adding/removing this part of your workload make a difference? I
> guess not when you describe those boot freeze with 6.18 above, but still
> a variation from a generic system setup.
>=C2=A0
> > +----------------------------------------------------------------------=
-------------------+
> > | NVIDIA-SMI 580.173.02 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Drive=
r Version: 580.173.02 =C2=A0 =C2=A0 CUDA Version: 13.0 =C2=A0 =C2=A0 |
> > +-----------------------------------------+------------------------+---=
-------------------+
> > | GPU=C2=A0 Name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Persistence-M | Bus-Id =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 Disp.A | Volat=
ile Uncorr. ECC |
> > | Fan=C2=A0 Temp =C2=A0 Perf =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 Pwr:Usag=
e/Cap | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory-Usage | GPU-Util=C2=A0 Co=
mpute M. |
> > | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIG M. |
> > |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
> > | =C2=A0 0=C2=A0 NVIDIA GeForce RTX 4060 ... =C2=A0=C2=A0 Off | =C2=A0 =
00000000:01:00.0 Off | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 N/A |
> > | N/A =C2=A0 37C =C2=A0=C2=A0 P0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 27W /=C2=A0 115W | =C2=A0 =C2=A0 141MiB / =C2=A0 8188MiB | =C2=A0 =C2=
=A0=C2=A0 1% =C2=A0 =C2=A0=C2=A0 Default |
> > | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 N=
/A |
> > +-----------------------------------------+------------------------+---=
-------------------+
> >=C2=A0
> > +----------------------------------------------------------------------=
-------------------+
> > | Processes: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 |
> > |=C2=A0 GPU =C2=A0 GI =C2=A0 CI =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 PID =C2=A0 Type =C2=A0 Process name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 GPU Memory |
> > | =C2=A0 =C2=A0 =C2=A0=C2=A0 ID =C2=A0 ID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Usage =C2=A0 =C2=A0=C2=A0 |
> > |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
> > | =C2=A0=C2=A0 0 =C2=A0 N/A=C2=A0 N/A =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 1892 =C2=A0 =C2=A0=C2=A0 C =C2=A0 /usr/NX/bin/nxnode.bin =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 131MiB |
> > +----------------------------------------------------------------------=
-------------------+
> >=C2=A0
>=C2=A0
> Not loading the nvidia driver does not make a difference for the
> freezes? Or is it mandatory to even start some reasonable load that is
> needed to trigger the freezes?
>=C2=A0
> Jan
>=C2=A0
> --=C2=A0
> Siemens AG, Foundational Technologies
> Linux Expert Center
>=C2=A0
