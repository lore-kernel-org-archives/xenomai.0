Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A91CF5E3
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028162; cv=none; b=R4O+eJP2GgZThoeRF3xVipNhy6awKecrJM/qBEvT1LSi28ns4jlWS6NTBAfKcztVDFgQXEGh1D8MkpLw+u3KMnoEGqnnGgkVvWx6+eiQxExEJfWEedP2npMenpSzyxB/r0NUQPcFJDzizX3pT0MsXRszgjI3dW1TfMT7g++XT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028162; c=relaxed/simple;
	bh=bfCzCmy+IgvywUcA6SGZRSQnAAgsuAoRKPnWR2sHxn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XnehaNRAyZpmiqIQu9Li50VhpSbyQU4Q7WVxpiu7JR+sa9Qc/FoljBecFkdOnOkHQKLSDzdNu7ReQY/SHfxmK5d+/2M6FbX4k0x1JrmeaZWF63mTqq0psYpXxEYxjAhaWzXMLAfOSGCV0hv8k6Nrwllcj6g10UrmBXvmjDnNHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id A236D1A000B
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 14:55:57 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DBAE274003A
	for <xenomai@xenomai.org>; Tue, 19 Nov 2024 14:55:56 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314b316495so37253595e9.2
        for <xenomai@xenomai.org>; Tue, 19 Nov 2024 06:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028156; x=1732632956;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bkP0pLK2CfVkgFX8CftQ1BU7kUynSiIl6Gy9qgjShgQ=;
        b=wpMW7vhp0WcAAWian9Y9vANlzxNV/pODyGTPuZ+xQshTRdI8hlm5JSSjBdVcOzujz+
         ox1zWt4eA8PSCvSqlFgHP8IY7ngC1rShjBkPHkUe8M5idG9ltVH7VqtG4oSIHph4b9YN
         3S16XoNJrymNahTdo8pIBxjltICod0CJHjH2eeUT3W6wypmKPmA6yx0c026RChHm5Eud
         4VTqZ9/Q1T1PIP89UnTVTNErF9oPiule7gSeBjXWi3eV6hAsn6Cgfq2C3LFJMZx6xgbv
         BepCXcqw0BvH+uR+WBqmw8kFQ4SZ4ZT9xS8F3W5KsKObxo+PyUWmyOnM/o4jgKou8Jbr
         Onxg==
X-Forwarded-Encrypted: i=1; AJvYcCWqAsSmeor4Sltexj3NPeqalt6vVMm6vzZYMK+qF+O3La7MDyJWTYOxDiOdk1/dKl+oTcIC4bkB@xenomai.org
X-Gm-Message-State: AOJu0Yxvyl3YMYvosEPKmkZrnlIgJssP13KDalt551EQUTopmnqCR1Lf
	ifLqzo7AIBqh91Z4T0NCxppML97JdHorZA69/n+S7m/1g8OMrXATJ0eCpKav
X-Google-Smtp-Source: AGHT+IFSf/wNvTUFvqw9QngDE02PfZoDhsVJMGg3HhRyCY9sE1sxeqVVEJO7cWVTKOX6HSNaQ3A09g==
X-Received: by 2002:a5d:64c8:0:b0:381:f604:3d55 with SMTP id ffacd0b85a97d-38225aaf59cmr13461987f8f.52.1732028156289;
        Tue, 19 Nov 2024 06:55:56 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3822e65cbdasm12523907f8f.7.2024.11.19.06.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:55:55 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: "Julien Aube" <julien.aube@smile.fr>,  xenomai@xenomai.org
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
In-Reply-To: <101a-673ca280-17-7629bb00@147965553> (=?utf-8?Q?=22Fran?=
 =?utf-8?Q?=C3=A7ois?= Legal"'s message
	of "Tue, 19 Nov 2024 15:36:04 +0100")
References: <101a-673ca280-17-7629bb00@147965553>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 19 Nov 2024 15:55:54 +0100
Message-ID: <87jzcze0hx.fsf@xenomai.org>
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

> Le Mardi, Novembre 19, 2024 11:23 CET, Philippe Gerum <rpm@xenomai.org> a=
 =C3=A9crit:=20
>=20=20
>> Fran=C3=A7ois Legal <francois.legal@thom.fr.eu.org> writes:
>>=20
>> > Le Mardi, Novembre 19, 2024 10:26 CET, Julien Aube <julien.aube@smile.=
fr> a =C3=A9crit:=20
>> >=20=20
>> >> Hello,
>> >>=20
>> >> Reading this exchange it reminds me of a problem I had a few months a=
go=20
>> >> on the same platform.
>> >>=20
>> >> Here is the thead :
>> >>=20
>> >> https://lore.kernel.org/xenomai/6814fa90-015e-91df-6941-db643e4d4229@=
smile.fr/#r
>> >>=20
>> >>=20
>> >> Conclusion was that disabling the scutimer(*) on DTS level was enough=
 to=20
>> >> restore the correct usage and I did not found
>> >> any bad behaviour after that. The product has passed all the rt-test=
=20
>> >> afterward.
>> >>=20
>> >>=20
>> >> (*)
>> >> &scutimer {
>> >>  =C2=A0=C2=A0=C2=A0 /* scutimer is forced to disabled since it does n=
ot work with=20
>> >> Xenomai */
>> >>  =C2=A0=C2=A0=C2=A0 status =3D "disabled";
>> >> };
>> >>=20
>> >> Maybe i'm completely off the subject, but maybe it's worth having a l=
ook ?
>> >>=20
>> >> Julien
>> >>=20
>> >>=20
>> >
>> > Thanks. That fixes the problem. I'll dig into that driver to try to fi=
x it and submit a patch then.
>> >
>>=20
>> This may help:
>>=20
>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> index 8377f1d030c3a..a28f6b7f7eabc 100644
>> --- a/arch/arm/kernel/smp_twd.c
>> +++ b/arch/arm/kernel/smp_twd.c
>> @@ -181,7 +181,7 @@ static irqreturn_t twd_handler(int irq, void *dev_id)
>>  {
>>  	struct clock_event_device *evt =3D dev_id;
>>=20=20
>> -	if (twd_timer_ack()) {
>> +	if (!clockevent_is_oob(evt) || twd_timer_ack()) {
>>  		clockevents_handle_event(evt);
>>  		return IRQ_HANDLED;
>>  	}
>>=20
>
> No noticeable effect here. I tried to dig a little more into this, but I =
can't find anything.
> What I can tell, is that the TWD interrupts triggers on both cores when h=
ung at boot. TWD registers settings seems OK in terms of prescaler and ever=
ything. By checking with JTAG debugger, I can see that xnintr_core_clock_ha=
ndler is being called in the TWD service routine (twd_handler).
>
> I'm trying a little harder, but don't really know from which angle !

The issue is as follows:

When the proxy tick hijacks the timer to hand over its control to
Xenomai, twd_handler() may be called either from the oob stage upon a
real tick coming from the hardware, _and_ from the in-band stage as a
consequence of emulating a common kernel tick, see [1] in the "Under the
hood" section.

The way twd_handler() operates ATM causes the hardware to be sent an ack
on every invocation, which is wrong wrt the in-band tick emulation,
which is most likely wrecking the logic afterwards.

[1] https://v4.xenomai.org/dovetail/porting/timer/#proxy-tick-logic

--=20
Philippe.
