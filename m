Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397D23D7C4
	for <xenomai@lists.linux.dev>; Sat, 23 Aug 2025 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755982693; cv=none; b=GPecSmJ+7W/i67hnDXh3ZH3hCbwf8NhKCNlmePoIlPriWU5mdmcU1lJ6mL9ZTg/Xy85Hkab8vlqe4YGRraJa4/Hxi/fXthS4eh6+4lJbYN5hGM/+0N+0YBlcpaSiNBpqR82SULu++yg1MGs0fBlAdOnL9BItp2UB6wWoTmC4BDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755982693; c=relaxed/simple;
	bh=YM3YXyiisQvB9HLAG2KNgdkRtp2df5OIVWCr45d/9Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G91HBRZvYZlTcgxXqwH8SlUo5GV6Rxg16jDlg616Xe2KAGz0XmUtWPTkTH8jpMGhiLcHzLcBY+q3dd3/9rmexW1/vFuBj+ioATz4L6fEDc6XJ9cwU4WYCfAIhgYcUW2mahHsmoERa953iAu41DBJjUs4yg2JD5huUz11dDAWwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcW8/1e6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcW8/1e6"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3253f0c8788so1566768a91.0
        for <xenomai@lists.linux.dev>; Sat, 23 Aug 2025 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755982692; x=1756587492; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM3YXyiisQvB9HLAG2KNgdkRtp2df5OIVWCr45d/9Y4=;
        b=kcW8/1e6Gyd7gYvD10X3bQuxviHH1DLTxD7bKshre3MmY8y/VdxPkIBGgnuqlxD1sB
         noPDu3mOZPrm7rdknBv1eLb/LU28QGuIgamUd5wsxb8ayjiwegdeKqLdLvuWgurN5TNx
         QdSwfzbr7+2tAlgAUcezZHHUxRF9+174RUhLL7LQCv86mICtB22jPY/tBxN9ztxdiqD9
         8BpRRzhb13wWOwJjc/dwLcEizxILGOR+inYYgFcLHxoAX3+wYp+4287wVJPlbH6m7PdJ
         fL1nQ1OC5zhYPWgC0Ii3+deEAJeaO1JKGfmGOJlFMCmyHpMRLTjz/AVu0Lm4UoYs36Q1
         v0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755982692; x=1756587492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM3YXyiisQvB9HLAG2KNgdkRtp2df5OIVWCr45d/9Y4=;
        b=ReejFVAtWA6xvXki6PdEPcNIVd8oFoTTtSf2TW/phXI5Mw906U61v/0+Axl6jbznCt
         /H5RpVQiM01i5Sdb/iC0x6/AH2hdkIP430vcZuHNwG6WGDbJn1XkB0iYI3SsIivVNtYO
         127sotSb7HjIyWMYillmynTbfnmuGusvLIfG/Fr/eDVEl/E7EZx4WwZN7vsqS25SQ+gk
         qb28efVPtwJRSx3Yz0EQAyvU2VMTrWdZ1UTfNXlZ1Ry5C1Qj7iw7QWG5WL5COYt5Gm2e
         M7AZp3kwvcFDcc+oRzxqofj5FFZZjs4B+6AV+6s1rrv7S3f7iTX3KVi78lcHbki1jpVV
         sjbA==
X-Gm-Message-State: AOJu0YyXaWKX0YQycrvlCBd+RfpWYj8tqQlpQmDnBPZpxbRrsqRwsqol
	p6ezrCP/6+5mGJWpDNEhzQBdkosk6tQSA5c/4N9iwZHN5b2KotdUmt8vTqGox+qI07K3Uy0JVNV
	djkwIYifMbN2K76rGoyVgx6MisH4SyEU=
X-Gm-Gg: ASbGncs4MF7VMNpGb1/iqrhod64UwliSdpRNj7ry68/qvRtrqBSPHZ06Du2qZMdWHxo
	baLeNkBtCHf/vPfOm9sXIp1lHxUDqc3d1Vz+a21CGKvry9jBD3WRPj2HT+T3UbXT5zqfHF+lRi4
	baO7F+3koHwVFyarTkQ2rHKlT8ceLpWSe4kIAvDbQqS9dk3wFndKorM7MQ7BDifyQtWXWhBSXph
	vso8Vk=
X-Google-Smtp-Source: AGHT+IFqc2XwdfaKTax9ERHPX+9Z13HY6HCKONaHMqGWd1ya/KCnJDNYQeKLFiQZCxJpHu/ELgiexQ/la9qxpTweJ4o=
X-Received: by 2002:a17:90b:514b:b0:321:a1fc:a425 with SMTP id
 98e67ed59e1d1-32515eda016mr10104890a91.26.1755982691632; Sat, 23 Aug 2025
 13:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
 <CAFLxGvyLoamDw-u64ahzU9OPrOMuCqLFOdvFNpPeSsOx0ZWKPA@mail.gmail.com> <43e42f60-e923-490d-809d-b0e35d4743d2@siemens.com>
In-Reply-To: <43e42f60-e923-490d-809d-b0e35d4743d2@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 23 Aug 2025 22:57:59 +0200
X-Gm-Features: Ac12FXwtvrvrly1JI_MTENmbgDKgmEA0gtrjJShIb74WYuL3PIDkgMpTYjCVXbI
Message-ID: <CAFLxGvzSDiNjwHNyys+mfJihO9oEyrR6Fy=7ENEZ750MD9RcnA@mail.gmail.com>
Subject: Re: Xenomai Meetup at OSS Amsterdam in August
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 4:14=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:

> > Finding a place was more work than expected.
> > But here it is:
> > When: to start at 19:00 after the booth crawl
>
> Just to be clear: that is Tuesday, August 26.

Exactly.

--=20
Thanks,
//richard
