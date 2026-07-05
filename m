Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E51433E7A
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264661; cv=none; b=Inngm4OItXzG0ocnQPncjJcsTlW2BOUwQMBcgnx2PFRe8KoV74Ohe+uqohiwfdrPO0AE9UjI+/5KfP+iR/leuvJi1ZStYks6nnh/Vj4/M+QM8Led7hkYM1ZgtUYG1Q5f5Mm2737SAzjiO/lMa8POenXHPpzzaboY+I7KOe9BkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264661; c=relaxed/simple;
	bh=Ko3LsIq1V0+iFcmCOF0OBpxQuF0VYKwFyLRZgLNpL9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9aMhzgJ19ydS5UdSKJlHgRyqJHyFXAhU97GKVBE0BHybrJdTJlBqNlexfzvc1jwXmCE17N4A0mGW7zp3edZoE+AWiPKhE64CB7vJYDcmRbJ7nzRDA5HbUxlw5kNYAEJ37zna5X3o7hGV+7U/bWiq6/3OpBhZCM49PrHS1ow10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUVUwUHb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUVUwUHb"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1823154f8f.3
        for <xenomai@lists.linux.dev>; Sun, 05 Jul 2026 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783264658; x=1783869458; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A18NW4JDvYcBBfviaBOta9HHvl2cU4S6YdyNlpF4ev0=;
        b=kUVUwUHbUu1hUzfPecp8RSk7NLYabusjtuSSNXd/1J8rQDXkmqiiP3AMVjLVSV7aSK
         ORgIuzdyJegldJf4d/M8UPp/TTzB0gsV0uF5ndZ9IzCHU9l0oszFYheuDp8s+cMWI/Z1
         iyZAAIivMwHrlXBybMYnlaIQFSAjtc+coiYG/LKVi4UVKesHbR155hRkGzitSfbEvQVy
         384WbUR2eVWRBKg/ummgB7CClPa6Q0RxYNBC7LeFcIHUub3b2/nCLpIb4gn7sacaaikI
         esaeM1RuIJP3on6EWwVs7MvKpMrvu/x1LrRKYo8Ee0wAZFhkAeXV7PQ2VVUxluIFrqB9
         L3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783264658; x=1783869458;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A18NW4JDvYcBBfviaBOta9HHvl2cU4S6YdyNlpF4ev0=;
        b=UoVm6HP0jvdWCVgSfkfgmuCmriBHlsvvctndsxY7eY46zIkJktBwMyRAKCw1lg8UIn
         zq4GGUrkXS+nXiEysunUYqV0d4qbmo1wj1t8cJiNmN4yEt+3ZVnWqyakULJlL1o/Q/hW
         H8DTPzOQs9QwYyk7cFiRwhq13CryhYaMY9nFNbKrH8XejK01nDmXAn5qTqdvMwGToHas
         IEQsayNe06H1ed3yxxv4+KiNuaEf2SCVmXJ+4IC54he4nw+6cQjCviz8AAHzYKvS8GYz
         Gn6S85XOD4MXNWbukn3YcImIiqY3WfNwMbvjlvStZ5GlmqAFWjjFTqSCyIx/eKsXGu3Z
         QV5g==
X-Gm-Message-State: AOJu0Yx520qhfFqLsw26NJEwBOcMAkYRyrofqOm2Q9HYLXMsOJfLQ5MA
	xAFRXw1FxFJHDPEDSO6Qd/VSEx03WIvOPCoyposbtOualhDROqFXODmKe3z8gw==
X-Gm-Gg: AfdE7cntG9jYijy2FQe8gpZ6zFe4Rq6GtpKsjE78o6j67L65RpL1KxRBSB0QyHovbhd
	k1dQOLkmZlHGAsWaFFBTnHJwgRx8VNKwdbtC7b0ik/j+0JF3wCul1Rjo59bXn7TmfIuXxELbtmr
	1nUAvcLjJygwmZGpif+LzW9j98ByF9/TzfQXwJVGc/nOg1MQW0HKqe4F9hHww8/d4l9QYLAm2/W
	nrpzIrk0O5tA4HWSFpkA7iPkvxwHU4Vjy2oMSHLYBcFxsxMgoAVntpUq7nleDSOHn21vqrSlitQ
	7BRdbILdziBj32WEehIIQWIJXHpDOcrH7xRLHsWExr0cg94QlLlzIugXB77rjiQxCk9smSEzkFI
	k9hshNeQ7N+HAH78vlDi4/jLcQ3t1AUJQg34NbqnfqROqd+ILuSP7xKyhsj2QFf9icXhO0t2PdF
	E5a8qKBZwB+3pwHSeHa0sHt9WSWD8tBpk=
X-Received: by 2002:adf:e003:0:20b0:474:2929:474c with SMTP id ffacd0b85a97d-47aad6434a9mr5348359f8f.36.1783264658316;
        Sun, 05 Jul 2026 08:17:38 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm15091125f8f.34.2026.07.05.08.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 08:17:37 -0700 (PDT)
Message-ID: <593465e6-53c2-4f54-8d4f-745b028ff289@gmail.com>
Date: Sun, 5 Jul 2026 17:17:37 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EVL: Kernel WARNING
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <c88ccba0-23fd-4f4c-a182-0967e79adefb@gmail.com>
 <b5821b4e-cfd9-4255-ac8f-3de55a788d1c@gmail.com> <87h5mdmq6w.fsf@xenomai.org>
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87h5mdmq6w.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 05.07.26 um 17:06 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> - With the good version, I tested ~1M packages, all fine, max 60 us
>> response time on the real PC
> 
> You mean 60us for the overall round-trip time between two evl-enabled
> targets in full/end-to-end oob mode?
> 

That's between an evl-enabled host and an FPGA board as a target[1]
directly connected with 100M Ethernet and an Intel I350 after some
heavy tuning. Most tuning was done for PREEMT_RT. I have to test what
is really needed for Xenomai4 and what can be dropped.

I don't have two PC's to test (yet).

https://store.mesanet.com/index.php?route=product/product&product_id=374
