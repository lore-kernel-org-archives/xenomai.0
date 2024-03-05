Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6B7E0FB
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613556; cv=none; b=idq1mpKMrflNIngnIVydCVrz7GsE0KnO3JkZpvlRHreCpsONDoDGCB9UWythtlkj3LwGdSOPfjQ9RJMo2fHuqyIV8bM+GrERIJ7BNyCfmgm2zgU7dcX00HglnDIkmuGKWgS8F2z8SVkmHzdiZ9GYX/Qki2deueTr4csGbq9Qniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613556; c=relaxed/simple;
	bh=zUDiFeA64B6kpXWPA+boLPUBGbJRZtrnmglKhc7HlOk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=e/XYtE7U1lxlUh7wkPPQVbT/93hCjQzhkKTzJ9KK/9Nq3WXI8hrvmklbDu/E4vBLj8Q6hpwoXrvdoMziUcfIsTofSNNUt6tZustn6FeUC1UJdLEb2Vdss1AGfvBt6hMUWIUEifNVbGfpzjAx1Ay4cJqNArRApp47K/IJ1SmY4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=IkVUkoOd; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="IkVUkoOd"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 80F7A240003
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 04:39:05 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B4C20D8094F
	for <xenomai@xenomai.org>; Tue,  5 Mar 2024 04:39:04 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-412e80e13abso9093345e9.3
        for <xenomai@xenomai.org>; Mon, 04 Mar 2024 20:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1709613544; x=1710218344; darn=xenomai.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DePY8K8iCKzwXLNSkkWo3/FX85/dx9JJeFTfKiY1+P4=;
        b=IkVUkoOdj2Sjm7/oQ9qZwFR6I9JNUtd6cM1zFb3W4p4/yVcrChj40bVvc0vFJPKFTo
         IIY/lktudZRlsy8vcB3xADGdIzcJB90GwEOQrFJIDwzjlnfLSMqLQPZ1YmMG+T/ufg6t
         yDyN4QJ9HHcPBQO6+sC/InCSk6K9c9/u28lsiXp2s/bdQBhxksUQ4KbRg5PbO4V17Mzb
         vKLePITHWGqohCdrUt/YnPZ0mLjU1jZMzxcTBSIE/1Z09WxPXPSVMVzBMVaYF/6o0hmX
         8ty3LU5xpg7MTp0okQRmhymib5TnJI21CiG70FqxEpuszA03WgbIcbnYsBPHn8YyMcFc
         VpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709613544; x=1710218344;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DePY8K8iCKzwXLNSkkWo3/FX85/dx9JJeFTfKiY1+P4=;
        b=A8+Hh8NqTpXg+dEJ1qR3qty+yAhNLPwBWarrUIKRsoA9HjzLBzrlvtmKm2GAg5ZTDi
         rCSOrEJuMSogBOmZUqmz1kOZ+O4nJzk8m3m+dt2Yp1E4m5YMW2kg8MsOj0VV18lWocM/
         gC8bmCAejX7fcm7po3XUhQL037LTWBJe+487N2+XuL0AlnAP4DbANC2aT7uvQCfikPh4
         4M7AM4yiiWzuOeh+sW3I9TjYVmxT2sylKeA6AnuZxPuvzYjMswRSUfz3a9CIK8IsqtnX
         5u8E+apG1sI0j1rue+UKiktFiEAm0sNs0VHOLyoHtt8bCN3KoPPsztnae1b/Z+vQ63/X
         5MFw==
X-Gm-Message-State: AOJu0Yzvold7CVmDWsorN6jjjZe01aVkKfHsjGPJMtjkmFut3zaeNWBQ
	zleWNNrVkCwWEdYNmmsUlb7jUNong0nftoAlRBBdODN1K2zZuepl8aZhEZfg/B4MWJsY/XlPjn/
	h
X-Google-Smtp-Source: AGHT+IGQKZhDt1fvFHSSdi/aPb30pgX5JTGlvAngVt8cY89cldk6Os1UB7kz2ZxaAA1TbE30aUg6aA==
X-Received: by 2002:a05:600c:5252:b0:412:de1f:cdfb with SMTP id fc18-20020a05600c525200b00412de1fcdfbmr4070425wmb.20.1709613544078;
        Mon, 04 Mar 2024 20:39:04 -0800 (PST)
Received: from smtpclient.apple (2a01cb0808994d00d49bca7f9cf45fd0.ipv6.abo.wanadoo.fr. [2a01:cb08:899:4d00:d49b:ca7f:9cf4:5fd0])
        by smtp.gmail.com with ESMTPSA id f17-20020adfb611000000b0033d9f0dcb35sm13780949wre.87.2024.03.04.20.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 20:39:03 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: DYNAMIC_FTRACE and I-pipe patch
Date: Tue, 5 Mar 2024 05:38:52 +0100
Message-Id: <1591F599-3AF7-4BEE-9742-56DBCD4DADAF@smile.fr>
References: <PH7PR11MB74998DAE5D29AB428EAC3BB9F2222@PH7PR11MB7499.namprd11.prod.outlook.com>
Cc: xenomai <xenomai@xenomai.org>
In-Reply-To: <PH7PR11MB74998DAE5D29AB428EAC3BB9F2222@PH7PR11MB7499.namprd11.prod.outlook.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
X-Mailer: iPhone Mail (20D67)
Authentication-Results: spool.mail.gandi.net;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::331 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr;
	dmarc=pass (policy=none) header.from=smile.fr

Hi,

You talk about the I-pipe tracer?

--
Pierre

> Le 5 mars 2024 =C3=A0 02:13, Chen, Hongzhan <hongzhan.chen@intel.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF
>=20
>> -----Original Message-----
>> From: Pierre FICHEUX <pierre.ficheux@smile.fr>
>> Sent: Tuesday, March 5, 2024 7:44 AM
>> To: xenomai <xenomai@xenomai.org>
>> Subject: DYNAMIC_FTRACE and I-pipe patch
>>=20
>> Hi,
>>=20
>> One of my customers uses a 5.4.70 kernel with an iMX8M board and a
>> custom I-pipe patch (with Xenomai 3.1). It looks like all the I-pipe
>> patches disable the DYNAMIC_FTRACE option :
>>=20
>> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
>> index f3f2fc8ad81a..98d7c64b7b8f 100644
>> --- a/kernel/trace/Kconfig
>> +++ b/kernel/trace/Kconfig
>> @@ -532,6 +532,7 @@ config DYNAMIC_FTRACE
>> bool "enable/disable function tracing dynamically"
>> depends on FUNCTION_TRACER
>> depends on HAVE_DYNAMIC_FTRACE
>> + depends on !IPIPE
>> default y
>> help
>>  This option will modify all the calls to function tracing
>>=20
>> That's not the case for a recent Dovetail based kernel.
>>=20
>> Could you give me some information about such a limitation ?
>=20
> Maybe you can refer to https://www.google.com/url?q=3Dhttps://source.denx.=
de/Xenomai/xenomai/-/wikis/Dovetail&source=3Dgmail-imap&ust=3D17102060040000=
00&usg=3DAOvVaw0IXHqzeoruHeu6lnhYcPQw.
> It mentioned " The I-pipe provides its own function tracer based on the Ft=
race
> engine, but still duplicating some of its features while
> restricting others." but  I do not know if it includes such limitation IPI=
PE was restricting but
> dovetail improved.
>=20
> Regards
>=20
> Hongzhan Chen
>>=20
>> Thanks in advance.
>>=20
>> regards
>>=20
>> --
>>=20
>> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>>                            https://www.google.com/url?q=3Dhttp://www.smil=
e.fr&source=3Dgmail-imap&ust=3D1710206004000000&usg=3DAOvVaw2X5QyoSLrMfOonkG=
BSzX5c
>>                            https://www.google.com/url?q=3Dhttps://smile.e=
u/fr/offres/embarque-iot&source=3Dgmail-imap&ust=3D1710206004000000&usg=3DAO=
vVaw3N1t1B1QlZt68DA6MYbiQJ
>> I would love to change the world, but they won't give me the source code
>=20
