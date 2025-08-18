Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9131770E
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508560; cv=none; b=o+gnyZPp/iTNqawlY/NObpwoPBAxRu3Z2Rdj+BfUGhrY+Od9y6BlD6oCrndHRYRC0fu8SfwWBaUZttttPwTYO394k1sK6CzqezsiUfXgrLlicDCI7f7U75i4l/Jngj0cLI8ykehcTHbW4sqYyhw8i40W5y724w8HweN4RXYDVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508560; c=relaxed/simple;
	bh=CdgXB7ML6typqWSkBxR3J7c5bYT/o4rjCpSXvuTia78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WqTrQzoYQyyuQTMFnStnvrJq/q3EzokePK+02tNjTc5TK7AE928wkRWIwVAQtvac69fsJ0m0VGswzoPU54IMetsR41lhpnX7Ikd7JQvcZvCniSlbMBla+P5TenMz2U/9xFtDrtJOqklD62BwyFtu8ywZ3otTH8sdBwdJEvW5sjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiLeLRll; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiLeLRll"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32326de9f4eso3341167a91.2
        for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755508558; x=1756113358; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4ziByO/Aa8PWC3E0g8/ni7hf87n41vkTnzxIo7fSaU=;
        b=OiLeLRllqApvmru2IoCwTmTMD2i6EWKNvaxXh5bCQ/PcCGA3eKUUO2eiwx4/C07ZLo
         MnWrx6xz2nH6N2MTta4kkj/oqJlSNtt+SOD36NoAq9d+nxxDVV9EW+DF254zwqr4ulU+
         isYJKvETWFwkH4lHPMpHPrOXealjpvv+ULsSQTar9kY1YpMXw74SW5eg6MpWRJO7kLy+
         PnNIE021xi2l5aHdoEXWiabN4dgxTCThmvROWi9Zq24ii+nlJyPwRBaI9M35Qkpz9ztT
         dsdlQ7uffXO6+sNy4ey0LwAq9OkQWDb1fIPldi9lMwz5SC4/WdjxRqcMivF2mVbKi47n
         dYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508558; x=1756113358;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4ziByO/Aa8PWC3E0g8/ni7hf87n41vkTnzxIo7fSaU=;
        b=okjw9HNkhVmUFUDGmqSyFogkX0os1Qn/VNhr1Vwi/Y33EIXji9RzKZ6C6IPlELbM/s
         UGYD3hFCsyOP8huDuxJ9zzQ+72fA+HOXJgvZV/aSZMTIEV1bQ1sEjHhXsghCrHIqPH7O
         E6aBdIf4fpgieb+BxuxtUk/0hJmNGUIiyPTX62my3lX9VduyUeXqb8ZKsEu35pzgcCCx
         UtA1tjb982id29DoweQF3S4R+icNf3u+35y7NbEM/WuKTWXdjrqehHJgmubUzbVpC0Ee
         ybaAs5tglIySMY7SWtQJKs44Qi8PqJLg15UNWuFxenK5g+ciLRr1bs+DwYMUQj+TkgRl
         kX/g==
X-Gm-Message-State: AOJu0YxVAkPrs1MHECBAtko9duu+XhKNxOx10cHven4zFDQmAQvw5PEt
	ebY0Lsz9cFe1W98AeNUkv3wMJ+dQNDfzUMkLwBwAntQhovx4HzqOoZ4M86zigZnloRCuay+W0FF
	PLP3iUwPyWKIRXswek5oFCUCYYDcRvM36sbik
X-Gm-Gg: ASbGncvFwXM4SzbIiL988oq0cGaILFhjSVs3jx1IAJ7pjMwdPgIUSn5k5tJ/C8+VFou
	5HBkr6cSs4Q2hEOBZEPIn2QsC9nvLdgZDq7zDsxhBUmbKP2i9YT8GrFxi1Z2bt/V48IhR9E5s3A
	V74yfJaMlCtHFT/wvCX0Ekg+BMLAZIHuq212AXHNI2ljHnGu6MO4r23ayO56//55pM7Erz0umm5
	NX9Vw==
X-Google-Smtp-Source: AGHT+IE/GodTVmBuFWxDnCdw1QNhHrp64eFQaRZ3Pr85/hb25eWl6MmrlZ3IFpUoASilwWBEP8qy6Aq0fnJYY7Zx8Iw=
X-Received: by 2002:a17:90b:2d4e:b0:311:df4b:4b7a with SMTP id
 98e67ed59e1d1-3234223b9c1mr15152469a91.29.1755508558319; Mon, 18 Aug 2025
 02:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
In-Reply-To: <CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 18 Aug 2025 11:15:46 +0200
X-Gm-Features: Ac12FXxn2IsRJ9GzgDWk2Gnr67XNdjpPUwJ2ImJkFiZRNkN71y-kMlXp2cBJ_Wk
Message-ID: <CAFLxGvyLoamDw-u64ahzU9OPrOMuCqLFOdvFNpPeSsOx0ZWKPA@mail.gmail.com>
Subject: Re: Xenomai Meetup at OSS Amsterdam in August
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:55=E2=80=AFPM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> Like last year, I expect that some members of the Xenomai community
> will be attending
> the upcoming Open Source Summit in Amsterdam. If there's enough interest,
> we could arrange an in-person community meeting at a local beer
> garden?

Finding a place was more work than expected.
But here it is:
When: to start at 19:00 after the booth crawl
Where:  d'Overkant (Scheldestraat 101-105, 1078 GJ Amsterdam,
Netherlands), about 7 minute walk from OSS Europe venue

See you there!

--=20
Thanks,
//richard
