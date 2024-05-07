Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A715ECD5
	for <xenomai@lists.linux.dev>; Tue,  7 May 2024 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116247; cv=none; b=Gnmf8ueAF0C2kQORw+rdO1Cmfho5OR/2O0uw7LmgE99CotN4n2mnx5N/YZT1W/E1IlCPIBI542rsB+NKuwlzvhqP8sBn7QTqaCRXfqeV5LChF19Z54kv7y/RmMMM8H8QY8eM0a+9aW3++iVGAbR6mqVnF/DhvIF19E8hfhwrSJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116247; c=relaxed/simple;
	bh=9z9AkBCW/cdjyVYJN4hvU3sJYVazaGhKOIk4wbXB6v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqpeOlHhpYRMaOPbk7ihxjUoQWXBKQpKrY2pVoRONHIlyjFMwXcxDyy3j+tcJdkbWiegRnrHNob852zPNOXN8kEPmKUFuf44gQZ2DTkMxSBEdzS12P0LqaPxzM37J654SNAmQbx5sL2BO68vk60cy8p5Iu9fSrmmSBOtvmMxPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKSAto6U; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKSAto6U"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b5f3e20615so704494a91.1
        for <xenomai@lists.linux.dev>; Tue, 07 May 2024 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715116245; x=1715721045; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z9AkBCW/cdjyVYJN4hvU3sJYVazaGhKOIk4wbXB6v0=;
        b=EKSAto6UZ7JhVK6MF4wpSoEdwKkSH3UTNvTjimJvtiqZWyiTHcT2zJeYJaVwjZrJeT
         /rJLqM5IYPYYGj8HojrWZ+5YMU58ELx/OdG47mGOEeqaQi1EL39og28obyZwvggw6Pdo
         G/QlofnGvEzoK9ODy6+T8RtrBhCEOPuVogPT28kOVOQ77ZT9HhOekwMG7ZyWy2KtcEjD
         cwC2gUzpJWBFoWkvnT7b4a4qns0jygZ9rRHHjFyCNv8rytB3xN+urwfwiFl+pK8Hdz2f
         RxqWoEQqbRRcLCUsBTfu16OCKg5EEUV/BTnwccjlPsHLThev9Uuo2U/WMj3dD+1bLhJV
         BfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715116245; x=1715721045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z9AkBCW/cdjyVYJN4hvU3sJYVazaGhKOIk4wbXB6v0=;
        b=d86zBYEF0dNme6AeqzUE4ygduIORbJY2BJcx4uGTH/7LjILE9ognorkaQdKehlE6Ta
         wP4U6Cey54fncUBtVn6g3i5hK9/2YSTiHS/UQzlBPEMd99elcNGOlkZ+j1cN8nmlv38y
         lrEL8h4ny6Ao5R+f/L51KHfP5CnQ7SrF2YYqHs4CdK9ZSUMZwa5W9g+15ydAQKWVLEnQ
         bkYn6B/H6IWTFYyRGFNDWfQ0uO+UF0cJ0NVbdvSyZs2kUVOwwe0BAtXIc5R94WOU5qJJ
         SkvqxwGCm+3TEnjOxlrceUrV6S8hww6ATapGzFr1wALHkj134Oeh9NWvDBhnWodhfwq0
         C8UQ==
X-Gm-Message-State: AOJu0YyarGjiPT+A3gsFNcRZcKhg+CM1QNlh+0n+Qmb2fi6+TyA0DuSG
	tUDMG6DQuI6N+Mvp52j/SuZM6kqf7WA2XIeET75+qv8Qnc08Wse1vB0SH3hSfcD/t12O9y8Vy1/
	OgUS5EbO7jzANBKQPsjNgCWjYeAU=
X-Google-Smtp-Source: AGHT+IEQSaPUpF42yEE67msm+VsJDjBip6u2iS17flgG8LcC4oiWQ2WuW1swVAAlrPC5FQ61czKGU+QoY0Jf0fW+IUw=
X-Received: by 2002:a17:90a:d195:b0:2a2:7a00:f101 with SMTP id
 98e67ed59e1d1-2b616be63bbmr716227a91.47.1715116245196; Tue, 07 May 2024
 14:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 7 May 2024 23:10:32 +0200
Message-ID: <CAFLxGvxLRSpn34e5OWxV6Z=_oioHiyG1macowe8BSQ8qVcsKKw@mail.gmail.com>
Subject: Re: Reminder: Xenomai community call on Wednesday, Mar 20, 2024, UTC
 7:00 AM
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:41=E2=80=AFAM Chen, Hongzhan <hongzhan.chen@intel=
.com> wrote:
>
> Topics may include but are not limited to upstream/downstream project
> plans, status updates, and technical discussions. It's an open online
> meeting that anyone can join and ask questions.
>
> Time:
> Wednesday, Mar 6, 2024, UTC 7:00 AM
> Paris, France CEST 8:00 AM
> China CST 3:00 PM

It's been a while. When is the next community call?

--=20
Thanks,
//richard
