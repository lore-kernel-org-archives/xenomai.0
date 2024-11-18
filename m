Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA0A55
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937045; cv=none; b=fYWAmgOpG7WqL/HrHQkfgEacJn2YP4HQfjuk1PZHB1n8xSZEFa4BrjI+zSRxyvFLDXezIgYPeWj2cVLFbk99I6ovrtjyD2OLzCiSqQhIbwmiED+BMRTn7xLs9OA+s3yyKSf2UY2kxJTjXWvpmzB9fKfL48Ilu9r56r9FUXQgZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937045; c=relaxed/simple;
	bh=K239tUN0zbkXDwPavpmyQylj/+YbUn+fAuO3QBjxK1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W+g4qmhSOV4ABMPeifaRCa43zh4rsTmHJvgqOB1HkOBbnaYXdA9eZNmtRJpDdKxZ97cSwMySnl9aVRMYEUJ87yBMDGblO0P6jNrf7h80yJ7IgT7o/m7/vxkXrkoN3R7Jy0Blc0f9qydThOfWZGJpwQoyKInsw/RrfhftuamXLqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id C5269240003
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 13:37:20 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 06D1CAC181B
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 13:37:20 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-432d9bb168cso24039665e9.1
        for <xenomai@xenomai.org>; Mon, 18 Nov 2024 05:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731937039; x=1732541839;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zv9kpLgXHz5hjMHBVHtrD41jFl27/aB/bChAzVlq5v4=;
        b=aNSbFUkM6XT1Yz5Sg5jzE3twSqV/re6srsTwR+v965hwXR7lVLjRODLikXJU+69ad7
         uw8TjbOzTI1mX/Sgi9ll7e/9OPzAvAjDoCX3rPQvu5FIe1e3klC69VJWBfGoZuDsbpk6
         lUwFJOnfy9fmUAzn/ACGTpjyJMqy4Ct/e8nu1J8CoORjH9VGaW5KPIkqkD4l8a31BszV
         STbSS9W/ACHM0e1pSun3GHR+rJytcbexS91joOzMh294iHKer6mhmrb9SB0BjUDe9s2J
         2gyB+J2ouhFlVfbUJvt/a03MPDCTU/xRS2GuEriDjnvkhkW5CgFDoioamBEzgRMEGbCX
         RRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+cuG4Un2RSNZEpDohDq1UqzuOQtqlr9ova7n9vcg3vQAYs67IWT8GQBLwWVWe0U6E9ZFd5v2c@xenomai.org
X-Gm-Message-State: AOJu0Yz0f/FzIMV3hwQdMur/quZmQLbtmGgG6uUcpJrGAbG66H5N6V50
	x0SIAt6bR3Z2K6jEQmtbZdpX/IQ5hblRXs+6WlYiRoZoB2Y384FS
X-Google-Smtp-Source: AGHT+IEQWiizCr41Uzuki3Vqruycg52lQnBmtt6zI1cae5JRG/sGUQe0gMelpdgD5pscTTbuq3zVFg==
X-Received: by 2002:a5d:598c:0:b0:37d:43a8:dee0 with SMTP id ffacd0b85a97d-38214022204mr15329990f8f.17.1731937039291;
        Mon, 18 Nov 2024 05:37:19 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38243e09ff9sm4297740f8f.68.2024.11.18.05.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 05:37:18 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: "Florian Bezdeka" <florian.bezdeka@siemens.com>,  "Jan Kiszka"
 <jan.kiszka@siemens.com>,  xenomai@xenomai.org,  =?utf-8?B?5a2Z5rab?=
 <suntaoworks@163.com>
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
In-Reply-To: <1017-673b3f80-2f-2c5d8800@259496866> (=?utf-8?Q?=22Fran?=
 =?utf-8?Q?=C3=A7ois?= Legal"'s message
	of "Mon, 18 Nov 2024 14:21:14 +0100")
References: <1017-673b3f80-2f-2c5d8800@259496866>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 14:37:17 +0100
Message-ID: <87cyisk6ia.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.128.45 as permitted sender) smtp.mailfrom=philippegerum@gmail.com

Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:

> Le Lundi, Novembre 18, 2024 13:06 CET, Florian Bezdeka <florian.bezdeka@s=
iemens.com> a =C3=A9crit:=20
>=20=20
>>=20
>> [ Updated CC list to merge both mail threads ]
>>=20
>> On Mon, 2024-11-18 at 12:37 +0100, Philippe Gerum wrote:
>> > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>> >=20
>> > > Le Lundi, Novembre 18, 2024 11:32 CET, Florian Bezdeka <florian.bezd=
eka@siemens.com> a =C3=A9crit:=20
>> > > =C2=A0=20
>> > > > On Mon, 2024-11-18 at 11:21 +0100, Fran=C3=A7ois Legal wrote:
>> > > > > Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan.kiszka@si=
emens.com> a =C3=A9crit:=20
>> > > > > =C2=A0
>> > > > > > On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
>> > > > > > > Hello,
>> > > > > > >=20
>> > > > > > > running on an Arm v7 cortex A9 platform, I'm trying to switc=
h from xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dovetail).
>> > > > > > >=20
>> > > > > > > I can successfully boot my system with linux 5.15 + CONFIG_D=
OVETAIL, but as soon as I enable Xenomai (CONFIG_XENOMAI), I got stuck at b=
oot in a do_idle loop. Did I miss anything ?
>> > > > > > >=20
>> > > > > > > Attached is my config.
>> > > > > >=20
>> > > > > > Can you factor out from it what the SoC is, if you patched the=
 kernel
>> > > > > > for it (in the past and now), if you had to adopt Dovetail etc=
.?
>> > > > > >=20
>> > > > > > Jan
>> > > > >=20
>> > > > > The SoC is Xilinx zynq 7000. I have custom patches for custom FP=
GA peripherals (which most of them have been successfully ported to 5.15).
>> > > >=20
>> > > > We had a similar report for the zynq 7020 a couple of days ago.
>> > > > See [1].
>> > > >=20
>> > > > What happens if you disable CONFIG_SMP? (Not that this should be t=
he
>> > > > final solution, but it might help to track the issue down...)
>> > > >=20
>> > > > Florian
>> > > >=20
>> > >=20
>> > > Disabling config SMP makes my system boot again.
>> > > How can I help working this out ?
>> > >=20
>> > > Fran=C3=A7ois
>> > >=20
>> >=20
>> > This looks like an issue with the proxy tick device. First thing is to
>> > disable CONFIG_XENOMAI, enabling CONFIG_IRQ_PIPELINE_TORTURE_TEST. If
>> > the kernel still hangs, we may have a hint about the reason
>> > why. Alternatively, you could keep CONFIG_XENOMAI in, booting the kern=
el
>> > with "xenomai.state=3Dstopped". If no hang occurs at boot anymore, the=
re
>> > may be an issue with proxying the timer device on this SoC.
>> >=20
>
> CONFIG_IRQ_PIPELINE_TORTURE_TEST seems to report OK (attached bootlog CON=
FIG_IRQ_PIPELINE_TORTURE_TEST.boot
>
> Starting with "xenomai.state=3Dstopped" works (attached boolog xenomai.st=
ate-stopped.boot)
> Starting up xenomai with coreclk afterwards seem to work and not hang sys=
tem :
> root@Arkens_SV:~# /usr/xenomai/sbin/corectl -start
> [  117.328878] CPU1: proxy tick device registered (333.33MHz)
> [  117.328883] CPU0: proxy tick device registered (333.33MHz)
> [  117.339995] [Xenomai] services started
>
>

Ok, so another usual suspect for this issue: some weirdness in the CPU
idling code, which causes a (timer) interrupt to linger indefinitely in
some per-CPU interrupt log. A typical scenario is as follows:

CPUx
----

     default_idle_call() {

      ...
<IRQ> -> logged because local_irq_disable() in effect, _however_ we do NOT
         expect hard irqs to be enabled [1] before entering the idle call
         next =3D> issue is there.
      arch_cpu_idle();
      ...
      /* per-CPU log is not flushed, because of [1] */
     }

At the end of the day, the (most likely) timer IRQ is marked as pending
in the log, but never played, so the kernel activity stalls on that CPU,
especially if the boot CPU is involved.

--=20
Philippe.
