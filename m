Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117D2AD14
	for <xenomai@lists.linux.dev>; Tue, 20 May 2025 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747716647; cv=none; b=lk/D8O4mg2R8SSUO+EjxererLOPrplzBZ9jZbFm3T3DYWjQM9QOLmD5n/PW9Fb4rHCXOK/KKBg9OWfFD4qn3gghp/v9jmbKSWz3isedwfOfwN2ZgcYq9iHYh23fJXIIXI+mfSGa+QSFDHbEVdutiz/xCZsYOke+HY8aiBpg8aHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747716647; c=relaxed/simple;
	bh=yYc361+YQeT0sts6G627NXTxr/vTSzNlhwPqE7PvMcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOxXjmHSiCiTlgf9JxjpTX4y5XeNGPoqChp78pI91P5R5FBzLCSS3lIDtyqyfuTm6xFIxUOeLkeLOIFNg+g+McbFuofM9bB4Nf0sqKugtzYLOj4mODyrKrhnP1BWSdjIpU+zQm2VKxA9GWyRDuGZBNRgbNZX8Myj4qloXbjM9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=ybPh+anB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="ybPh+anB"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-550edba125bso3601014e87.3
        for <xenomai@lists.linux.dev>; Mon, 19 May 2025 21:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1747716644; x=1748321444; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTrA869gkmMdfwflZhHlx665ihGSmWpm3XBND6GmmTc=;
        b=ybPh+anBr/ea9gI6jl+T9a8JRlkwkNMyH+FHianxxp5QauW2p+UQlDks852Xwo7aBT
         q1124BD22xJTwOlEpNnjqLojRHH31wh2YCUG603I1UxyBiCfrKUtCrgbu2YiE/N99T7M
         aun/ghGVHsYhE2NaHKBjoUJDMXeoefBf52428=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747716644; x=1748321444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTrA869gkmMdfwflZhHlx665ihGSmWpm3XBND6GmmTc=;
        b=KpxcnrZgZl38jJ+JMR4IKDcIBdoqOmYvwdcSd9L+Do/RItPN8CCJBI13S1c53YPBt4
         q0A/iHK0n3FQ9MwmGh47kQkfmjbeUY2xcyPtJE+AeVYL0Gx46ZEYx1sI6JO9aHbluwmY
         0w1+Jtyo/cbQ5KQuxMTUc3NZr6ilq1h1IuOwFm/gElVl+ZctagV4VzWWiegdeFwZ7ySt
         Q6F0xxkhIwdFt7khKaPEZyjLtkUwbftUQYbmwk9XtLNOIO3v6Wq3OKi9HPLKVZcjfIc9
         1pg3WVyTz7WJ457t4nKlOWyYCBB+5YEXf66M91LZv+9zjY7+dir5xUhzpRAVyWvJiTkI
         ZA6w==
X-Gm-Message-State: AOJu0YzOmwAtdyQ5lj7npvFv50ELu64p77vlwSkB/6yOSvpKHWo3KkCx
	iOBW6FprIv/VoLsa7z4j4i/eWj1YdYTZeR/WF8sVKVXufpsuElK0ct13gHgdJB9j8A6Mh4iTwLx
	esNOPHX2k277AXZcEnra1JRMg5zeSdOSJyK+i7muvjA==
X-Gm-Gg: ASbGncsRIMvEMILFTF2TVSTExx+X0sGSOcFy+PjCpIyWJ/IcuwzlyHkvEhyeCJPadIS
	eDlDwq9m6pNkw7PdHJtb4AEdSMlLvXvPdYCK40ztcCVmLyrm6wdFuOMtSuqM5sL9ldyZnbRAiEK
	FvHcwWWRnH1kEmT6Q6TZDWSKwh/mzwAHkt
X-Google-Smtp-Source: AGHT+IGs2knAg+s1coqdFMryHCNlMU7vsKU70V3uXviR5AIGkhTusRke8T7gFZ2XmJypOx/qHbdEB4SAh1lmSB5+UNI=
X-Received: by 2002:a2e:ae0e:0:b0:30b:b7c3:ea71 with SMTP id
 38308e7fff4ca-3280773e671mr38986901fa.15.1747716643573; Mon, 19 May 2025
 21:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
In-Reply-To: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 20 May 2025 06:50:32 +0200
X-Gm-Features: AX0GCFvsN1lR2Fn9dZB4e-SxIQl4L_mnBzTrf9P_6WSoFetHsdjd09go3TU4PBE
Message-ID: <CAFc1U0vhiFvELw7Y0uxiASQspk2ZDkiA4G-1e_qDRZMVH3rf=w@mail.gmail.com>
Subject: Re: Xenomai Installation Inquiry
To: Tom <t93252352@gmail.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The footprint is very small: some additional libraries on the target
and an updated kernel.

PREEMPT_RT doesn't need libraries but not a great difference compared
with rootfs footprint.

Regards

Le lun. 19 mai 2025 =C3=A0 20:55, Tom <t93252352@gmail.com> a =C3=A9crit :
>
> Dear Xenomai Project Team,
>
> I am part of a research team currently evaluating Xenomai 3 for hard
> real-time control on our system. Could you please provide an estimate
> of the typical storage space required for installing Xenomai 3?
>
> Additionally, if the installation has a relatively large footprint,
> are there any recommended alternatives that offer comparable hard
> real-time capabilities but with a smaller storage requirement?
>
> Thank you for your time and assistance.
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
