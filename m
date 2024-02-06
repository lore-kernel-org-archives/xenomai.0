Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA212DD86
	for <xenomai@lists.linux.dev>; Tue,  6 Feb 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214347; cv=none; b=ABW4crcvpMwsBKdjIm2erwYlhplQRRBT8WJyBPHE564TBJB086vFex7B4PW+3D7oAgU6rwmAOvPtbr/249JzaVBlVmdGr7wprYLMlKW5n9JNUK4077jdpWG6FCDVGeah4YJk6fFqGv2E7NZUyXeWqiq5JK5NZlBASm5h2b6x0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214347; c=relaxed/simple;
	bh=QrszGnShn8f3MuXjCuaDxuRCDJ5XKLSGdJBkOk8MFDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUb617uBZwGnFs79gsdcAKUCuSOanUuT0hNxyZ71VhJSim465flN9cTDFkVno2ZCdNsH2O76pFBXu4rBZF614H0OlSUV4s5IDLiu5uVpF1Fpf4kiqCXPYtv2yc2e9d2UMitConud3UZT8sh2qCjeYsdka+i/OrsZzw08Feh2Ok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLUB3kcE; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLUB3kcE"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-295f9a4a656so4447537a91.1
        for <xenomai@lists.linux.dev>; Tue, 06 Feb 2024 02:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707214345; x=1707819145; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB+tskAO+480tjE/dJleaEmCcQMKtQDOmiJhaWnUc6M=;
        b=HLUB3kcEGnYd+E5uR70o9ykDJc/7lCbpXjRm6FxjqyafxEcEh9Tj+T1rAXDHVT6s0P
         O6vHP05dvslz3QH4ouusDd2mvgENxgdSkAvfKPKVp3eMGd3v858EuXj9tILxo7Gpzf3Y
         jSTBBKimzXJZeEQPIbNGRvVklDJo4yIyODN/K4McIWNhnTR6XriO5p2mYYcoKI45sL+C
         7MzYxbQ//L67phJmByptAif8577+IDMBonsAymzon5hqEq72VnONovOq/le7xtPhyrj8
         ADZfJ03EdsvmPF3aCR+2O4XHpocHDwvw7CL6+CAZ04LGYcu2ArF4nfROJ97ZUZKyYKX3
         yoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214345; x=1707819145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wB+tskAO+480tjE/dJleaEmCcQMKtQDOmiJhaWnUc6M=;
        b=em+NIJd0DQPbnELdPqHF6VYx3WQW1hswb5bs91GHpmppQKd5V/LUIWDyhkoILEk4kN
         xwjH2RSRl52Am11OR9rAJivudnz1vIWUInKYxJE+L1WTfWIREqIS9pfSdutv3LT+TOH/
         eZ/5riH7htR448P+v/G771UyTCZbYVF40pefb88FBrRNKN9tJGjXbsD+r4Sup4nlfjDI
         94vltL9E9VNAKpVBYDDulmGSDfA9Dv+j5b20ST1GJjpaypqlH+KjVGgN7GGXLx6rGQdL
         Ltt31EyTm+cQsM7HfwlNsWoHDKRKl/PGQyAHKFQmZzwDMpBNYJiNPU0HE1IDtmMdI9Uo
         Vgvg==
X-Gm-Message-State: AOJu0Yw49qF/i6E1rEza5hnDxT43+1cszT465GB5CqlIAXlGmNH+sypn
	1CG15zrbfu6DZWM/qR2iuE3OuEB0OJwxmVdWQhHN8oGIH3PT/qlvs7bBKwKC4a633SpJ3ToexL/
	JG9ICfzjQPBHQiPzErelUvQQsay8=
X-Google-Smtp-Source: AGHT+IE6eJ2+I9mcuWtQxl9ut3AfqpjljzhOjk30vnvTFbDIKCUTmscEs6xN2WRJRpr0963EHliRQp0o5qEzuzuL8Qg=
X-Received: by 2002:a17:90a:c7d6:b0:290:69e2:de18 with SMTP id
 gf22-20020a17090ac7d600b0029069e2de18mr1721884pjb.41.1707214344888; Tue, 06
 Feb 2024 02:12:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALB5Fwj5g-feayCXagd+rYhq2Wkwu0cgixZssDJs5A_WAmNuQQ@mail.gmail.com>
 <CAFLxGvw--ieUV9v6WKLyvwBKntmcSbt+3jZV-cdhbX_VB73_hw@mail.gmail.com>
 <b52d3a17-15b4-45d1-beb9-538f316010ed@siemens.com> <CA+Eki_FWb-KhKYh=8yAN326VtW8-4Wy3jVFpUBekJ5Y2yEE-eg@mail.gmail.com>
In-Reply-To: <CA+Eki_FWb-KhKYh=8yAN326VtW8-4Wy3jVFpUBekJ5Y2yEE-eg@mail.gmail.com>
From: Gheorghe Chirica <georgechirica92@gmail.com>
Date: Tue, 6 Feb 2024 11:12:13 +0100
Message-ID: <CA+Eki_GGBUgrX-x62UOjMb664tGuc3ahP2hgtf4eOyhghCXFVg@mail.gmail.com>
Subject: Re: Xenomai 3 setup for BeagleBone Black
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Mit Jothiravi <mit@mytra.ai>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mit,
    You should bootstrap the install first.
     Try these steps:

sudo apt-get install autoconf autogen libtool
cd xenomai-v3.x.x
./scripts/bootstrap
./configure --enable-smp
make install

reference: https://v3.xenomai.org/installation/

George


On Tue, Feb 6, 2024 at 11:07=E2=80=AFAM Gheorghe Chirica
<georgechirica92@gmail.com> wrote:
>
> Hi Mit,
>     You should bootstrap the install first.
>      Try these steps:
>
> sudo apt-get install autoconf autogen libtool
> cd xenomai-v3.x.x
> ./scripts/bootstrap
> ./configure --enable-smp
> make install
>
> reference: https://v3.xenomai.org/installation/
>
> George
>
> On Tue, Feb 6, 2024 at 9:57=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
>>
>> On 06.02.24 08:25, Richard Weinberger wrote:
>> > On Tue, Feb 6, 2024 at 12:25=E2=80=AFAM Mit Jothiravi <mit@mytra.ai> w=
rote:
>> >> I would like to run the `configure` script to specify the single-core
>> >> processor using the following command: `./configure --enable-smp`, bu=
t
>> >> the script does not exist in the Xenomai 3.1.x stable branch:
>> >> https://source.denx.de/Xenomai/xenomai/-/tree/stable/v3.1.x?ref_type=
=3Dheads.
>> >
>> > You need to generate the configure file first.
>> > e.g. autoreconf -sif
>> >
>>
>> FWIW, there is a pre-integration in xenomai-images for that board in
>> case a cross-check is needed.
>>
>> >> In addition, the self-contained source tarballs outlined in the READM=
E
>> >> -> http://xenomai.org/downloads/xenomai/, returns a 404 Page Not Foun=
d
>> >> error.
>> >
>> > I fear the new website causes irritations.
>> > Jan?
>>
>> Yeah, someone needs to update the README, aligning it to the website. We
>> have stopped providing a static download area and fully rely on gitlab
>> for that now.
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Linux Expert Center
>>
>>
