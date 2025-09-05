Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C84271468
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100996; cv=none; b=nzGpn7AdA8ZFWt3WQU7qU85+8iWaJj3Vjr0we1z0/J2GEwrwAKSFRT5M32jHrIrCcxWP1yKnskWDPG1gYYbZMM1BLj81/cTv2NjNmum66EGJ3e92xM7S+9fc78Kg5ETny7cbKnObXtAjHbrWKWgefGXBcE0KmxW76vD1+v2giW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100996; c=relaxed/simple;
	bh=XFsozzHd2/355IgG/T2D9c2jYO/Pte12hP8E5UYy80Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WmHI/lVU+fI1O6szLZ2oay4FCX6j+XtUA74nTtnZEZKW6W6r0M0oWQt9etWb3OqJTBw1vco8HjaATKxsJ0oYrf4tk4HcZ4u5Od4nPKkzAzFpJQkpXAoEgj59xD7qVCLViji8BGltXLP2PJ6VrzUQ8/dRx3e65dTPTQ5izQfz4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPaIdn18; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPaIdn18"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ddcb1f495so2937095e9.1
        for <xenomai@lists.linux.dev>; Fri, 05 Sep 2025 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757100993; x=1757705793; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wZVkOuoOSZ+U6BkdEPSKJ+u1qvz0al0hY90Yuj6LDDQ=;
        b=KPaIdn18WVCPiZQTacKfgXjA0aST6j67kuvkexF5Qfhrq/h02MajvZf6xyD5WWq5f/
         8A0hH9qBiTQITH02n2EvoOUW1528blewJC2Sqq2kxVHcDjivZ3irXA0ENqwjhNcO5lHJ
         VCk0H5RYsBu5cEaUSlA0lry1BzZ38wVStw6rGE4qRJqYBI6U4XWufJKdk5KUXxThT3gQ
         IzUWgj0MpZk/65iurMjTSA3r+mt4iD/nEtDRTBMZVQp1LnoEo4emVzWzOSEk8ZaV5MR0
         9bJDU5SC2ekv1gMJzm/pn1/RUX7TfxOy4lvJX4JDGOndbYXyVSOks4w12exydEMfnTki
         5Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100993; x=1757705793;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZVkOuoOSZ+U6BkdEPSKJ+u1qvz0al0hY90Yuj6LDDQ=;
        b=XzRifbe7n6ugrE/peRXnj4fEZnG5v6go3ygQUgBkOTtm2rpunHLm814dG1jEdUAnH5
         +nDmC8LomKaRcI3amJPks3LRoiVbQ50cAazScXGk6gFv+4qrOXQgN1tqCA0nxd2a43cl
         MBbeDB3MGBhYXo5zubZkv2/Fxtkh9170hOl1D4kAAxJ1959r0vXJevVu9mtDm6SgA0YU
         fZJk4zlm9BEI117eTj7qRsL6tlnznnu3pnqDevJtNU7qn7NQYUxtn5x+UdnXBlbOTbuD
         lImYv/CJw7vMJsxC7EQbe/HOzfdDsoyeM4az3SFWc2MapxlWPXIK+pzTbj4LDaGVYhxu
         c5hQ==
X-Gm-Message-State: AOJu0Yym9Rq0/GrqMa7AKcUeFyCqt3BdFC5V3y/r7QJJmJBjX1TL2OFe
	P/dVh0vBkztQt0raMWYv69qutTHGxLu7oS8teh2eTsVnAlS7GF0nIoAv
X-Gm-Gg: ASbGncvN/7dEDIWGF9dj3zxpx3QogYvaCXHK8RbTwN/z6vxmfP8EmCIWZqVGEVlxt38
	OaPmhrVDpDxys/K315mJiEl3q8yY1G2hSW4M0GhQf20z3XiMmwCs4ZRumbCoaqWJ70cvBK/TQxu
	a9s3hCpGIV9auj31PQy996FE5J7hY3LJfFbLJppsHyjIyr7dI1/YDX5qq+j7iPVh/6KOPSUmD7U
	ee67Zt5M+m74zKU27HPwH5cUuc6oISKXpipnGb0aseSJZi9zJOM+m/odDrZhlbEoi9qM1iS4HKx
	btSHx+QmCgGEtSE3bgy0ZOI5zdFfV2M5C+yWc0SY579g+6SoGsvm2IrDQQuN3BVFs/ywU6lmI9A
	/iD7RLIWcgTN8Bvg=
X-Google-Smtp-Source: AGHT+IGGxCLV1sJUGKGxwIeewARebcTyUKFM3xscKu78YxKsHpDlyYLu5o1Y5HWQqq7sYvyOtaIV0A==
X-Received: by 2002:a05:600c:3ba4:b0:45b:9961:9c09 with SMTP id 5b1f17b1804b1-45dddee8ea3mr375865e9.17.1757100993217;
        Fri, 05 Sep 2025 12:36:33 -0700 (PDT)
Received: from bogeyman ([2a01:e0a:9e1:e390:3656:699e:ad52:5555])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfcb1497sm47318315e9.1.2025.09.05.12.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:36:32 -0700 (PDT)
From: Philippe Gerum <philippe.gerum@gmail.com>
X-Google-Original-From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail v2] irq_pipeline: Fix system freeze triggered
 by periodic edge type IRQs
In-Reply-To: <20250820-wip-flo-fix-edge-irq-handling-v2-1-1a958d17eace@siemens.com>
	(Florian Bezdeka's message of "Thu, 04 Sep 2025 21:38:00 +0200")
References: <20250820-wip-flo-fix-edge-irq-handling-v2-1-1a958d17eace@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 05 Sep 2025 21:36:31 +0200
Message-ID: <87ikhwk7y8.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> When IRQ pipelining is enabled, it could happen that handle_edge_irq()
> is interrupted while syncing the IRQ log - for the very same IRQ.
>
> The pipeline entry code will set the IRQS_PENDING flag and bail out
> forcing the sync code (lower part in handle_edge_irq()) to loop to
> infinity as the (periodic) IRQ might fire again after calling
> unmask_irq() and reaching the hard IRQ enablement in handle_irq_event().
>
> There is a "race window" involved. To trigger looping to infinity the
> IRQ(s) must arrive while processing the IRQ log for the same IRQ in
> handle_irq_event().
>

[snip]

>  kernel/irq/chip.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 8a0831193d74..0fa3dce5b9fd 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -669,6 +669,8 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
>  		WARN_ON_ONCE(irq_pipeline_debug() && !in_pipeline());
>  		if (irqd_is_wakeup_armed(&desc->irq_data))
>  			return true;
> +		if (irqd_irq_inprogress(&desc->irq_data))
> +			return true;
>  	} else if (irq_pm_check_wakeup(desc))
>  		return false;
>  
>
> ---
> base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
> change-id: 20250820-wip-flo-fix-edge-irq-handling-16e48193aeac
>

Good catch, this bug was obviously no fun to track down.

The change above raises an issue though: what guarantees us that no hard
interrupt context for a given IRQ can run on multiple CPUs in parallel,
since the interrupt is not going to be masked anymore? The logic above
works if all occurrences hit the same CPU because the pipeline
introduces the needed serialization by design via the log, but if an
interrupt distributor decides to spray multiple occurrences of that
interrupt on multiple CPUs, we could be toast.

-- 
Philippe.
