Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08B31A65
	for <xenomai@lists.linux.dev>; Tue, 19 Sep 2023 13:56:55 +0000 (UTC)
Received: from redirect.mail.gandi.net (unknown [217.70.178.230])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 0DDA5D3A86
	for <xenomai@lists.linux.dev>; Tue, 19 Sep 2023 13:44:51 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 616C924000B
	for <xenomai@lists.linux.dev>; Tue, 19 Sep 2023 13:44:44 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 5B7587803EC
	for <xenomai@xenomai.org>; Tue, 19 Sep 2023 13:44:43 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b974031aeaso93445921fa.0
        for <xenomai@xenomai.org>; Tue, 19 Sep 2023 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1695131082; x=1695735882; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z1oyVrQ4+GuLISPWlHfFbiIDBLBbpFO21U8KzCLwNU=;
        b=WRhOE4h1vuTY+6a7W7xjZpLrbHM5l9c9MpoVZjDQRbbR3u16H4HjkgpV636EWQcQVL
         ZgqUF/VkwaR9Q7rEr4Y1G0PLp8oHglqf1Iw7tMt50qMdn8oQu2Aix6wssbOnTh/DJqIf
         Q2UIJrpzGD/J2VhgopCuVi46Iyho6ziMt2ifX9ycKZrfe7jHfyQcsEBYEdUGG5qhndxl
         wCxeY89SAQ3KB20bsV9028TYaprMYqbTnI1kmpphdSOzXOCj+VMYk1rDesdzfpROI6Us
         fYiwuYcGrd3mTzRKLCQciaYzQan8iKLpjcENfad9znw5sr9d9mbkNP/3K5A+vu+9i58/
         QmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695131082; x=1695735882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z1oyVrQ4+GuLISPWlHfFbiIDBLBbpFO21U8KzCLwNU=;
        b=MNtsnvEFTW3s2cqEgaNd7VFQIveBg4KbPHUZpCaXuaz4K/NnWWVJh8ZywZQIOPo4SP
         voaQlKsiHofXOY9aRjwjVyG/ImmiEIv7Naz7150WywioQfiLv1NvchKBTw+0tAcRXEzo
         zbOu0XavGMfbHtZijLI7PJU3RBz5Iu+aThn01JURWQKlawTuuQU4L19UnyOKWCMBzNA6
         uwYUmsd74OCjAQT/gK0j9h84P+XAA+sGwKy0iKw42ouSK4lScEe4Vr74Z/IQeba49nGc
         xkMuurqLKG5zae4AJsHlmWwV6fLkCDwEsQlkEnbY0w9AZTqrrAtFmX2yD2jef5c+UIj6
         eO+A==
X-Gm-Message-State: AOJu0YweaGOJ4UnID4ru4OWGn1ZdQaSn6HXbeNRlwlEbPklEnjlHLYwc
	zX3isrG6YO2tczvKUvzKTx7N3Vxd1Jct41L+GNNxD7pYdrwqt1hN
X-Google-Smtp-Source: AGHT+IGaK9qkBoUy4Ow+Y44gDtH6c3NlRxGiwkbPtLLXs8L5OnirEftxcXYoklg3Qn/47nlqoz7vl4p3C7lFdCny02g=
X-Received: by 2002:a2e:2416:0:b0:2b6:eb5a:d377 with SMTP id
 k22-20020a2e2416000000b002b6eb5ad377mr10372047ljk.5.1695131082562; Tue, 19
 Sep 2023 06:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0sNjB52q=9pNQ_G6o6R07GJTPJtYZs-AHh9Oe0PVXkzwQ@mail.gmail.com>
 <08509b51-fa6e-466f-8974-b88d0c63644a@siemens.com>
In-Reply-To: <08509b51-fa6e-466f-8974-b88d0c63644a@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 19 Sep 2023 15:44:31 +0200
Message-ID: <CAFc1U0urgjjpLdVewh5AQjaw4rknjYPZTey_a+AgmnPoh9ihMQ@mail.gmail.com>
Subject: Re: Xenomai.org download access broken ?
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::233 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi Jan,

Thanks a lot, I didn't see the message.

regards

Le mar. 19 sept. 2023 =C3=A0 15:42, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 19.09.23 15:23, Pierre FICHEUX wrote:
> > Hi all,
> >
> > It looks like the xenomai.org download links  used in the wiki page are=
 broken.
> >  (https://source.denx.de/Xenomai/xenomai/-/wikis/home).
> >
> > https://xenomai.org/downloads/ipipe
> > https://xenomai.org/gitlab/ipipe-arm
> > ...
>
> Wiki-based homepage has been superseded by https://xenomai.org, see
> https://lore.kernel.org/xenomai/878r9atwev.fsf@xenomai.org/T/#u
>
> Historic downloads are in https://ftp.denx.de/pub/xenomai/ (we are
> looking into setting aliased for the old links), newer downloads can be
> done directly from git.
>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
