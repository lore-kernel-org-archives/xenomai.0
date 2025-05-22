Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13228B3F9
	for <xenomai@lists.linux.dev>; Thu, 22 May 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919182; cv=none; b=f16DpaT+tc3XC5903cLDsno95YGeCNNJPHCafyfbB/iIlvS0Fo1vE2SQuBWx8IgdJfE1K6VPklcXQRkA1MkYQ4wb7sHldYPpR/PUtDoSU+In+0kjpcWuCf6Ntgfw1I/4GfwJWFiX3Xe130Hpfz6S10FYjiFM0GPQ7VlOG/qqyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919182; c=relaxed/simple;
	bh=V88k7EC6wZfKMVTp4wYeZ+UWzI+z+2fLnXYjU0kGnqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sg/Knp4Vun+G+odW7IimZP1T9HtzmC6J9JHArohIZokpatflw44JF4eblgBJYxCb/pMOookNsZIfs0wmqJSDsd7kt4h8Sg1xIM8iRZqYInnQRSE3n+wh+NKIw2pXkEYoVy0PQPsMPIm6veEm+bNfoflLJHofSKQXdm/Vk1j1G2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSIyZ7jJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSIyZ7jJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30e87549254so8858497a91.2
        for <xenomai@lists.linux.dev>; Thu, 22 May 2025 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747919180; x=1748523980; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V88k7EC6wZfKMVTp4wYeZ+UWzI+z+2fLnXYjU0kGnqg=;
        b=NSIyZ7jJOPmdACu3mUUFwUJ3+usIm10zZ2mi2jGHygSMVnQl0IHLr4J/h+y+BDqCN3
         OzSLp3ckIhVFOBAzfzlf0D9VeE0W4DYNdywgSfc1bek5/g7FSbAuOSLHfzoYiV1whPdm
         A762T3z1zlOp2fNgFH29J5IPtDK69nRrdtPO0Gm18zGb87PdPkYsCdQBRR03OHTzG7V4
         SH1H54AH4e1Kn8gv04JcP0+hsPR/7dPfh1gs7mJhz4r7okfUG8DK7MMDu1KWKnM9TkVs
         6JppvYRnul3AA+f+uKhNGOfaR4ZLxTnpehSFGpQLBx+DurE1Sg/GT8r6T3DL4mSRPeOh
         Eg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747919180; x=1748523980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V88k7EC6wZfKMVTp4wYeZ+UWzI+z+2fLnXYjU0kGnqg=;
        b=PLMfiiPl24qiuQJGrgKpb4102RZe4t1cX8G/4+74ZsC1NN2UHNCWwLbUg9b8qSs2hQ
         VOPuG2RAL1reMTRISvFoLMYVSaSxVW+aZmUEmnihkK6WyAMmInhpT7l9PLfjtYRP4RyE
         81hGOV3Ztp50pifEXF0Yi/ppT+ErQ+O5ad/89+UUFdnXaELLxrneyiGnbEPlUctS46qa
         Pf4kXkOwFqgwab6nD8amDPhVuD58KjPwsvkI+ts1cBrkSV//FtKvXJIYMAYwf1i93M5n
         uUolFBNaGf4bWIyR5TtPAib4kW57SEQEOAyEp2upIgchRvI+E8F5qJ8EKNpiCUziarM5
         WvEw==
X-Gm-Message-State: AOJu0YyfC1AVlbuCvfOLZ5RMZwakOkdi2pNxMsQ6oEk5ibPAMfWwHqcx
	KKmAHgH2SAW7RQ3kv3594jCWKd1czLNgBtRQqZTQlKCsAWcepwYq5rsuqL1EXgD+oo4u6pVyfvW
	9USezUnkaXTcb2U9ThPs40vQI3nAw5Ek=
X-Gm-Gg: ASbGncsL3HFBEU38o7878ya1Da4wUhT+EGwKBpzzHOkcSwmGedqvCMLtr/NGm1gvm5L
	cXG3MpjfCyXxR85uEwEUd9G3hgbHZU24WDybwWfTG8FgBmwrZXV/DGuzP8PfDKdqzPu0jcSXxd7
	P2sqJiRPwrHQNr4wbxhAkDFduJl4K+
X-Google-Smtp-Source: AGHT+IERssPxXFuBrVwz5vcDbiIRsVBJLeUXfs5ACtnnNfSCabxRDii1cREKh7cY3xZVXX6iFH5WeVgYC3TFjw/NpJ4=
X-Received: by 2002:a17:90b:4b0f:b0:2fe:b907:562f with SMTP id
 98e67ed59e1d1-30e7d527e41mr41929448a91.14.1747919180409; Thu, 22 May 2025
 06:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvxhk27ps98JL0afZx1+iecouV2NFsDHv6Ccp=zpn-yESg@mail.gmail.com>
 <f011dc68-e0ba-4fee-b3e8-00d135f2e6b2@siemens.com> <CAFLxGvz9cpMCFCxbqAvSUsYuDJKbcnLBFX_XfR1QjpCxZMVw0Q@mail.gmail.com>
 <5fc76c7e-7512-4151-8bf9-43d20603895e@siemens.com>
In-Reply-To: <5fc76c7e-7512-4151-8bf9-43d20603895e@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 22 May 2025 15:06:07 +0200
X-Gm-Features: AX0GCFsMvnBtrytJhSkSHwRsPDE4dPXQKzDlerIVO8hrHSyOXejyAh3n0VPMNMI
Message-ID: <CAFLxGvxCBJ45ofY6x=CdQ93AFsS6R=3e=cZvOZD-4mOFWSsrtg@mail.gmail.com>
Subject: Re: schedule_work() from primary domain
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:55=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> > Hm, I'm still chewing on that.
> > So, the problem is that schedule_work() makes use of spin_unlock_irqres=
tore()
> > which can cause rescheduling?
>
> In fact, the issue already stars in queue_work_on: There is
> local_irq_restore, and that assumes to run in inband context. Even if we
> changed that, next would be the pool spinlock in __queue_work which
> would have to be hardened so that no one holding it anywhere could be
> preempted by the out-of-band stage. And that may pull more stuff into
> out-of-band than we want there.

Now things make sense! :-)

--=20
Thanks,
//richard
