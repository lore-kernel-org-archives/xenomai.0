Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5014A4CD
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895668; cv=none; b=iQ3lsMghH+J3DnEUhLFMFjqzQOSe/vkUeyrhuqGUngv1G0rGNEbTwp2KYG9H6XGLcyixh8v7k4OZjvZ2/fjFb8NRAoYGXOJJrgTdwjjipIpTp/fKPFZ3w1QTYzKW9oGJKdnltjhgax4j5D9LKOSaI1KA3eTIiSXIN+BqqEOXW2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895668; c=relaxed/simple;
	bh=XiL7d3YqGc94KrQRePHPpkYQnYFZ2OZ5QaMi5nGA26U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmwUwmW/W7VD12WdJKyBFkipdTPBV35aIX9/EkPgXsSbRZe4WvHe23TfZab69KPb+CMPSf4XBKnjLRk5k1pLW0g7CyOIZgUGsTF4QpBjsLN8WeVJw2BBf+fz/hkojGI0klGMC3IGX33EEZlHilUF4Me3Px7//Xqc05pFhEgpuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8HJyPXr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8HJyPXr"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ddb807e23bso1600506b3a.0
        for <xenomai@lists.linux.dev>; Fri, 02 Feb 2024 09:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706895666; x=1707500466; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiL7d3YqGc94KrQRePHPpkYQnYFZ2OZ5QaMi5nGA26U=;
        b=A8HJyPXrI1aAC+BJav7iXzRFJt5m3Ryyc0AIsmQlAXXi/QPx5NTmDjQIqswW1p7SP+
         6UECFIWYnRwgAMXmIRCWcVhjLnQmptZybrVk1aPXKt2KvlQJA7umXtwFnpa28lu9qiYY
         9MYgCIp/c83Wc/61fKzGoCSLUzRVovB1rvc19XtICZJ5TCd6ZOFpXDCqvTK7nSBEHGB5
         gzoIuBGjV8e90WcTBMrc4g6Zq0PDqwjqYLpp52m9Jfdcy98cu/8f4CHLl0Gb6EaBFqrA
         Ke1vmBT2l8gvmWa8KR63W9k1afo3i+zPYejJjDvkPPglaRm4TJ9HE2E1wHP7nvb9mqVu
         O5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895666; x=1707500466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiL7d3YqGc94KrQRePHPpkYQnYFZ2OZ5QaMi5nGA26U=;
        b=g08W50LGuzU0IvGAFlZaFSzJd40CRRZQz5UyVYBJuOi1sn6CAK/aHC2a1zl9AFVEwF
         iPfS5ktIvta5dlbruaWIcyBUQRpSdxIWyg8vIOYU3a+Aq63UH8COj2Hu1iy8nHHoC0xx
         /ZTfgPbg4ySKfhK6XiudR4C7DAgl28zkJm3KZ0lgXaGcKy0SDjx0S8pbcbaHY12+DcHR
         EnG8WMUgmuJnd8d/IFBaIOfQSMJPnYHgAA5mr4TUU00iXmUYliBSv6Buahsve+TkJiPl
         XUjUQf69N9gMyU8O7L2X69phyxL0zsUc8J9ZaNDulUgL+4AcKc5DKD6GsB8H5fXEnDvb
         MZSA==
X-Gm-Message-State: AOJu0YwD3Bon4TGn0eiT90l5PqEdU3aqG8M2UWME6BjOm05YPNnSsdR/
	9mQzV7gy+9Kd+syqhG+9TEZuEkrvDBDrb67V7crv74GWQLLLnh8lQ28ZzYqtckSYwEEPk6diT1K
	V3hqwQ0fxGxT6W9tm190BvaZyVLI1ULt3/4o=
X-Google-Smtp-Source: AGHT+IFZYKDxI2+6J+3jE+c0t8zDgzBimx9fISOeQGOuS8mvs3CAQACUTQv3IFf9U2SAgHN5f50pfwgb1JqDpoxfIvk=
X-Received: by 2002:a05:6a00:4c93:b0:6df:e035:5549 with SMTP id
 eb19-20020a056a004c9300b006dfe0355549mr9594952pfb.15.1706895666166; Fri, 02
 Feb 2024 09:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com> <CAFLxGvw+oSFroW3rY9FD9hnDKUbZ5E7w4is9Z1QCbODar5b6qQ@mail.gmail.com>
In-Reply-To: <CAFLxGvw+oSFroW3rY9FD9hnDKUbZ5E7w4is9Z1QCbODar5b6qQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 2 Feb 2024 18:40:53 +0100
Message-ID: <CAFLxGvxr4XqoNJ+SbqyQ6zUCp5cayB4zdEt2ubvzhgXWAgqsxg@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Add 32-bit compat support for arm64 to xenomai
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 6:13=E2=80=AFPM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> Do you changes really need to fixes on the dovtail side?

Way too much auto-correct, should be read:
Do your changes really need no fixes on the dovtail side?

--=20
Thanks,
//richard
