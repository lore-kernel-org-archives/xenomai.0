Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554719066D
	for <xenomai@lists.linux.dev>; Sun,  5 Jan 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098118; cv=none; b=k0zf/y47JAawUa4ecAJ6lnlKS5xWwxtNYx0Ptbv3cxA27iXf3dbGXKWofYO+tY/4Zicij6IA0FhHdaiKorTfmOimvQVwMqSKCMBF5E9khkVk8DVSkXkjLJalBljPVRLO84A21M0FaUhUNhRY9eYELoBuWCSLUFnCX31Tfdp1W44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098118; c=relaxed/simple;
	bh=pVnMWLNLjLzF8LcntgutP08F9L/hVh0hxB0lOboIVb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F18pxulHMA9qnXM30GmR/uqwby6ngL7DTd4gRoDZc1pGCCTujkJnQHBTizYeZs3VuKB61tDaAjp2YT7upsjYE2YmCPQjJRUdTgXMNWxd1UUcQp9hG754SJeiQPOPAbqx1W4hR+bz1i8AoJPu6VgCze6zjNx8QvO1sIrfh9yj9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385df53e559so10779343f8f.3
        for <xenomai@lists.linux.dev>; Sun, 05 Jan 2025 09:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736098113; x=1736702913;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pVnMWLNLjLzF8LcntgutP08F9L/hVh0hxB0lOboIVb0=;
        b=KYdchRcUWnw9wNx/7Hoob/xjpIx7uHhJTABapzNLTTaOjH3xgnTP/SZGiQINoOnLp6
         ALg+7XnXZpSkhDXpDbYyOsO2oIM3lR06UWg84aaJ7WS09M0pIpBXRIqS9i3a2DsF05r+
         L0gB2Q8ZHP4tHGFquFB8pSz53Rpmt2VmDMnWuYCkQCtN/qb9fw6H3ahOQilt8Hvt1O3p
         3Z1GGyiHxe2LUkoenYNsgwsy+SFx2PpMJ8LVqWRJhpF+rD5O1GFZo9Ht28pTFt3N7PUX
         QX+mBMpJmz+ceOJG8cgHoxWi8uL6iuYtTE7ohoPkonu9t/IiFFIvuUOMIB7AUKnanN5B
         peBQ==
X-Gm-Message-State: AOJu0YzOSEfmtq44TFAxRSUy0eY6kQOqzIpUgT0AjZa8sEDMkTeNvhQX
	oXtzHQl4FEtS8FRbH22xbr/cLe1RiRXFFjwgP1EhM2vMVDo11sT1kYKB8A==
X-Gm-Gg: ASbGncuhOlgKSwT6hgbQheMYxHgcBQrDcXZyXrxUoJH95yLIymYyfvEwwo5cKlU1zgc
	VDPmtO7+FRKE7H85vks1GXoR6R76K9ihwAKRdCWiCJOo9+k7kl5UR09qnpCYITygKN6lc58839l
	FjIsFu7i1p6u+26R+AWpcZ1H4sy6KehrG5zc9C01BIaWgx0EPrJADEAsoThQER4v4avARRTZTpd
	Md10MYl8Qz48eGvS0ABBXYtpP2K8EcrD0utpO+QOQ==
X-Google-Smtp-Source: AGHT+IEO59LpUI2eJApu6MlEalCTdszpwX9TOc8mFvHxSL2M9MeU7fxGkNxhJgQIDAZMhVTwlEpZDw==
X-Received: by 2002:a5d:6c63:0:b0:386:3e0f:944b with SMTP id ffacd0b85a97d-38a223ffbfbmr41416809f8f.37.1736098112979;
        Sun, 05 Jan 2025 09:28:32 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b013e1sm571711255e9.12.2025.01.05.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 09:28:32 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Hongbo Wang <hongbo.wang@nxp.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: FW: [EXT] Re: =?utf-8?B?6L2s5Y+ROg==?= Performance issue about
 Xenomai4 EVL
 core(v6.6.23-evl2-rebase)
In-Reply-To: <87frlziw8t.fsf@xenomai.org> (Philippe Gerum's message of "Fri,
	03 Jan 2025 19:32:34 +0100")
References: <AS8PR04MB8119B0401C5CB0EA31DF207DE1352@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<AS8PR04MB81198798255FBF290C500120E1372@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<AS8PR04MB8119B91C92C4361DDB6FBE2DE1302@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<87ser2wld2.fsf@xenomai.org>
	<AS8PR04MB8119D9E6C982D6BB998B4380E1392@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<AS8PR04MB8119242427AA2F405CBBD9DBE1392@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<AS8PR04MB8119EF7586D426724D8ADC6CE1392@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<AS8PR04MB8119D818B3D79ADBDBFE980FE13B2@AS8PR04MB8119.eurprd04.prod.outlook.com>
	<87frlziw8t.fsf@xenomai.org>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Sun, 05 Jan 2025 18:28:26 +0100
Message-ID: <8734hx2mrp.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum <rpm@xenomai.org> writes:

> Hongbo Wang <hongbo.wang@nxp.com> writes:
>
>> Hi,
>>
>>> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Philippe Gerum <rpm@xenomai.org>
>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B412=E6=9C=885=E6=97=
=A5 17:05
>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Hongbo Wang <hongbo.wang@nxp.com>
>>> =E4=B8=BB=E9=A2=98: [EXT] Re: =E8=BD=AC=E5=8F=91: Performance issue abo=
ut Xenomai4 EVL
>>> core(v6.6.23-evl2-rebase)
>>>=20
>>> Caution: This is an external email. Please take care when clicking=20
>>> links or opening attachments. When in doubt, report the message using=20
>>> the 'Report this email' button
>>>=20
>>>=20
>>> Hongbo Wang <hongbo.wang@nxp.com> writes:
>>>=20
>>> > Hi Xenomai owner,
>>> >
>>> > I try to find the root cause of this issue, so I applied the=20
>>> > attached linux-evl.patch for kernel, it will reuse RWA counter as=20
>>> > timeout counter. if
>>> RWA counter is not 0, timeout happens.
>>> >
>>> > In my test using evl_latency, I indeed captured the case that RWA is =
not 0.
>>> > after that, I supposed it may be caused by out-of-step between=20
>>> > userspace vdso gettime and evl_read_clock(*MONO*) used in EVL core,=20
>>> > so, I
>>> applied the patch libevl.patch for libevl, to get clock_id that used in=
 EVL core.
>>> > but it also has same issue, SYS is bigger than CTXSW obviously=20
>>> > because of
>>> using non-vdso gettime.
>>> >
>
> I would find it way more obvious if you could verify that
> handle_vdso_fallback() (kernel/evl/syscall.c) is indeed catching
> __NR_clock_gettime or __NR_clock_gettime64 when the sampling thread
> runs.
>
> Btw, none of your notes mentioned which arm64 SoC you have been working
> with to get these results. This information is needed to figure out what
> happens.

Also, you may want to tell us which clock source is current on your
hw. In the example below, the architected CP15 timer is current,
therefore we do have vDSO access to its cycle counter via the vDSO for
arm64 (which cannot be disabled/null-patched).

root@blade-arm64:~# cat /sys/devices/system/clocksource/clocksource0/curren=
t_clocksource
arch_sys_counter

--=20
Philippe.
