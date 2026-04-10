Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A7343D7F
	for <xenomai@lists.linux.dev>; Fri, 10 Apr 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862606; cv=none; b=eQ+xl1KWFhwHusRgZSDr3uqWcDiCLTQbnXYpqxUBqucudWYkaed61kA/eAAQKreg16DXG3ceF0fuEcNZobv+3n56Ssj3giN+msC/KKLQd2ONzWO/XPVPp0e0ijYvJa+J3zmzLd96zVK7jZs0WeyJIcwWxnL56WWnoTWkIX0p+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862606; c=relaxed/simple;
	bh=R37gN+38hytIurLeCcWcY0ZWkrripDujDCh11aRMoMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fKTHQFV7ZWaiE0piwlM4PWd/vJBm3beIPe1u50J9s/U0YiBMmDKab0a1ntOKGurCXsQxYTDXZtxSijxbPvUHTwEAGH57N8xbHr2nj982B3yJQJIHmVx8JCO8OU0l03F5w0YChnzjLN8RsP3YcctfxOaPQeh4OUncLL2JOAJyj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z85AVR1c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z85AVR1c"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso14256235e9.0
        for <xenomai@lists.linux.dev>; Fri, 10 Apr 2026 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775862603; x=1776467403; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=llEfObjG1LH5gHgZqILSDqrfpdu401iVChTNKfkAMbo=;
        b=Z85AVR1c0Myd2Q/1IcmN7J9D32z7j3XcQIi71zVDvmazHxjPcbFVIx06rmK/4iu837
         BGLmbh2bY3CmqvyN41zPTKNgR/5ZF+qF6HNbcL1g3XzmkfS2xFjhXX++KR1MmViS3vrj
         EKQXOxTVp/aVcKBK5+tbP3OZ1QtnBk/LqqjLWVeAPQ4g3fhMOg+DAcYIqRmWnPYF1Ad4
         m2rqJ6GznNsyA7b6nBacMbMyeH6c3b3SoV07x4GChIbLXQrkLw+pLg5M/1N+E3lf9YWP
         H5oZWKMTy7roZJSs+IV7v5PUDRya3KXMC2bbrvecdhNmB8pFcbqPD86qSWZi7TSSSwg9
         OzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775862603; x=1776467403;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llEfObjG1LH5gHgZqILSDqrfpdu401iVChTNKfkAMbo=;
        b=aZSvrCpBwU3z04dDNhH+/PfgpTvgJChitwt4SYlnFdGkkPgRP9hseKN7xBjduBdNn6
         si96eIofpaOgxcq5wcPNfGX0HYIyo1M+saavsSoFZ5OLewv+FuOFgfsolGiNAuRZu7Zg
         tCSSTNlyRK2sRdTqpXXYQ/u23Uv10M+XCMBPWACBVp1C1nvhgdw8yq0INDZGqAxPgVBI
         K5BzhJmt/0J66Uw6n8Ar2acJ3y/Igo8WbX3VYvHuTxQ5R78/tu1d6uVVoSLXLbHXoGRM
         7IGNJkAvUwwn7iyQCpR/au4+ryexYDH1C0APpu9NfO7A59nlrclitFdreOozOMlCncxO
         njBg==
X-Forwarded-Encrypted: i=1; AJvYcCUlrQUVCYr9SJQf7q9voPPWAtpPJb1XmPelJrnJTbP4YWqCTSa3j7ir1zyc71v3hXYot7Wr7ei0@lists.linux.dev
X-Gm-Message-State: AOJu0YwT2B1JAbcXTzwgIbUQmKMMsXCghoMg7TQYxLC5nUNh3i2E70yi
	+UZ6ha1md4HC8wAWOhTedz/zfr+6zNyXys6svHN9z7nC7RldeoUz60qa
X-Gm-Gg: AeBDievDSNFUJM3nIhPxjMk29QVzelxzeyJwLNaBM6TJfqwpbxbtxWI77/iFK3Htavl
	zXAzOHKdzxrxxQ5Zm4z8XeKWP7Fr1LEhSSP7sXGVAAaOiiMFXNJrfnzpxO3H0V+TKxdPeL3smhV
	KaXkK0UnNJNsHyqcJ2e9idx3Q+pGfOEdBK6TrNaHckjcY8xuZg29nFbooVRHFeijzXMgARi1Ayc
	G82jfEeMVqQJ5XcK9t1xmmPCgBMdyZrZj7pDC11ItLrGFwG+GrMRNrbwPaNHM6bW5Bl3ah5it1d
	ecwaajq+yA/RhzK5FTNncPyljuHCuknCUPwasenP9Wm3B6VEwHv7jxgmwEKbKWTGF5LZg0uTrcI
	WFghSzKkicik1GxmteLCykgISlFlGqK+SoKEi/IKrRU8k8K9z9MlqDfnW9a96Q6HDbHjOmz7H2l
	ZBp8gr6KWQVVdJbG2Yf0ONrPkYBbek9l8=
X-Received: by 2002:a05:600d:d:b0:485:4eaf:eb54 with SMTP id 5b1f17b1804b1-488d684b88amr51218075e9.20.1775862602919;
        Fri, 10 Apr 2026 16:10:02 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a74sm11626375f8f.3.2026.04.10.16.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 16:10:02 -0700 (PDT)
Message-ID: <c1579ac9-c67e-42f0-a50c-062ce76666eb@gmail.com>
Date: Sat, 11 Apr 2026 01:10:01 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix memcpy WARNING in kernel
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <b3a7cb51-870c-4856-86a9-f8714aa09e6a@gmail.com>
 <989b39fccc6fb102ddc938bbae87f476b2eced11.camel@siemens.com>
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: de-CH
In-Reply-To: <989b39fccc6fb102ddc938bbae87f476b2eced11.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.04.26 um 23:14 schrieb Florian Bezdeka:
> Hi Hannes,
> 
> On Fri, 2026-04-10 at 22:21 +0200, Hannes Diethelm wrote:
>> Related to https://lore.kernel.org/xenomai/f10afb4e-2aaf-4a3a-8bc7-893c1a09cdd1@siemens.com/T/#t I try my first
>> patch submit on a mailing list. I hope this is all right.
>>
>>   From 34d65bcc3343b5323f19cd73561bf39d2652481c Mon Sep 17 00:00:00 2001
>> From: Hannes Diethelm <hannes.diethelm@gmail.com>
>> Date: Fri, 10 Apr 2026 21:56:16 +0200
>> Subject: [PATCH] Fix memcpy WARNING in kernel
> 
> Close... Looks like you copied the file content of the generated .patch
> file into your mail client.
> 
> Just send the patch using git send-email [1] or remove the lines above.
> In case you like some more tooling around patch submission you might
> have a look at b4 [2] , which can be used easily for Xenomai as the
> mailing list is hosted on lore.kernel.org.
> 
> All of that might be fixed on merge by Jan, but maybe you want to give
> it a second try as there is one possible improvement:
> 
> Proposal for the v2 patch/mail subject:
> 
> drivers/net/stack: Migrate struct rt_proc_call to flexible array member
> 
> Proposal for To, Cc:
> The patch made it to the list, all good, feel free to add the Maintainer
> (=Jan) to To or Cc.

Thanks. I allready found git-send-email but I it looked a bit complicated, so I followed the guide
on Thunderbird in git-format-patch. However, what I did not figured out is how to give additional context. But I have
to admit, I did not read all of the man pages, it's a lot.

As I have seen now on [1], you use the ‘Link:’ tag.
This would be added in the git commit message, right?

However, due to Jan already responded to my last mail, I think this is not needed.

Now I got git send-email working with [2], patch will follow soon. b4 seams to be a bit overkill right now but I will
look into it.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html
[2] https://billauer.se/blog/2022/10/git-send-email-with-oauth2-gmail/

> 
> Thanks for your contribution!
> 
> Best regards,
> Florian
> 
> [1] https://git-scm.com/docs/git-send-email
> [2] https://b4.docs.kernel.org/en/latest/
> 
>>
>> Warning was:
>> memcpy: detected field-spanning write (size 80) of single field "call->priv_data" at drivers/xenomai/net/stack/rtnet_rtpc.c:93 (size 0)
>>
>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>> ---
>>    kernel/drivers/net/stack/include/rtnet_rtpc.h | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/drivers/net/stack/include/rtnet_rtpc.h b/kernel/drivers/net/stack/include/rtnet_rtpc.h
>> index 01d7ab152..f4ad47306 100644
>> --- a/kernel/drivers/net/stack/include/rtnet_rtpc.h
>> +++ b/kernel/drivers/net/stack/include/rtnet_rtpc.h
>> @@ -43,7 +43,7 @@ struct rt_proc_call {
>>    	atomic_t ref_count;
>>    	wait_queue_head_t call_wq;
>>    	rtpc_cleanup_proc cleanup_handler;
>> -	char priv_data[0] __attribute__((aligned(8)));
>> +	char priv_data[] __attribute__((aligned(8)));
>>    };
>>    
>>    #define CALL_PENDING 1000 /* result value for blocked calls */
>> -- 
>> 2.47.3

