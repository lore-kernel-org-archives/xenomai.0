Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31CA274B43
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344182; cv=none; b=DC751LzF4MtvLG8k+lVQ07eo5ccFtkNUfngntbw0G4f1Qxvr3N11WbUqPwMVubgGj7qXHxdo2NV4qiU1eTbHJSvWYmk4hwcukcz0r0BMJYGQ7km5AG5k5ItvF5etbk4GVRuI+Aeqf7nENurDpFf0zRdQqMP4EARmNeUOF+l3bb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344182; c=relaxed/simple;
	bh=g3yyP7CS92A4vUd/b93uHWH0ElmABICIhWWaUcSs67w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVsfGDKQ6c84z5bZoxcEzfzL/vgHLwHZa/S5V/yp28EFQIDCrbnQgWb3pNXBGA94o+p0Z44uu3l+N/Dx8w6tW0qbMLQA/qcxcPEsBEiQAtFMRAHW7LuyGFEvj/tJpeAuaxx0IlOdlsiDbaBWQLFrKgMJ6LNbqepuxlpJ+5E+ayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9fwe1q5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9fwe1q5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so94593195e9.2
        for <xenomai@lists.linux.dev>; Mon, 01 Jun 2026 13:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780344179; x=1780948979; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=huuR/itXCr2iN2tUZ+MapyN2c5Hezrn9zyEb2VpAsaA=;
        b=e9fwe1q5wDiwjm5YQ1OfVdMRXkPA/O0lQwgBD60zKQaxMOINB0POUjYv/slZmrQxrB
         Srf9mrOBq3x8b/C4MDxy7d16z4L1jQE5ARait4+lNjF+jnH3KC1QNsH0pZlQ3ayLoacf
         Pm+yOTFZn3mcCxbrZeN/6jA+IHEViakASD+nuGS51pw3HvQuRJAMFkX/2bKX3I7QxDln
         V9KxJIArG+ejah15OFwzix6107x2MrXUvfZbWjgeVTfStilfAz5nFbr593i/RiLi1ocS
         U1pq/g97YVok1U60vGQynAJgNy0e0UiXvfRnIYBUFKCfvW8z7ZpxoinGrHzai3bwJJAQ
         r/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780344179; x=1780948979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huuR/itXCr2iN2tUZ+MapyN2c5Hezrn9zyEb2VpAsaA=;
        b=DHDqAuPSWuD/7w8Com2qiYfkX543iv/h2KmWG0ZUlWjj1Q4eltmt006/DkiZ9S6lx2
         zPygpfiXo+IQFHrAGvHPL3k308VS6WJTgIGY60/H75pxxUcQJ0ObHD8aXEDYWvNQmsh3
         FjVBOBsFzRcvHImwqp7sWkUaoM+NY+Xp7hTCU9/zwpbRzYZPOC9px+8FWgF+Jc0hEaXb
         3CkOZ06ToyveOkHBXgJrF/KTZfk25/PgyT4bW1LbiOpV6gGfjGi7Zts0e6iMVIA4zSgV
         bOWSEB3183/SYD9qu0TwX+vCUcLB9gK4vPz4qLbaTXGIjLb6ti5fRQ50NK/tsL2i+wG9
         97tg==
X-Gm-Message-State: AOJu0Yype+27reud2pYdmEL7VSYHU4YbiiAsPRUrkOIM2I4KoXSk3oXB
	IiqYJZFxmYyCJLtIyg4ru6uv6JhQ1gE0148vrtZpkXcQneZNnBcwjcfg
X-Gm-Gg: Acq92OH/pJBeHUtl38d3K6AST1X9LSyKzz5vQRTOh+VGGYoEf1SJuNclljX1CIEDD7T
	KeSM+CjGe3VJurUvkZDFXSG86t9caPOayRVhnxCTmWzF7sK8csFv66UiQ+5Mp2l5HfXSZFTQmiV
	oQ/7GxH2E91krZSDi3vMLWt5UG21kK2ShIUtbiHhxO2y872VScSH3Jq6bFJme1dxFJShHiNmjkf
	AjVtuGZ6KpByBJ1Q8R2cm2utVJXl3e0+1wmgQ1+04Mr9i5FlZg5zSyEoTecidh2LbcWan380PlR
	B8eRpBtqRLaTSwqkBboo6DqzTSuhQt7SDRW/YuUwP5MgilF26GOCgyxYNq4vM7P04LXhb5hL1Ik
	S4oTe+leJ4K8i2FTRnyt+Wqoq5ephYL9kTgono+qu8lOA3q0EYn+7is3nX0ulrMhEmNH0zK30Tt
	A26INbbOXFJLOIMncSy3kdxmIp98cI9lModPP2WUHyBA==
X-Received: by 2002:a05:600c:3b14:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490a2904d7fmr230330595e9.7.1780344179211;
        Mon, 01 Jun 2026 13:02:59 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e38126sm11183605e9.14.2026.06.01.13.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 13:02:58 -0700 (PDT)
Message-ID: <3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com>
Date: Mon, 1 Jun 2026 22:02:58 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
 <20260528194459.6117-2-hannes.diethelm@gmail.com>
 <87a4te64vn.fsf@xenomai.org> <874ijm62yu.fsf@xenomai.org>
Content-Language: de-CH
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <874ijm62yu.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 01.06.26 um 11:10 schrieb Philippe Gerum:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>
>>> This fixes random EINPROGRESS at init or during runtime.
>>>
>>> Also correct whitespaces and make stdout more consistent.
>>>
>>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>>> ---
>>>   tidbits/oob-net-udp.c | 58 +++++++++++++++++++++++++++++++++++++------
>>>   1 file changed, 50 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
>>> index 11b8459..7af834f 100644
>>> --- a/tidbits/oob-net-udp.c
>>> +++ b/tidbits/oob-net-udp.c
>>> @@ -50,12 +50,12 @@ static void usage(void)
>>>   }
>>>   
>>>   static void print_addr(char* text, struct sockaddr_in *addr){
>>> -    char ip_str[INET_ADDRSTRLEN+1];
>>> -    inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
>>> -    evl_printf("%s--------\n", text);
>>> -    evl_printf("IP-Address: %s\n", ip_str);
>>> -    evl_printf("Port:       %d\n", ntohs(addr->sin_port));
>>> -    evl_printf("Family:     %d\n", addr->sin_family);
>>> +	char ip_str[INET_ADDRSTRLEN+1];
>>> +	inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
>>> +	evl_printf("== %s\n", text);
>>> +	evl_printf("   ip-address: %s\n", ip_str);
>>> +	evl_printf("   port:       %d\n", ntohs(addr->sin_port));
>>> +	evl_printf("   family:     %d\n", addr->sin_family);
>>>   }
>>>   
>>>   static void sender(int s, const char *text, int mcount,
>>> @@ -226,6 +226,8 @@ static void client(int s, const char *text, int mcount,
>>>   	free(tbuf);
>>>   }
>>>   
>>> +#define SERVER_ADDR_LIST_SIZE 64
>>> +
>>>   static void server(int s, const char *text, int mcount,
>>>   		struct sockaddr_in *addr, int iter)
>>>   {
>>> @@ -236,6 +238,9 @@ static void server(int s, const char *text, int mcount,
>>>   	ssize_t ret;
>>>   	char *tbuf;
>>>   	char rbuf[16384];
>>> +	in_addr_t addr_list[SERVER_ADDR_LIST_SIZE]={};
>>                                                    ^ missing whitespaces
>>> +	size_t addr_list_fill=0;
>>> +	bool solicit_done;
>>>   
>>>   	tlen = (strlen(text) + 1) * mcount;
>>>   	tbuf = malloc(tlen);
>>> @@ -276,6 +281,39 @@ static void server(int s, const char *text, int mcount,
>>>   			evl_printf(" (TRUNCATED)");
>>>   		evl_printf(": %.*s\n", (int)ret, rbuf);
>>>   
>>> +		/*
>>> +		 * We need to call evl_net_solicit for each new
>>> +		 * client once before sending data. This will break
>>> +		 * realtime for the first response.
>>> +		 * If this is not done and the ARP address is not
>>> +		 * yet in cache or garbage-collected, oob_sendmsg
>>> +		 * will return EINPROGRESS on start or during runtime.
>>> +		 */
>>
>> We can happily send redundant solicit requests to the core, no need to
>> filter out cached addresses, evl_net_solicit() will do the right thing.
>>
> 
> Except that doing so would always demote the caller to the in-band
> stage, which may not be what you want. The fact that we'd need to
> maintain a cache in apps in order to figure out whether solicitation
> should be done shows a shortcoming in the core, users should not have to
> do this dance.
> 
> We should have an oob call for probing the route+arp caches with
> ipv4. I'll look into this asap.
> 

Yes, this is the reason I do it this way and print out a message if
this happens.

I think server mode with multiple clients in real time is not something you
can just easily do without careful considerations what happens when multiple
clients send a message at the same time or TDMA behind. My intent in this example
is mostly to show that it is possible.

A real application would need one of these options:
- A thread only for solicitation so the main thread doesn't get blocked
- evl_net_solicit() with a flag like MSG_DONTWAIT and then poll in the main loop if
   the client is ready
- Know the clients in advance
- A warm up phase during clients can connect
- ...

However, a way for probing and reading the arp would shurely help. It would also be
nice to have an "evl net" command to list the entry's. I tried the normal arp command
but it doesn't behave nicely with evl.

No hurry from my side, I have linuxcnc already running well with evl oob networking,
I only need client mode and i know the IP in advance, so all good there.

Sorry about the whitespace issues, switching between projects... I sent a patch v2. Feel
free to merge this already and I can create a separate patch when probing ARP is here
or wait and I create a patch v3.


