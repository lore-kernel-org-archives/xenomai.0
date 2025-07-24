Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41610E0
	for <xenomai@lists.linux.dev>; Thu, 24 Jul 2025 04:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329687; cv=none; b=GeMBjfZAoVS+7g5alK+vhhl5O75X1kmPII7+sxgL2h9oD5F++p94V0BSzA/uXXW1fnm2jT/GtR5P1ovwUsNswsnO3tT9/iL2J2TSG6aYhrnLxBO6+mo1cGiL7hiXgTf4zDMIoMejw2opiPZKADqO6czlYeVdehDKyz63plwO6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329687; c=relaxed/simple;
	bh=B1jp99JZREoenK8oiBdWsi1L20Fxgnb+6eeOJDTDr6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sof+mJu58xlT3ViPz9G3Nhe7JK1xyhMlQnriV7fGZm/qyJqvZEZF9zw4b2y6kPS2xh9Ejv2waq7E7SXaYlbsHhRpyM7FQLS7e6P35J/ro05n6NbEXCkpjeedBH9UZpo5Ebb/KkMZZa1+XGDCmAxvxUlr7XY8CjsxUunpmYJakjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=AyBuSaPq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="AyBuSaPq"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32e14ce168eso5981871fa.1
        for <xenomai@lists.linux.dev>; Wed, 23 Jul 2025 21:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1753329683; x=1753934483; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmnVflJFQeyZ3CX3CF0+0lEnzg2W0G02YyS1FxYVT+8=;
        b=AyBuSaPqXyVJMz2FhPZl6p++wyxB7A2vkWmQzm5fNQikGS8l7E00TkGyXybBmY3fzL
         rOinAUIkzFLHuFyt1u3HZLxg6eGOA3+hTJr1Ema0ByLvAj6Zv26uYSxAmvh0omRn94bf
         JiJA+67Wtff15SdUdGig9TgGWPFa+4vCQKBGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329683; x=1753934483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmnVflJFQeyZ3CX3CF0+0lEnzg2W0G02YyS1FxYVT+8=;
        b=l9DDOgqmm/jLcvLzodnEhSlHac88+rSQPeGGPqW95rwUlSaOqADXVW8wB+1mB4SXgL
         DCCNkqaVHcseW2RVSeHmtRuD0oraViLLeiQO0kJ3JPrt2HuUtnZNiDWeR9f2M2RVY7Z0
         qJWZkvuheEs0Wt7ilWmvQj+nxtUXCSRCnRhjmXl4CyY8OVjSztkDx/FP+4lZj3vDiF8V
         76hFte1wTPT+bf1AM0luG9NtqCoMjbM2dqLZER2n/arxM8zxX9Tg2/OnS+7196Xv/Xhv
         q+ZWLYdUror4c+cByXmXEwltd8ulchcTGlUx+8yuW5G7d1QATdRGVgH0HPS9zROiH3g+
         9+4w==
X-Forwarded-Encrypted: i=1; AJvYcCVdMRP0gstBvdtcwsZ5DrOutZEVG95lrBgoLHAaCBNJkIKPEERdD4bA9q+EE8WO7KGh05ENATl8@lists.linux.dev
X-Gm-Message-State: AOJu0YwFIyR4j+81iHWO/1Iqb5q4Q8W3ZX2V614Bq8fjcxCakg8mFVxX
	1oeBbfNa4IsSnf8nsazfHy+pvPGAuddmBQ9erXshnaO3eGlluyzmhv4VzbZohYwtmBYKilF4cU8
	Xw27hyI+leBR/Byv5TzZhHRFCSpP1gVCsmMlrrL+D2Q==
X-Gm-Gg: ASbGncvfqxrYFVEtB4XQfyOclqH5xH51ukcNm2eoMlytexTfUM6dHeNF9F+UNPFD2XT
	NWQoXhWrGO7JTL6sD+vwGzZS85utJSAC9IJp3KSqoAKdt3PrXZi4NZwGLb8UxAu4753TUWnixR5
	o93hdPo3LEmYZJ3d2SZ5SLs/fA7ur1nVFCoFWSoo4P7XlxWuHI/FIbBKw61BYAVD9V1jDt6+zhz
	IwwcaRLipc7mAgBgpIITzR0r1JTtdcEeP7WISWP
X-Google-Smtp-Source: AGHT+IGxjMqFIGyOLP5UlYvMrp+vvZ6M+OnKNnukCmvTrMChR0RhVAa2rJCFoHHyPcg+0cqameEnjoJVGe8bIlk0QFg=
X-Received: by 2002:a2e:be11:0:b0:32b:6cd3:3938 with SMTP id
 38308e7fff4ca-330dfc4801emr16556981fa.13.1753329683083; Wed, 23 Jul 2025
 21:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <7ec1afca-5d28-4763-a091-886e1c31412f.luis@apue.org>
 <CAFc1U0v7ENaCASVAje4CdEoJ7xP1GmM13StK4rVCt9T88mBGSg@mail.gmail.com>
 <f616e74e-2df6-494f-9017-201e5825ab4d@web.de> <ff2d19f5-ae8c-4db3-904c-c5498733e9c8@babic.homelinux.org>
In-Reply-To: <ff2d19f5-ae8c-4db3-904c-c5498733e9c8@babic.homelinux.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Thu, 24 Jul 2025 06:01:12 +0200
X-Gm-Features: Ac12FXxbRUj0SNIgDJEEe4GOoA0Ad5m3zAW8yQYDn_ghzNwaVhrAx0KGF1wEyr4
Message-ID: <CAFc1U0stQBrmzaSfN=T_rHy=1xyqxiPjbLOWnaArHbHNCgOmyA@mail.gmail.com>
Subject: Re: xenomai.org down?
To: Stefano Babic <stefano.babic@babic.homelinux.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, Luis <luis@apue.org>, xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It works fine now, thanks for that.

Le jeu. 24 juil. 2025 =C3=A0 00:57, Stefano Babic
<stefano.babic@babic.homelinux.org> a =C3=A9crit :
>
> Hi Jan,
>
> On 21.07.25 18:33, Jan Kiszka wrote:
> > On 21.07.25 17:34, Pierre FICHEUX wrote:
> >> Same for me.
> >>
> >>
> >> Le lun. 21 juil. 2025 =C3=A0 04:45, Luis <luis@apue.org> a =C3=A9crit =
:
> >>>
> >>> https://xenomai.org
> >>>
> >>> GitLab Logo
> >>> 502
> >>> Whoops, something went wrong on our end.
> >>> Try refreshing the page, or going back and attempting the action agai=
n.
> >>>
> >>> Please contact your GitLab administrator if this problem persists.
> >>>
> >>> Go back
> >>
> >>
> >>
> >
> > Thanks all for the heads-up, I've informed the admin of source.denx.de,
> > our host.
> >
>
> I could have access to the server and I fix this, it is online again.
>
> Stefano
>
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
