Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31EE79F2
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627244; cv=none; b=rcFw3PbZ86IpL+c33I6jl97PAqcsDvqouiy1OdLtH6L54ShaYshLZxPzs5F78Hiwd6mmbUPIOW8AsvC4lGcy4kyux/htp7WnsNfwteJ6peYhwQnP+DVveEkuahnsU3V40EJeJ57C8TAf2KL5ku+b00xmowySoCB4kf/2XqiPJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627244; c=relaxed/simple;
	bh=fJyiOne/++rgdIiqDJmmbbnd/ndyfa5DYJwn6Oh6SgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzuHl2eMu2DIWgaOajkDM3QPjGybVzU+KyaI8ZGGTkV1ZGLcOopN20V4u1phT0gS9kA3LPEj1Ec8iOxy7Rbycje6sAnZr1xHim2lttGt6259uuEEHxJ/WzHDtBZMnPjv1e7xiXo3J8Ri8W7/3Q0ARQDEkweEAF0hjtO9l6Hm+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=LDjSma2V; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="LDjSma2V"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 5D4DB80007
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 08:27:13 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8496B941475
	for <xenomai@xenomai.org>; Tue,  5 Mar 2024 08:27:12 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2d3ee1c9ea9so6716371fa.3
        for <xenomai@xenomai.org>; Tue, 05 Mar 2024 00:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1709627232; x=1710232032; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFhMmJt//hA02f82EecyhEm1I3OIo288dAz8xLkQp6E=;
        b=LDjSma2VswhKBAjlhTX+giTLu6JSNAzlyVbjtix9RFwp3uX0vI7Gu/qtFYoK3leZua
         UHC18nlZJevI1gK4tGKaRnbE2zPdxxrrvxS5uKdyqWJYUCcM9upKn3ZBJZdlQ1Ca0bOU
         QWRwcf28yUt8iFi649zVLwh41iGEIyjJ7dOlHfqE2o9I6MPtPiPcxGbLlI8s6vuNghd9
         1/wNiGM87B10n4t/DC50llg0+ZNweZ3Xi5ph63RCp/nd94zd5azyS/AYFjXTj7YM4n+x
         5bfEdXhr7/cf2PKT/bPy2q+6HEYoCrKVmiMHAC3daNacj8oRlxP+rXutXmXY+/2t2sFG
         LIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627232; x=1710232032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFhMmJt//hA02f82EecyhEm1I3OIo288dAz8xLkQp6E=;
        b=JFfOvThhHxK65iER1AKaHrVBuWSSXf/TC1b5eA49RY3GoH7LcJpgEp2tp9LOmgJiY7
         Yi0Ch3RuiQzuFNH8MeXAVZu4gVZHKqwFVbKVesZzwCk5imv9AoBJBrOlJNsCBWtJI95i
         8TekupE7BSWoo624RHqjEcFhSpLu0xGHyCai/uwC7ZO2W33d/A5MHB9YNWNzWEjQuh0w
         9Qy3+IWKl/1NPaKqscb037PsdxRne0lk3tp9CVpGO1NRC+32i4Vywsd/dySjqeZ+4NYs
         YuEPglG7WGt500wWYO96jr0yUwfc72IMwMR53tAUJsnCjjmBcpF1BuK5vjMffBJytzrn
         hjXg==
X-Gm-Message-State: AOJu0YzJTeDqzWrLF4DMPHg0lY+nAUsZSJigduTVqZojRK8K8ceFcCls
	xvVPN/Dy3aeVT/fYTRnFVvwqIsg3u/6/B9pq6+iJaTmzWLfZKoHrkkwD5HyTxSYC/49fKT0ywFK
	1v3JnDpGDDL05i4/oFmLJXWTzu9XwZmSirYykxw==
X-Google-Smtp-Source: AGHT+IF8A7bNQFour3HeNIubtchhlzZ9qTq2Wt+TbG2bcbDQwXQ8EKI7bj0kDIaWA1ZSN5HW3zqbIIv8pK7MJKI4ifo=
X-Received: by 2002:a2e:780c:0:b0:2d3:f09d:6563 with SMTP id
 t12-20020a2e780c000000b002d3f09d6563mr699696ljc.27.1709627231745; Tue, 05 Mar
 2024 00:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <PH7PR11MB74998DAE5D29AB428EAC3BB9F2222@PH7PR11MB7499.namprd11.prod.outlook.com>
 <1591F599-3AF7-4BEE-9742-56DBCD4DADAF@smile.fr> <PH7PR11MB74990E278E333490012A9ABEF2222@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74990E278E333490012A9ABEF2222@PH7PR11MB7499.namprd11.prod.outlook.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 5 Mar 2024 09:27:00 +0100
Message-ID: <CAFc1U0sgm9gMve_RJdiaRbG76-5__y2cN98ZQUWfbMw_OpQieA@mail.gmail.com>
Subject: Re: DYNAMIC_FTRACE and I-pipe patch
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=none) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::22c as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

So a piece of advice could be to switch to a Dovetail compatible kernel ?

The soc is an imx8m mini (designed by Compulab) using an adapted
version of linux-imx. Is there any porting guide?

https://mediawiki.compulab.com/w/index.php?title=3DUCM-iMX8M-Mini_NXP_iMX8M=
-Mini_Yocto_Linux

Le mar. 5 mars 2024 =C3=A0 06:03, Chen, Hongzhan <hongzhan.chen@intel.com> =
a =C3=A9crit :
>
>
>
> >-----Original Message-----
> >From: Pierre FICHEUX <pierre.ficheux@smile.fr>
> >Sent: Tuesday, March 5, 2024 12:39 PM
> >To: Chen, Hongzhan <hongzhan.chen@intel.com>
> >Cc: xenomai <xenomai@xenomai.org>
> >Subject: Re: DYNAMIC_FTRACE and I-pipe patch
> >
> >Hi,
> >
> >You talk about the I-pipe tracer?
>
> I am talking about the issues that dovetail want to address as Philippe d=
escribed in the link. The DYNAMIC_FTRACE limitation you mentioned with I-PI=
PE maybe one of the issues that dovetail already fixed. That is why it is n=
ot the case for dovetail.
>
> Regards
>
> Hongzhan Chen
>
> >
> >--
> >Pierre
> >
> >> Le 5 mars 2024 =C3=A0 02:13, Chen, Hongzhan <hongzhan.chen@intel.com> =
a
> >=C3=A9crit :
> >>
> >>
> >>
> >>> -----Original Message-----
> >>> From: Pierre FICHEUX <pierre.ficheux@smile.fr>
> >>> Sent: Tuesday, March 5, 2024 7:44 AM
> >>> To: xenomai <xenomai@xenomai.org>
> >>> Subject: DYNAMIC_FTRACE and I-pipe patch
> >>>
> >>> Hi,
> >>>
> >>> One of my customers uses a 5.4.70 kernel with an iMX8M board and a
> >>> custom I-pipe patch (with Xenomai 3.1). It looks like all the I-pipe
> >>> patches disable the DYNAMIC_FTRACE option :
> >>>
> >>> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> >>> index f3f2fc8ad81a..98d7c64b7b8f 100644
> >>> --- a/kernel/trace/Kconfig
> >>> +++ b/kernel/trace/Kconfig
> >>> @@ -532,6 +532,7 @@ config DYNAMIC_FTRACE
> >>> bool "enable/disable function tracing dynamically"
> >>> depends on FUNCTION_TRACER
> >>> depends on HAVE_DYNAMIC_FTRACE
> >>> + depends on !IPIPE
> >>> default y
> >>> help
> >>>  This option will modify all the calls to function tracing
> >>>
> >>> That's not the case for a recent Dovetail based kernel.
> >>>
> >>> Could you give me some information about such a limitation ?
> >>
> >> Maybe you can refer to
> >https://www.google.com/url?q=3Dhttps://source.denx.de/Xenomai/xenomai/-
> >/wikis/Dovetail&source=3Dgmail-
> >imap&ust=3D1710206004000000&usg=3DAOvVaw0IXHqzeoruHeu6lnhYcPQw.
> >> It mentioned " The I-pipe provides its own function tracer based on th=
e
> >Ftrace
> >> engine, but still duplicating some of its features while
> >> restricting others." but  I do not know if it includes such limitation=
 IPIPE was
> >restricting but
> >> dovetail improved.
> >>
> >> Regards
> >>
> >> Hongzhan Chen
> >>>
> >>> Thanks in advance.
> >>>
> >>> regards
> >>>
> >>> --
> >>>
> >>> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
> >>>
> >https://www.google.com/url?q=3Dhttp://www.smile.fr&source=3Dgmail-
> >imap&ust=3D1710206004000000&usg=3DAOvVaw2X5QyoSLrMfOonkGBSzX5c
> >>>
> >https://www.google.com/url?q=3Dhttps://smile.eu/fr/offres/embarque-
> >iot&source=3Dgmail-
> >imap&ust=3D1710206004000000&usg=3DAOvVaw3N1t1B1QlZt68DA6MYbiQJ
> >>> I would love to change the world, but they won't give me the source c=
ode
> >>



--

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot

I would love to change the world, but they won't give me the source code
