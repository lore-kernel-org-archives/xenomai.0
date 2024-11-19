Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B31C8797
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011825; cv=none; b=c2pX461pJpe7CgUj2vF72lNnoT6EzLxxTdSWrFjfoh0pwsAkSykdmulxfxoIeMFE8TYCKUCDJLD//0dXBWNVow4RxbTrJ6GKWpXcIJv1z8MgsjW6glg+EF2uIiNWW6EX91p16oB++Wt/VnVjFwR66m8N3PndohOvEFj8u+l2C0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011825; c=relaxed/simple;
	bh=r8MzUHj2nOJDMvYHtykyplOGIMVQaCZVV6ctkdvi9pM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c6o54fVzmicIVnmcmXNpQdSqJ6apFspZ5wLja+4nJYDEXBPgwlBm12dRfmS6mMRcsupxsqchDTVjkjLUU/YkNn9RLTwARXMDhmYjM1fa3eRc6V/KGPeZU4drie5yOkAyfYkkXl4dI67479JEsLF+lldhJYo9NCoz8ffu9GQ6Wyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 1D8D5100005
	for <xenomai@lists.linux.dev>; Tue, 19 Nov 2024 10:23:35 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 54B15740045
	for <xenomai@xenomai.org>; Tue, 19 Nov 2024 10:23:34 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3824709ee03so1469065f8f.2
        for <xenomai@xenomai.org>; Tue, 19 Nov 2024 02:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011814; x=1732616614;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OB+w8hZFLBeIiTDj7Vin364a8up8ul3gSYZ0IQ1/O8E=;
        b=gFYDwm59KZX3e72hQ209CDMv1pnGsUIB8WNpYLeex3xgH1XFBixYEhTk/99+XW8Y5L
         U6SEPwMnHyUZz+M07wV1LJh35wa0Z5FtJn74dQOa5/RWPJ8DYblEtQKevI+HRZy2YsTv
         RDLZiCmjeNubkaub5DXHawrPXRp2eue0p3MOdVbPoS3kygtqLo74NwBl1/PpwK6mkKXC
         XfbaxV+8EMqbhmrwhHiDwwaWlXUsaL0zisi7ZY29AEQgX67ZPA3+gZJ4haxZxEYiIlOu
         4Py1rzzFU0kBYsF+TsLduk/g90BWUOPs99eiJlYJKOJcf8gy2Ztngq/JVsa8LCAzE+gs
         RbMg==
X-Forwarded-Encrypted: i=1; AJvYcCWNR6SCKTu+Rb0vNG2gyUFIVjwdKg2KbrEurCRvvBXp2vhxJsQqIgWAzhH7jf09RfJGbxd3Z43u@xenomai.org
X-Gm-Message-State: AOJu0YwX4yQdira2zcYCfESN0tYFFkTdreOWjeIyjGw9KN+Rarc5oQBY
	x5n5XiObqji6rqZvDSUqx/M08hpMDSv/RFQQ/spV+BODOY5VVWEgqfCDu04X
X-Google-Smtp-Source: AGHT+IH9aMMGssGosefYfmSxk7q8LTnh2P+I+oenlSElU0TigPrHRaciB6Q/pgfz5+QUR7r23nZQhA==
X-Received: by 2002:a5d:584a:0:b0:382:4a98:da57 with SMTP id ffacd0b85a97d-3824a98dd09mr4506854f8f.47.1732011813768;
        Tue, 19 Nov 2024 02:23:33 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adadba4sm15251223f8f.24.2024.11.19.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:23:33 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <francois.legal@thom.fr.eu.org>
Cc: "Julien Aube" <julien.aube@smile.fr>,  xenomai@xenomai.org
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
In-Reply-To: <1018-673c6300-2d-5b0c8700@119761111> (=?utf-8?Q?=22Fran?=
 =?utf-8?Q?=C3=A7ois?= Legal"'s message
	of "Tue, 19 Nov 2024 11:06:47 +0100")
References: <1018-673c6300-2d-5b0c8700@119761111>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 19 Nov 2024 11:23:31 +0100
Message-ID: <87v7wjed3w.fsf@xenomai.org>
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
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.221.45 as permitted sender) smtp.mailfrom=philippegerum@gmail.com

Fran=C3=A7ois Legal <francois.legal@thom.fr.eu.org> writes:

> Le Mardi, Novembre 19, 2024 10:26 CET, Julien Aube <julien.aube@smile.fr>=
 a =C3=A9crit:=20
>=20=20
>> Hello,
>>=20
>> Reading this exchange it reminds me of a problem I had a few months ago=
=20
>> on the same platform.
>>=20
>> Here is the thead :
>>=20
>> https://lore.kernel.org/xenomai/6814fa90-015e-91df-6941-db643e4d4229@smi=
le.fr/#r
>>=20
>>=20
>> Conclusion was that disabling the scutimer(*) on DTS level was enough to=
=20
>> restore the correct usage and I did not found
>> any bad behaviour after that. The product has passed all the rt-test=20
>> afterward.
>>=20
>>=20
>> (*)
>> &scutimer {
>>  =C2=A0=C2=A0=C2=A0 /* scutimer is forced to disabled since it does not =
work with=20
>> Xenomai */
>>  =C2=A0=C2=A0=C2=A0 status =3D "disabled";
>> };
>>=20
>> Maybe i'm completely off the subject, but maybe it's worth having a look=
 ?
>>=20
>> Julien
>>=20
>>=20
>
> Thanks. That fixes the problem. I'll dig into that driver to try to fix i=
t and submit a patch then.
>

This may help:

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 8377f1d030c3a..a28f6b7f7eabc 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -181,7 +181,7 @@ static irqreturn_t twd_handler(int irq, void *dev_id)
 {
 	struct clock_event_device *evt =3D dev_id;
=20
-	if (twd_timer_ack()) {
+	if (!clockevent_is_oob(evt) || twd_timer_ack()) {
 		clockevents_handle_event(evt);
 		return IRQ_HANDLED;
 	}

--=20
Philippe.
