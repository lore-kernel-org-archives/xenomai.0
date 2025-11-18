Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D8B640
	for <xenomai@lists.linux.dev>; Tue, 18 Nov 2025 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431949; cv=none; b=r6gEqH22qF54KBOAZGP2q3yxVJ+AAmibt+hHld6q8hVQPPLUqYz5lNNtpIRg2nlKEXtohscCI4/Phg7YDb6/bYaUGF9G4pjuL9Ug8mqPtHrKJF0FkSSvKr/EPzmLABSosb1GHEwK/pVc4VUc6nQ8wBDrlmcAQAWm6lg1abBE0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431949; c=relaxed/simple;
	bh=q8ulZIVKhnULHaV0AwBTJjMXBnYGjxsBC/UYoBnqVVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKRV4T1F2gn0f8iEKg0C3X0V5KeW7X2f7Ejj5ISzqPmly8mbXaSJQsjydM5/dZuNaSzCquJov0OhDWOL25+1ro+jpa9EdwLhy8Yi/DO2lov9bdPYirDvNa+s76aggsEGHO/UT0OtjjuxjWf7C0AtOkdM6VJiTvME8iXLQI+gBRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2hlXvrD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2hlXvrD"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so6822167a12.2
        for <xenomai@lists.linux.dev>; Mon, 17 Nov 2025 18:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431946; x=1764036746; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRRG3rKSo0RV7FodKFIaOuaBOj8VjRnVbAxrw8Q4SLM=;
        b=Z2hlXvrDM8utC942K2SJfdPHqz403xYMl2Lu7wk/AwcA1KgSf+jS3hWnOpvS7XnYYO
         M7QceLF3Xrpp4OUl/JSKHvql8KdzyGPe4hlkCt5zVCsNJ/yf9C2yObH0xy5BmNs4iQ95
         abf8F3zV4AkEWaXq5qkd3MJ3WDwn4Sb2W/OKtLW4xCaBYN/HO9RmmBmxm3tgushEFjqX
         /KMgDgoLfYRPl1DbRxWN1JBBooZzB08NtpgwccCL0eyqgcxAmSm0p1qn3oBFERWy2sqX
         L8gxQQW3ef9Nj9upgyX20FxbEOivWbSmvrv/sGoaehFqQYhMG2E8JXM8IW3JWqlNGBVC
         a64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431946; x=1764036746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRRG3rKSo0RV7FodKFIaOuaBOj8VjRnVbAxrw8Q4SLM=;
        b=qFcNWlt0bn0hEh7WO1nj0p4P0tCpvTHkc1vi/ZggI6TNmgsfDEPYQ6X1AO6oX6RI1e
         IUF/mtBcXfCicmfOjSk+j+m/pVAibkVPWm7PUWNTUnWjV0cVJ0Ey6rFEaflmiDdmAkKW
         h8cUUjKgxvq/tO3wrFLvaUt9mlAwkTjWQaINafL4F/WvgrINfyMUoiYoOpFtNxNJ+x4N
         GVlECRP6zh0r7FJp3RQmuBpGVmsCc7jJFu16KH86bmnOCQJ/wD1SkU85Ozgv3AjLyzYO
         SXSZUKhSJME06zl/Cr8wFaqGJPwQKheK9h6wocs2YMJqDhUd/IHQp+nro13SeBZ90pG7
         Jwag==
X-Gm-Message-State: AOJu0Yx9kWH09RcYLHBc8IA7tmx6+NpbVd1oEvmC9FpWpZAROgCMjoTN
	11XnfFgRjP002oI1MuD79v7v2xIovIN/cocEQpoXM8qzk+RsILLDdJuIe74Acr4A6fUUmVTam3E
	VMRbqeXDb24joP4BilP73WFa+z+AWs5g=
X-Gm-Gg: ASbGncs3DX7VwZ63L461ZgVxwThRHXtsYRddQhZUIFwq123Ro+gtFVQaB9iBSGY8ohx
	QBOu6HpFPgCOpOX6yozq2NCbh9lAfTWaPp8BvBVXZXQtcuk0DDPsVYg6FUjQAd+ltjeo5/0gdn/
	wX992gnOSR6Wa90it0ij+FVnaZJVMk0AphfXraQZRlyUIgrrPbvjXiq95gmudF5WaZrUd+mtE12
	Y63HcmQPN8U5sVbTUehjqO7CgaZi7Igj2mLw1mP8EhTyWi72eHPr5tt04h9qGU=
X-Google-Smtp-Source: AGHT+IFpsMIsqdeDp02WT31jP1ZxGyoscAwyOHjREjNVjrtj9oL4yb2xXaSIU2KY9vlkfQzbzhUf4ASHarB6sQJJgfM=
X-Received: by 2002:a05:6402:51ce:b0:63b:d7f0:d93a with SMTP id
 4fb4d7f45d1cf-64350e118a2mr13453418a12.3.1763431945766; Mon, 17 Nov 2025
 18:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+K1mPGw0T0tOz9kYb0qmJaF0RLoKfDLJCbJ0Kx5yzvy=2icUw@mail.gmail.com>
 <43ccaa58-1b6b-4bd4-ae62-713314be97c2@siemens.com>
In-Reply-To: <43ccaa58-1b6b-4bd4-ae62-713314be97c2@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Mon, 17 Nov 2025 18:12:14 -0800
X-Gm-Features: AWmQ_bldTD7YKFAosFEdAoH2W7mERnwoVgIbpPzdb0aFMc4j9z4-bM9sTMWspgs
Message-ID: <CA+K1mPGR7R9eGyh9fe3kOYNbjOF+=4oH3CYRyRkX37szqYG6iQ@mail.gmail.com>
Subject: Re: rt_igb Ethernet support multiple devices
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:32=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
>
> On 15.11.25 08:09, C Smith wrote:
> > Can anyone verify that the rt_igb module will handle multiple NICs
> > simultaneously?  My motherboard already has one xenomai rt_igb
> > interface which works fine. Now I want to add an i210 NIC to the M.2.
> > slot as an additional rt_igb network interface (with a different IPv4
> > network address). Has this been tested?
> >
>
> I'm fairly sure that this will work as there were measures taken to
> limit the number of devices. But if you want to test before buying
> hardware: qemu has an igb model as well.
>
> Jan

I tested it in the real world and multiple devices work OK. I was
receiving UDP data on one rt_igb NIC while transmitting data on
another rt_igb NIC.
They were on different IRQ levels, BTW. Do you think that these two RT
drivers could share an interrupt?

-C Smith
