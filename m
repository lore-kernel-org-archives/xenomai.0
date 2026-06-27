Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49C13B7A3
	for <xenomai@lists.linux.dev>; Sat, 27 Jun 2026 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591675; cv=none; b=I4YR1F16wJPTT44d42rXbERiC51dKiBaH/yI8pnGQ3Kr1tBqfRmMBA0Oxdlb0THQQC0hsRZxwpGoAqapB8oHL0hPxY17ZL/5ef++d6Bn61Wu2ZAd9lcEIyaaZF+dztRbOxshdSbR8JHXaZZLeC/s+4Occzmh9RW1fef1S3fehFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591675; c=relaxed/simple;
	bh=xFETU5PUACUriQAduwN4/p1QIkjDMrDgTq238XQG7NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDq+UT+me68r1ncahizFw+Ki1OVlijFOrbDr0EiNB6DNm2O3u/qWcyIVIFVi7pLQd1K48EkS1tBa2Z7kkPwanJlFwsVyoNUHjtfn9f0hrmdskLcvWbzm/L43n0ZrgAMbMe2+kSCcsQ+ImhJ8SUfUoaPfe4zbCGFXE1oPCCbDz7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYd48ST9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYd48ST9"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493a5392c60so1621905e9.2
        for <xenomai@lists.linux.dev>; Sat, 27 Jun 2026 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782591672; x=1783196472; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHnEU8Zsm+bTku1YWcssUTb44XQ2yB9nla/iAE5Zv3g=;
        b=JYd48ST9FSOq1k7HRJZkkhiiOQ9ZTMVhleP+uqIYyWwse4p91h9yRhicugu9k2Wt2z
         dsX/4K6UI5Qw0OQdmcPTgxSm36Stj5ObiwaBq8DqgZYGwo0n8d2VFg86A6fnm370OxDJ
         fMwQxhqDzbAdEwxXuVuwtUO6EPqCD2bXbLpPuZ971QmQvU/yJ8qoOyoaWuhoVJgf5xMy
         UwwZ1/q7rhC07p28FJGUtb1bWTZZH7ZgawVk6HJeEOPucrtRDv1YiZMtH/tK5ioQUIjp
         oLuMBJVLfLS2Pnd7zPOH4O17U7SC2h/bq8k4fQk95PMaJnewFtWPxssTMcEemeP0S5EH
         OGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782591672; x=1783196472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHnEU8Zsm+bTku1YWcssUTb44XQ2yB9nla/iAE5Zv3g=;
        b=qE75APqBbblOZlAB2UjiJxoArYrV4D7rThghWwInLLbUQanzYNoaP+FhN2a+g4Q+Gp
         fc0RVKmgXtAUVRBRIUn4HaJ/rAeDYv9sYYIRL71EQblK6YXWmxW9p5094OVMCq4LK8lt
         hDdwnz3Zt0Zh6OLJWYHm8RKQo5EAF7tuQXvMy2U4L2gIfpZpxZK1uDnuHnNVc+K4PYca
         n+o/HmCNSjMrlfVOFSwaWDA5fOWubKqU00MptB4/ajBeXzBuvdJVu2TWytNIXsBFvf4f
         LMR7+vk+CEdUfGi/AXescH/lH9NAaiTqRVEfiVsaffwC4GRdg7iXmI4ffepjAs7S3IPZ
         fdaA==
X-Gm-Message-State: AOJu0YzraPhAnap+Nsu8J+/mWOdVvejfJWh+LYfNzP9OenV7MiI7f1jm
	AS869vTHJ4tIP6IzY77E4Q8fTHlNhEJENZ96nln6L1ov5nhpoXS+DyFm5z6Fgg==
X-Gm-Gg: AfdE7cm+U675ie1k5A/rJil78jmWyqgGcv0MlOaMgDXreN9zFG7QmhOkWPF/e4ckcec
	btrURmFFSaYE8f8quFx40yWO2JgO7+N76gep1KfjbJmAfokACjwtc0VgOzOGCwPRYtzdV00z/8b
	TRkjx1SWqGwAwq1qptqPQeMCK6zUQSL7X3QmiHNtELqZKpXQC8d0YQKphXSIBhta4Qg0ew6KYu+
	MWPpOw8Q2+vgcgxNy80tbSXlm3IiFIsDoJW2vMgVWs3al7pfTL0Reog9HUarbAuy8LAAtKm6Pnf
	ZOj/MFBszS480vTWtO9vYYZEELlJXEK+lk70GY/1wHlrxQELyZUFyCQLiVXIGXnQ4z6jvAnJe24
	/yJ4LQPNXF/9C5tt5cXP7N0wbITOMiRmgFZAdxth8yzplOdQgdB4WNPMxskZ6gWTqtGKFfo6a88
	61Fg2uDsQr9BNzJLKrrrQl
X-Received: by 2002:a05:600c:3549:b0:492:4363:e7eb with SMTP id 5b1f17b1804b1-492668acc8cmr179983245e9.32.1782591671812;
        Sat, 27 Jun 2026 13:21:11 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fcee16sm195964205e9.2.2026.06.27.13.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 13:21:10 -0700 (PDT)
Message-ID: <6c0d9a13-732b-49c5-886b-3dda8b1f5cab@gmail.com>
Date: Sat, 27 Jun 2026 22:21:10 +0200
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
 <3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com> <87ik7d86kn.fsf@xenomai.org>
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87ik7d86kn.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.06.26 um 19:28 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Am 01.06.26 um 11:10 schrieb Philippe Gerum:
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>
>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>
>>>>> This fixes random EINPROGRESS at init or during runtime.
>>>>>
>>>>> Also correct whitespaces and make stdout more consistent.
>>>>>
>>>>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>>>>> ---
>>>>>    tidbits/oob-net-udp.c | 58 +++++++++++++++++++++++++++++++++++++------
>>>>>    1 file changed, 50 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
>>>>> index 11b8459..7af834f 100644
>>>>> --- a/tidbits/oob-net-udp.c
>>>>> +++ b/tidbits/oob-net-udp.c
>>>>> @@ -50,12 +50,12 @@ static void usage(void)
>>>>>    }
>>>>>      static void print_addr(char* text, struct sockaddr_in *addr){
>>>>> -    char ip_str[INET_ADDRSTRLEN+1];
>>>>> -    inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
>>>>> -    evl_printf("%s--------\n", text);
>>>>> -    evl_printf("IP-Address: %s\n", ip_str);
>>>>> -    evl_printf("Port:       %d\n", ntohs(addr->sin_port));
>>>>> -    evl_printf("Family:     %d\n", addr->sin_family);
>>>>> +	char ip_str[INET_ADDRSTRLEN+1];
>>>>> +	inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
>>>>> +	evl_printf("== %s\n", text);
>>>>> +	evl_printf("   ip-address: %s\n", ip_str);
>>>>> +	evl_printf("   port:       %d\n", ntohs(addr->sin_port));
>>>>> +	evl_printf("   family:     %d\n", addr->sin_family);
>>>>>    }
>>>>>      static void sender(int s, const char *text, int mcount,
>>>>> @@ -226,6 +226,8 @@ static void client(int s, const char *text, int mcount,
>>>>>    	free(tbuf);
>>>>>    }
>>>>>    +#define SERVER_ADDR_LIST_SIZE 64
>>>>> +
>>>>>    static void server(int s, const char *text, int mcount,
>>>>>    		struct sockaddr_in *addr, int iter)
>>>>>    {
>>>>> @@ -236,6 +238,9 @@ static void server(int s, const char *text, int mcount,
>>>>>    	ssize_t ret;
>>>>>    	char *tbuf;
>>>>>    	char rbuf[16384];
>>>>> +	in_addr_t addr_list[SERVER_ADDR_LIST_SIZE]={};
>>>>                                                     ^ missing whitespaces
>>>>> +	size_t addr_list_fill=0;
>>>>> +	bool solicit_done;
>>>>>      	tlen = (strlen(text) + 1) * mcount;
>>>>>    	tbuf = malloc(tlen);
>>>>> @@ -276,6 +281,39 @@ static void server(int s, const char *text, int mcount,
>>>>>    			evl_printf(" (TRUNCATED)");
>>>>>    		evl_printf(": %.*s\n", (int)ret, rbuf);
>>>>>    +		/*
>>>>> +		 * We need to call evl_net_solicit for each new
>>>>> +		 * client once before sending data. This will break
>>>>> +		 * realtime for the first response.
>>>>> +		 * If this is not done and the ARP address is not
>>>>> +		 * yet in cache or garbage-collected, oob_sendmsg
>>>>> +		 * will return EINPROGRESS on start or during runtime.
>>>>> +		 */
>>>>
>>>> We can happily send redundant solicit requests to the core, no need to
>>>> filter out cached addresses, evl_net_solicit() will do the right thing.
>>>>
>>> Except that doing so would always demote the caller to the in-band
>>> stage, which may not be what you want. The fact that we'd need to
>>> maintain a cache in apps in order to figure out whether solicitation
>>> should be done shows a shortcoming in the core, users should not have to
>>> do this dance.
>>> We should have an oob call for probing the route+arp caches with
>>> ipv4. I'll look into this asap.
>>>
>>
>> Yes, this is the reason I do it this way and print out a message if
>> this happens.
>>
>> I think server mode with multiple clients in real time is not something you
>> can just easily do without careful considerations what happens when multiple
>> clients send a message at the same time or TDMA behind. My intent in this example
>> is mostly to show that it is possible.
>>
>> A real application would need one of these options:
>> - A thread only for solicitation so the main thread doesn't get blocked
>> - evl_net_solicit() with a flag like MSG_DONTWAIT and then poll in the main loop if
>>    the client is ready
>> - Know the clients in advance
>> - A warm up phase during clients can connect
>> - ...
>>
>> However, a way for probing and reading the arp would shurely help.
> 
> Here is a general proposal to deal with the issue of sending UDP packets
> to unplanned destinations, which is basically what the server mode has
> to do, when receiving unsolicited messages.
> 
> We have a single invariant to cope with: the evl network stack wants to
> use the routing+arp information produced by the regular in-band stack,
> so that we can benefit from potentially complex routing logic without
> reinventing that wheel. Therefore, the route to any new/unsolicited
> destination must be resolved by the in-band stack once so that we can
> send UDP packets to that peer from the oob stage next.
> 
>  From the point above, and as you pointed out already, an oob sender must
> either plan for reaching a particular destination (e.g. soliciting it
> prior to entering time-critical code), or accept an initial delay for
> the route to be resolved if the destination is not yet known on first
> transmit (i.e. out of the oob caches).
> 
> So, I would say that evl could meet the requirements you stated above by
> implementing the following:
> 
> - Honor MSG_PROBE for oob_sendmsg(), so that only the general call
>    sanity and route resolution to the destination host is performed when
>    set in the request flags, without actually sending any data. On
>    success of such call, we would know that the routing information is
>    readily available from the oob caches, no offload to in-band would
>    have happened if we had not given this flag. The absence of routing
>    information to the destination from some oob cache would yield a
>    specific error, so that the caller may decide what to do next.

It seams the flag MSG_PROBE is kernel only? I did not find any occurrence
in /usr/include or in libevl.

> 
> - Extend the effect of receiving MSG_DONTWAIT (and more generally
>    O_NONBLOCK on fildes) to what we would do upon missing routing
>    information: if present, return with a specific error code _without_
>    relaying the packet to the in-band stack. The caller may then decide
>    to handle the case locally. Otherwise, proceed as usual (i.e. relay to
>    the in-band stack, then notify the caller with -EINPROGRESS).

So the oob-net-udp server code can be changed to use MSG_DONTWAIT and
if the return value is EWOULDBLOCK, call evl_net_solicit() and try again instead
of holding a list of IP's right?

> 
> - Provide a way to synchronize with the route resolution process in evl,
>    i.e. a syscall that would block until a given destination is available
>    from the oob cache. This call already exists, evl_net_solicit() can be
>    used for that purpose (if a resolution request is already in flight,
>    subsequent ones to the same destination won't cause any harm).
> 
> Points 1 and 2 are implemented in [1]. Feedback greatly appreciated and
> important when you have time. Usability for real-world applications is
> key.

I am a bit busy right now, but I would like to test it. However, It can
take a week or two.

> 
>> It would also be nice to have an "evl net" command to list the
>> entry's. I tried the normal arp command but it doesn't behave nicely
>> with evl.
> 
> Could you please elaborate on this issue? Currently, updates to the
> in-band cache are propagated to the oob cache (by registering a hook
> into the relevant notifier chain in the kernel). So I would expect all
> destinations of interest to oob which are visible from the in-band arp
> cache to be available from the evl map as well.
> 

The issue was on my side, I need to run "arp -n" so it does not resolve host
names. Otherwise, it takes quite some time. But this makes sense, with OOB
active, it will never receive the answer on the request, so it times out.

By the way: Since some time, all incoming network traffic goes to the OOB
stage when it is enabled. However, all outgoing traffic from the in-band stage
is still sent. Would it make sense to block all outgoing traffic after
"evl net -ei" except might be ARP requests if they are initialized by evl_net_solicit()?

At the moment, this is done using nftables for linuxcnc, this works fine
for preemt_rt and xenomai, so not really needed.

> This said, I agree that we need a way to inspect the oob cache
> specifically. Working on it.
> 
> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/wip/net-solicit?ref_type=heads
> 

