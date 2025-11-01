Received: from cockroach.ash.relay.mailchannels.net (cockroach.ash.relay.mailchannels.net [23.83.222.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67E51022
	for <xenomai@lists.linux.dev>; Sat,  1 Nov 2025 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014827; cv=pass; b=I9G36MKXmDM/mguu1W757PHYgEUKaEBI0e5Eer6LD5gu4OJHhbhD2V2VAZlyuMACM6j+2Mfl0igZH3r8d8iYCL6+d0Sysy5vfeFHuTmza5VgvbhK5wTwRAZmsD8rMhss1kSw6ojBHp+dHfQKeof7+fhcyb0h3BTH+pOZrn5VW9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014827; c=relaxed/simple;
	bh=tg4q/9M5EfohB0CQ2cmIJcsGRoQT0Ac7fNF3ooImmfg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H/Q8w1xXGKriiEqXvqhI34h6VPFMAqP4CuHrL8ko9FL1gbwyREilTJkLiqDD0tgXfhco+CQdME5EAkZBGa6NGwGu/vKumYKuFBI5jREpz1oLyj8UGzqIJgzCVE45+TBxP9HzAURBDDlvyHr+5UjHJ8ltM/mWbLDf3qHBpEtFejY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=3SC1WZhx; arc=pass smtp.client-ip=23.83.222.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="3SC1WZhx"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 17F9B561CBD;
	Sat, 01 Nov 2025 16:33:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a486.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.124.155.193])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8EDFB560BF0;
	Sat, 01 Nov 2025 16:33:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762014817; a=rsa-sha256;
	cv=none;
	b=1KSx/K9I/WkKESgJYL1xnMX5Vu7/MIZrR7sl8wyXV0JGqj5qyolxN5MA8h4XUxS4Lq43AH
	2BpgO7Vs5GP5qK9NklHufsLOv5IXFwuScSSayXnwP7vitB+w58KZnXExk0Pz4hzbhd1ulC
	y/iRH7yc84oN/BblXB3GoJkZvAuCJCM1JKS4UhBRi3plnEDn6nStbLzBzdDXBRxB1bhrT6
	F9OqZg6yszwfLV4/TNQsrKQXterw+WqyqhiYc8fu2C0cUWfWdQjPyieeSOOOCsey507X8u
	Gs/511wQV+9cLPGSatVBoeyA1uQi3gGz8Yi+uRBP6GJMgNoOaaaO2p3625E/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762014817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3DUS1xqgNl/cjm9KPa21yVoKLXLLe77JfbSLrCXFU04=;
	b=wN9OhbA4zENAxpvhYP5BcoSVZdUkcdgXOrHcS2ifJ8tgVXNd74Q8gStAx94sD03+i9yY2H
	ALq52mdDjWmJEeePA9KJLpxndh2vvibw2ijADozbLc4EWrMSwtVqwB5GXdpgc5zDetRw+y
	LAlVOFpdiNYFKtGOhkWAKTphTTtaak+RYaz4K0jKunUCro7DCVnT5qY0LZmPBgLY1fG9w9
	czZCP/fHKI5vReHrXrssLG0dlobnDesqgrLOO0VAD9A1yfR5aAa1jcUYnWKLPtKuD0Ge3O
	ey0cFoDVH5BGbeyI/qlsZO59Iht1FJfKvCPZnKvN8RB3YaJ2goiCEak6C0isCg==
ARC-Authentication-Results: i=1;
	rspamd-77bb85d8d5-7x8dz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Decisive: 11ff9eee23ac0c19_1762014817898_4168978489
X-MC-Loop-Signature: 1762014817898:3082226945
X-MC-Ingress-Time: 1762014817898
Received: from pdx1-sub0-mail-a486.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.155.193 (trex/7.1.3);
	Sat, 01 Nov 2025 16:33:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1762014817;
	bh=3DUS1xqgNl/cjm9KPa21yVoKLXLLe77JfbSLrCXFU04=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=3SC1WZhxhmz0qj7i1do+pXjWouRavPU66dDDT9bWYXPMrKlPV1XrChvWGhYQta+P/
	 HAmkDJPpiN5P7enaWq4k6Fssk2nhGFzM0PPFDElKhottOOBT++BDSTFqBsKDr6EcSc
	 3KeWL8JNpQmwxO4oZk0hj6/IOOjwcnCaehznfQjFj6LWRkenkwwxU9lsnuDlAIiEP0
	 A6Xium/KKdPCL0Ra5aoDgCZ5ssK1jv9ba0AjCwZtsUxn2CXARK3JFI8o64+SWWf7Sv
	 R9wltPtJdivr2V8NvALpaWrQkqwXCAfPumGnEy9KWsYBqpG3W+dHYoiHJfKqSf+Pwi
	 Il06oc4q0K1FQ==
Received: from giulios-MacBook-Pro.local (unknown [186.170.47.63])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a486.dreamhost.com (Postfix) with ESMTPSA id 4czNhJ6FPvz1wdd;
	Sat,  1 Nov 2025 09:33:36 -0700 (PDT)
Subject: Re: Unexpected switches to in-band
To: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk> <20676160-4572-d92d-4b33-ff4255946345@bela.io>
 <87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
 <f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io> <20251020094705.2ac256f2@wsk>
 <9d2bacac-8d70-f083-e926-21beee2207c2@bela.io> <87o6q1ad07.fsf@xenomai.org>
 <20251023155439.0170f987@wsk> <87a51djuor.fsf@xenomai.org>
 <20251027120535.7933c720@wsk> <20251027172505.29eecfb2@wsk>
 <875xbyawx7.fsf@xenomai.org> <20251029145125.71debaab@wsk>
 <20251030132602.2d1ccfcc@wsk> <87qzukuzy5.fsf@xenomai.org>
 <20251031165615.2c9f72f5@wsk> <87bjlnc9u5.fsf@xenomai.org>
 <20251101165957.12432bf4@wsk>
From: Giulio Moro <giulio@bela.io>
Message-ID: <58fcd922-3a50-74c5-bfee-01cbcb7e1e6d@bela.io>
Date: Sat, 1 Nov 2025 11:33:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251101165957.12432bf4@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi everyone,

> 
> CONFIG_COMPACTION=n - it also automatically set CONFIG_MIGRATION=n
> 
>  From the Kconfig dependencies CONFIG_MIGRATION=n -> !PREEMPT_RT [=n]
> (i.e. it can be only enabled when PREEMPT_RT is NOT)
> 
> I've just set CONFIG_COMPACTION=n (which also disabled the
> CONFIG_MIGRATION) and now I cannot reproduce the issue on my setup (i.e.
> v6.6.) anymore.
> 
> It looks like those (enabled by default) config options have slipped in
> silently and introduced the issue...
> 

I can confirm disabling CONFIG_COMPACTION and CONFIG_MIGRATION fixed the issue for me as well. Fun fact is that I started looking over these options when I first raised the issue, but then realised that evl check did not flag them as problematic, giving me a false sense of security ...
Without knowing much about the internals, in hindsight it makes perfect sense that the process was more likely to fail early on in the lifteime of the process and/or of the kernel than after it had been running for a long time: once the memory layout has settled, it's unlikely it will get moved again.

By the way, I was thinking that replacing an in-menuconfig warning (a la Xenomai-3) would be nice to have, instead of having to manually run evl check on the config file.
Thanks everyone!

Best,
Giulio

Łukasz Majewski wrote on 01/11/2025 10:59:
> Hi Philippe,
> 
>> Łukasz Majewski <lukma@nabladev.com> writes:
>>
>>> Hi Philippe,
>>>   
>>>> Hi Łukasz,
>>>>
>>>> Łukasz Majewski <lukma@nabladev.com> writes:
>>>>    
>>>>>>> Could you get me a trace which goes back up to two secs before
>>>>>>> the time reported by evl about the inband switch of the timer
>>>>>>> responder? e.g.
>>>>>
>>>>> Why is it 2 seconds? Is it related to latmus "refresh time"?
>>>>> (which is 1s)
>>>>>     
>>>>
>>>> Picking this delay is purely heuristical. Such a long backlog is
>>>> likely going to include the smoking gun, if any.
>>>>    
>>>>>>>
>>>>>>> [   75.214527] EVL: timer-responder:743 switching in-band
>>>>>>> [pid=745, excpt=14, user_pc=0x77d08492a5fe]
>>>>>>>
>>>>>>> In the above case, I would need a trace going back to
>>>>>>> 73.214527 or so.
>>>>>>
>>>>>> Apparently the ftrace buffer was too small. I will adjust it to
>>>>>> store more data and share results.
>>>>>
>>>>> It is also interesting, that:
>>>>>
>>>>> bash-5.2# echo 16384 > /sys/kernel/debug/tracing/buffer_size_kb
>>>>> bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
>>>>> 16387
>>>>> bash-5.2# evl trace -eirq -f
>>>>> tracing enabled
>>>>> bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
>>>>> 131
>>>>>
>>>>> Reduces the buffer size...
>>>>>     
>>>>
>>>> Yeah, the evl-trace script is not that smart. I can see the issue
>>>> causing this, will fix.
>>>>    
>>>>> Hence, I've used the "normal" ftrace with enabled evl functions -
>>>>> the
>>>>
>>>> FWIW, EVL relies on the normal ftrace. However, evl-trace fiddles
>>>> with the sysfs entries manually, and may be a bit naive at times.
>>>> As Jan pointed out long ago, relying on the trace-cmd front-end
>>>> would be a better approach than tweaking ftrace's sysfs-based
>>>> controls manually at the very least. evl-trace adds EVL semantics
>>>> to the tracing configuration which is handy, but the way it is
>>>> done today may deserve a revamping, or maybe drop it entirely in
>>>> favor of trace-cmd if we have enough flexibility there in order to
>>>> introduce some EVL specifics.
>>>>    
>>>>> detailed information about the ftrace config is with log files:
>>>>> https://nextcloud.swupdate.org/index.php/s/czBd3Ydq9B9noZ7
>>>>>
>>>>>
>>>>> To extract the cpu2 specific data:
>>>>> bash-5.2# grep -rnE '\[002\]' Xenomai4-ISW-trace-6.6-logs.txt >
>>>>> cpu2.txt
>>>>>
>>>>> Here again the ISW happens in the cpu2 execution "hole":
>>>>> [  128.466459] EVL: timer-responder:736 switching in-band
>>>>> [pid=738, excpt=14, user_pc=0x7588e71985fe]
>>>>>
>>>>> Happens for cpu2 between:
>>>>>
>>>>> 11832546:          <idle>-0     [002] *..2.   128.466438:
>>>>> 	sched_idle_set_state <-cpuidle_enter_state
>>>>> 11832547:          <idle>-0     [002] *..2.   128.466468:
>>>>> 	handle_irq_pipelined_prepare <-arch_pipeline_entry
>>>>>
>>>>> However, now the log is large enough to inspect what has
>>>>> happened in the system for ~4s before.
>>>>>
>>>>>
>>>>> With the logs:
>>>>> timer-responder-738     [002] *.~2.   128.466214: evl_timer_shot:
>>>>> [proxy-timer/2] at 128.466467 (delay: 253 us, 66918 cycles)
>>>>>
>>>>> and after ISW:
>>>>>
>>>>> <idle>-0       [002] *.~1.   128.466469: evl_timer_shot:
>>>>> latmus_pulse_handler at 128.467208 (delay: 739 us, 195206 cycles)
>>>>>
>>>>> Why there is such increase in "delay" (253 vs 739 us) ?
>>>>>
>>>>> It looks like we have only 2us delay as the timer has fired on
>>>>> 128.466469 vs. expected 128.466467.
>>>>>     
>>>>
>>>> Ok, so the issue is still the same: for some reason, the
>>>> timer-responder thread is taking a (minor) fault when accessing
>>>> some memory, on its way back from the ioctl(EVL_LATIOC_PULSE)
>>>> syscall, or right after. This seems to be valid memory though,
>>>> just not immediately accessible, otherwise we'd have received
>>>> SEGV, which we did not.
>>>
>>> Yes, I also think so - like some "deferred allocation" despite of
>>> mlockall.
>>>
>>> Please find the logs with the below patch applied:
>>> https://nextcloud.swupdate.org/index.php/s/JXNW5bJrB3fQo5E
>>>   
>>
>> Thanks. I need to analyze the fault flags next week to see if I can
>> make something of these, but I just stumbled on an obviously
>> significant fact when looking at the multi-CPU view: the memory
>> compaction daemon is running asynchronously on other cores while the
>> responder is taking the fault. Compaction is all about moving memory
>> around to free larger physical regions, so updating PTEs will happen
>> as a result.
>>
>> Moreover, I could not reproduce the issue at hand, but I did not have
>> CONFIG_COMPACTION enabled. In the meantime, could you try disabling
>> this on your end, to see if the fault still appears?
>>
> 
> CONFIG_COMPACTION=n - it also automatically set CONFIG_MIGRATION=n
> 
>  From the Kconfig dependencies CONFIG_MIGRATION=n -> !PREEMPT_RT [=n]
> (i.e. it can be only enabled when PREEMPT_RT is NOT)
> 
> I've just set CONFIG_COMPACTION=n (which also disabled the
> CONFIG_MIGRATION) and now I cannot reproduce the issue on my setup (i.e.
> v6.6.) anymore.
> 
> It looks like those (enabled by default) config options have slipped in
> silently and introduced the issue...
> 
> 
