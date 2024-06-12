Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2616FF3E
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196029; cv=none; b=cOn/jEl0sHzu/XikFyDs06OnIftQB+h1zN3nfdRHmaI2blM0CqqkVCCH0Tb5xl9fBs8c2pWi9KYimaZZrLv/2/b8kOJK20Cx0fknCZu+cWgwXQqz6Rucgr+S5bAFn7NRbWcwKOgY9zR5zaKSEg4VJeT98nmG0P32VFzoQt6AVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196029; c=relaxed/simple;
	bh=WDUUjvy447S97hr1LSaaEZlY+kp2LWBl7ipPTxSW/NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+NfM0GNixvatCn9TKnzwkMl3RfECkY1onBJAY/380ss2mFj+U82FeE52/6qY020yThCxjziKI/vtA8V2eiAasCd1a7ofz4SojyCdciKF9NwNDlZROlQbPF++RxhBCza19z8ovMirMfJpJJJ/C/raWCPqalikANC706NorR90HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUJo6uZC; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUJo6uZC"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so2856941a12.0
        for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718196026; x=1718800826; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jz4uczjKRGSUjdfy7r+he9pcIot/HJD6Oxw6D3GCEIU=;
        b=KUJo6uZC1JrQKcWZjHQGN0/nNnAHSYi5uPGxoYtAWUwj9ppSsl5pXh38471on7KLXH
         4W+uhTnnOi70QCwdiHBCgVfVgUw8PPgcT2/R1QffbtDSespdQZ4cEyM4cfqbhKweqiry
         gUZa7f71lnR0N1DeIGl0TBj+xbXXK8FC57zcJ1zjGyF7jN4SSe9nFDRUoyTOFSOJJjfw
         C6RRepDduArF8k0o/6ApjdqPQ06IGHodLNj5GldoP/khrhX3kA0LyQ5xxLH369p6YC5P
         fy3LyQTPsXQGgc38rSHD+tUTRDrJ7ayWwdvgA/I9i1k5wjzij07ZOagDvaV4rC9Nr2YK
         Q17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196026; x=1718800826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jz4uczjKRGSUjdfy7r+he9pcIot/HJD6Oxw6D3GCEIU=;
        b=odIHlP5mHt85ntR35fBPuFFkUu5B8QHQkekpHKQ07T/ZfUJuoBu2oksn7nEzszk20T
         YNRiwCcMhQzOR4WYHU/MuMRPTbbL9iH8s+qCe1ijEDH2axtnzyh4xw6rGaM7TvKi6icP
         fb0NUsIhgjiw/IcoILGKnT17yCkLUiqgSqzY5KZZOltLgTjwQz3MOD5HOP5XZC9o2w1f
         zs/XIniTrKl7YlqTCF8rJ2VVkdJspizRAonSJWokabSARX98Ljd1to42RZrsTV4yq4yz
         CSrgwd4RqPp41zYnAws0jBUwAy2WnMyyh+yCT0jnFS2rVKzruK/f7Iy5NZ7KpdoDozwO
         0CnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaf56iLGD0WhsxQRAitoh9UWTMFftvh74jbRrKcHotxiFz7kaIZYYvq1OwABOBK7xrZiva/Jn6C52MI8eWt9cVustCA5a1MA==
X-Gm-Message-State: AOJu0YzrWza8zF6OjPQRgWdl5uhgrC8uPsfdQuBNow7AouSb4zWQt6Oh
	xJgneI+tY+fI+4l4J8C2asMacPZrIYPESVqEREKzjNiHsfKBAwNeiJYWbZ4GAPu6jvg9JqX8xlT
	dsrE7zRnhust+tPrMeQv7etRf8/U=
X-Google-Smtp-Source: AGHT+IEezx8rPRz0tsSpKJ0k16pd1Ht/VhAZzoXxS35+uzP1PR80o++VHO6HiYVIPMqjJSwIt5VSexRsoigCvfagb+w=
X-Received: by 2002:a17:907:7da4:b0:a6f:501c:5da8 with SMTP id
 a640c23a62f3a-a6f501c62d0mr9594866b.22.1718196025492; Wed, 12 Jun 2024
 05:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <PH7PR11MB74994E73E4A092626F492425F2C02@PH7PR11MB7499.namprd11.prod.outlook.com>
 <1158-66699000-d-2e725200@6131804>
In-Reply-To: <1158-66699000-d-2e725200@6131804>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 12 Jun 2024 14:40:10 +0200
Message-ID: <CAFLxGvzhmZEL4+22UjkPD34g9AqMfdA4xUavug5itv_1GR=dPA@mail.gmail.com>
Subject: Re: Porting RT net driver to dovetail
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:09=E2=80=AFPM Fran=C3=A7ois Legal <devel@thom.fr.=
eu.org> wrote:
>
> Thanks for the answer.
>
> Maybe I mixed things up, but I thought that with dovetail, one would some=
how use  linux network stack with special OOB drivers, and have no more to =
rely on RTNET. Is that correct ?

It depends on whether you want to use Xenomai or EVL.

--=20
Thanks,
//richard
