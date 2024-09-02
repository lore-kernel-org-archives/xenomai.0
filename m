Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B819C56C
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281884; cv=none; b=OLDeSLH79xSg+ppRY0+8wKsYu66lvVxTBSqxIlxQIicTvqhCfAv/YShCQrIT1zMmVXXQBcviU7a0jWqi20xVM/JvfonIm01YDMYZRXzKC9Gn5JQPiB1bE+3Fj3c1WFXXHH6aVZrxUTzwCoXWKngvVSEa3sKWScqGVGj9/QH7jNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281884; c=relaxed/simple;
	bh=afvTCfhBUl0Elcx7WYqYvkWRzD2aKcepFz/exPpIrQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uX3blv50YstFI/tRPkF9+Rm+rGHXz7uG0nR0zbN3hpGDBUoqiOTRacQRVsVOunzSFpbsl4T+4zNc2zNPCcl+mRvNsqblhkpZtNzMdoeR/rxcVkFS0PC2kuYtu8qSglxHc2bLXDTJbyT2+QtXtpDSV0fpNg4y0neva+GltBlQwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=1QImcTqy; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="1QImcTqy"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id EFD7580002
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 12:57:59 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 20EBB7803DF
	for <xenomai@xenomai.org>; Mon,  2 Sep 2024 12:57:59 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2f50ca18a13so49770801fa.1
        for <xenomai@xenomai.org>; Mon, 02 Sep 2024 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1725281878; x=1725886678; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDOG39nj0yAlAhTHxWATv6VbPG7M7UJ/UFhf2ZWdPHo=;
        b=1QImcTqy2UEuiDr1Y6SRgGWqKbObwTi3Jrqdxk8AtUMywVFBLlVlf9DymtS+NEEwyW
         ewUlpmTgevAdQPLbpGV3T4ePmTeVrFyz23wY6gVvNbBkYZzpsj+3GWxjSLs2jZPib+Fq
         WWKsq0X7b+NQSc8NFRFbGJkUQl+4WtQWPkMwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281878; x=1725886678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDOG39nj0yAlAhTHxWATv6VbPG7M7UJ/UFhf2ZWdPHo=;
        b=uYkOGvnbWivXeOIj4igsRQwz27cVXxdZP7xjQLb44CtTFx6pS0X5F4a9wv4s16xD54
         g/UOO8J11KhnbZykWhsIhbl1FRUnftviPh6+qcZ/BMX+9ik8dbI75IJ0L+RDveUJVhiw
         Q8tKCmzYCcYlWfNlnBKt4Sv4Dx3G3fgl9pCKUYxGf8H4H067RZjiTxzUrUV4kFvJ2OIj
         YKsoYIi+NRu25tnFtCfI67rz/qYdPBC7QbD/0DaHohwsAdOzMJkT5M/1AMeYp4GFswGi
         31qyGD/+c/HLKwDOUmXx3fgbAeco6IfTJJf2jhPL3MZQlA+xHNjTs+jBKfjGcY2eJDGH
         xmmQ==
X-Gm-Message-State: AOJu0YytDiTo8rFgIy5607CsO6CXuOsE29WZFOdvLUDOZYCSH2nVEUg2
	ABO4aUZLmLpD/5Dun/z7Sz+LTTyxCJ5aVupvG1c6NpylWPuf+JdZhEen9bVhMxKri73vSg9T3Ds
	hKosx+vEDRL/wWl2Opfg6OmV6rOp8zCtQj9L5PKAm2SX5xTqJ
X-Google-Smtp-Source: AGHT+IHs/Ls1ryEMvdjbxYjL+oZo3AwhlBofhukg25/zQk2MzAv1chwv04tCNsv8L0cTrRCIEj4+vYyx7UryEDuuVc0=
X-Received: by 2002:a2e:4a09:0:b0:2f3:f1a7:9813 with SMTP id
 38308e7fff4ca-2f61054a1c2mr89670151fa.43.1725281878194; Mon, 02 Sep 2024
 05:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0vFRz4E11z7v+kL=_E8NsNJvAsXvc3qmHBSzpnKzNfpug@mail.gmail.com>
 <212199c4-8566-4f9f-a2c2-2eaba99a6d1c@siemens.com>
In-Reply-To: <212199c4-8566-4f9f-a2c2-2eaba99a6d1c@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 2 Sep 2024 14:57:46 +0200
Message-ID: <CAFc1U0svARUpQHi3_4yNruzt2LsDPOe5+yY+eo=6zrhfZCdV0g@mail.gmail.com>
Subject: Re: xenomai-images for Xilinx SoC (ZCU102, Ultrascale+)
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::22f as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Thanks a lot, could be a nice contribution :-)

Le lun. 2 sept. 2024 =C3=A0 12:51, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 02.09.24 12:31, Pierre FICHEUX wrote:
> > Hi,
> >
> > I would like to use xenomai-images as a demonstrator for a ZCU102 board=
.
> >
> > I didn't see any support for it but I think it could be possible to
> > add it. Is there any documentation available ?
>
> Not aware of specialties for this SoC. Give it a try, but start with
> recent mainline.
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
