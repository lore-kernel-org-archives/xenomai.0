Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B447B3A1B6
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797686; cv=none; b=VSD8rZ7wN0v/6eIG5sc6kYJ8wYRw7oGPiNZOYDUs8mBef9lD5mtqkGwKkd2Nn5qy11DR3bZIHVPdYPoaYW24YdIlKotBOXk6nF6LhP9zJfd83YuaR7CudXfHxudphNnXcEYveLLypmtJKefaj9/8Sut+HOe7RpO358w5MhVCGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797686; c=relaxed/simple;
	bh=0bKDbLv/2jfvw/hVXoy1+hw7Txr4zjQdu89JFCnyPB0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4j6fcQHC9LJuvbH0R8oQpGsj4f1rWkvPFVt7jalDlNXV8jJs7gmygUft3M8uFOSZNFOV9p5sPkIw0YUPM+i9R6j52fJKW7JReVtkhg9aNrynXNNRCzdz2gad+PU1dk5xWwiVAFvvTdVHi6LDH6X4N31gyw5BQjAKmBQQUm1ZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=tgk0YSey; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="tgk0YSey"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a61b70394c0so882319266b.1
        for <xenomai@lists.linux.dev>; Mon, 27 May 2024 01:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1716797681; x=1717402481; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYGfduoFznBVJmQPQN+WaBOUkVry6S4Yr78xGkvgWbw=;
        b=tgk0YSey/lzP6GGlkfmo1g5K8/8cQ+mZlwdBtKpx91nGw/xjlzvTagcGXEidODgqLt
         xEh5i/3kEoeUyUGuEN+KbqLLmxiC8C2g2exVSB1XKR2Aaws/gV1/2fxyi1RzPIzfagTS
         dW0iT7QoXuiEeOXq4Hl8cw/wmZzIzgTCotyf1LR025GlSOWucsXAyL9jaR8iFQJn4voX
         9gOEsZk/WnB1I1xU+nIblKYyZuBXc/7Fw0IUyjgDAKzvACbWWDisUynu7sCxuNruUJAF
         perAxDzL7ZKyASaZiB/+kgXJBtH4dYLsGW+NQiEV/uiGVcHtVrd/1Npc5W//mCsscx9t
         zDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797681; x=1717402481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYGfduoFznBVJmQPQN+WaBOUkVry6S4Yr78xGkvgWbw=;
        b=CqEGF6h9U64z67pWeORpM/8Bg/NcfMnz6aliK/Usp9euyxA4QxV7DatjoqDfAOFnWN
         p/T7TPTBtz9/2vlJBylr/kT+C/sNhChki+8n2OH+Me0wsj7NkfHohKSoyE3Tra7XDu04
         +42NVXFBCnOKZm4k8yexULKKXQ42LVkhV+t2/KE9u8QgGYYJ9uMfrmL8+qL9+D+q1b+R
         pXFXMUnXE8D4hLooOhFloMcfMv0RFV5Py8tQa7SeggV3mk3VTG7GrCa3qRYqPBvJRgBm
         /Y7h1l85i2XkJA0enkxEX8j8r7DxEESYMFR2s6ZwPyBm88DlKvT5lkmeJU5nZlvpG9k4
         YpmA==
X-Forwarded-Encrypted: i=1; AJvYcCUd+gheKBI5R4OsBKzvdusSzItqw1Q3C+Kh4aoVSXxRsnNJBTEeX6m+BJZGGXzc3OwJP+D9FCbRaPP08qYynlopjA7i/h/nzg==
X-Gm-Message-State: AOJu0YyIRna/jTFefsEK76RVkev6rqFdtRcjNU3VE+cqzAs8Y504t8ss
	UIly+sqGlHotcQXeocR+4XSeelyuEW2tI+TVltpg0N05R/n+uLiQ2zPP8UkICWY=
X-Google-Smtp-Source: AGHT+IEMvOgH7tWcEWkvPmxflof7u8Jqpspro9VR+ZWNQA2kjq0/juVyckH+arJuujblA1yFcUF0HQ==
X-Received: by 2002:a17:906:fe06:b0:a5c:d67a:e8ef with SMTP id a640c23a62f3a-a62642d49bdmr738815666b.31.1716797680841;
        Mon, 27 May 2024 01:14:40 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda54c9sm460395366b.202.2024.05.27.01.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:14:40 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev, upstream+xenomai@sigma-star.at, Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [PATCH 03/16] prepare-kernel.sh: Convert to tabs
Date: Mon, 27 May 2024 10:14:39 +0200
Message-ID: <2274162.2U7a3VyTpS@somecomputer>
In-Reply-To: <4236b09da042f9bfb766707a95dd60f229b69a51.camel@siemens.com>
References: <20240525115806.12101-1-richard@nod.at> <20240525115806.12101-4-richard@nod.at> <4236b09da042f9bfb766707a95dd60f229b69a51.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

=46lorian,

Am Montag, 27. Mai 2024, 09:19:44 CEST schrieb 'Florian Bezdeka' via upstre=
am:
> Hi Richard!
>=20
> On Sat, 2024-05-25 at 13:57 +0200, Richard Weinberger wrote:
> >  patch_reverse() {
> > -    file=3D"$1"
> > -    if test "x$output_patch" =3D "x"; then
> > -        if test -L "$linux_tree/$file" ; then
> > -            rm "$linux_tree/$file"
> > -        fi
> > -        mv "$linux_tree/$file.orig" "$linux_tree/$file"
> > -    fi
> > +	file=3D"$1"
> > +	if test "x$output_patch" =3D "x"; then
> > +		if test -L "$linux_tree/$file" ; then
> > +			rm "$linux_tree/$file"
> > +		fi
> > +		mv "$linux_tree/$file.orig" "$linux_tree/$file"
> > +	fi
> >  }
> > =20
>=20
> This part is introduced in patch 1 and completely rewritten in this
> patch (patch 3).
>=20
> We could avoid that by applying patch 3 fist, so basically reordering
> the patches so that patch 3 becomes the first one. Could help if
> someone has to bisect later...

How does it hurt bisecing beside of adding an extra step?
But sure, I can reorder.
So, I assume you're fine with tabs? :-)

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


