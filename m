Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E653FCB2F
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771440; cv=pass; b=hpTpznHwdn7WFK87hEaLHsltf4eKidbJ702a0YgCg68vcTnDwmLYek/u5hCoL4gijbg4imintOo/T6wFbPng9QRzKjGHl7q5/xlTznixG/NFhGb/zDb9JF55j4f+FbVQ4PU0JbR3QFQbl2zfguPdFkuZOSzXSrH4r41sqcJiSZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771440; c=relaxed/simple;
	bh=XWVwVc/+kPH5TLh1+6wq7jXCmI2D64qZ6NK0pTe6Lxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4aSqq4OnVXzDXQ9hwY4mqMrtCqjHj/hhpQoEHSsSAeGzIM9CJ6+leDm4WRUcjdQvjLcSz5rUB3P1pJM1/CH60K6LAO2nQKKOrGmrZnwfHGaJHMjAimCBo+GjZxaKeRYI+MbbDBxKXndqa2JOIhVSavoPYSosZ2md67uvvfWJn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio; spf=fail smtp.mailfrom=elk.audio; dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b=TDJzp/TG; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=elk.audio
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b="TDJzp/TG"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66d20c35575so208581d50.3
        for <xenomai@lists.linux.dev>; Mon, 07 Sep 2026 01:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788771438; cv=none;
        d=google.com; s=arc-20260327;
        b=AdpWOMiYf329qk4Vj0v4m0XNzY381bss+9AVrWDYc9sPSD2S9s90nUH1YPSKxRDv2C
         COKk9Ol/Xy/40UW3Y7yZ4mlHw43mUz5NkcVVwx6hrMJz5617aJuANwYkKedbZ8XUltzm
         xZJEZErd1MAANXnBGfe/SR3fjc6Ly+CykohCj+LOMeZoJW84Xg0FeJdpho+RtOVNijZB
         XEgVt6vKnYujSIEYRemaswdJa963Yndsifsg4M4xrNmzKkzCbAj4WcnHnWzD4FVaq1lk
         xw/rRCswiNYVYGR/hgkWoFpQzIzJWbvZ2Jh30Z34hG138Ik+MdQ4KKN2si1ApEp4eMbZ
         7j8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XWVwVc/+kPH5TLh1+6wq7jXCmI2D64qZ6NK0pTe6Lxc=;
        fh=MTJBFNKdZ7BG6Nbe/UkHbWThgHhA6Gy5N9pVMtqWP/g=;
        b=UiudBlDLX6G8cCUZqAj/DEetBwApVPVUDmCC+LyND1ScewrKhSRDiM1Rjh6B1ISHx3
         m//Ofg7x9/lk50bXhAWTamktIY1JNnhTjcm373W7Fri090/UQFhJNkZcRqcI9ItDUKAq
         5vgBKLGa5EnmE7FRI7gD7+kEOQHZQcoS4bIlwnkxIBb+TQlSJgguyuIjxJbBclpS+Rkj
         Ah2OTJXWEUPXKg992cOaSd1iXKiOj8LxEUaZFXySinh0fbkY1lUpK2mKz0RMJwgmN9Eo
         VK8skWegtpQT62KtLdZL8HCYVTDW083KVKwc7Ti36GhHIoss5TPE6+DVnFE3S9Ux7IdK
         5TfQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elk-audio.20251104.gappssmtp.com; s=20251104; t=1788771438; x=1789376238; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XWVwVc/+kPH5TLh1+6wq7jXCmI2D64qZ6NK0pTe6Lxc=;
        b=TDJzp/TGU1sHUHdRR7pd1PieY63qKqoUs3RMLvprSVRqaqDyT8+RJC4+Q0JATaj7XW
         N9m1dj0J8so8ZayWdvYmtQbhcXuUN0WnDVjYbE4o5Lq1nkbk+x2qyiAYqW/yUl5DSBPW
         7tHHBuIUZg9KvJR7zj7ynw4buR0LEZk68gLlgUPbP41Jvy0luMnRc/TCkvVJ73D/U+iU
         riF9ojr35y6vl4yRvLjGqFx+cOxipHdQPqyJOyRw6r44gevaqI3K8ufDHmp1a+ZQRF4x
         bxyH2PXm8D/1EyKRhxmrbLY9DNTrmLrC3iYzRUXGI4YviCI2XZakV5CRLg0+QxP40/mA
         /W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788771438; x=1789376238;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XWVwVc/+kPH5TLh1+6wq7jXCmI2D64qZ6NK0pTe6Lxc=;
        b=Qc1Qp8gfaqslFfkFvGY5gWNqXN96Iel1836KsT5D2uMKD2f+RT8z9xGNurvQlqSkA3
         P2B98Atf5Sumk5Fu//BKxD6MUIT/o/qUKP27UNQE/zbiwtXfzE7as7vsU3we85CuxNgL
         KmDWotpQ69GOEr9CLLT/Y+Sdp1IH/thIlL1M5kj2eL7mBYWEnjx2Ey1kSm0OqXPU96A2
         Yv79whOa3QBPPVxADulS/QUf6IUERf9Ogwx84edLYUHzpQNi1pGKIvtC3D2KEbcInxHt
         ahATgSCNhwn+bSS8fFrU/myIepb8jeh8AwVxfYtVhnrwbFKA2spGy1z14G8rI49Rbh3i
         rVUA==
X-Gm-Message-State: AFuF++lhHB7IeekC27/Q2aPqHtZA6ECjQHqO3bECSPmQO19iE8bUIp+7
	t67HCZX9N7HAtMB4V26dJ51xRcDvoXrjPonR5jybBY8Uln2H5D/4CHRm4+CpU4sw+TeXaAG8niM
	CaWkIXZGnvwhxanLMuy4Dl3VgJ895MYyvMlRBlCelPg==
X-Gm-Gg: AYBFou3kG3rYsvcHhwF+euR9ZGXtmhoQo6HUh1aKsjTy+Ylz+sgd8xSkFS2Pwrpi45L
	qhFJHVTcfrT67QMHXgBC9mQ9FvY9vUbiqCxkUhNaxFuNfad/DU3L/2wOyudJjPQFjRCBhzexFxM
	AUfBzYETme0dIlZZOL1KqNTGzJpjkPUeIwRJ1bQ+jttZchdWwjLStYXQHe80tblROGPJMoeA6Fm
	qKbx4u7v4ByYbdZTNxBGuHab9yBQk+sXprpkcN6VORaeJDnH6zfriJTJbwPfQLOmOK7KWy8WlU3
	tGwffJpciw60aTz+XdBDmJQx7qUeKsnoZa46gUK5JTuj
X-Received: by 2002:a05:690c:9c08:b0:862:7bf8:287a with SMTP id
 00721157ae682-873f3b91410mr45385747b3.4.1788771437867; Mon, 07 Sep 2026
 01:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
 <9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
In-Reply-To: <9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
From: Andrew MacPherson <andrew@elk.audio>
Date: Mon, 7 Sep 2026 10:57:06 +0200
X-Gm-Features: AcwNN1WzYOV4td8zmfRBjVhK6hmlmg_EyN-XBcmqOkcG_7FfUuAj2sjteH2SeiU
Message-ID: <CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sept 2026 at 16:08, Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> Hi Andrew,
>
> [CC + Philippe]
>
> On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
> > Hello,
> >
> > We're working on an STM32MP1-based system running Xenomai and found
> > that perf top shows every symbol as "unknown [00000000]", i.e.
> > profiling is collecting samples, but they all point at address zero.
> >
> > I'm not a kernel developer but went through a few debug kernel builds
> > with an agent which eventually led to the attached patch. This change
> > does resolve the issue with perf, however I'm not sure if it's the
> > correct solution.
> >
> > The reasoning is that arm_arch_timer.c's percpu IRQ registration never
> > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
> > tick_regs, leaving get_irq_regs() to always return an all-zero
> > pt_regs, which in turn breaks perf's sample IP.
>
> Yep, that is wrong. The patch you provided looks OK to me. I'm just
> wondering if that should be addressed in Linux as well / first.
>
> @Philippe: Any additional thoughts? Should we take it already?
>
>
> @Andrew: Could you please provide a formal patch with proper signed-off
> and LLM notice (assuming agent means AI ;-)) targeting the dovetail 7.2.
> branch? That should help to speed things up. Thanks!
>
> Florian
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>
>

Hi Florian,

I've submitted a patch now against dovetail 7.2, let me know if you
need anything else and thanks for the help!

Cheers,
Andrew
