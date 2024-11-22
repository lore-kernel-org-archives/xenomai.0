Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A021DD886
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280094; cv=none; b=fOodRWXqoCXWaXC15ZSwmznUwr3PDrKDDcZjPQOq7ferlgrjHjm2UJ4jZ5XrHKv2Hnp2AR+gkqRk+cV5jVlDf1hXiG4Mx+bmG7/7TAW1VS31Deoo26txAOAgdKT/N/fNibEEVwDwn0gcNityMMmaU1znxtIetTmOgJvhbM+SIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280094; c=relaxed/simple;
	bh=clNSu/sCNWNfSJOXkeGtRtorOHMtRUG4iJNvtAeGaK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FABN6PwGrXDbfP70TRPtGCs0CFJ8S2GsG4Z9qhGubh++ouYVFi7DcPciSeXD+x32jb2lRTc8GY5Kwbv2nzX2hHGwlVvIxjWBAJ4DW3jxxqj2L5KWC67SxCZabEcTIRX8qfSBHIuIA1H7Syzx0PBeg8w+/ZMrCaf3UYrM9mTfnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=oDWbQwOZ; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="oDWbQwOZ"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 7F8FE80002
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 12:54:45 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B7D9A9416A5
	for <xenomai@xenomai.org>; Fri, 22 Nov 2024 12:54:44 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so4710191fa.3
        for <xenomai@xenomai.org>; Fri, 22 Nov 2024 04:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1732280084; x=1732884884; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HauLZIYmw6QcV3BixWVU+BY4Q21vAzXSmxIEt2/K8/4=;
        b=oDWbQwOZ3mwS5qaetrrq2P15Vj547Ae9l1KLZBFlYamQxQg754BzRIWD8dGfUfntBA
         muTxgCaCvwQJM3TPlsg4VD7bOvsHlxWXSnkDgqGROfzHp3yc1uBVefL3nYcc+Z7r9guD
         +3AhFmpAtkeOhwyZEdCK9HQ8xcK0ozPSajmN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732280084; x=1732884884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HauLZIYmw6QcV3BixWVU+BY4Q21vAzXSmxIEt2/K8/4=;
        b=K/XC53GnJ4EUKG8W4nPDS+Qz+WjOVwSc1axMtnBc0MsigJZd9yYm1710O0wMD/3dsC
         agkHa63ljVZNkhDgKmeSYIOA0Axk/L6NtoMalXnoyQLBZ6f5P/4HFi25FHSWjoFCCFW4
         jtY7ZJ+hsfDBhK6e+9oxjgLEF6lXTSSzgG/jo/Owi2NON+Eu3hnK+x1UmXiHJf43smBH
         OVGuuvjjAOAAyM7iWtTwPYmweQaEXfDVrG1c0lol7Xl/UB/iIfIhMYhD1ah7xk+WXFEJ
         f2N2N92UxixsyWzrK0jm/CtO1WD7b4bz/j0pCOvy1LhCJ2aD9PQv2sHgNftbWjrwDey9
         hdiA==
X-Gm-Message-State: AOJu0YzkXxAEfqWVYzyZLYABoRwhrUmm+7z5/ds7iCIrIkbUHzEca3uI
	s8ZncpB0116Q+gnLNvOTqzXE7sm7i0RlnHFrMGAQGWCvCRlEBoWwp4lV+dc7U/lhw6BvrlKuzbM
	1XRRytU2QeTyTHDFL6ezyBZLZSWY6emiwsikkzA==
X-Gm-Gg: ASbGnctFHi6Cr8bpdxF/aHvsahTPE0jWjYGn4Lh7o1WgvCoA7mjYvUQgufk0yDviSIY
	IXe3qnT+AJrjEi6eJhqW6gco7k+3bYuWFcmTJM0tcMZIzIQFNY3AA0NMqsLgL4Rvg
X-Google-Smtp-Source: AGHT+IFq4hsjhzZboJuOl3lfVuW4hrr4JurSRvEg3TXcLzLIsXf9FWFR31ePqP+rPYCpSC5uXblWftD80GxMiyfKArY=
X-Received: by 2002:a2e:a98b:0:b0:2fb:6057:e695 with SMTP id
 38308e7fff4ca-2ffa71302d1mr13475351fa.18.1732280083973; Fri, 22 Nov 2024
 04:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0ud_mp1nfZNR9xBML4ddgXo-qAu47=cwtv+GBQ=3kf9WA@mail.gmail.com>
 <c0d68831-8391-480e-94c3-b5666edac991@siemens.com> <3b14df79-5b77-42a3-ba64-4f0a454c7d3c@siemens.com>
In-Reply-To: <3b14df79-5b77-42a3-ba64-4f0a454c7d3c@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 22 Nov 2024 13:54:33 +0100
Message-ID: <CAFc1U0sUZS21swZTChDMDPLccZoX7vSO3V9Q_gUaCR6XT2_e5w@mail.gmail.com>
Subject: Re: Xenomai.org + Giltlab
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::235 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Was down today at around 9am then back, then down again...then back


Le ven. 22 nov. 2024 =C3=A0 13:52, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 22.11.24 13:51, Jan Kiszka wrote:
> > On 22.11.24 13:44, Pierre FICHEUX wrote:
> >> Hi,
> >>
> >> Looks like there is an access problem sometimes...am I wrong ?
> >>
> >> Error 502 on the website, very long access to the Gitlab.
> >>
> >> regards
> >>
> >
> > Confirmed. Philippe, anything related to you refactorings?
> >
>
> But now it's fine again.
>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center



--

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
