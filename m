Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8EC1DED40
	for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664052; cv=none; b=pTak3SgFEpnJK28SqMTLi4uxTKnUHlhb8bfPWQG1myhFTATAdrSm9/AyDsKR/JR4KTFzkr1z8o9krHZe1wOqw7B6zT4JrwfEbwcix7L2UlHcpi6So9dvNtQmrO7PMATgVY95SLMJzKriV0A8dyx7AzcdLb8DH0bizL5zV2Yrp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664052; c=relaxed/simple;
	bh=nmCcodepTR8NTzdSRCWVvQfcpkbi9ZtutGT9TaNhNVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ni8oj4BLwXo/Vb2jLpsUbMnmx3jZz6MZ4Sci0UdisSvxhpBuD7ZceT4HIDKddwXGMduNcwvd2fDKeW9DJQ+Q6R9ILtLH9KnN6nkoSv3/iIFuRgrObOg2fIHZQ8xl0FZ5CovDm0aQKddMvhbjtXZHKX874P5+47CgVSMcZELkMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ5BaCaq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ5BaCaq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so5486740a91.1
        for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744664050; x=1745268850; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmCcodepTR8NTzdSRCWVvQfcpkbi9ZtutGT9TaNhNVI=;
        b=iZ5BaCaq6LIsEw/6JvLTnppavyRl2ukWmyCU5e60FIEs1GnC0rDEYBMF1XkNx28Z5X
         c1M0LwVpl7k/mr+MWr8g6nqEOGLsKTd+N4e0x1uWgqpYnMzV2keA90ky6xyo3Y38vdyK
         fquvMRZYb99IIRDKkDf+ChMf9U6UKYiPrvgCgnv3qCwJ8cE3ImWTHCMa5GNwGZXSZvO+
         U58v7K85uoyGo5nz8Pki6DYcXS3YwITz5OxTY3PfMACA02ipLGV0Zpbi7kxmg7nZLHW9
         j5+fZdurgLdzEacOa2lgPO5Rva/QttE1Jq2gi4dm3t9fSoa7V3Z5a/LWfV6IDUwMn/Dg
         vv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744664050; x=1745268850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmCcodepTR8NTzdSRCWVvQfcpkbi9ZtutGT9TaNhNVI=;
        b=cXYbPWsZXFY0HwGMoE7jzf+YDvtb3dKOngakJqD8E+GHQVdfLHehDsgxw3p7h+axxd
         HR9OYd46VMu7xEbGIGKeRCkFUlwAeZ9zO27l2a8SekneBxXyDETs6sKF0Fp9uKUISVPg
         G35evr4yrsO8mxnUwnx7Uf3aUTV2LTyS0Mh0MP5R3X7lCMTDbkzjc1a3+aUnqHULDyAM
         jbyc3+triEuONZEsaCWihk3ccWpyB80U4KNP2x36E+oofV8saUK/8mTVNDnquxB/+c1L
         qnaaLWBe1sZuMlyczmL+jmeGguCUgDUlpzgmJc5xKodTL9aI6nAgI28rprA931C3QD4E
         QzVg==
X-Forwarded-Encrypted: i=1; AJvYcCWMBqeSxPLpJe3kZffzXudUvtLeCfHFg0F/3UCU2hgm1XdxFQ/P1zMHaLxqTXba2kh3+spSk+0D@lists.linux.dev
X-Gm-Message-State: AOJu0YzgZb4QmHcQ2jY1Tor83OoeBQA1B9/SQwyC+txcNH/Kf2BprKp5
	EAKUOR8ZPzaurBeuslF37/GmT2M8Pfk/gCNiMnt7dNIhQc10CrJ2pjliIUXFmRnTR+kjf5Acn2E
	tt6MJeXpo6AkwVFLJmfDsN/zhgHs=
X-Gm-Gg: ASbGncspmEVM27aLORbm1yfGHfDDJ58RLAnIFkoi0EuB2SuFpAbJiRzbNJmHUIYBG9n
	LOHw6erAezIJIEauZpndIHOYVZt5wgLzxcMSrGREjoNjiQVy+Uf0cwAgtgoIjL8qxjNbBkqovPl
	ugAO8PuPjrcQ+4itSb9KdXYg==
X-Google-Smtp-Source: AGHT+IFhcElWCxsSd+x9ocUjDLlBk4ZWQ1JYAPesBf7ccv2MLvkIcEdzSVbOaES+yjwYBwbYQi566Yb4CsNuJqnu5wc=
X-Received: by 2002:a17:90b:5705:b0:2ff:53d6:2b82 with SMTP id
 98e67ed59e1d1-3084f3b3e7dmr1145163a91.11.1744664050222; Mon, 14 Apr 2025
 13:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250414153817.1829100-1-aspirestro@163.com> <89584308d4044af665ec7ed2ce71258edc237ca9.camel@siemens.com>
 <3e4268139f9fb21608367b46d939b8d1c93e1f88.camel@siemens.com>
In-Reply-To: <3e4268139f9fb21608367b46d939b8d1c93e1f88.camel@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 14 Apr 2025 22:53:58 +0200
X-Gm-Features: ATxdqUGJ5D6HTKx8eJvRu58juMoxvVXYD-Wec1vWKMagPqyYNUAsxfK22NfUOpo
Message-ID: <CAFLxGvxC+TZKfQ90Q29fh1kQxjqLruUWezdHtjD-OKw=fJBVjg@mail.gmail.com>
Subject: Re: [PATCH v2] prepare-kernel.sh: expand tilde in --outpatch path parameter
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Haiyang He <aspirestro@163.com>, jan.kiszka@siemens.com, richard@nod.at, 
	xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 8:50=E2=80=AFPM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> My main point is that we should not use eval on user input. That might
> bring us to security hell.

We are already in this hell.
Both --linux and --dovetail use eval.
AFAIK, this is the only way to fully support tilde expansion.
