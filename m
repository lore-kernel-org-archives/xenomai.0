Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D81863E
	for <xenomai@lists.linux.dev>; Mon,  1 Sep 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740503; cv=none; b=N/UvVz1+55m/RG6TL6rAfyLDYnX1aR/0lWY4iVxDrsOC+r5uFY79mT12PhM/aAD3Ml/P3g7gNM0q2m1YcKSt6mUgnxbukUq/Qn1wZGvn1+y+uxkeswITfCaF5mLFNENuZbG92fe1FP8nnUx0RTR0+llBZeZ6PWSGKLB4zA3FVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740503; c=relaxed/simple;
	bh=t0AJsDamzL+TPriT17z3ur/Z8Bxu6XKQ6j9WASpo/xQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZOCE2FahMOrC396iopMiAR5F9jj64GOP9D/5zdVvgdnMqPnkBuFCGbZscNLcuUHm/ECA6s+izC3zi8DvzVec7zPsutRbpDKdeMdO3iaG1y6NJUgV8ij0LfpwR5y6ke9mQ/EUecQxLZPYDWugxjX0m74KZGK36cptAtgHHrrpzK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1aHxhcU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1aHxhcU"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f646b1db8so4100355e87.0
        for <xenomai@lists.linux.dev>; Mon, 01 Sep 2025 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756740498; x=1757345298; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+ssz/AffALY3U4h668qiUsC6W9zqJ1tdUDGxmKu2Vs=;
        b=D1aHxhcUKbixbcPwv8nrUZGglNki45bssMyeilEsq6338f4i5bqM4GyhanfryPLfEW
         vUGCJibHKDs1fllZw7mMDuhpOCKaGOzo6puhwSId/FdSNXFhQf9yvnAIKZ86ZAcGR7G0
         RTj+BvMq0JlHekjI4tDXIZ0AsHZcg2nVRSfKOckCPay4Ez2dW/JJZj765uug28kEzmLL
         vwb6q9WXCMUYWnUk6Z7IBHshEWX2upSobSsPuPCIdM6t8Pua9Gs2kLX169iWbFWPkVgX
         xmeBrmRkcMFCk5cBJ0D0hUbHxxX8GW5aIX7DcE/9xq0pEtRPovsZOE25cKTDVHDDiWb1
         7nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756740498; x=1757345298;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+ssz/AffALY3U4h668qiUsC6W9zqJ1tdUDGxmKu2Vs=;
        b=EdWBfQpjWZm2cQ4Cch0Ma0PdxhIv2E4Hr21IszNvwv+eJGiFTibMYa0o+8gI3jMe07
         bbXlXVxILXFFMDBL47symh4KEJK/jn5e9fPfejSTpyJXqXmRqnYHpojVzHcpB+5D0zvI
         gfVtr81jQzziuvljCWr4ludac29iOpxSpn78l60GzeT8MnktIF6rWOSW01AuaWxfobvP
         wgsbjv0tMEt3ElSVpIONImrO4C4nJlW3/QAHMY0X0CmHXvJa7+CqhFYL2xSWEuMWm6dt
         N+Qf0/jJYkt+BxL0ckhcHlaTr3iaZ7ypOxeNXiaB3FA+AXkisURyKb5d2KrNDqgpLDnm
         WheQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqwQ2CB2s3/kMD4wiwnCYl9JeG0g/PUeLJ/cy8pVY5j7q3l4ZIZVcbKURftsWG5gDutBj0QrOS@lists.linux.dev
X-Gm-Message-State: AOJu0YydPY+x6Rgov1HpcKRFm2vx1aDlwLIDt+2yLhsKdGC3izxpnwCF
	XTfOzE2UHnXuO3Cm7vMeqQTD0y8SI40JMcJ5zUFMO8lZ0n7vgYm++Bh7cjeToaez
X-Gm-Gg: ASbGncsrua+fjG+lzQ0jorjIp/mn/U3MFg8GptkfjA606sAfkB9OYwGlCGCAL2mPKRn
	LgkrCSlEYqhbnPTSE00xKEIlNxr52IiLcYu/LfHu0U7of5Up7WDw1h5qRT00/rUoc21Aio8Sx+5
	+zGTjc0DHA4IVnL7aX/uVvEq5K4BqUt4zhPR5NDyMXWyHFhTwa17nP08NQ5c7Z6yXZzTftht96X
	lRuoO3aG+06cDZDHoDmFQLVipS5ToeavcxriJoRTCWhwgpNTE4ObyweGPolKezM1+8qNzm6Xfvz
	Aochpei6xUR/LNguVyU0B2uhIFVPmPFVtzMeeqiqRoWUrgCDRKX8SeKU3Dvb4n/06CTTkvf422W
	WOYxXcsNlfHipUxQ=
X-Google-Smtp-Source: AGHT+IFvnrtnYiNcyWjNbe/iGehjlmbibEWA8zypF1pMMmJEbTl6guzFL9HK3TB41n0ZmJTYn4fHrg==
X-Received: by 2002:a05:6512:2443:b0:55f:3faa:7c21 with SMTP id 2adb3069b0e04-55f708f19famr1609252e87.34.1756740498006;
        Mon, 01 Sep 2025 08:28:18 -0700 (PDT)
Received: from bogeyman ([2a01:e0a:9e1:e390:3656:699e:ad52:5555])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f6f58cc23sm2260314e87.2.2025.09.01.08.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 08:28:17 -0700 (PDT)
From: Philippe Gerum <philippe.gerum@gmail.com>
X-Google-Original-From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: [PATCH] cobalt/pipe: Fix invalid wait context in
 xnpipe_wakeup_proc()
In-Reply-To: <bc5c15c2-3423-4d6e-b296-63797ef7ff31@siemens.com> (Jan Kiszka's
	message of "Mon, 1 Sep 2025 15:51:52 +0200")
References: <20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-v1-1-43a7c06e676e@siemens.com>
	<bc5c15c2-3423-4d6e-b296-63797ef7ff31@siemens.com>
User-Agent: mu4e 1.12.8; emacs 30.2
Date: Mon, 01 Sep 2025 17:28:12 +0200
Message-ID: <87zfbe19bn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 29.08.25 17:59, Florian Bezdeka wrote:
>> Recent Dovetail versions complained about an invalid wait context in
>> xnpipe_wakeup_proc(). It turned out that this warning is correct as this
>> function is called from the inband IRQ context (while syncing the IRQ
>> log) with hard IRQs enabled and inband stage stalled.
>> 
>> The call graph looks like that:
>> xnpipe_wakeup_proc()
>>     wake_up_interruptible()
>>         __wake_up_common_lock()
>> 	    spin_lock_irqsave() <-- might sleep on PREEMPT_RT
>> 
>
> So, the warning is issued independent of PREEMPT_RT being enabled but
> the bug would be limited to that configuration, right?
>
> Since when is the kernel complaining? It is wrong since PREEMPT_RT is
> available, officially 6.12 then. Then this should go into 3.3-stable as
> well - noted.
>
>> As confirmed by Philippe in the discussion linked below, we have to
>> migrate the wakeup code from using a synthetic IRQ to irq_work to address
>> that issue.
>> 
>
> Hmm, can't we use something that is a thread when needed and an IRQ
> otherwise?
>

Unless PREEMPT_RT is enabled, we can't guarantee threaded handling, but
we can always guarantee irq-based handling by setting IRQ_WORK_HARD_IRQ
for the irq_work struct.

-- 
Philippe.
