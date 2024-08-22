Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85517A584
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326720; cv=none; b=QEez4UWjPrMJtCXZGoakg0x9DbhIBXd84lOg8ZBpmLLTyhUV63PKscAoci1pPKfxQZj2ewNSB3/fszs2nE6msAmXTZUZEhQrw/KV6wVstoKhg6Wk15NQfp+oZ8r0MxcDFjiuiWAVGD1g9uGmqKisW3B2rbPn3aJEQLek29p+n6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326720; c=relaxed/simple;
	bh=zsPrS1KAG7nGDW+xaZUrAkbSgtEib0RQQcCOXWP5Lys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guNt+lEDteBWsl5urCLAbRapYAVjMGxr9yUbNsrts7FDoof3Hj510m+pUmA/ud+xUAfPdMqnq/hGQZwkiKUwJe46UNhxLmAnRNC5Dyr0TcISrQ/xctBr+FfmDsA0orlhkaG13znHmK3QCGSWdGuEZVP5YgT8JA1HM9naL4pyRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=gi++51RG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="gi++51RG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42ab880b73eso5144095e9.0
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724326716; x=1724931516; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u55Cxz+a3DPZVMRsytnVLn2H68zKKVVQIg0xOM8tTGs=;
        b=gi++51RGOMKKAtKEhtqfcErrNcLVnwcIST7tjTSEdFtGUFpJSUMaTzeiQiv2sVSqSN
         UPIPzLfNxZmEnVuOH5/y7xlaHNp5ZyhBc15sDmDgfcOPI5BzKiWBP4UphMvksTsnM7cR
         +H5sXRTlriU7QGvTaGJCosDZaImDZJEHjNicKg0u3u7x0Lag/riw89/xLquswYGkd4dS
         e8boZw+eAW6pbXqhf4bVVBt4cRCd4z3o7DNweq9KZMoFdKYTpjV1Nr82gimk3QxHcbGr
         +VGRgfkLb9s7NuJsm7NrcRChJ066+euwt/VsThgCMGuSDWCM04yfzBmReHLj/OtIGK7O
         Et3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724326716; x=1724931516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u55Cxz+a3DPZVMRsytnVLn2H68zKKVVQIg0xOM8tTGs=;
        b=xUXUazb0IyYM+se2LEKMt908hJq4XeURY1R9FiICGEA+dw2xjTRqOxW3VjtrAaUl80
         f1pk/UnscayepSCQrDMSr1bblHZQLkipPfJVz3H+jvptaNG6Vta0RcnpPEuKCa54J8ZG
         c+FffUnROTMvUnJ7+AFIZdORpgFEuVoqLNBMWGXGCg2ND/gTXlvdWUIOdimNkYpaEzhz
         CpBvRjFGj0Kxtedye0E4CEo/a8u4xSlSCSHAY5jDLX6rHhYFqu3ZUSEBkIMFjBwguSYs
         S/WNzsT/2td2hCidUVBXovr5o6LeqUqTm+Jcd2Vs3RnT3wBojui6Pf2qBD4WOi9ffm+b
         oDvg==
X-Forwarded-Encrypted: i=1; AJvYcCWgM6csEPAfsMfsM9UMvO/XbjTbTthx50/SCCG2fnV1jFTrC3n4W/82wJc2U3uiSLn3io0jxGCD@lists.linux.dev
X-Gm-Message-State: AOJu0YxB7hEygHLHtG6oWWKhHndxFFr4dYM0PL4qreNdMVZ9LwENx3CF
	MWKe8D8cllIIY9I9df78IG5/4lCMAyPCYTWllfPYx5vv9d+cv0Ql3iU0dvv9a8Y=
X-Google-Smtp-Source: AGHT+IGZF0BNltuTgIhJHQr0/JuqA1lmFIdP9TnC75TI5W5zvkvwX6brjH1b0tcZWTGVmMMT/Y/0iQ==
X-Received: by 2002:a05:600c:4584:b0:426:6551:3174 with SMTP id 5b1f17b1804b1-42abd2458fcmr44248225e9.29.1724326715557;
        Thu, 22 Aug 2024 04:38:35 -0700 (PDT)
Received: from [172.16.0.149] ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac517a65dsm21525805e9.34.2024.08.22.04.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 04:38:35 -0700 (PDT)
Message-ID: <391fa4c5-e9c1-4a68-9553-672010341cc1@sigma-star.at>
Date: Thu, 22 Aug 2024 13:38:33 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib/copperplate: Get session name from env var
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240822080737.17939-1-simon.graber@sigma-star.at>
 <20240822080737.17939-2-simon.graber@sigma-star.at>
 <4b024ebb-7d6f-4382-8427-f16024d2b387@siemens.com>
Content-Language: en-US
From: Simon <simon.graber@sigma-star.at>
In-Reply-To: <4b024ebb-7d6f-4382-8427-f16024d2b387@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/22/24 12:51, Jan Kiszka wrote:
> On 22.08.24 10:07, Simon Graber wrote:
>> At present, for two Xenomai processes to share resources, they must
>> be started with identical --session= parameters.
>> This is cumbersome for extensive projects involving numerous helper
>> processes. This commit allows the specification of the session name
>> via a global environment variable, namely XENO_SESSION_NAME.
>> The --session= parameter overrules the environment variable.
> Hmm, did we discuss priorities already, and did I say that this ordering
> would be best? Then I'm no longer that sure, and my feeling is rather
> that env should overrule command line. Still looking for other examples,
> though.
>
>> Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
>> ---
>>   lib/copperplate/init.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/copperplate/init.c b/lib/copperplate/init.c
>> index 16fc59f..e695c52 100644
>> --- a/lib/copperplate/init.c
>> +++ b/lib/copperplate/init.c
>> @@ -114,19 +114,28 @@ static int get_session_root(int *regflags_r)
>>   {
>>   	char *sessdir, *session;
>>   	struct passwd *pw;
>> +	char *sn_env;
>>   	int ret;
>>   
>>   	pw = getpwuid(geteuid());
>>   	if (pw == NULL)
>>   		return -errno;
>>   
>> +	sn_env = getenv("XENO_SESSION_NAME");
> Why fetching sn_env uncondtionally?

Right, that's only needed in one branch.

I'll include this in v2 once I know whether args or env should take 
priority.

