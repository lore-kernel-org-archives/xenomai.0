Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F254A05
	for <xenomai@lists.linux.dev>; Sun, 30 Mar 2025 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743333934; cv=none; b=NuChiOlniw2Iuv3IXWajHB780D0A2NwK5Qm6mvoCHP/mNDHybB4AUqz4sE9S9zR9ChhvQvxnVhq41NN7hunKsr1FuhxufR9d0Os1+VOTLdr9nkHg56wIIEdVkmZTevoW+jneIzMEJlF3jkrOoRN8dJoXr4+/jZ04LOnJ8xjt5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743333934; c=relaxed/simple;
	bh=/e6opWPF+D6QDMyjwHeQFAP0aNf8OcDJXQ1otQb0pqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FI7zwYF3+NwSyTurMCDYO6k5aXLpNxst1gJvA82aA5Y3K3Le+HPAKS5FuI2u/zWc7+2w7vBY66Ud1EcfnO4fdKHuVWX/XlfDhmOl9VyIas5d4UXfhQkWqLJNtS94GUkfDOo04DyvX9N9IlZRkQYEyapByOXWpov8C5mxDR5+6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=IfUPcS4P; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="IfUPcS4P"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54af20849adso3498506e87.1
        for <xenomai@lists.linux.dev>; Sun, 30 Mar 2025 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1743333928; x=1743938728; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA2YceDy6QBTVox9aHu3jf01vSuvQBWc1NfJ19/1P1U=;
        b=IfUPcS4P5E/wXZciXIgWv0AYl+8bm3YLLS/0yZKcSacmJlEMuXpTKvGg0wV9BzMLLK
         IYfQUVKe5P5vjvQtHDMKe5hnJhvTw9zPhPNIfZY3ODHPhpl83rcnLGmLlTWeX3skyWbi
         J1SkTspti3X2I60csKoQi2xQrmjlbc5YHd6+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743333928; x=1743938728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA2YceDy6QBTVox9aHu3jf01vSuvQBWc1NfJ19/1P1U=;
        b=tRErKZntPxM+rYGI6OwQmMZ35sdDHBS4BBcEWXYWP3GEB3FEJHYyaU1jCv7DCrGG2P
         IlVDtiHCCssik3hV5g7Ect7JrfBD1jl/UW/T7Ul4ru2JhTIY989vqmsLJ4Ws7TkIGwaD
         f3pwd/enb1DkGxhI4CSdp1Q0xK2jaM9rc/e9eb5srxnKuRVpqi9mQXw0raznJ8HTAZgR
         8cpLvKoai/8cJUQ9hkdkrnQd2wPH8AALjD07Cjl2FaKgDQTBCnfXjdLvtLICHKzo1ArH
         hhZBnpS7k0+9qscnGlE94zu/9Uet+556HLrQTfpmYueAxjOQT7OLgH90XCm212N3yEZV
         eEiA==
X-Gm-Message-State: AOJu0Yw5/453ACaz6hgxMCaDA99bprJx1m189c4t6dUWKtghAwI6jZq1
	h5LR40lbjdiz1D2Bm3OenB713D6LU1i3gRhhT3SpR3lm5r+SGZfIJrqyV5MqFXxdQ0RkcbsH153
	3o1gD6Nj+mEInlyBqz4k1/TW4XT420qeuWNBzzQ==
X-Gm-Gg: ASbGnctPGM+ERPsJYZ+LOpJlXKEnBkpuGoObNa2rmp/Jc4GRyNE0n1pHiL+xYT+xH+Q
	q4MAdpGuk6540wGmi6V9KqS8uweHSsBmDA1GfIU+FXbDg9c16IaysNbLyO38aNFgj3li3gbKZbH
	gASuCBNvOmjR63ww/k+DZtqXlJSXUZgxz6mhca9l7lTnbnQkKdc9MANOiLkA==
X-Google-Smtp-Source: AGHT+IHDbxDuKaWVbeGa+fcrHgJ7514sjp7WE1EzTuJkWoYPX0RLCH2dXGtLJ8s3P+/zdy8/Wbf7ZjFDffA9piT3FjE=
X-Received: by 2002:a05:6512:618f:b0:549:8d2f:86dd with SMTP id
 2adb3069b0e04-54b0acd156dmr3388121e87.20.1743333928438; Sun, 30 Mar 2025
 04:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0scz6GaCTgaoXFzq_KEtNw-GAeJNbQnMR5qeSw2Y0fOHg@mail.gmail.com>
 <5bbb0060-6d26-4b3a-9022-fea5b73c1a26@web.de>
In-Reply-To: <5bbb0060-6d26-4b3a-9022-fea5b73c1a26@web.de>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Sun, 30 Mar 2025 13:25:14 +0200
X-Gm-Features: AQ5f1JpPhHUFOqGLZoMRyQKbThRYqOLcehx15GxOoMiHbL_LlaigitFepDdobVY
Message-ID: <CAFc1U0sZrzQy9Rf4VJYJtOVE4P5h0GN7peSbQ56nXkipmbPnCw@mail.gmail.com>
Subject: Re: Building SDK in xenomai-images
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK I will do it, thx.

So after applying the patch I can do "bitbake -c populate_sdk demo-image" ?

Le dim. 30 mars 2025 =C3=A0 10:17, Jan Kiszka <jan.kiszka@web.de> a =C3=A9c=
rit :
>
> On 30.03.25 09:20, Pierre FICHEUX wrote:
> > Hi,
> >
> > Is there a way to build a SDK for the target selected in
> > xenomai-images? Such as the following command in Yocto :
> >
> > $ bitbake -c populate_sdk <image-recipe>
> >
>
> Not tested yet, but something like this will likely be needed:
>
> diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.con=
f
> index d1b24b7..a113a54 100644
> --- a/conf/distro/xenomai-demo.conf
> +++ b/conf/distro/xenomai-demo.conf
> @@ -23,6 +23,9 @@ PREFERRED_VERSION_libevl ?=3D "4%"
>
>  KERNEL_NAME =3D "xenomai-${XENOMAI_MAJOR_VERSION}"
>
> +SDK_INSTALL +=3D "linux-headers-${KERNEL_NAME}"
> +SDK_INSTALL +=3D "${@'libevl' if d.getVar('XENOMAI_MAJOR_VERSION') =3D=
=3D '4' else 'libxenomai-dev'}"
> +
>  WKS_FILE =3D "${MACHINE}.wks"
>
>  USERS +=3D "root"
>
>
> Jan



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
