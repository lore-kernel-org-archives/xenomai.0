Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D751DFD9
	for <xenomai@lists.linux.dev>; Mon, 12 Feb 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750883; cv=none; b=VYwUUNGdGPuddz/Oh2FLs/mFCW1Pu3MuEMQ+l7ftXIlo99CKsJyvw7/6xGngfcOZ8E3QgrvJLoqJhbQ08wukEHsWFyoPYH8CCVXD33HrwRnKk2wvPjPd+HYcmT6yGbsBEwKSsz1qgNvh0D0J/mzP3/k6GUeAsCKQ1YHIcuxwFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750883; c=relaxed/simple;
	bh=FutsoXM7BwSVlnj6YPNEHmH1RluGNLJJ2fe9zaj/8bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwbx0tX5Qf5Y8ox2eeSglPQ4uhFEqvx1W7BqS4EvXWUltXQmXJkl+GZMGGAGM7Sf3bB0fG+Pp9VbBG4W6DlJrVTB5gbJ68QsghjcmpJTwmdrmsRjNICV9BwDOU1cE8O7YSxkkgHsfO4MVznZ/Zg7cPxk0uecCAmA8sD2tt/QUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG8tEP95; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG8tEP95"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dc20645871so1862702a12.1
        for <xenomai@lists.linux.dev>; Mon, 12 Feb 2024 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707750881; x=1708355681; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FutsoXM7BwSVlnj6YPNEHmH1RluGNLJJ2fe9zaj/8bU=;
        b=fG8tEP95Bz9cjqXvrWjblCSbVqxccFU95k7p5pfp724LKm3gVvIpK8ZaTPr6cXkY1p
         vbP3dKek94BA8wZDSiCxuLEzwYDBoEkthDDrQHqEgPqBqEiiRBGt7cxIvHnlh+OyQBJD
         3JAhEB7dNyFz5Ks54BEuF/0XxdG0ofXyRhngmZnV4TufsV3DMlmYobZGxnQ75QNr7ss1
         JMnyk4u5r/l/Cs6Fef/nI7WCjx6SBReBXol9KCKecfPJMv0Pzq7DHa6icIUsFtM2w5wv
         KQvwFo0ilrOb6/o0vYxw6XUMBZN+QPl6Qu4bJCPWLyzeeYYuowUi+u71nRx/607+7ts5
         zeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750881; x=1708355681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FutsoXM7BwSVlnj6YPNEHmH1RluGNLJJ2fe9zaj/8bU=;
        b=vy2+i4AP2Tz//fVP/Tqgxbxixv55hEFGzI57v5/bnQEKhvatAhOE4bEuq3oE/gLXbi
         Tl6fg+xMa7jH1oOJn09G1zT0/hX5qD5DUWhPeV89Y+j+tN5IdKhhjeg/4szj8UHmpYKt
         aC23enZCI6cp/rXxkwh8voSiqC4nS6Ab0z2xoBttU5La/y96g4VOq3TvpA+DJZRKGlHU
         F+FqA1cJL02Sdgpny40H98Ec1WRuZ9s7AJqTZGVZMlQIt2r3JHQ1VmbVU90pzPVDsbDJ
         bmAFdteF4Xyks3An1hFTRKwVuh76LFhEk5xjZpcCDcmO/L/K5b1L+9C1kqJ4lHnFcsn0
         pBpA==
X-Gm-Message-State: AOJu0Yz2YJajEscgaEGfOMQZXwdap+/en2afVZi7TceHPgfWv62TYQEX
	9ZUr6WuoJ6nWwESMhd3o9Rytl6qTcMEE66EtciuwoCQsoTu/Jp7UXY0ysxfkVv6TrwfMAF983fG
	zAn+S9Ypi92nq2bCJ/VDBE1ahDMw=
X-Google-Smtp-Source: AGHT+IFhn7LZLeWdurpY8sYUwykfp6vqYA1ug1kSEE0K3SZsH4tUjdNslFD4NIIkDLAR5ttLlraHokzNAECLMpO+pFQ=
X-Received: by 2002:a17:90a:8c8:b0:296:72ff:4662 with SMTP id
 8-20020a17090a08c800b0029672ff4662mr9587119pjn.15.1707750881350; Mon, 12 Feb
 2024 07:14:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <VE1PR08MB490963A18B8D61A5AF0B7AFA923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <874jv7rxb2.fsf@xenomai.org> <5809272.1B3tZ46Xf9@somecomputer> <3ca2aaf3-f47e-4fbf-8d46-b5da9542bc3c@siemens.com>
In-Reply-To: <3ca2aaf3-f47e-4fbf-8d46-b5da9542bc3c@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 12 Feb 2024 16:14:28 +0100
Message-ID: <CAFLxGvytJP_ibg0ex4zgyahaxNJH2b_M=Nu3ZBWtrm9neRoW9w@mail.gmail.com>
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@sigma-star.at>, Philippe Gerum <rpm@xenomai.org>, 
	Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 4:12=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> >> Ok, so since the idea is generally agreed, I'll push the x86 and arm
> >> support for this in a couple of days.
> >
> > Currently, I'm looking into implementing Johannes's RT-Signals for ARM6=
4,
> > but from what I see on the dovetail side, only x86 has gained support t=
o declare traps handled.
> >
> > At least on x86, I see that a trap is considered handled if no switch t=
o in-band has occurred.
> > Did I miss something?
>
> Yes, I do have some first hacks here as well. ARM and ARM64 is not yet
> ready for this, unfortunately.

Can you please share your hacks?
What is missing? I'll happily continue your work.

--=20
Thanks,
//richard
