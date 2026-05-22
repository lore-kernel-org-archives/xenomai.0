Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD1357CFB
	for <xenomai@lists.linux.dev>; Fri, 22 May 2026 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492112; cv=none; b=dmToNQ+PH8ETCpxWp7PfUd4w0N0xsfWljobLFY7Y2qWSpq2uaI5I2YiCwJkR7W8n7t43DtprAOR6336X7gC5XiV8COm2jGATr8yZQuKkzo/xRbydvBV3nd201lAOmr1tHKW+ev7XSX+3lbR9Uu/mzbxWcGtxX/Ob57cHR/5xPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492112; c=relaxed/simple;
	bh=kSTMgd+4+4xioUc8m7DkLbuCAUc2f7QJWmM5KA9tL7k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fV9Vk+QTSMSeoW+nAnEodUHxTY90VpIEGvKjUOZfGgfsfj58BXBu9IQlGMraEy+FbdQu+5DxNUuH92m8F2WOgPhzZD/jYaOQGUg1TzIZttPClF+GawMhwbEey9jjJdZUBBsqqTT4BRD9h1FnNMDxYpUc07M6pf41ZqbNDYGh1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMzMe8zC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMzMe8zC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49039a8851fso23924575e9.2
        for <xenomai@lists.linux.dev>; Fri, 22 May 2026 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779492109; x=1780096909; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1DGObOOH3vNwU9Ximhwk7PC2Jb13rjtH5KI1IyFOms0=;
        b=LMzMe8zCx5paqZ1Fed2+/gSKnG2t8R+dSDJsGLBYnHZhg50xEkrbJbKXAXMWjvt7Gy
         WZpr6LDGT4Y/DJ5hsNzixs7MpoOHdSICnpETL4t0+5TwfR8nxNKLn68Xh7OmA//KAo7w
         ibEofFHs8daywog+7YGihYhxECjXkM7uMnD8bijpqZRGxXG6pGfJ0LrlL/lvrHxT7ieH
         KFA33U5PM7MUjYU73Vvn4uHahSa8uGLJkalpkOsbQoGzMumn6wWIabO7c7gKWQSKakBL
         GUgLO1JwHQb4UoO/56uHkfVoP8Ch8CXgkE+nmYPDxLzjg7Kv+vK6IvI8MwwdrWqQFYlW
         jwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492109; x=1780096909;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DGObOOH3vNwU9Ximhwk7PC2Jb13rjtH5KI1IyFOms0=;
        b=mrVfJ77gnKOhDoQkBi3FFxRCfdp5fe7P3INCiczZTH0Jn0NkK/HQsz0ghHirf/+dC/
         pR/bsxS1I11+2jZpa/IiB1Qw3yaas7pOdjZXD3foNy04WXxe3HodJyta8Naf6e56B5T1
         Z380xLNbG6dqZkUAgEfptykX54jXXVklvgsvk1Fc7vTmH8tSS0uDGjWC3sy+G6QyjTcI
         QI9q6001hGPUgLL/hDWejmsmDf46ZK7OnZkF6yoywx/FI/ZNf8e7L0e878/qPOM2oGKf
         HuEaJaWNXDaOMK4HqOvKdDXi+hFIll8KMcX9SarnZKGhpLkJZ+MznjRDPSmsvd+MtATO
         HgXw==
X-Gm-Message-State: AOJu0YyPAUBU57AZf3APC1Is9KfRrmk8t+0FpQgZBoE2DyH0ZgYVlXqq
	nTgr5FaMbW/fVJ6Hg5OMZYV1VVQb8PvCKGZE/O4AVJJca8Qs7QTrrWPraiUSYQ==
X-Gm-Gg: Acq92OFlFv6KdxGmP5FEKnzZ/Q3n3i5PKGiJ3oUNF1BpGB3tHlMgoXllk6bdkWLGTnz
	RBNtkLl3PGc4CDtyyZ7PFpZl8P1eL3PUa3s7C4hbNySiQv7ALTB/Qbjl/qcLgSGDD07EXSh81/h
	UX1h+GuOvyVoR067GBab8Kc4oBNBFVytFKFDwFMQeypctByE22KjiboJ+CS2XGnjFa8Pvi7twjL
	lVkLJBPsJjtK+57It4s5jSDIzSsNYIHT0k2fozNOhyPJredpTTF+ru1a9AdflHYbh0L5iB5pS6D
	DZ3KzkopcV/02YyPkgYGN8JykDyMhB+iGJ7rJEWntBci40cJVfHtnprdqDcHanYiGzCqTiI1VBU
	EAW16GmdV8Ng0YFUuTbehPUX2yR7PZd2QeaudsXTrThXAAEwR4MDec2y61+IC5DQ0NBmx1Ioono
	3x1SEMXoBDRLuJDmpjDAgYA1sq5rLDOXM=
X-Received: by 2002:a05:600c:1497:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-490428d1551mr53020805e9.22.1779492108248;
        Fri, 22 May 2026 16:21:48 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042ae1ec0sm25183825e9.26.2026.05.22.16.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 16:21:46 -0700 (PDT)
Message-ID: <19e440ba-bb7a-47ba-a1a9-bb72eb83badd@gmail.com>
Date: Sat, 23 May 2026 01:21:43 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: Re: [EVL] Client UDP not receiving data
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <6f9e6ff2-95a7-402c-90d6-19f0f89bbc80@gmail.com>
 <87v7chf5xm.fsf@xenomai.org> <327a363e-6b79-45b2-a5b0-6b9f8a82d756@gmail.com>
 <87y0hbe9kw.fsf@xenomai.org>
Content-Language: en-US
In-Reply-To: <87y0hbe9kw.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.05.26 um 17:40 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>>
>> Thanks for the detailed answer. I might have been not precise enough.
>>
>> The -S and the -R mode work as designed. To show the issue with connect() in evl, I changed
>> the -S mode to:
>> connect()
>> while{
>>    oob_sendmsg()
>>    oob_recvmsg()
>> }
>>
>> This is the classical UDP client pattern. It works with vanilla linux (net-udp.c)
>> but not with evl (oob-net-udp.c), I do not receive any data.
>>
>> By just sending the modified code, it is easy to explain and hopefully for you to
>> reproduce. This is also why I attached the files instead of sending a patch.
>> Be aware that this is just to demonstrate what is not working, not intended as a patch.
>>
>> I run Xenomai4 in a VM and communicate with the host for debugging
>> but I have also a real PC as the final target where I have the same issues.
>>
>> First start on the host:
>> echo Hello | nc -u -l 5201
>>
>> Then in the VM:
>> sudo evl net -ei enp7s0
>> sudo oob-net-udp -d -i enp7s0 -a 192.168.122.1 -p 5201 -S
>>
>> On the host:
>> Mellow sword!
>>
>> In the VM:
>> == bound to enp7s0
>> == sender mode (=> 192.168.122.1:5201)
>> --------tx--------
>> IP-Adresse: 192.168.122.1
>> Port:       5201
>> Family:     512
>> --------rx--------
>> IP-Adresse: 192.168.122.155
>> Port:       58422
>> Family:     512
>>
>> The package is visible in wireshark but oob_recvmsg does not return:
>> No "= 6 bytes received: Hello" and no second transmit.
> 
> Ok, I totally misinterpreted your previous post, sorry for
> that. Brain received -ENOCOFFEE.
> 
>>
>> It looks like the auto assigned and bound port from connect() is not forwarded
>> to the oob stage, so no data is received in oob_recvmsg().
>>
> 
> This is exactly the point, indeed. Could you please try this branch [1]?
> The two commits on top improve the situation with your test code here.
Thanks for the very fast fix. Connect works now as expected. And I was able to remove the workaround.

I switched to libevl r58, r57 did not work any more. Is there any visible link libevl->kernel? I just
got an operation not permitted in oob_sleep_until.

But there are two new issues:

-oob_sendmsg returns "Invalid argument" errno 22 exactly every second. The last number is the
system time in ns.
ERROR: oob_sendmsg Invalid argument 22 806999652287
ERROR: oob_sendmsg Invalid argument 22 807999655503
ERROR: oob_sendmsg Invalid argument 22 808999650416

I have this with the exact same code as before using bind() and also with the now working connect().
There are 3000 tx / 1000 rx packages/s.

I tried do{oob_sendmsg}while(errno == 22) but that resulted in a full freeze of the PC.

-The last commit a4cc7967 on the next branch doesn't compile. Just FYI, I took one commit before, so I was able to test it.

Error:
In file included from ./include/evl/sched.h:14,
                  from ./include/evl/lock.h:9,
                  from ./include/asm-generic/evl/net.h:8,
                  from ./arch/x86/include/dovetail/net.h:6,
                  from ./include/net/net_namespace.h:41,
                  from ./include/linux/netdevice.h:38,
                  from ./include/net/sock.h:46,
                  from mm/memcontrol.c:67:
./include/evl/thread.h: In function ‘evl_unblock_kthread’:
./include/evl/thread.h:415:9: error: implicit declaration of function ‘evl_schedule’; did you mean ‘io_schedule’? [-Wimplicit-function-declaration]
   415 |         evl_schedule();
       |         ^~~~~~~~~~~~
       |         io_schedule
./include/evl/sched.h: At top level:
./include/evl/sched.h:290:20: warning: conflicting types for ‘evl_schedule’; have ‘void(void)’
   290 | static inline void evl_schedule(void)
       |                    ^~~~~~~~~~~~
./include/evl/sched.h:290:20: error: static declaration of ‘evl_schedule’ follows non-static declaration
./include/evl/thread.h:415:9: note: previous implicit declaration of ‘evl_schedule’ with type ‘void(void)’
   415 |         evl_schedule();
       |         ^~~~~~~~~~~~

> 
>>
>> But might be evl was never intended to work using connect() in classical UDP client style?
>>
> 
> IMO, the evl netstack (and evl in general) should follow the POLA
> principle as closely as possible, and any UDP user can reasonably expect
> auto-binding to be handled. So this needs fixing.
> 
>>
>> If you think this this example is useful, I can finalize it (for now with the bind() workaround) and also add a server mode.
>> So there would be 4 modes in total. With a server mode, you can run the server on one host, the client on the other and continuously
>> send data forward / backward and measure delays. I would use:
>> -T send (previously it was -S but then I have nothing for server)
>> -R receive
>> -S server: Waits for data and sends a response for each received package.
>> -C client: Sends data and measures how long it takes for the server to response.
>>
>> As an alternative, I could just create a second example oob-net-udp-server-client.c. This would result in a bit of duplicated code but not to much.
>>
>> What do you prefer?
> 
> It is definitely useful. I would go for option #1, i.e. integrated
> send/recv/server/client example. First because all the boilerplate and
> ancillary support for parsing options and setting up connections is
> already there and the code running the client scenario to be added is
> likely small enough.
> 
> Next because the I'd rather have a 'client' mode measuring round-trip
> times explicitly in the context of some example code, rather than
> letting people think that we would actually provide a 'ping' command
> that way. Reason is about performance: the standard in-band ICMP server
> is operated from kernel context; although the latency would bite
> compared to any oob-based server under high load, on average the figures
> obtained on an idle system would be somewhat misleading compared to the
> oob server in application space, because reinstating a userland context
> for handling ICMP requests may be more time-consuming than handling it
> directly as close as possible from the packet delivery point in kernel
> space, i.e. without entailing any context switching to userland (even to
> an oob thread).
> 
Ok, I will finalize this and send a patch.

>>
>> I also created oob-net-ping in the same style as oob-net-icmp but this sends out a ping, receives the response
>> and measures the delay, similar as the ping command:
>> ./oob-net-ping -i enp7s0 -a 192.168.122.1
>> [0] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=317.1us
>> [1] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=218.5us
>> [2] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=252.5us
>> [3] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=320.1us
>> It has to be cleaned it up a bit and integrated it into the libevl repo but then I will also send a patch.
>>
> 
> I think we need a simple agent somewhere in the evl netstack in kernel
> space answering ICMP_ECHO requests flowing in oob channels directly,
> just like the in-band stack does for in-band traffic. I can look into
> this.
The oob-net-ping sends out pings, so basically the inverse of the existing oob-net-icmp. Now you can run
oob-net-ping on one machine and oob-net-icmp on the other to ping between. For my application, I use it to ping an FPGA
board to see if the connection basically works.

ICMP_ECHO would help in some cases, but ^ works also.

> 
> PS: thanks for the test code you provided, it saved a lot of time on my
> end.
You are welcome, I had to create it anyway to understand what was going wrong. Thanks for the easy to understand example
code, helped me a lot to create the test code.

> 
> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/next/v6.12.y-cip-evl-rebase?ref_type=heads
> 

