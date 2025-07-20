Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F512116E9
	for <xenomai@lists.linux.dev>; Sun, 20 Jul 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753020853; cv=none; b=N4ScODls/0zeJWAPnIgTykJmg0UzXGcrofvcyDAJV7g3yfq/a8LLvNLfnSGB1TBdtJzOSF0NCI8Ss909JVKtUaXqrfFZkDBccsouWFq8suIJ4vPhhbdG6824r0otjczdfHRga9crr7UKx25lTNQ6oy3Z+JkMbadvSM35THYoh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753020853; c=relaxed/simple;
	bh=8fJOUAIEenDSCmsEyX2klf6+YBBGlucWiU8DgSh5txA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttRj6jUlZshvQ8bCnLHosvzltFbHQfMvCLGSoXdMh2S5dCSlPjyceY6Ekv6HtXTvncR5gj310ZVPK/fEFT6qux7y3uFsu00KbxIWGgZr3vthynR+Iu+DRhzk12BpqjxwjrCBIRYsbNzxmQ762NOpJhJwfy+AdCtjqv0CxWItgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wufacey5; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wufacey5"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 4670443C73
	for <xenomai@lists.linux.dev>; Sun, 20 Jul 2025 14:14:09 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 59DF8D802AD
	for <xenomai@xenomai.org>; Sun, 20 Jul 2025 14:14:08 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-235d6de331fso40130675ad.3
        for <xenomai@xenomai.org>; Sun, 20 Jul 2025 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753020847; x=1753625647; darn=xenomai.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SUZ9fAd/jKoN2z1U9ITSVu3m7mVefyzd3SRlTNgAhZo=;
        b=Wufacey5ORSlJNNPrnJlZrv+hzhPANRYdQt/2Ten9Tf52Fkj8kv78oLt6JCaGpRGuU
         k1hmru1aEfjrg8LZyNcbBldZofWmC09lMOWdBcG4uW4akIMVYkxfViiAleMmi8ELhLa7
         7CBTzyRAbVVvxzAQRWLKBMcIjIW7aJpCAl4ZE2nrJmWJiQnDYoiblXuPobJUtDrBSoQC
         vN2rV0B469pSUHCjSPvvK5F134SQxiwBZl3d7CgAAMhcQ8XYxjJhSd2PIENJfCq0op1D
         2ECrg+8F4eXUHtqBS4Hdf3zNIM4+S2D7OnJPmbYyOmiZw0LYQGZw0/udvUgLQR/bfl0l
         zjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753020847; x=1753625647;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUZ9fAd/jKoN2z1U9ITSVu3m7mVefyzd3SRlTNgAhZo=;
        b=Nia6Q6AFS7i7Tfi0u093ZhhHRGSw8yInSrE8XBZYu5UvAQP1bR/MRi6aQWz5ZcDMCo
         dpDjFEEWh0C7aVeBB1OomirYOarbU7MnpPyoMwUvgUQOjKEg3K1XPmh8cadwbFEs2AGd
         ojyMkqtfchtuqzbm0hztA+N1Sg9tLu37uRJ9m2dbwBUjEFvDVUtuXSqbRw9/Hui1F5dp
         4NAh1zV2CaFFunc9coMrDa7P3Ts/Scizkxd2jBRSlT3hl6UWCk/oLaFzbM6pW0RcWJqP
         FpqasCwfiLU8avp6KgEvu4OeqsiGGLxU9R3ZSWQD/sl523Yr8t1lsvHh+TNQWbthNX1E
         jwhg==
X-Forwarded-Encrypted: i=1; AJvYcCV7TfOXsvoRsyu0cX4KyBFPlq50UNuC79LbORQ3eMyH1mxv8B3G624oGMVBSiERHjFFv3s7Dzso@xenomai.org
X-Gm-Message-State: AOJu0YxXrxZ7Rw+vrrhwVlbRUupMhMRIF54GIBEvQYDG4BZHKESZtkGi
	6Q+6Hrx3BpA19g5/JlQUuFAkaqZBpCvKgCVvNifoaLyD4MW/VQuasM9d
X-Gm-Gg: ASbGncufLB8NRJgbmgj5lYFhu/n8fh+bF6q/Jmb0XofuHn9Ab5ca+52EN/LpiYk5zYA
	fwJ0OL0pumEREZKH1x0DQ9AhwhrkJOl4Ug05R+rYI9K/GRhTGS3IisXHMF78NmXakc1vKx2q//Z
	pTbpRmZmAuCI10c/wISZwRkcVWqCKfPaq/mpWVYg6PkUQYRWvkXIR6cJMAgsaBT9gtVsPgUbX8K
	Rbo5zEjR8gIttaJWHxaYtP+6cqHnN7nnVi0Ia9FeltNohQBtjzZyWbQ8hsfS5QlgxjZF4pG1iCU
	xIceza4zHI4DP7Fcp8+wQ4/ysiPE1mbobOiK2pG7LIG5u/EIuoWKJwbFnvaLdSBGUklcWDWcaLR
	Fkq7QjBYXQCx9NG5Yrk1aCvW63Ysl+dpcDFMNOQgYChDNWva1ViyAM8xiBBAkDqe6RL1XmBM=
X-Google-Smtp-Source: AGHT+IFEsXpmibKhv9OcsCHJWLBqzsVVpiWtUvAsIarTOPapcvHdoz2VIm2unOzCusnJMy6hvNEkDw==
X-Received: by 2002:a17:902:ebcb:b0:234:f200:51a1 with SMTP id d9443c01a7336-23e2566a7bfmr216292175ad.9.1753020846640;
        Sun, 20 Jul 2025 07:14:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3c3b2c4esm41825935ad.189.2025.07.20.07.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 07:14:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cae6517d-9580-424b-8d1d-c9bfcdffb73c@roeck-us.net>
Date: Sun, 20 Jul 2025 07:14:03 -0700
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
To: Thomas Gleixner <tglx@linutronix.de>, Phil Auld <pauld@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Henning Schild <henning.schild@siemens.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, xenomai@xenomai.org,
 guocai.he.cn@windriver.com
References: <20190729101349.GX31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net>
 <20190729205059.GA1127@roeck-us.net>
 <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
 <20190816193208.GA29478@roeck-us.net>
 <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
 <20210727100018.19d61165@md1za8fc.ad001.siemens.net>
 <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com> <8734mg92pt.ffs@tglx>
 <20250709134401.GA675435@lorien.usersys.redhat.com> <87frervq1o.ffs@tglx>
 <87a54zuojn.ffs@tglx>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <87a54zuojn.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of groeck7@gmail.com designates 2607:f8b0:4864:20::62c as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeileegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepshfkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepifhuvghnthgvrhcutfhovggtkhcuoehlihhnuhigsehrohgvtghkqdhushdrnhgvtheqnecuggftrfgrthhtvghrnhepfeekffejtdegffelgefhjeejvdetleevheeiffejheevueehueefudfhtdeludeunecukfhppedvudejrdejtddrudejkedrvddugedpvdeitddtmedujedttdemvgefvddumeeivdhftdemuggrgeefmegrvghffhemfhgvtggtmegsfhguheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddugedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehgrhhovggtkhejsehgmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On 7/20/25 03:47, Thomas Gleixner wrote:
> On Sat, Jul 19 2025 at 23:17, Thomas Gleixner wrote:
>> On Wed, Jul 09 2025 at 09:44, Phil Auld wrote:
>>> Hi Thomas,
>>>
>>> On Tue, Sep 03, 2024 at 05:27:58PM +0200 Thomas Gleixner wrote:
>>>> On Tue, Jul 27 2021 at 10:46, Jan Kiszka wrote:
>>>>
>>>> Picking up this dead thread again.
>>>
>>> Necro-ing this again...
>>>
>>> I keep getting occasional reports of this case. Unfortunately
>>> though, I've never been able to reproduce it myself.
>>>
>>> Did the below patch ever go anywhere?
>>
>> Nope. Guocai said it does not work and I have no reproducer either to
>> actually look at it deeper and there was further debug data provided.
> 
> Obviously:
> 
>          no further debug data was provided, so I can only tap in the
>          dark.
> 

FWIW, I have not seen this problem for a long time. I know it existed in
5.10, and I can find logs showing the problem in my company's bug system,
but only for 5.10 and older kernels. I don't see it in my test system either,
not even for 5.4.y or 5.10.y kernels.

Guenter

