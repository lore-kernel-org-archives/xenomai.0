Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3A2F49EC
	for <xenomai@lists.linux.dev>; Fri, 14 Nov 2025 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103565; cv=none; b=IxlSUrjcleFcu91EOxlDIQMlHBTmtnw843kFavAR6a4Wk934SLWTjGh+8qUyjGpadX45/t0L8IuhYQOGrcmK/ow84Y9EAUw4+zubSvEqUcQ5QTPXL9GgRdo7gphIiEx1i3L40mR0maZ1JuTT1lpzVc0OgBDjvwz+DG8Oe3r/lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103565; c=relaxed/simple;
	bh=fyb7gBB0bBtTz7L8Uq3swVrAPbmRp2RnAthliEDRtDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngogmr2vyaBcQ/NHwdOkU5o3Cc94KyxJiPSUcRmyQWghqRvbJ3D1P3n4DGrLGivmvjNod3NzaekDVOMqgJGNbxjlVdmnYpm6nJKN7BcHDqS90yvQzdxo/nHnUUKg12fIjvt8nyF1LpBqx5PCaHNEz/mAu8s77wkFp9f64kgnHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=lLUV2HXn; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="lLUV2HXn"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37b95f87d4eso14238841fa.1
        for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 22:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1763103562; x=1763708362; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EaBaPbBuugJ+ASPzwEbL7lWIAJFrGPYDBgwGx/D+SY=;
        b=lLUV2HXn/t1rDwsCUBAtEztL4dW0XhIlwhzfsUDruqKp6U+kjMhpWRA0d66hUnDMA8
         5bv+hYN4a/krYAfTsBgOPq88idp9S2VfjjVLa3q6rF9M8joNPoVbJQwFBL/WH4uX4xFn
         J6u6YblDPf0hG2LU5yG4vPjH8ullcluboIvu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763103562; x=1763708362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2EaBaPbBuugJ+ASPzwEbL7lWIAJFrGPYDBgwGx/D+SY=;
        b=IcPSOj73DrPBoHgdVhBPO01Y+nhppMl5PyFj6FzCIr4jbVOat+0FC6/9SOD+xs+VKq
         /dIDz95WiqIHkYZ4bKKtdoCc7b2nBWwbQIozBcYWDMtso/vFpoRCA1Hgu2pMYqXFzHYv
         z+cMfQJdTFmBZZU/o3f7J9dTyRAigcqjwwAydIMnSNhlV26hw6g2Ce+128rnleEgH9O7
         xQpkflG2+FTqh3dlEmxFuLSXaYPuATS994EUAocdljEQuY2emqTdi5u+9sWVRSD2yDsh
         1a+tWnnUxAEt7UcAcXD4qPVBiUVcGQzvDB3kf5Op5cgE3s1zPi+RQoQMzjVJEmJPtXW7
         ToxQ==
X-Gm-Message-State: AOJu0YzfKeq4khtO4MNb0rqswF4TN4n/QfgsUkLFGvkprsNuQxxerhxE
	29vNY/+dWtqZ3GateluvcebF8vExbDO6J7Qe9pk0FS4Y/m4vVF27xUatgsViWdWnCmgfzNhq92X
	JacKPIzJYNE3p8RCWGFhtod6IjSLMtaXnrm4nXwVO3ze6XAGgobz/cxg=
X-Gm-Gg: ASbGncuJh5NgId/vQ7q6Ezlz7XWqRlEv3KqOeCL+RpFVo0aAlSN7dP+GXs2vVlGnBHV
	35mpoy5yufSQgOdH9F14rLbsNUYvCWVzZZPITqJLnHWMZTFhvoEv7TUCoA+/Wn8dfNCvqb0dlOy
	eJTIFmdmBA365s7gzyeZEGJRsdIZOFoToIlF00EYeikOSLNsGeNpBvPSw8cuwGEEyLzi4gfL1B+
	Qdg7X+fQ9gponFaUoff+g2NEt/+KlbIX2hcnTughrT8QwEwYoM2VyiZL2pTM8V9O7TxkxdLk1RB
	Xm4D0Z1CbKUUJQ34Pmh5W8K8kf8FDM2cXiiTxPFUrCwAr68ZSh4PpiCQvb7wKkPtlXl9b/B0KbE
	+ZVFH5i9ouJ2lxJ0BZu2DYLfkUzw=
X-Google-Smtp-Source: AGHT+IF9J3XWVOJGn+6QX8Z6gy/cRI+GE4CUyRXVcbuwhRb8+hFOrXwrMGKX7f+LH07V8QdYCXWrMbIw+L0pR5iSw34=
X-Received: by 2002:a2e:a00a:0:b0:372:9bf0:aed6 with SMTP id
 38308e7fff4ca-37babd5c9b5mr3197891fa.25.1763103561582; Thu, 13 Nov 2025
 22:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0vT7a_qcGQwfuFUibL+eSv8uktTFNAz+uQB+UO0HkvKrQ@mail.gmail.com>
 <79e2290f-5e86-43c4-9acf-c658a12f7944@siemens.com>
In-Reply-To: <79e2290f-5e86-43c4-9acf-c658a12f7944@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 14 Nov 2025 07:59:10 +0100
X-Gm-Features: AWmQ_blskHhyFIOzdpej6DXuM5XTe9p47Bu-3jI1FjlsIIPkDvcH7kUjCL7JU3Q
Message-ID: <CAFc1U0sDC7T5RY-o0-xZ3joaSE6nX2Vgc8rC7yVfjB3UB9hcQw@mail.gmail.com>
Subject: Re: DENX is shutting down
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes I know, but I've just read a message from Karim Yaghmour on
LinkedIn (about DENX and Nabla).

https://www.linkedin.com/posts/karimyaghmour_goodbye-activity-7394939523467=
694080-C6mn?utm_source=3Dshare&utm_medium=3Dmember_desktop&rcm=3DACoAAAAiSq=
oB5NnhF8ZwyNzorwlaNsy_kbgZdl4

regards

Le ven. 14 nov. 2025 =C3=A0 07:55, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 14.11.25 07:46, Pierre FICHEUX wrote:
> > Hi,
> >
> > I think you're aware of this, but just in case:
> >
> > https://www.denx.de/
> >
> >
>
> Yes, that's why we are on gitlab.com since August.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
