Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06C8389DE0
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264866; cv=none; b=DWEsMlBmgWTl1El+9h/fjjGA46C58qsZzojhK8OHRxJvqalmqHSu9B62BMIX3wtis23ELukHgLiLsKToT99uaK4PWoRcIB2r2KJUGKOXbSr6gKK2EaZT8pjwwTNrQCzLtbgJnlBuH++I4e0I9XI94nnjdwWCQyul27IoHpCh+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264866; c=relaxed/simple;
	bh=oQg1R7+zwch0MowZ5DFdLIKbejlJNghsjyHgC1V8Rcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGEJpapRSG+qkEoYRN7A0y0wPItZRZBVQ5m4l/qjvj+l1Rx6BBOtDBwP9RrqwliQlYtc2JzdPNCwqHWQl7iz1ePSTzenqC/9J9iHkkYETBC8aDI3Ob4eTcTnSKcglYlGCW0w5RR/vzOaGWfkl80HXZqWb2scyRGlecRoLP7HXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACPWDQII; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACPWDQII"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-476d8e647e9so1859722f8f.0
        for <xenomai@lists.linux.dev>; Sun, 05 Jul 2026 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783264863; x=1783869663; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvSktOwx1VRYprKLjRTtI5n4WEU3DY0WlZFUsfkt1o8=;
        b=ACPWDQIIDxsprhmzRRHkh2i1Z65LmLdAMRqAE+oiKrKS3v6ePOZnli1sh8C/8Se/nH
         9Ecq7EmU5Edju2pRUj/RvoO/oZpTUqcHMHvnuoNFmPhc7wdqngCoLqgC10Bfo8uv1nEe
         2jifN4s2EYGzV5hxrEqnunWqVUVh3A3UUNC9cro+nuUH1BuZPAqTOKYS/GNmDhNShln0
         PRiye5hmaUsccG/nX+Qat4ettuYL/LM/aABIj4ClBRzGtd3k17sbQtd2qS5bh5PSSRa6
         n2ORmHDgBeOKSo1cWPpET9btvdlz9pzX994FdkLcbNFimRQhma6FnL8qt6lOqdWADPm+
         lWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783264863; x=1783869663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvSktOwx1VRYprKLjRTtI5n4WEU3DY0WlZFUsfkt1o8=;
        b=sUR/KP0GCZ0YNqiKWFdGq2u3zjJTTLGE8nDRcHe5CfR4nizNlnz5eMd2RN2AslLT3I
         LlGdWpfjcMQ+hLaAOPp6RDi513S7PDZGyRv5XRVLr3NFZFE8GGPT7zgHypt9NLnsD/GL
         xVI2hVxrujo0NQRJmM7bnKZGmz/ykOeKRAznxbxDWhfDqpnmbj5bvtbX2A3KGe9G3Xgo
         DZex1+7XNE153An88y1jnbmno8gQGhgupf7EN7ZuiYh7UwZLDe9OYRzFZWO0nv8GeN4e
         Bo7YV2SQyroTdccRJ/hSlRF3GObA7xYD7Kxdfv5gVxX8BIMNXCjc/qSN2tp+bVFBfvRx
         9D+g==
X-Gm-Message-State: AOJu0YwX5CQJIUfWd2wQZHoFoepYZXDZhT64395+XSv7zVtmZwRR6Vys
	zTHPcfkD98g58fY5z8lCb/dNzTDxNWWvUZnw5AiYT2zvlJBps98NAZNQLBoQhg==
X-Gm-Gg: AfdE7cmGegB2c2IS11w6TmJvmwKBDxmVm5RJTvMK9kQmJ244WB4/1UL7I7BgvbA1yDy
	In/W4l5lDkLGo1S+VLjONmOlK2kuQUbt9gKXr0yZ4zDochcP6Al6+lT1Qy8KLzZsdc+5h1SBMht
	A4IG0oDLNMOn/hUZI7xlxM4uLSHyE/zwqMwMZ2laKECrfk/DZPR1lem45OmlAFaNG6RwNxFzm62
	N7I8sBDr75PXMdRw2B+j6oyOukiPhXeUCiVKP98BCfgFrkz9OOlKDMABok/lKh+/DDXgiIVNJn2
	uighYDDgNMRxqM5E9sGxOXbv5JCmfAHv4FdGXTasb8YLeRxMbDm+vWdIJvRMYLbSZMhHV5/O63g
	6obXJaFeInGbor0FK4GC0127kZvzDdcZsDfDeTXG3go2d3ASSnK4IzKdJs9YdQAQ49jRdCLpiUT
	HKU4f4LMATlmV11bJ/FHfIez97efMvmys=
X-Received: by 2002:a5d:6e48:0:b0:475:5e4b:588f with SMTP id ffacd0b85a97d-47aac01f951mr5538145f8f.16.1783264862995;
        Sun, 05 Jul 2026 08:21:02 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm16492537f8f.36.2026.07.05.08.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 08:21:02 -0700 (PDT)
Message-ID: <c67924a5-603f-4c8e-b958-f055dd9b1bfc@gmail.com>
Date: Sun, 5 Jul 2026 17:21:01 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] tidbits: net-ping: add ping tidbit using raw socket
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
 <87se5xmqf6.fsf@xenomai.org>
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87se5xmqf6.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 05.07.26 um 17:01 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> This patch is the result from experimenting with evl networking. I use it to do basic
>> connection tests from the out of band network and check the timing.
>>
>> It is a bit complex due to evl doesn't support IPPROTO_ICMP sockets.
>>
>> Using the in-band network stack, you can use: sockfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
>> and then only send the icmp part of the message. However, such a support is not really needed,
>> it works fine without.
>>
> 
> This said, we have an ICMP protocol module in the evl stack since
> recently, which only responds to ICMP_ECHO requests ATM, directly from
> kernel space. Extending IPPROTO_ICMP by implementing the oob_sendmsg()
> handler for it there has become an option.
> 

That would make the ping tool way simpler. I can also wait until this is available and
create a new patch. It's mostly done just to figure out that IPPROTO_ICMP is not available.
