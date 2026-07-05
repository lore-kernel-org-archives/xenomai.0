Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4263587DE
	for <xenomai@lists.linux.dev>; Sun,  5 Jul 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783265280; cv=none; b=leZBFF5VpLkMbQHja8jWjrE9d5RMdcY73pzNYnte38AtO0LBrzkBeBtThUyzMHCYZOguqbUyduJIjscKaT8Vk8R2Mh0P40GF5I7Ojn0hn9jSbTwUFQv8UC/i35X590pocPC0X8uJa1LGtIIMVzgtS80X9NSYART3jp8Wo+Bu7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783265280; c=relaxed/simple;
	bh=tU4Jhn1X34DweevFCyd6mQ2V1EXeQbmiAP+pAy+UPBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayCmtoNzLJmzLXU1HkxkoTgZokz+sBXZrlSpGsRKfRu7+hVRWDp6wYdWZcZ0AVXJQAHYAjb3Vs5/oQZqDLanVL7WhPQQdscSMIYEOkWNHHnoRvp9bemXNTiEZqCukDi0yeq4nkZJqJBizeFVZFO0VJfFob0Z65X4b5GKh9y8KzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE230nQS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE230nQS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so21503735e9.1
        for <xenomai@lists.linux.dev>; Sun, 05 Jul 2026 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783265277; x=1783870077; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gmyows6k91kT7jnhibosg3WP5TYSWTCNsoKKU03AONM=;
        b=cE230nQSrqXayT1rUosDgqmk3Zg3bbyq5AuuSvdia3dc76b27+umBWSP2NFemhA2MI
         aKn22QjR+35AHsXvllH2cG+GtFzWz8Fucl/FcH0PVpaUr9IXOXTcE6hy95tlAoEwpxoM
         0LWYZ+Fnv8VQrXezr1DKX4A6fsMO8/6obyyZL1LWtrweL3kEM0jvloedB67+rWI404D3
         CjDr6Tr9K1NqeJ2qxg+W53CTPOtYsm0OBTXp+wRfHusJmgPvlYGB0FNs5irYXQUj680D
         94uiTaPrPH1sQ0kwrUt7bKRAFZzkuF711/OSYGl0EtuHYNEGgVwFNjN5K5MXMDDVobUi
         kHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783265277; x=1783870077;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gmyows6k91kT7jnhibosg3WP5TYSWTCNsoKKU03AONM=;
        b=LOZ2Quqfyd8HXgwmp4YVvX2XhOdsVw1natHDFRfOJqyYPiWqXFQKhL3myorJ/6hp1Z
         5kR08B9S316/KIWoWGag8C2z3fzZEV8OZ+WkQFavFGLKqtbf1tFsTIsaOlzq8OhFUj4M
         JT8r//y4jHEcY+DDSQtNde8dMavdk266rC1Cpk8GdwzYQvL6+S0dOhQALKl+3HUvYY/z
         TpiUVVfXX5DD7+fhZj4lk1l9qPxP9mRgZOJQ4FO4KtGhRAYrVGgiAElsUGSOyNNRcamN
         gtqq7U7WUjFBh1CqqYEEvw375gXgtZPpzTnZ12iKWPx+pF/QmqtHVxuEF+6Djowd206n
         fvVQ==
X-Gm-Message-State: AOJu0YwIl61tmI6Vp91B1u4jUSpW3UBJUYx8aB0zttmaMKi3FkHmRYzP
	KqUC1L9e0BewwqshJfTXWfEzDRCdypleNqfrQY/ndPXBgx1mZCDXeVG33JKyPg==
X-Gm-Gg: AfdE7cnEVCtewM7CZUIabaQwnTib06hGR9qx8VqW9r9Jkhsp8OsBhx+6TNRzqYtxqPP
	IldNLhvPH4Q0y5mj8oKY3XN7MQ1V7qfl1DeWTYaULzeCIwqPSz7qvwOERr1vUehyTl47gjjIvcn
	N8RH7R+v2AfCfsmBbGr3vzPG8Zm1Sh1AHoeN3Dbb2PCgJI0yC5I41u6Allt89IxulWQPkwkNE4q
	otCPPH5UEETeGuj0SKBEAaYi73huoxVp9gU9v0oKkdkdgkGFXFUhWxQHVJjdeRwdZnUGn24C4bE
	RowZv1RoWxgd7xSDuHnosxNNOSVPdRKecOSTlZCJcoXFM8b67OkKGyiVDs5Yrjdh9x4excn8beA
	KkFScuZZkr1gYJqhBUmIYJKXklQyAANa7tS8gaB254kTBOsBUFPYh/G/47mp2yGqkKWYaEkc6cG
	RPV6ckvxKnHY+OfSlY9D99
X-Received: by 2002:a05:600c:4e4b:b0:491:91cc:d12d with SMTP id 5b1f17b1804b1-493d76c4431mr31136115e9.25.1783265276848;
        Sun, 05 Jul 2026 08:27:56 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm17051725f8f.2.2026.07.05.08.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 08:27:56 -0700 (PDT)
Message-ID: <7f0d1a81-adce-4d15-9707-87b8469cf8ae@gmail.com>
Date: Sun, 5 Jul 2026 17:27:55 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tidbits: net-ping: add ping tidbit using raw socket
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
 <20260628153956.1435330-2-hannes.diethelm@gmail.com>
 <87y0fpmqky.fsf@xenomai.org>
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: de-CH, en-US
In-Reply-To: <87y0fpmqky.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 05.07.26 um 16:57 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> This tidbit allows to ping any host and measure the response time.
>>
>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>> ---
>>   tidbits/meson.build    |   6 +
>>   tidbits/oob-net-ping.c | 480 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 486 insertions(+)
>>   create mode 100644 tidbits/oob-net-ping.c
>>
> 
> Thanks. We need this to build on 32bit systems:
> 
> --- a/tidbits/oob-net-ping.c
> +++ b/tidbits/oob-net-ping.c
> @@ -215,7 +215,7 @@ static size_t build_icmp_request(uint8_t *o_frame, size_t icmplen,
>   	icmphdr->checksum = cksum;
>   
>   	if (verbosity > 1) {
> -		evl_printf("ip_len=%zd, icmp_len=%zd, ip_len=%d, datalen=%ld\n",
> +		evl_printf("ip_len=%zd, icmp_len=%zd, ip_len=%d, datalen=%zu\n",
>   			   sizeof(*iphdr), sizeof(struct icmphdr),
>   			   ntohs(iphdr->ip_len), datalen);
>   		print_ip_header(iphdr);
> 
> What about turning this code into the (currently missing) 'evl-ping'
> utility? I believe it is of general interest to any user.
> 

Thanks, I will fix this.

Why not. So I would move the code in the tools place and rename it? Meanwhile,
I was continuing work, so statistics are available, ping style.

oob-ping:
2 packets transmitted, 2 received, 0% packet loss, time 1633ms
rtt min/avg/max/mdev = 226.8/248.3/269.9/21.6 us

ping:
3 packets transmitted, 3 received, 0% packet loss, time 2030ms
rtt min/avg/max/mdev = 0.118/0.142/0.159/0.017 ms

The only difference is, that I use us instead of ms. That could confuse some users.
What do you think, stay at us or use ms?

BTW: This is in a VM, that's the reason for the bad timing.
