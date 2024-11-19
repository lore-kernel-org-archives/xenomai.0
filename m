Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBEC1CCB4E
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032625; cv=none; b=URvIP7qf4BH50eHJF8Nr1bSPgRY8Pf2OZF+T4YHfP/M7gIWrwO3nayRO26KkLFGi5NH/DEfJDP4FvU3TqcCqeQ7jeaLq5ffZZ0HOT48gLPSXSHgkmMSZ9NhhIsHahWx0icnR5T6uNOkMb/8AWIDL2vqeKq+0prCQMtltfzR5R4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032625; c=relaxed/simple;
	bh=jpFsMcpkaSrsZICePx/74rgpcj4pM6OfC+tRYmhSlmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aZ4LhngQF1Tgo5/Q26JEnp6xd0HR4FxJP4yMlNqgAYP7peHs6hxB07jmv6mBCehMKYt+YpIaX/wzs2H1VRfNpbb2GaPjotCInY751zOPk3c57EtOfCeijUpdb9Xn0j4ZIPaOu/Zw0hlFeCBQHARt0Bhs8BmPHDmJJEXaaxlfAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 3DB511A0004
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 16:10:20 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 66BD6D81164
	for <xenomai@xenomai.org>; Tue, 19 Nov 2024 16:10:19 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so47558105e9.2
        for <xenomai@xenomai.org>; Tue, 19 Nov 2024 08:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732032619; x=1732637419;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Rf9OzgVLjpS9to1gjxivd58eV4F5essiKXIJZEfRBI=;
        b=eapJfP7RxqeWcKddU+jR79sRLggRzFPXQg8Ep6QMwp/bpuPHmmqERHX4qMD4WlL3h+
         l/sJkn2auJMU8Ukz0HIpM9qk3K4Z1FSzU3LiAxINh0pqfSLVUskCXiWqhDF6FV6bm/6S
         TOn0+lYfaAfA4svw6aPt8ywJNjJ7xd4WThg1/bKx1tOS+tVkrBAJBNEG+hQW/a5mrl+U
         h0XRIJ+WyX4HmhXfgQwrFufYyW3wiN2nsLl5eEJE6mz+NFxEuXP0UN3DHgyJYsYAO4Jo
         nXTPjcPrU7thm+deN5Jyc6jeSFrXxnYjb+3agvWLsUQfk9WfpVCZk/JovQChpHpubzoF
         c8IA==
X-Forwarded-Encrypted: i=1; AJvYcCWmOlOvrEXJf03Rxt30fbiTuuhFlKD9Ak7ezKTjllJZz28kB2gYrP4RklkyOusFWsVxTZG2Wqh8@xenomai.org
X-Gm-Message-State: AOJu0YyWsA+dIFEcm+6Mm8kdu+n0OpPDi/CdUFc8JdaugsPUIdsPryFq
	6KkXCRZ9PruqKGdYi6e5QyW4VhzRy5jh8ZYyO1ohaEJIVCsfC6lf1zMugypo
X-Google-Smtp-Source: AGHT+IGbBlp/F8Np4fYQqeWBSg5RaQn/ru+ip7k0aA1Foz8SOWgSWeaeiYCluosgLuKNDKYvPkWSeA==
X-Received: by 2002:a05:600c:4f02:b0:431:59b2:f0d1 with SMTP id 5b1f17b1804b1-432df71c4a5mr147729595e9.4.1732032618801;
        Tue, 19 Nov 2024 08:10:18 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2946a3sm198268895e9.35.2024.11.19.08.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:10:17 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: "Julien Aube" <julien.aube@smile.fr>,  xenomai@xenomai.org
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
In-Reply-To: <87jzcze0hx.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	19 Nov 2024 15:55:54 +0100")
References: <101a-673ca280-17-7629bb00@147965553> <87jzcze0hx.fsf@xenomai.org>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 19 Nov 2024 17:10:16 +0100
Message-ID: <87ed37dx1z.fsf@xenomai.org>
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
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.128.46 as permitted sender) smtp.mailfrom=philippegerum@gmail.com;
	dmarc=none

Philippe Gerum <rpm@xenomai.org> writes:

> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>
>> Le Mardi, Novembre 19, 2024 11:23 CET, Philippe Gerum <rpm@xenomai.org> =
a =C3=A9crit:=20
>>=20=20
>>> Fran=C3=A7ois Legal <francois.legal@thom.fr.eu.org> writes:
>>>=20
>>> > Le Mardi, Novembre 19, 2024 10:26 CET, Julien Aube <julien.aube@smile=
.fr> a =C3=A9crit:=20
>>> >=20=20
>>> >> Hello,
>>> >>=20
>>> >> Reading this exchange it reminds me of a problem I had a few months =
ago=20
>>> >> on the same platform.
>>> >>=20
>>> >> Here is the thead :
>>> >>=20
>>> >> https://lore.kernel.org/xenomai/6814fa90-015e-91df-6941-db643e4d4229=
@smile.fr/#r
>>> >>=20
>>> >>=20
>>> >> Conclusion was that disabling the scutimer(*) on DTS level was enoug=
h to=20
>>> >> restore the correct usage and I did not found
>>> >> any bad behaviour after that. The product has passed all the rt-test=
=20
>>> >> afterward.
>>> >>=20
>>> >>=20
>>> >> (*)
>>> >> &scutimer {
>>> >>  =C2=A0=C2=A0=C2=A0 /* scutimer is forced to disabled since it does =
not work with=20
>>> >> Xenomai */
>>> >>  =C2=A0=C2=A0=C2=A0 status =3D "disabled";
>>> >> };
>>> >>=20
>>> >> Maybe i'm completely off the subject, but maybe it's worth having a =
look ?
>>> >>=20
>>> >> Julien
>>> >>=20
>>> >>=20
>>> >
>>> > Thanks. That fixes the problem. I'll dig into that driver to try to f=
ix it and submit a patch then.
>>> >
>>>=20
>>> This may help:
>>>=20
>>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>>> index 8377f1d030c3a..a28f6b7f7eabc 100644
>>> --- a/arch/arm/kernel/smp_twd.c
>>> +++ b/arch/arm/kernel/smp_twd.c
>>> @@ -181,7 +181,7 @@ static irqreturn_t twd_handler(int irq, void *dev_i=
d)
>>>  {
>>>  	struct clock_event_device *evt =3D dev_id;
>>>=20=20
>>> -	if (twd_timer_ack()) {
>>> +	if (!clockevent_is_oob(evt) || twd_timer_ack()) {
>>>  		clockevents_handle_event(evt);
>>>  		return IRQ_HANDLED;
>>>  	}
>>>=20
>>
>> No noticeable effect here. I tried to dig a little more into this, but I=
 can't find anything.
>> What I can tell, is that the TWD interrupts triggers on both cores when =
hung at boot. TWD registers settings seems OK in terms of prescaler and eve=
rything. By checking with JTAG debugger, I can see that xnintr_core_clock_h=
andler is being called in the TWD service routine (twd_handler).
>>
>> I'm trying a little harder, but don't really know from which angle !
>
> The issue is as follows:
>
> When the proxy tick hijacks the timer to hand over its control to
> Xenomai, twd_handler() may be called either from the oob stage upon a
> real tick coming from the hardware, _and_ from the in-band stage as a
> consequence of emulating a common kernel tick, see [1] in the "Under the
> hood" section.
>
> The way twd_handler() operates ATM causes the hardware to be sent an ack
> on every invocation, which is wrong wrt the in-band tick emulation,
> which is most likely wrecking the logic afterwards.
>
> [1] https://v4.xenomai.org/dovetail/porting/timer/#proxy-tick-logic

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 8377f1d030c3a..194d3cc7ca2c8 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -181,7 +181,7 @@ static irqreturn_t twd_handler(int irq, void *dev_id)
 {
 	struct clock_event_device *evt =3D dev_id;
=20
-	if (twd_timer_ack()) {
+	if ((running_inband() && clockevent_is_oob(evt)) || twd_timer_ack()) {
 		clockevents_handle_event(evt);
 		return IRQ_HANDLED;
 	}

--=20
Philippe.
