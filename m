Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBDD20370B
	for <xenomai@lists.linux.dev>; Wed, 11 Dec 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939435; cv=none; b=mMSBxbaduB8LPm6oJblBQARczUET6nNolcrzKzaQ3jgHC6USY+sChvUj07dbNfpfLFvcXSUmvD0LpZ+jm6Ui72QHsl5+7/oRVJyV+34CW1ipCgAH9D+YTtS7tggtwTq4XcYn+1eLQJzI/l/E1tbMglvouRK4al0Hi8HCVqpNDuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939435; c=relaxed/simple;
	bh=R8+/yc5UAuLBYUF66aOrQw4jLKZEE9/+1PxHK0jFmfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duzIwkE3fSDOJ7wos6H3rKz70nPd8GYR19RkG0vHK3TGElPl00Y3KtP7EnMAhWabWb6oxLjN3pa/XpAvxY5/VPFA2JSPcQy1oWqHHgDl9pbu++znbOjf1Y2saT4xLPMCTKhOwkY5axHk162dFH8Cfp27LvosuoJCZ03fRtD6Ubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=djcmai+N; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="djcmai+N"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 0309C200008
	for <xenomai@lists.linux.dev>; Wed, 11 Dec 2024 17:50:29 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3644D7803D1
	for <xenomai@xenomai.org>; Wed, 11 Dec 2024 17:50:28 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so70129281fa.3
        for <xenomai@xenomai.org>; Wed, 11 Dec 2024 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1733939427; x=1734544227; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrFKiLTjzmZuBgrbYAiFQaDGn8XrXNH9NjNmrsIJSdM=;
        b=djcmai+N4+A8vN20CMqFvW8zbJdgJu3n24jKAu9HCrWtduvONRy6as7RLOMu0UEVeo
         tlliVd8uiEPmUl3+nx0N4FJG6D7bFeHAyxcqBGwZHQgL8Kjz/HsSadCowZ9OMpkBjZaW
         HqHUgTO+GLuB91+QqPs5L3lg+trET69rpzmJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733939427; x=1734544227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrFKiLTjzmZuBgrbYAiFQaDGn8XrXNH9NjNmrsIJSdM=;
        b=AD+7/7zhl/eprwEsc1ndLx5QWdQ4NILBsf782KyfT25Fj1kSChS8oriKPLvuGk8dE6
         1DCHEJtUyi9FEJit+cj/LaVnmuhv1O4bueLA6lecQjCJ9UVvjeUeZVlf1v30Ktzk+M9P
         2Gfz10SVK9SZLzI9GpmbHjqs0Uw6MjGDzQuaF067lGYfL3clhE/Gt5vdzXyaV1Df19Hl
         qJHq0hZSGqrcp6QGJy0qBRj77o5W/Co4sJNLIifCmwWZphE7tjEwHV3uP83cyWCXh8lD
         rKJJxr9OOJSoSYgowCrUyXXs13YDOvsvX8NxZIGhWH8xnd/CMf92BIMQdrLmgOS6rak8
         8/LA==
X-Gm-Message-State: AOJu0YwHI0qwIILdJvcScmalGE2Mba74JPnzAuELMra/XVZxsfYNUIHA
	X5hnZdRs8okL3/1zCcARppxOYQcRjjznM+zx2X+4X/3mRwnmfvMmtB1lIC+aYOyrGJ9cMIiLjoC
	Kl9S9Xr7HeTgYHY4FNlfeLxLDqCOERZk2itsu681MgTdHx37lXZY=
X-Gm-Gg: ASbGncvwemJVBiPbqAytZt79URGAY2WBwq4dVe3dk8PCyqgJMKYBOH7MmArTNm/NAVK
	hg0nLi8tRqJ787fPSKQEZDGT5gvVsYXSTDGjGJutFi2WEQzsiXbzo0u6+96H1nHh9KvEt
X-Google-Smtp-Source: AGHT+IHhA6RzCWPY5Cy8FBfWo9CkXevFmEP92UMKTMCrrdnrCRR1MXGbOEwolyJuppFPnroboU8Wb7GwgnK5V0ZaZyg=
X-Received: by 2002:a2e:bc94:0:b0:300:2a48:fb65 with SMTP id
 38308e7fff4ca-3024a20f6a1mr793861fa.18.1733939427360; Wed, 11 Dec 2024
 09:50:27 -0800 (PST)
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
Date: Wed, 11 Dec 2024 18:50:15 +0100
Message-ID: <CAFc1U0tWPyn3NS6L1JZBkhwhM9FeycVAnTB9KkR5LoHf-uki8w@mail.gmail.com>
Subject: Re: LS1046 support
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::233 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi,

Some news about my test.

As the LS1046ARDB is supported by the mainline kernel, it was quite
easy to make it run with linux-dovetail :-)

regards


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
