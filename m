Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7D16D313
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897505; cv=none; b=K56jOgrgNwHr68J5bshASObZWisw1K5Mx3N9vhPPhjpbdiYk08DW74U+/Gt45pXfMLtCfJgWdFHU9AiEIEr5siP6eAkctUvw7ohIsgw+5zYNU0O+5x+Ltq/zOMgCwF+AqU1sdr9DaAvNT5Sl5MnUrmr8+Duh5mdm0/AhNsuo1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897505; c=relaxed/simple;
	bh=ynJJsks55CP2th1vmLJjKD7aNgkz24PID0exzRlnYTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1iXTV0qxNpfHEXBS/IIB4RPdggAcNC1EmUWTuoqn6pSzW2AJpc/VLQoNUMAA4rkyWVBqfOrw7mtUKhq4vTkIM+VliiXoemLagCPLAboz6ZoSXqK4gs8+idRq1hKcpNLN6FECCiDrwA1+q9oT/MmfLE4qvDP8ca3CGIMjiirqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=OgKPBopy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="OgKPBopy"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42101a2ac2cso5459885e9.0
        for <xenomai@lists.linux.dev>; Tue, 28 May 2024 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1716897500; x=1717502300; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5wHYmhtoWY98TeI0p7eO1FyO2OdlloO6ZqlXOnVOhE=;
        b=OgKPBopyzdgBUgXJTVwFuzTLysLhggpbPrYdLRxA+tknchfAXBUEGvMAz9loSfL2V4
         UQWYbhmwuFBlyDQg8NklSPJHQIh/mZ352vrn/ncI7tOAF3FcrKoHl5X+SWlyQhYBoDCm
         KfgKD2YagwY2cqAO6V32FqSxNUDJprrF/n4cfLldgXmfrc3V9ux3CJBGzQdRX1fD++SA
         2Bsr8kEP9N6f5+ucIkTpPUMa9NqbpvfPPGfrfBZKcqZoQoeNQRPlTQH5GOrnOf7lcRz0
         GOyABUOuoeJ0J8a0Q7jCTFJlTGfWX35cf3T0Pl38sOQz9QZ7hjk2V9LpIrdag3nDS0tv
         tckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716897500; x=1717502300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5wHYmhtoWY98TeI0p7eO1FyO2OdlloO6ZqlXOnVOhE=;
        b=gn0FHlt2k+ZgwGm1OapxAb8mtYRvWRn3oTeUKhOjj2/cSI8/Htiow+aKqz1iDYoGHJ
         h/WHhW49lW2YtBsBVLBUAk8cugOCVv9yomu98I+6YhnIfrcA3E0NJpmO3FpPtFGKmgza
         nDrYy4xn6fbE3mhZsQzvdIBYCP589hR2kM9ZM0vjUL0GCDIE4VyB9gA11VRoso81S0g0
         QU7WJAYMDDqScspGO9YhKjn0XDWw25JcrFQFQLBJ+92yK/kzg1j+VTATQpqwQ30firf1
         0DoIVl/PEXd6rAy9UZlE7vjlnZ0aRPGbxX+4j9GvA3xXlB/+dnL5zBqFDPgLjmfEbVGJ
         Y/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuBQlSVV1AM7vdV8QB8TL4slIUI/4esZY86dbYOGyA6X/2N8VlKpWr34joW8yIR3jVEf+NihvfC9FZBrx7uRP83zFoOrR+Uw==
X-Gm-Message-State: AOJu0Yw/1BKpt3kUayiWgMBQCXRjJqOtJ46xEjpAIFEcV0U35PWoZY33
	zvg94nhLeFpStshc2xjgOR3fu0SqnqZotVu/FneP+GV9iCOaXoO4VBk+bnMiQJg=
X-Google-Smtp-Source: AGHT+IF0fyhI2R9TN2s6m5gh6YhNKpLCo8nPbeu5BhtsrJGKmmezp2+rlQmJgrFmkgOVaXzjLLFOUQ==
X-Received: by 2002:a05:600c:458a:b0:41f:3ee0:a302 with SMTP id 5b1f17b1804b1-421089fea64mr85153135e9.30.1716897500277;
        Tue, 28 May 2024 04:58:20 -0700 (PDT)
Received: from [10.115.255.165] ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f15f66sm170021905e9.14.2024.05.28.04.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 04:58:19 -0700 (PDT)
Message-ID: <5472aa3d-6245-4bb8-afbf-ae4d702e7d29@sigma-star.at>
Date: Tue, 28 May 2024 13:58:18 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] xnthread_set_periodic: Improve period adjusting
 support
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
 <20240528070432.6669-2-david.oberhollenzer@sigma-star.at>
 <b22f524c-f1b3-4981-bb67-6f936b14e507@siemens.com>
 <fc1d19dc-49a5-4b66-91af-38889c8f32b4@siemens.com>
Content-Language: en-US
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
In-Reply-To: <fc1d19dc-49a5-4b66-91af-38889c8f32b4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/28/24 11:38, Jan Kiszka wrote:
> On 28.05.24 11:34, Jan Kiszka wrote:
>> On 28.05.24 09:01, David Oberhollenzer wrote:
>>> Currently, when a periodic task invokes xnthread_set_periodic() multiple
>>> times, the timer is reset each time. Consequently, the period drifts
>>> because the elapsed time is not taken into consideration.
>>>
>>> To improve the situation, this patch alters the behavior when idate
>>> is XN_INFINITE, to keep the current timeout value and alter the period
>>> only after the current period expires.
>>>
>>> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
>>> ---
>>>   kernel/cobalt/thread.c | 18 ++++++++++++------
>>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
>>> index cf3b4dbb0..de97b7e70 100644
>>> --- a/kernel/cobalt/thread.c
>>> +++ b/kernel/cobalt/thread.c
>>> @@ -1273,9 +1273,10 @@ EXPORT_SYMBOL_GPL(xnthread_unblock);
>>>    * point, expressed in nanoseconds. The affected thread will be
>>>    * delayed by the first call to xnthread_wait_period() until this
>>>    * point is reached. If @a idate is equal to XN_INFINITE, the first
>>> - * release point is set to @a period nanoseconds after the current
>>> - * date. In the latter case, @a timeout_mode is not considered and can
>>> - * have any valid value.
>>> + * release point is set to the end of the current period, or to
>>> + * @a period nanoseconds after the current date, if thread was not
>>> + * periodic before. For XN_INFINITE, @a timeout_mode is not considered
>>> + * and can have any valid value.
>>>    *
>>>    * @param timeout_mode The mode of the @a idate parameter. It can
>>>    * either be set to XN_ABSOLUTE or XN_REALTIME with @a idate different
>>> @@ -1336,9 +1337,14 @@ int xnthread_set_periodic(struct xnthread *thread, xnticks_t idate,
>>>   
>>>   	xntimer_set_affinity(&thread->ptimer, thread->sched);
>>>   
>>> -	if (idate == XN_INFINITE)
>>> -		xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
>>> -	else {
>>> +	if (idate == XN_INFINITE) {
>>> +		xnticks_t start = period;
>>> +
>>> +		if (xntimer_running_p(&thread->ptimer))
>>> +			start = __xntimer_get_timeout(&thread->ptimer);
>>> +
>>> +		xntimer_start(&thread->ptimer, start, period, XN_RELATIVE);
>>
>> Doesn't that mean that we skip over the next tick and fire only after
>> that one + the new period?
>>
>> | ........|...........|.................|
>> last      now         next              actual
>> tick                  old tick          next tick
>>                        (start)           (start+period)
>>

According to the documentation of xntimer_start(), the `value` argument specifies
the first time the timer fires ("The date of the initial timer shot"). Then, the
interval would be used after that ("used for reprogramming the next timer shot")?

So, to my understanding of the documentation, the timer should first fire
at "old tick", and then apply the new period?

At least that is the intention here, complete the current period with the current
interval value, then switch over to the new one.

> 
> And you also need to update the documentation of rtdm_task_set_period, no?
> 

Ah, yes, I must have missed the mention of that case in MIGRATION.adoc

Thanks,

David
