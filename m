Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6384D8BC
	for <xenomai@lists.linux.dev>; Fri, 20 Sep 2024 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726818078; cv=none; b=cg/R1CjC1dBcovuvQqsiCskH7T5h1JWlIyPRMvsE4+kox1MP5W47QOQh5TidoMGyXY1pbZOul1k7KCQA7cYd39L5HFRzzV7CfMtru3f55sDQ+mlrdIhFaJkr/nZKxXqRtQcP6ijxzidfId2wU9/b6jWFahHRVxEmYjueFC6jSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726818078; c=relaxed/simple;
	bh=XpfSvwkfA53pnl7r6Llgm06gyhG+tIaL+jROslJabgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MjVuQ65HsKV3bvyZLZ8muMTpSA/Y/3SL4H81d8VBHkvbIot9t2cV4EobXGstJYjRYcbdcu8FLwSUzKGi4wd0bI7XK6MeRJXWjejJx7gVKiaK0FGFFbjC5Ejvpy3zO4QrCdJktcBYIY9Jlx8wW6iHi0wYfehnSr4ECyHUqmusBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=Zd33xePv; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="Zd33xePv"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id A33B11A0003
	for <xenomai@lists.linux.dev>; Fri, 20 Sep 2024 07:41:13 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by spool.mail.gandi.net (Postfix) with ESMTPS id CEE4D941030
	for <xenomai@xenomai.org>; Fri, 20 Sep 2024 07:41:12 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so19370761fa.0
        for <xenomai@xenomai.org>; Fri, 20 Sep 2024 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1726818071; x=1727422871; darn=xenomai.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWquoUv3oK7OjqBhau0gMoAjzUaxRZf6jIvZPoFysg8=;
        b=Zd33xePvHBjw7tVkEC5uZAiC3YzQ44KtGPvEJd7EzmFd9NhT1oL0rmEaxVpCUpysNo
         WXS8zu2NvswsPgcqMDVi8GQ9ouxmCUmUlZ46wAYzQlM37Zi7EwyHlgdmzLck+D1Xa5oO
         qEVuwjWs9FCX5oZeHEraChFxP+4K33y4SkpdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726818071; x=1727422871;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWquoUv3oK7OjqBhau0gMoAjzUaxRZf6jIvZPoFysg8=;
        b=rInH7XW5INTFJ/pzJMYN+vya35JV3hasD3bdRBoIz+A0sMx+hNrqSLK7ARk1d4KZ9+
         Kks7V/aa5PyxIwIe845XRrczbWaoWLaYiz/WOocJI6tVjBVdu5IRojRFiY0bJJ03512y
         fsJfz4CUhWpgHTpH8+Zhr6oZNaC5+3TUwHo2Qp7JbQ0Tj101rFZwIt0KN8AJBFDSw3ve
         1b6E0eHchMRoRW1ooa0jWoq6X7yF5xEo4PQmtRw9s9l+G3DoB/FsvQeRm7jiP/q98wuf
         j4Rv5kPLr2+9VEMy5iNSiIazRXOusJqsQIx4zYUqWpTMKaSgC0QYpXF0YGazalwcGaSG
         +6bg==
X-Gm-Message-State: AOJu0YwQU+LPEKnl8uL+wN4mS5Zc0E5NxJ7Lz7ErvSqQ1yWxLTBd8p1g
	NCMYmoN1N043kPxYavdNhVPCaKZq/LXbKJjdXnQ0F/xn7WFUdTJwG2kDcuhs0bETQwBso/WknZv
	hwtVYiMsoyFK/hNBSNUrFVz+G30tEBv8Aej/9aBZtDhgkavkq
X-Google-Smtp-Source: AGHT+IE2miDcgBpk5oWEH3RO4X65zbH37yYkai+CPZWfw3TxkYmhkXV8aFrulzY3xaqTvnWazOeX58tCM8AutZ1xPPY=
X-Received: by 2002:a2e:b8c2:0:b0:2f7:5759:db45 with SMTP id
 38308e7fff4ca-2f7cb328923mr12535901fa.31.1726818071431; Fri, 20 Sep 2024
 00:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
In-Reply-To: <CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 20 Sep 2024 09:41:00 +0200
Message-ID: <CAFc1U0udyU8FJMB_Vmz7zg1kB0M=9SC=Q1m+-E6hekcsYcRHXQ@mail.gmail.com>
Subject: Re: POSIX API for EVL
To: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::229 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Maybe we could talk about it during the next Xenomai community call ?


Le ven. 20 sept. 2024 =C3=A0 07:57, Pierre FICHEUX
<pierre.ficheux@smile.fr> a =C3=A9crit :
>
> Hi all,
>
> I've read some discussions (may 2024) about the lack of POSIX skin in
> EVL.  Supporting several skins just like for Xenomai 3 is not
> really useful but POSIX is an industrial standard and so for people
> willing to use Xenomai instead of PREEMPT_RT.
>
> In the EVL documentation
> (https://evlproject.org/core/user-api/thread/) I can read :
>
> The main kernel=E2=80=99s thread is the basic execution unit in EVL.
> The most common kind of EVL threads is a regular POSIX thread started
> by pthread_create(3) which has attached itself to the EVL core by a
> call to evl_attach_self().
>
> Don't you think a kind of POSIX "wrapper" could be useful or is that a
> silly question ? Did I miss anything ?
>
> I'm about to start a study for a big industrial company and the lack
> of POSIX support is a real issue.
>
> Regards
>
> --
>
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code



--

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
