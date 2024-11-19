Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FE1CEAB7
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026624; cv=none; b=MOT4mfbTggRpFgS0fRWZatUgmQWVhse4ag9tmxFV7aj/T8zV4/CEpc1nQmx8RPO9cQDgLgL/K5u1dR2/6FCS6xaGdpOM4zXRLWhVDtV9+t6sC1rLSCo7b54L8SKaAw/lLtP3xAiwC44VbRQPSdSjU7QvNy4T2UXdRTGkgSyPL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026624; c=relaxed/simple;
	bh=CQxZGXFIHnf44A+Qmwq1jqKSJ1AwU4nx3iPru0gHdIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8SMqE50s8VLTmIm7XI4+4OzIU18hOHosSSxBgYx5F8m915E8o9DEaxbBbuOsCblvW59ZYNhhvOMUtTDKD8ZmiLzk59u/bUwTU3+n2whHKV6qjl84VnbIQZLHbtldyKhExJw91rMDrviSsehcrCGYpgiAUo8jjvVickQKY2yhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 16DCC1A0004
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 14:30:18 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 2373EAC1503
	for <xenomai@xenomai.org>; Tue, 19 Nov 2024 14:30:17 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4319399a411so9206595e9.2
        for <xenomai@xenomai.org>; Tue, 19 Nov 2024 06:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026617; x=1732631417;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g1ZoKo/5YZdXg5jV8YR+Um5dnaUUQA2JDbUrPBmP6oo=;
        b=j/ShvIWUuxh46SBIYmv3vCbCyYNjKUOtMzbatRzo+IpZcOd8SQAKcoYar0uuGD1Miw
         yh1WoKopy2KHShYWF+AHUGbjACGL/cAs4EaRXy1/q2oEAB4Bk79bldG6jNNTFIX0AaKR
         9nUXhcV3EsLr78ifH1sVoRLZV9/SnJVh6QGSZ5lprG6eeoWXCFdLzrttalPfehV5fieq
         2WkyJ210T0u6aQubjGHPru5H+SaY1ENhbOFQWa/Tz2MfvoKpYMHUayFE5d/zcQRS6+02
         j9M4BfaJF5oz16TOnL5A95cta78jqiIS+PBMMFLWsAy2xSQfx4Os9xo41XJjkw01e+ei
         mYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIGQAh0KgN78MAbWvcxjcUCwO5/i7VYKKXlG9hdCa2BsFJmdMidkb86z64QZ9ujaL/d24b6NAY@xenomai.org
X-Gm-Message-State: AOJu0Yy562stDSp1jdR/jiv7nTRaVCkAReGfmlXGN8K8DYvNahL2Rl6b
	Eughje4gYwW0O0fwfvGYeFVzKYcuOh155Ate8f7yFr6oA8fBppx4Ohhtqbn1
X-Google-Smtp-Source: AGHT+IGUxjx1sJdlKIfqcG9+xHlCsFE3PXGTaX7M/S04uTuTCwMBf84jZ18KqDxlZEPH1tDL7lARww==
X-Received: by 2002:a05:600c:5487:b0:431:5f55:28ad with SMTP id 5b1f17b1804b1-432df78c44bmr116086655e9.22.1732026616473;
        Tue, 19 Nov 2024 06:30:16 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80ad9sm191899115e9.25.2024.11.19.06.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:30:16 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <francois.legal@thom.fr.eu.org>
Cc: "Julien Aube" <julien.aube@smile.fr>,  xenomai@xenomai.org
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
In-Reply-To: <87v7wjed3w.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	19 Nov 2024 11:23:31 +0100")
References: <1018-673c6300-2d-5b0c8700@119761111> <87v7wjed3w.fsf@xenomai.org>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 19 Nov 2024 15:30:15 +0100
Message-ID: <87plmre1oo.fsf@xenomai.org>
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

Philippe Gerum <rpm@xenomai.org> writes:

> Fran=C3=A7ois Legal <francois.legal@thom.fr.eu.org> writes:
>
>> Le Mardi, Novembre 19, 2024 10:26 CET, Julien Aube <julien.aube@smile.fr=
> a =C3=A9crit:=20
>>=20=20
>>> Hello,
>>>=20
>>> Reading this exchange it reminds me of a problem I had a few months ago=
=20
>>> on the same platform.
>>>=20
>>> Here is the thead :
>>>=20
>>> https://lore.kernel.org/xenomai/6814fa90-015e-91df-6941-db643e4d4229@sm=
ile.fr/#r
>>>=20
>>>=20
>>> Conclusion was that disabling the scutimer(*) on DTS level was enough t=
o=20
>>> restore the correct usage and I did not found
>>> any bad behaviour after that. The product has passed all the rt-test=20
>>> afterward.
>>>=20
>>>=20
>>> (*)
>>> &scutimer {
>>>  =C2=A0=C2=A0=C2=A0 /* scutimer is forced to disabled since it does not=
 work with=20
>>> Xenomai */
>>>  =C2=A0=C2=A0=C2=A0 status =3D "disabled";
>>> };
>>>=20
>>> Maybe i'm completely off the subject, but maybe it's worth having a loo=
k ?
>>>=20
>>> Julien
>>>=20
>>>=20
>>
>> Thanks. That fixes the problem. I'll dig into that driver to try to fix =
it and submit a patch then.
>>
>
> This may help:
>

Not that much actually. This does fix an issue but introduces a
different one. More on this later.

> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 8377f1d030c3a..a28f6b7f7eabc 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -181,7 +181,7 @@ static irqreturn_t twd_handler(int irq, void *dev_id)
>  {
>  	struct clock_event_device *evt =3D dev_id;
>=20=20
> -	if (twd_timer_ack()) {
> +	if (!clockevent_is_oob(evt) || twd_timer_ack()) {
>  		clockevents_handle_event(evt);
>  		return IRQ_HANDLED;
>  	}

--=20
Philippe.
