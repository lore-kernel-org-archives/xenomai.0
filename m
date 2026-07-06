Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949421638D
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372897; cv=none; b=jkoKH6QOMrwF6ZqHaX88V4YzWTQZtyKpbw/ZlKe96pUR3MOr6ms8QhCrTQ+fyU6lVJK4rCIfElb7mWtDha86awRnwwLob1yJYCrXYUftv0hNMRGvU7xxfJbvDoGj9ifWe60AvISNg8NekB4m2mqvAR+Y23E7a+YMsYE3k3RYlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372897; c=relaxed/simple;
	bh=nCndE9toDoxWuiTLFsjPIZhez74dTqdkz9xanUDX9JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4e0HpQ3xhgRO648bnE5TFP/x5TjUgXm+TgKx4Tp56kb2IN/YP+l+Qg/N9+97/IyG/70uZQycmTHKP6sbVOeXYFh2bCk1NEcFaVewTsA+Dva32WI051xrIfTO4lFUQkHkoOGEUNqjfuLyd2ocTKIMzYZYg74Qksw2aKPNRVwKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBqWHiD1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBqWHiD1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b691cb44so25115215e9.0
        for <xenomai@lists.linux.dev>; Mon, 06 Jul 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783372894; x=1783977694; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7M830ZKfy/uKnQqJH401DLoUe31wEN1pru4wfsWHLU=;
        b=IBqWHiD1Wgv8DyiiKvQfDanVK0Aj7p3Zv2rg29BbDnKKj2MtU5mAMkdlI14LKVB/o8
         yNJYhJYTLs51+SkcV+vnrnGI4JXfJe75HLjlBKbag3rkLvX7DUEfXiEakkifrKSDXXzU
         GBI1eREdC+ENuXAvaTiK1ZeRMh1P5JaHmP0wHWvuzRh7iJeWv5RVYTI13tH+9eqa5J+T
         3A7JpwX7FF4J4OOylkzss8AnJ0npV+AS2FNB9iQWWud1WsgRNeOK2Q5p2UYK0QDyLj8I
         NPeHZbUruKjOHoC3HT5I4YNxyruYxxqlqoZtOjiGS2FVXItBuxCQ0Rrf8fnh6rG4jPI+
         AUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783372894; x=1783977694;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F7M830ZKfy/uKnQqJH401DLoUe31wEN1pru4wfsWHLU=;
        b=kJ+bh40DEqYxAxlhYdisc9ZDMiTDUWD5kXJIyXpjumqWhOftrQRGECVPLEuh39ZkT2
         KfYt0D1TxIrTq3bdV/5SOfmCzhoLEsbRlBP2XHcCHKNjNZ4qOSbpadi/7V1AhzDLUQzG
         ZEbZzlDbCUHExO/G5khBWFCrZ0ggICJ+WwtW9jWwA9wukAloJ11QZnTbL/9aoxySAlTS
         fYutvYfVPn25/A5Bxg3fFGVeCoBOUxCb0igSIFotUs259PsPfsLzxnPAWWZ1VRG8uCx3
         jWXs4Gb4/Sd9TUWdiLPlKQmGC9YdxMR2BTuNI6q5E7i+1cz2UVOCPiPARtLLhV2KM0r6
         6U3A==
X-Gm-Message-State: AOJu0Yy19iZH2k4nf99nNXnOjh49+3NAftFfkN8QDeCk6pCHO8VJPsHU
	6ac+fqIRaxRn+XnWh5kngOSQdFbdfRa71Qn5tDP3STCkHCz6VHfaOWfe
X-Gm-Gg: AfdE7clXovkE9/KFQVWrD20wQV5vJ7WnsxjsDERcK/IggDIYZU0YtjZcqIWVr3z71Hr
	75Rt3E4+UxMCfwoozy2UwuxTk9M/HkvxtjCV4clccId3KNbRuPBlY4sGlEN5O7kpu+t1ehoU/i6
	4MByseQ/u/mwWDiw98GNroOCxVx1XYRuyUa78rT0pPwU6DveFBMETxD7IOG0fiaveSikvkNjZXg
	LYv4hUvjkvX9nmD2oAMnaDhrnhvzWe1mERupZYxsOycFXei+eAAsBotRddCHLgn2uiiGOHpA02R
	S/Ny7gUr9o9bV3lGwTdrs6Yfmpj3aXnQQqYCrfbeNrKc8m0BZocKGFwocV6UwSEK4QNR1SCJbF6
	uD4773bJJ5pvJY0TDt5FoXIzXTmjEyMWANhYQUvemMcrvBOBzUp32cY9+k+4ir7aP+n9uYOSI4D
	a9gOUsmQ7qd/pqzYY92ivt
X-Received: by 2002:a05:600c:3e1b:b0:493:bd66:3efb with SMTP id 5b1f17b1804b1-493df09601dmr23164705e9.29.1783372893965;
        Mon, 06 Jul 2026 14:21:33 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0fbd355sm727595e9.13.2026.07.06.14.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 14:21:33 -0700 (PDT)
Message-ID: <8713503f-ec2c-4b87-a07c-708b2bf4b159@gmail.com>
Date: Mon, 6 Jul 2026 23:21:32 +0200
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
 <593465e6-53c2-4f54-8d4f-745b028ff289@gmail.com> <871pdhs7tf.fsf@xenomai.org>
 <87jyr8r79l.fsf@xenomai.org>
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87jyr8r79l.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 06.07.26 um 07:56 schrieb Philippe Gerum:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>
>>> Am 05.07.26 um 17:06 schrieb Philippe Gerum:
>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>
>>>>> - With the good version, I tested ~1M packages, all fine, max 60 us
>>>>> response time on the real PC
>>>> You mean 60us for the overall round-trip time between two
>>>> evl-enabled
>>>> targets in full/end-to-end oob mode?
>>>>
>>>
>>> That's between an evl-enabled host and an FPGA board as a target[1]
>>> directly connected with 100M Ethernet and an Intel I350 after some
>>> heavy tuning. Most tuning was done for PREEMT_RT. I have to test what
>>> is really needed for Xenomai4 and what can be dropped.
>>>
>>> I don't have two PC's to test (yet).
>>>
>>> https://store.mesanet.com/index.php?route=product/product&product_id=374
>>
>> Ok, thanks for the information. Meanwhile, I found the culprit. Now I
>> have to figure out why I did that. Oh, well..
>>
>> commit a793acf3cab9a608d70a39d740f04c6a6a1ec77c
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Tue May 26 10:16:44 2026 +0200
>>
>>      evl/net: packet: forward status of ETH_P_ALL delivery
> 
> Fixed by #bb06b3a8f100.
> 

Thanks, tested and it works.
