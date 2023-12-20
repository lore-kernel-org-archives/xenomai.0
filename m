Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEF40BE2
	for <xenomai@lists.linux.dev>; Wed, 20 Dec 2023 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDiJLdqu"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dbaf9b1674so127377a34.2
        for <xenomai@lists.linux.dev>; Wed, 20 Dec 2023 02:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703066955; x=1703671755; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAocmkbxm2FroGDumXWx+s+4VEZE3vtA1A1ldBysq8M=;
        b=VDiJLdqugFYeXPIKUw9Ibr0mMZs0CF/2HpmNcz8KCRo4MSXBvWtq4G/Sq5Mb5Tq5by
         bm+MgoLiuGhF9cPHagr2vHRYfdJEWfLcoyXORnMF1sxcmY9lqFO8squcBnQ4PUNEeL4f
         bdMJbkKUoaNAvwjwkbxMwKuoZHoAffF/qOaBhFSSt3TVzFMWrjQXZ/hTzDqwt+5raxOp
         460kaJfh3r2wke0saLcDZWc6pH2BFmOfLCZzDKPq+BkTRDKvzk2VKC35e2hEuzuPH9Fd
         o3VNjlna0rEMBRlBrPuufpoVgrzzkkqWHM43M9KfGq6mCmDur92CKGxzlMrdo7pCsXmR
         W7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066955; x=1703671755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAocmkbxm2FroGDumXWx+s+4VEZE3vtA1A1ldBysq8M=;
        b=RSWEKTNxKtMHPP7t4B8sSmA7hJOIhd/49TjtnKBH7KLW2WI93fN5vAWkgMSLvKZa+m
         XC6BYVs+/5E+jNTehriAAYW9sB3j4NAGTXA2po3tn0ojCXxLtXZp+MusJsQEKZpJQhEE
         XX2Xef765nwMZTjd/qUdvem4eFcXVz7CGbNhD5JLTl0Xa4OEjk6EGID3AZz1OiW2RvAh
         VWotCkRkPHmbtedZBIa1UPPwLlixBal2Ym0I06m3VlAdsFmUfAPhh+MSY63wAjohM0tE
         qB62YmhKH3Jjgg4l1Eat2XIoDhTFKYZOPt7qt19E4i46kWog8TKmbe6drpIPIEglY61F
         nQtw==
X-Gm-Message-State: AOJu0YwGP9PcBbgIZ8CwWW8xa0rsiZmvCLLh0t1BGBR/EipJ0sHmBPb6
	UAqY0hMi3YIwPuHU/zPlfWFfGNXmtfRDLMkif6Q=
X-Google-Smtp-Source: AGHT+IHFmreQECyv6gT3MpA5k3Ce+IKdTVjDKgbDfSTU4U7I41JAvMT2eHp9oFQ/4yxVXKR3fmaqZRo/vTrACSRvf0g=
X-Received: by 2002:a05:6358:71c5:b0:174:7b93:7921 with SMTP id
 u5-20020a05635871c500b001747b937921mr6714rwu.46.1703066954525; Wed, 20 Dec
 2023 02:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH0t8y2Y6OP0g1c6duLKK6GnEjd2AYtsBfGJp_GKUprz+-kz7Q@mail.gmail.com>
 <e7624208-3436-44ce-b46e-eeb8e73d9f27@siemens.com> <398875541.48372669.1702980839753.JavaMail.zimbra@telenet.be>
 <CAH0t8y0Ck3A9A311Qy9qEXaXNFK3fmVrjycDQOB7tTyB_k_q9Q@mail.gmail.com>
In-Reply-To: <CAH0t8y0Ck3A9A311Qy9qEXaXNFK3fmVrjycDQOB7tTyB_k_q9Q@mail.gmail.com>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Wed, 20 Dec 2023 11:09:03 +0100
Message-ID: <CAH0t8y3nsRRNRmtP_YqKH1Vh7EiE==ruZTOrE1vJfmaDj+_OmA@mail.gmail.com>
Subject: Re: rt_e1000e and Intel i219
To: g.strobbe@telenet.be
Cc: xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gino,

In the meantime I realized that I need to apply the pathes to the
xenomai master tree.

Best Regards,
Tamas

Tam=C3=A1s Pa=C3=A1l <paal.tam@gmail.com> ezt =C3=ADrta (id=C5=91pont: 2023=
. dec. 20., Sze, 10:00):
>
> Hi Gino,
>
> Thank you very much!
> Just for sure. I should apply these patches on the Linux kernel source
> tree, and the result is the xenomai driver source, that I need to copy
> into the xenomai master source directory, by overwriting the files
> already there. Am I right?
> Does the v6.4-dovetail-rebase Linux source tree that I should choose
> as a starting point?
>
> Best Regards,
> Tamas
>
>
>
> <g.strobbe@telenet.be> ezt =C3=ADrta (id=C5=91pont: 2023. dec. 19., K, 11=
:14):
> >
> > Hi Tamas,
> >
> > Please find attached the latest version of those patches.
> > They were created against the v6.4-rc5 kernel.
> >
> > Best Regards,
> > Gino
> >
> > ----- On Dec 18, 2023, at 5:49 PM, Jan Kiszka jan.kiszka@siemens.com wr=
ote:
> >
> > > On 18.12.23 13:33, Tam=C3=A1s Pa=C3=A1l wrote:
> > >> Dear All,
> > >>
> > >> The current version of the rt_e1000e driver does not support any Int=
el
> > >> i219 network device. I found a mailing about this from 2019. This on=
e:
> > >>
> > >> https://www.mail-archive.com/xenomai@xenomai.org/msg16000.html
> > >>
> > >> The "unofficial" patches (created by Gino Strobbe), that upgrades th=
e
> > >> rt_e1000e driver should be there as attachement, but I could not
> > >> download it. Probably when the mailing list had been moved to the
> > >> archive server, something happened with those attachements.
> > >>
> > >> Does anybody has those patches? If yes, could you please them send m=
e.
> > >>
> > >
> > > I'm afraid, those are lost in the unfortunate settings of the old
> > > mailing list.
> > >
> > > But given their age and the source kernel, it would be better to resy=
nc
> > > the driver against a recent version anyway.
> > >
> > > Jan
> > >
> > > --
> > > Siemens AG, Technology
> > > Linux Expert Center
