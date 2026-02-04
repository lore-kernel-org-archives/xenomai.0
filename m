Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048293A1A2E
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212718; cv=pass; b=LETB6G70nMkLWCn2D0zelsgOQO7v4+GvIrvR78vVLfHJqktXGUcgZERw4omck1s4O9umcdFMMrxXyMkTZhpkVqsdNQSBntbM9Jd5eZ9XkA2Zu3ZFjRP72nt9BwjfT0XoAWnqqXoSelu3fihcdz9L+XZ8C53bz+JwcjpheLA4d/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212718; c=relaxed/simple;
	bh=+RbgojPUDwuR/fRI9Rm6oE7szZqw6BjNfdh7Hfuic0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=L5PEZUjbsOVLAxHUsFeYlFjiA+F9ZUTViD957xbNalxykR9XqE0inStfrZW+lhdGT1YkmepXYj1C0RFNE6WNTsvcdeesCo7sA85JIu9ampTuyfG97fD/dkIRrV//UME2Co+1Wacleu4yI9yXnuNN9KXQ2qt05jfGLdkGGgP+pTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=36fHzUxI; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="36fHzUxI"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43596062728so656102f8f.1
        for <xenomai@lists.linux.dev>; Wed, 04 Feb 2026 05:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770212716; cv=none;
        d=google.com; s=arc-20240605;
        b=ZEycbTbEwSSkUBU4miMOTnsVYAqkV9Wp7DlMsW+rAAyJYkM6MtcH3oK9pcc8PZoJaU
         oXLNGZYUnKsO9AFDlXLQwC7erbmWVtCV/jzuLOWXfGu1DNFVnZ76EZCYtTZqR51aa55o
         2EBaQyyvaVWhiFghU3HqNZMhmomej2fNkZR9n655XK7lqXZ7caQgcQ1YInLh6qJSQWhy
         eNp8A/ikgtE9SQpPDVq8JTCRLX4m8ZDGAQYP/nW6n/kQI8f8+M+AusL7J6gN3fLABpa4
         +rCs8Y4804dNom5BM+rEhaen9Eqhm2T8y4bY/o5hCAQfLSAIQBn9T8GiCszId96Z5Odk
         H/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+BbAnKZCPUQ2OG5fNB/NBKH3ToawiuR+WYTBus4M+ME=;
        fh=O15oOK5VJ7+HnQyR0P4j8h8E3vdYlzLasLiICAHXHME=;
        b=idtt66IYURTqnBdjxwj39mqL/AkuqAGvVPFJ25PT6ufPXFlqvAzLwW5e81i2IbwtLi
         BGcWf0nPSjnVqGc+GaDT13EAOPiFohFMqmP+AR4UYdCbMwv3R3XW7Zz2n9eFT54hQp87
         Ef+n6drOXxF1ZFriepPvVjbTr8E28nJDCIWW5KxXYn1XaUAagmueYtk0T764O+AeVWUZ
         gUf1GieaDfER/IEHfEUw1az9Dq4K7ICb4A2ZA6+NeaUxBKy1dyd9Z+7yquLNRNlto0gf
         s9cCo7Efa/brLwzzbmTkclzVPxS8o4/h5DNNIB32Q3TOBCbqXBPM+KRouLe0PfVq+DWt
         lqqg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770212716; x=1770817516; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BbAnKZCPUQ2OG5fNB/NBKH3ToawiuR+WYTBus4M+ME=;
        b=36fHzUxIr7dG8NepPAqxCML3gRlayRqFfsyECHx0a25OZKXb//lke9lzyYsLMzUkh+
         Qxy9IhKLFrMChWds1+FVyfrXBcfy/0IyJhgJ3XgfNLxDc0MJm7qN4OpBRIU9Z82Xnk5U
         NcILb10vC4C5l9GOWFtAS9588HVAVUOkbHhzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770212716; x=1770817516;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+BbAnKZCPUQ2OG5fNB/NBKH3ToawiuR+WYTBus4M+ME=;
        b=mfESgbthE9ZV0cJPSYhT6Z9Qj1DtWlmvvdzlaGVa/T8pUm5letE+hB5lG9pkUKdpd4
         /FQnzLmuxsTeqRZNWU503fwWYv7Sz83MqkfWCRQ98hX6X8CqM5NE4/h3lEkBZ8ovAWAv
         HcJ4H0cdyFadixvXkV0oW1nhGaXZ9j2TKgAa1oD6ZOu8/jGNnEegZPiv0ZPHNQpSrqow
         +LYw3L0UWyBmQgVlsYN9UO7EcxeQuq+4VSH4+huzfxVodI+dvbVJ6+N/ErjJGYjQKHTP
         4VfGDeKXzKAXFA32pjOSV1OR8QDrMURwNjknhOLcjStOiFpaQbW8mFP7uPKtje6EiFQX
         J2Vg==
X-Gm-Message-State: AOJu0YxkQu/vQGTOfqhLWhdr7RWkpG+DcD6r2lMzEPd8UBDzm2mRfJfw
	8Pno0PpKjh/X7aDABMjl/L3q2TcazQQb1Pwmx5ES4cIhBDzr4lbFB80q8dhU0O/P5QCFkttKfdj
	rO+g08Qtv3vcyINkLwbNNcm0IAuERbVoqvkxKHMh+s/xEJEJQ01Dl
X-Gm-Gg: AZuq6aLFBxTL2x7xY6AIh4xZ4hkx2gtXQvg3ls+GiUU6SRwmDUJXh394d6fm07TXFgZ
	CNomz2Lhopwo7b+x8Jr4rVMKLbCkUUrOYKcNTOmh3wcH5ZXJ6rOiP4XI4gnzY8UupiDa//YUBE3
	XEAdtai9r5StillU47oAmKISe57G4AjibQqnyq7HnGCOFk0QiHVuphey85+sQ64N5YBrE+IQXOY
	iTds1GVch3ManYd43vE1+FBzMhxTdeLiGR8N/p36yDvujOrHapN3MItM8Nn9KsVWnAxSD8Juw9Z
	GKjTwwVhYM21lICTSpQ0xvPXhJoW2oa3eJnnnLtZNLWLiWkyThoAx7g2WLoESEXOijYV/B0=
X-Received: by 2002:a05:6000:26c2:b0:436:15d3:ed2e with SMTP id
 ffacd0b85a97d-43617add15fmr5082339f8f.0.1770212715908; Wed, 04 Feb 2026
 05:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0tiZrh_GZAahX8_PRJkGPVr8_UAfdtv3GisRn01MqM+cQ@mail.gmail.com>
In-Reply-To: <CAFc1U0tiZrh_GZAahX8_PRJkGPVr8_UAfdtv3GisRn01MqM+cQ@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Wed, 4 Feb 2026 14:45:02 +0100
X-Gm-Features: AZwV_Qj0aeljvZDj4MDzCHZJhXVEqKKP8PtMoPFxr8gZauxem2R2uz5WXPZoRlY
Message-ID: <CAFc1U0uDm66v-v9N7tM6nbGroJiLOHVH0QJg_O2oy4T7eXO8EQ@mail.gmail.com>
Subject: Re: RTDM driver for AM64x driver (PhyCORE)
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Of course I mean "RTDM driver for AM64x *UART*" as a subject !

Le mer. 4 f=C3=A9vr. 2026 =C3=A0 10:07, Pierre FICHEUX <pierre.ficheux@smil=
e.fr> a =C3=A9crit :
>
> Hi,
>
> I talked about the subject today during the community call. We would
> like to use the PhyCORE/ARM64x UART (which is 16550 "compatible") with
> a RTDM driver. The 16550 driver exists for Xenomai but will not work
> out-of-the-box for the ARM64x. There are several modes for I/O access
> (Port-based I/O, Memory-mapped I/O,  both) but it's not enough to make
> it work.
>
> Is it possible to get any help about the subject here? I know Richard
> Weinberger has a very good knowledge of RTDM and maybe he  could help
> through his company.
>
> Thx for your help
>
> Regards
>
>
> --
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
