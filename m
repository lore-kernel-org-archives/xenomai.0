Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD581E
	for <xenomai@lists.linux.dev>; Sat, 11 Jan 2025 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736573878; cv=none; b=WVKFdb+CwoucR5FBUfyT8U0hgglAi6sQNF9jQQEGaKncdkk2rDOIlzwn7v4O9BAvXQ4Wy8hzlemHNf0mUw4DvM2S+iJK2Nyf1hkyzqOZqziEI1Tmc+Iv4GEVw8pAfSK1dTgNAlmXuAVdqAMdw5mfPPRMlQw4HitN4c3UfSOsQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736573878; c=relaxed/simple;
	bh=w73Cy4esyT29mhMY4767PU0nNLGQMhEPKcZz+Savpxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAy3zkjgSwBmgeUkhBl+b6Kwh6SbQj/07PUTMlH0VK0SS8wy9DB4kjTe8xCxFvVv7+6+ww3dmuvk0bSVTrdKsaJeHayUy06n4IIJwtJyS8QrWi9m2xUBxAE6nu8fA9YZtIUpHyfJ/TcvYsTW7ZKTZ4dgY8qg9Hs+J2eFpPO+TPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=sTqyvSRQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="sTqyvSRQ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30039432861so26419541fa.2
        for <xenomai@lists.linux.dev>; Fri, 10 Jan 2025 21:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1736573872; x=1737178672; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqMaaLL+QCe2iO9GoPuOBg4KwjfTWuNGP2dQ8i8zEaU=;
        b=sTqyvSRQb5s6r/Ee6EjiOCkZX+tVd7A5e7RM5bDeE2YEPLja7famSw/1RJY6+mXyqj
         ovfYLH5VTeK3UR8RCnSLm76oQIGPkeN/xbiGrZ32yU75jK9FonZQ9XlpEm73+1yzx/Ka
         kPlAiZjrRlwUwdaNFxX6gEZq6jV6PMT7qQkxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736573872; x=1737178672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqMaaLL+QCe2iO9GoPuOBg4KwjfTWuNGP2dQ8i8zEaU=;
        b=LMeC30ORKvg/dFB3v9E/sjibM27niB0upBf6/qVVQJsM5OSCp/uP1Kcep0vR8Di4sR
         e9zJ8Q8TIO93qgUjOiUnFR1zqYQnsWk3q6nE2odN90AiMxlcqn20WJ7vpCA6i8Bz+NxM
         Q83jImqyRocFjVSIFRuIQUo0EC50X2IgWSz0Yz8YbteG5m+PV7f+x//lkyBu26EArLgN
         hyg8rL2WTFSwp8C5CTxGRnpRsXe7HSCcoZlXYAHWtqs7IHEeWrb7sgREuwn3Iied/oaC
         X6/jWrS0D00yo1aOb2Wm5JKVxwrsVKeJttTuj9ge6sZqMPddWpCTs5yicuHL/3BH7f3+
         OBmw==
X-Gm-Message-State: AOJu0YyiGrYbqoDIdrx5IuVYlM5911R+ZJ38xFT6ZGJWctRMF4TAu7E3
	iOcbIlpJhSxjmF6ZCo+jO5DSZrHgpotxYA+ypNpnIcAl4gVKvPcLtgo5wSXP7HkkZgZDb2gOln1
	yvCygiWGBDyC2ssYs9tbFb+CAamcEOuIq2YRz4Q==
X-Gm-Gg: ASbGncsftUkvjebuTfVP9TGawGzhbTP223tArYu92Up3iylSurr/tvN/qCSnRZKPxhk
	uXBlOWXLV+teVnpIOIYuZfHOA3sw8Ac4xS61WZxAK4J953FnsSbHrzVJp2VSVR2aU4UZXIQ==
X-Google-Smtp-Source: AGHT+IE+0ihshUj4mJBkPGXQM8b+86RhLVx5Iv+RCRiga1EaM4JrehZDZ0SDV3HkRAVXtYbk86kOlFgIXu4iSg/MMjM=
X-Received: by 2002:a05:651c:19ac:b0:2ff:cfbb:c893 with SMTP id
 38308e7fff4ca-305f459ab20mr40794931fa.6.1736573872209; Fri, 10 Jan 2025
 21:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <87ikqnuiqb.fsf@xenomai.org>
In-Reply-To: <87ikqnuiqb.fsf@xenomai.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Sat, 11 Jan 2025 06:37:41 +0100
X-Gm-Features: AbW1kvYnCs6R0EAMikuYHqDGnYXNrTzsbZAie5-jxhHzCUgmRDw5bFpvCWIRbYg
Message-ID: <CAFc1U0stx7k8yo2v9GNTW9fbXrBO5amDVm63h=BxO_VF6TpHuQ@mail.gmail.com>
Subject: Re: Paolo Mantegazza is gone
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Very sad news. Another one after, Gilles, Wolfgang Denk and more
recently Daniel Bristot de Oliveira.

I still remember the time of RTAI/Fusion. Sometimes lively and
passionate discussions with Paolo but always passion for the
technology.

A+


Le ven. 10 janv. 2025 =C3=A0 10:24, Philippe Gerum
<philippe.gerum@gmail.com> a =C3=A9crit :
>
>
> A month ago, Prof. Paolo Mantegazza, the founder of the RTAI project
> passed away [1].
>
> Paolo and I met for the first time in 2002. Back then, together we
> went through a period of intense creativity, standing side by side in
> the battle for a patent-free real-time Linux.  Though our paths as
> contributors have taken different directions, we have always known
> that our friendship would endure.
>
> We got into the habit of sending each other pings of life, where
> Italian and French jokes punctuated our conversations. Last December,
> it was my turn to put on a smile in his mailbox. But Paolo didn't
> answer me. He left before, on tiptoe, mischievous as he often was in
> our discussions. This time I have to admit that you didn't make me
> laugh, my friend.
>
> Paolo used to describe himself as a simple practitioner of software
> development, one of whose missions was to contribute a free real-time
> system his students could use, study and improve for their research
> work at the university, welcoming others to join. Many Linux users and
> businesses owe him a lot, because under his leadership, the RTAI
> project has always defended the freedom of developers to implement
> real-time systems, particularly at times when it was threatened. His
> fierce will for RTAI served the Xenomai project, as well as others.
>
> Paolo was a brilliant mind driven by a great sense of humor, his
> culture was vast, and his friendship was unwavering when he granted it
> to you. He was often in a hurry like anyone with many ideas but no
> time, always plain-speaking. One of those generous individuals who
> embodied humility and that will leave us with an everlasting sense of
> loss.
>
>
> Ciao, Paolo.
>
>
> [1] https://www.freelists.org/post/rtai/In-Memoriam-Prof-Paolo-Mantegazza=
,5
>
> --
> Philippe.
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
