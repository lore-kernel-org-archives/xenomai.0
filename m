Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3A19885D
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929857; cv=none; b=BkSO3St0OHDPhKFxRHbu9M+wY6mfuMA5uNEqK1EAP+jHKt83xMDqBZ00RGpyPYYGwqjlG0r7PyOy4V7aQ7FsLx0I3MqJTVyUDbU9u0CzU/U8kueqZ8f2NKgmexlMHj9LzfPYudTsNMs/VOsPnR2PwyY//IqWVezJ1wxBCgt5YZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929857; c=relaxed/simple;
	bh=Qu9VEx78+nLigmrbrzOPYyiGrcsSHsGgzF41tWWwbSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MQ1B0dKjHR1M7hy8KnMTyK9P3JiN+bBj8EQ1UtnFrNqHWL4PkIqpWK1JzapSy/h7SSnKX1lyP22NRHMirUTuDSczvgiNwvYBhXnPXbykyl0pO41c9qLVM3z1xysOHyLkdbK8jswU9uf/tAvlIx1qRw58qcLiO48SNwcjPAZebq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 00E3D240009
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 11:37:32 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3DB9CD80C7F
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 11:37:31 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43161c0068bso15776125e9.1
        for <xenomai@xenomai.org>; Mon, 18 Nov 2024 03:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731929851; x=1732534651;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qu9VEx78+nLigmrbrzOPYyiGrcsSHsGgzF41tWWwbSU=;
        b=rjJoqjFqWJo5kwDQ6BHxi7CPFTgt0W2hQYXl/74Cr3ZmRXLK6SA4bRyzIPEsEf/FI1
         p5ZuDYKVkU4DtWbtQ/glRmUS9mHoqR/+xTQtrmhdoiAADyc5sR3H8agcm6HWDbOuqc+8
         FvQ/8vwcNxxSCmQSbjwOD3b5+igYo6k8vPKYIfw9UG+zCTb8Q+HBfdeOE250Ceyl5xxI
         mEuOFy/V0BXAkv1VplUjRrabNvsok5JU43XijBoJ0XxZ6TLJ4uVu01w7JyJV5bmUaPBA
         /OjH2U2PO1oupsuyWQL+TTptezx79bo7DiAIF2pUlC3IBxm/ua4/MPfXio6ANeW+WTSm
         d9PA==
X-Forwarded-Encrypted: i=1; AJvYcCWa6DPCIh6k/Y5AzClP3e9eG7BvDU297w45sKcfx0PVoeavseiugGkoWEXI5X5SELx84viPZtaQ@xenomai.org
X-Gm-Message-State: AOJu0YzFLptpNGuKOmATE4JUjLTJH3bRnOvDA2+Iaf9/2Bme6oxJtIXw
	O1NDKbpDGtMrVSBkty5L/296UY/frlNn6tt5wK1uCApyI3TuE8PttUMphc6O
X-Google-Smtp-Source: AGHT+IH1AZjHyarRzDKwgG3X1aOnkZiFGGDauOKq/OIwScQJSfFrQGbd0fxyVS/sqVh9/ebI1YPZBg==
X-Received: by 2002:a05:600c:1c28:b0:431:5503:43ca with SMTP id 5b1f17b1804b1-432df78d4d3mr84942155e9.28.1731929850473;
        Mon, 18 Nov 2024 03:37:30 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ce85sm154446665e9.33.2024.11.18.03.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:37:29 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: "Florian Bezdeka" <florian.bezdeka@siemens.com>,  "Jan Kiszka"
 <jan.kiszka@siemens.com>,  xenomai@xenomai.org
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
In-Reply-To: <1018-673b2280-29-5b0c8700@119759758> (=?utf-8?Q?=22Fran?=
 =?utf-8?Q?=C3=A7ois?= Legal"'s message
	of "Mon, 18 Nov 2024 12:18:24 +0100")
References: <1018-673b2280-29-5b0c8700@119759758>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 12:37:29 +0100
Message-ID: <87ikskkc1y.fsf@xenomai.org>
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
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.128.50 as permitted sender) smtp.mailfrom=philippegerum@gmail.com;
	dmarc=none

Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:

> Le Lundi, Novembre 18, 2024 11:32 CET, Florian Bezdeka <florian.bezdeka@s=
iemens.com> a =C3=A9crit:=20
>=20=20
>> On Mon, 2024-11-18 at 11:21 +0100, Fran=C3=A7ois Legal wrote:
>> > Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan.kiszka@siemens.=
com> a =C3=A9crit:=20
>> > =C2=A0
>> > > On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
>> > > > Hello,
>> > > >=20
>> > > > running on an Arm v7 cortex A9 platform, I'm trying to switch from=
 xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dovetail).
>> > > >=20
>> > > > I can successfully boot my system with linux 5.15 + CONFIG_DOVETAI=
L, but as soon as I enable Xenomai (CONFIG_XENOMAI), I got stuck at boot in=
 a do_idle loop. Did I miss anything ?
>> > > >=20
>> > > > Attached is my config.
>> > >=20
>> > > Can you factor out from it what the SoC is, if you patched the kernel
>> > > for it (in the past and now), if you had to adopt Dovetail etc.?
>> > >=20
>> > > Jan
>> >=20
>> > The SoC is Xilinx zynq 7000. I have custom patches for custom FPGA per=
ipherals (which most of them have been successfully ported to 5.15).
>>=20
>> We had a similar report for the zynq 7020 a couple of days ago.
>> See [1].
>>=20
>> What happens if you disable CONFIG_SMP? (Not that this should be the
>> final solution, but it might help to track the issue down...)
>>=20
>> Florian
>>=20
>
> Disabling config SMP makes my system boot again.
> How can I help working this out ?
>
> Fran=C3=A7ois
>

This looks like an issue with the proxy tick device. First thing is to
disable CONFIG_XENOMAI, enabling CONFIG_IRQ_PIPELINE_TORTURE_TEST. If
the kernel still hangs, we may have a hint about the reason
why. Alternatively, you could keep CONFIG_XENOMAI in, booting the kernel
with "xenomai.state=3Dstopped". If no hang occurs at boot anymore, there
may be an issue with proxying the timer device on this SoC.

[1] https://v4.xenomai.org/dovetail/porting/timer/
[2] https://v4.xenomai.org/dovetail/porting/devnotes/#check-that-the-pipeli=
ne-torture-tests-pass

--=20
Philippe.
