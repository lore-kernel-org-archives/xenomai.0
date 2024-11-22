Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C023AB
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283732; cv=none; b=Cqrs2KeCu/716C2XM+yfJhI7yyJ8VqlBM9nAJxutPzYgODzfDpqKtD/XkLdVuEsNduad/iJEIZ2nnsMi9xKOHptzqE7g9Sf6vMyQh9e/zsr4t3WtM8bwvvY7jfhWcmJvfo8cKGbBef15YCAtcukh4oK6PEzR/Jx8EMFzCvKwcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283732; c=relaxed/simple;
	bh=Me5QAdE9RIVs8T/CBQTXOvgIF/n6rXKzpRcq8JuuX30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdusLSxGIql/Gv5k4dnrD2/H4l8YqBKH3AGSxZh7YusWkTzAg6KKpVoNCaSuzMNYmboonqcylH3kND15LDZPx12a2jzGbAE42jgh9gXd3zi8DV1hE2MKBBmXoGIvmZm63poTtf+7BJgODmyfBCABE0nb6rJohtENK6a8lri3CL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=CpBTGOQJ; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="CpBTGOQJ"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 1A4B11A0004
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 13:55:27 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4841ED8106C
	for <xenomai@xenomai.org>; Fri, 22 Nov 2024 13:55:26 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ffab850d74so2834521fa.0
        for <xenomai@xenomai.org>; Fri, 22 Nov 2024 05:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1732283725; x=1732888525; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w42kHkaq3ezg28NpID/Yn0+lIzS4pkkV2WtYitRctZo=;
        b=CpBTGOQJfRfts6XWamxrF3CaKN2mesMs916MsAKWDfPCNWieIgSrFu7cpMxFwu1/h2
         ZIqZ18AaGiYxzwwxpTdwRFdUL7enJAS6EEdSHUzknQvTbsNd+3kH6ekdeHGdJ4STVFYw
         U9a1misjJtKRM50rixxjKPxhLJSg77Dt0mXFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732283725; x=1732888525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w42kHkaq3ezg28NpID/Yn0+lIzS4pkkV2WtYitRctZo=;
        b=KflQVMHpAmykCpdmErj7Hh6A/t+gGstsipph2oTwmNjI+k4itRUc0EJdOn7GWCG0Np
         Tby60szV0StZKOqs5sMaaYTCzkj/TnKKeKPFf3Gz+9vqreNybC2O4RJMAaCD58UCoaN+
         SwmNHvSpCg1m80mwK3eAKRfLKXj/VKz4O6faY7QzjziXuBABFNG4d68wUl1kzN3PdXrg
         CrFEtq8XhNnIoU1VFEuU5/n4A0Em+ALE0ox0AM8oFQAbaVfJ6L8avb/30iwxN4iFHrE1
         PD8A/BMA82A9cboq1RNkPidAq9iHkpMyLwjSw11Z706URMZZqJJZryyuehS2hgECoHIC
         wkEQ==
X-Gm-Message-State: AOJu0YywWFksml8gA4Kax5rzvwu/XFhjVkNLFLP09WkI/y7PSjKNEUpq
	FmXLUlo8oQjviHFWQ0azPuAlMsv1jpB+KcXKwLGvqwDEKNRtlgXfS68MCgkr/0qd/32Q4fERQAI
	3TBoNdBHxi5h/wXHNf0evmW46xzqQdEyjGKkzZF7hxHdHmltvb2Iz/A==
X-Gm-Gg: ASbGnctvdW0bO5JuAl9w96Ck0vxi46poG/kY99Tpv7HAUAhFBASx1VU3L0qTFBQmxa9
	Ya7Ul6JRgAgFjsuHaH9eDaXP4hFIHGZQMELbueXhMi/CFKeADOcqXiKSQEWimkLsi
X-Google-Smtp-Source: AGHT+IEMD5MEk7KLsohWof20fEiWWcoUDIM71EnlBEZsVL6BfdRrmGzoXO1S3fb1xgQOwxJ67mhYRrmW/TsQI9QbtrI=
X-Received: by 2002:a2e:b891:0:b0:2ff:6f2a:8417 with SMTP id
 38308e7fff4ca-2ff96a406b9mr22650501fa.18.1732283725477; Fri, 22 Nov 2024
 05:55:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0uhQg4UBLg=qQb7Lvc72FEg5c1hi+s98hjvqGuuS0D27Q@mail.gmail.com>
 <d22f0f7a-a55b-42f9-bdd0-3827677b57c0@siemens.com>
In-Reply-To: <d22f0f7a-a55b-42f9-bdd0-3827677b57c0@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 22 Nov 2024 14:55:14 +0100
Message-ID: <CAFc1U0uEVVWnF95Qjsae5su2fHN6S-NGZa-8ufRA9ZS-3LEmxA@mail.gmail.com>
Subject: Re: LS1046 support
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::235 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr;
	dmarc=pass (policy=reject) header.from=smile.fr

Yes but they seem to say information can be found from xenomai.org :-)

The guy talking about Layerscape on the list (Jerry Huang) is from
NXP, so I will try to contact him.

Regards

Le ven. 22 nov. 2024 =C3=A0 14:39, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 22.11.24 14:16, Pierre FICHEUX wrote:
> > Hi,
> >
> > According to NXP documents, the LS1046 is supported by Xenomai.
> >
> > https://www.nxp.com/docs/en/user-guide/OpenILUG-1.11.pdf
> >
>
> "Note: Xenomai is not supported in the current OpenIL release"
>
> But that PDF is from 2021.
>
> > Xenomai features are supported for LS1021A-TSN, LS1043ARDB,
> > LS1046ARDB, LS1028ARDB, and i.MX6Q SabreSD. More information can be
> > found at the Xenomai official website: http://xenomai.org/.
> >
> > I don't see it in the official ports (3 or 4) but I've just read some
> > discussions on the list talking about layerscape.
> >
> > https://lore.kernel.org/xenomai/87v8uykfew.fsf@xenomai.org/
> >
> > What is the current status of the layerscape boards?
> >
>
> You may have to ask NXP. I'm not aware of community efforts, including
> contributions by NXP.
>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
