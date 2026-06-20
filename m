Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E432B127
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976510; cv=none; b=DGr1HamFdciuifNCwd6+Jc/qQ/WGlub64fttrKY26tNekFybzYncIPYOhIiK0cn5jr0aJolnHge3ksy18cew5PYGCF2fbfP6lSGMbcL41hl1XOZRz/vVGUH7qqxXYxLyntfVQ+oUbkxZ2ikdiWBzvdMpHqs/Nbj+e1lJU4Fzmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976510; c=relaxed/simple;
	bh=SlnOpZHsU/q8WuNUA3WbiX1GotqXct4pXvLd+l2aRE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIN9rUVt0aG6fZ+lUXvH5XblGgbBh5CTNuwVKzWIt1fQPtqfMY2VyUnCyMPHJ0kRZ6wcz98PGPLO0BkPa9W8RtIDtT7g0f31RDLnX5XfJ0cyqycA0rJeewP0Sj6Wen2EmQkVc88TzrKtqeSKc7MMB1UFXqbAQtbl6LUkyp+samI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=fPjwWkbE; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="fPjwWkbE"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E20CC3F56B;
	Sat, 20 Jun 2026 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781976505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftvKz+uwA1bpGm9DWblA0vbW4pPbfozdqXGNf80ST44=;
	b=fPjwWkbER2K+glLG1FXJCmThOm7uG7b//5pbh59IAQF4oTjQMT6YiDNQBZeGv3fm5ZAxOK
	f+GPCDc2thhxsd8kcAjHR1PUfbpzz7xDWChrdcxhoP1y7oARmsvMthzTiu1z8afxHYhCLK
	rTRvaopU6Fuz1fBBWDUQBLMl7qD9Rl9VhDkVBw9fGM+FlryDXoZJ8smfN+cGQpYCELu9sH
	bCyxvTI3T6VpbU0klpecGxyAoouK5MV834bR9N5NaGeIwkzwxU18z6Wnua4xgAPh/mM0Vw
	T1n6Q+2lLRAAbAel1CBeOfays+1ighE1uuzO5NCfbXk8oS2OWG/X/fORU2hHIg==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
In-Reply-To: <3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com> (Hannes
	Diethelm's message of "Mon, 1 Jun 2026 22:02:58 +0200")
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
	<20260528194459.6117-2-hannes.diethelm@gmail.com>
	<87a4te64vn.fsf@xenomai.org> <874ijm62yu.fsf@xenomai.org>
	<3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 20 Jun 2026 19:28:24 +0200
Message-ID: <87ik7d86kn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGVe8/9XZjUI50Qt1B30DGEVM3Xnard5irqgKtpvqTWxvbRN0TLUXu/KBsTzvq4yH2j7sPYeKUN9kIBoH5AC4mE1WC8+CMfKqqZEDzV3d5C3MRsCW0OZotgFKNTd/1QfC48qhMz4EKWEYYVK2jSXaELT42YVD/4wzYWzXp8NgDBlRynsjRvCVVuknY1QHy74goY8xUsOTNkOjtbh86ZCllSbdS7cYi6RFDDz2EQpQSYVs8zSJ1Ep34uW0ZixCLPhu/d7CfOkk6MpvRU+vFv8ERqPr04/0WhZnwvX2s92M0wa/OnCYjJzVqZSwtKTGpeqxnq1fUPa5tcAEUW8bs5/UCfglmgJpEDqqyFdWJHktGOkziA1TAFrUnuQZXjGJcxtRG8zlI9lh8nutzXbsOURcLbYOKwkrqME741UzP48Of6kH9tapzp3D5RbUaCXw1nlrmKDlpaaAQPv9A+gGLEj2MGAsyQI+dkLQUMnRXF7GlwAc0jRFxcq0QfVME7nn3K6ok7Gtf16N+Tze6HydR/bgNOczeNqEag5oPMGZt54EK+Apdrj9LkBbq2M7AzhQQmk4MFy6PIl2bywnw8FEkRfyRx0HkNdLITd8KhnsAwDftcDlg4kTO8/hHt5we7IkcpDvuwV18OcyVRygXmXqxyZj/iaFcynDwWltDiXzHxcAZb0g
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 01.06.26 um 11:10 schrieb Philippe Gerum:
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>
>>>> This fixes random EINPROGRESS at init or during runtime.
>>>>
>>>> Also correct whitespaces and make stdout more consistent.
>>>>
>>>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>>>> ---
>>>>   tidbits/oob-net-udp.c | 58 +++++++++++++++++++++++++++++++++++++------
>>>>   1 file changed, 50 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/tidbits/oob-net-udp.c b/tidbits/oob-net-udp.c
>>>> index 11b8459..7af834f 100644
>>>> --- a/tidbits/oob-net-udp.c
>>>> +++ b/tidbits/oob-net-udp.c
>>>> @@ -50,12 +50,12 @@ static void usage(void)
>>>>   }
>>>>     static void print_addr(char* text, struct sockaddr_in *addr){
>>>> -    char ip_str[INET_ADDRSTRLEN+1];
>>>> -    inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
>>>> -    evl_printf("%s--------\n", text);
>>>> -    evl_printf("IP-Address: %s\n", ip_str);
>>>> -    evl_printf("Port:       %d\n", ntohs(addr->sin_port));
>>>> -    evl_printf("Family:     %d\n", addr->sin_family);
>>>> +	char ip_str[INET_ADDRSTRLEN+1];
>>>> +	inet_ntop(AF_INET, &(addr->sin_addr), ip_str, sizeof(ip_str));
>>>> +	evl_printf("== %s\n", text);
>>>> +	evl_printf("   ip-address: %s\n", ip_str);
>>>> +	evl_printf("   port:       %d\n", ntohs(addr->sin_port));
>>>> +	evl_printf("   family:     %d\n", addr->sin_family);
>>>>   }
>>>>     static void sender(int s, const char *text, int mcount,
>>>> @@ -226,6 +226,8 @@ static void client(int s, const char *text, int mcount,
>>>>   	free(tbuf);
>>>>   }
>>>>   +#define SERVER_ADDR_LIST_SIZE 64
>>>> +
>>>>   static void server(int s, const char *text, int mcount,
>>>>   		struct sockaddr_in *addr, int iter)
>>>>   {
>>>> @@ -236,6 +238,9 @@ static void server(int s, const char *text, int mcount,
>>>>   	ssize_t ret;
>>>>   	char *tbuf;
>>>>   	char rbuf[16384];
>>>> +	in_addr_t addr_list[SERVER_ADDR_LIST_SIZE]={};
>>>                                                    ^ missing whitespaces
>>>> +	size_t addr_list_fill=0;
>>>> +	bool solicit_done;
>>>>     	tlen = (strlen(text) + 1) * mcount;
>>>>   	tbuf = malloc(tlen);
>>>> @@ -276,6 +281,39 @@ static void server(int s, const char *text, int mcount,
>>>>   			evl_printf(" (TRUNCATED)");
>>>>   		evl_printf(": %.*s\n", (int)ret, rbuf);
>>>>   +		/*
>>>> +		 * We need to call evl_net_solicit for each new
>>>> +		 * client once before sending data. This will break
>>>> +		 * realtime for the first response.
>>>> +		 * If this is not done and the ARP address is not
>>>> +		 * yet in cache or garbage-collected, oob_sendmsg
>>>> +		 * will return EINPROGRESS on start or during runtime.
>>>> +		 */
>>>
>>> We can happily send redundant solicit requests to the core, no need to
>>> filter out cached addresses, evl_net_solicit() will do the right thing.
>>>
>> Except that doing so would always demote the caller to the in-band
>> stage, which may not be what you want. The fact that we'd need to
>> maintain a cache in apps in order to figure out whether solicitation
>> should be done shows a shortcoming in the core, users should not have to
>> do this dance.
>> We should have an oob call for probing the route+arp caches with
>> ipv4. I'll look into this asap.
>> 
>
> Yes, this is the reason I do it this way and print out a message if
> this happens.
>
> I think server mode with multiple clients in real time is not something you
> can just easily do without careful considerations what happens when multiple
> clients send a message at the same time or TDMA behind. My intent in this example
> is mostly to show that it is possible.
>
> A real application would need one of these options:
> - A thread only for solicitation so the main thread doesn't get blocked
> - evl_net_solicit() with a flag like MSG_DONTWAIT and then poll in the main loop if
>   the client is ready
> - Know the clients in advance
> - A warm up phase during clients can connect
> - ...
>
> However, a way for probing and reading the arp would shurely help.

Here is a general proposal to deal with the issue of sending UDP packets
to unplanned destinations, which is basically what the server mode has
to do, when receiving unsolicited messages.

We have a single invariant to cope with: the evl network stack wants to
use the routing+arp information produced by the regular in-band stack,
so that we can benefit from potentially complex routing logic without
reinventing that wheel. Therefore, the route to any new/unsolicited
destination must be resolved by the in-band stack once so that we can
send UDP packets to that peer from the oob stage next.

From the point above, and as you pointed out already, an oob sender must
either plan for reaching a particular destination (e.g. soliciting it
prior to entering time-critical code), or accept an initial delay for
the route to be resolved if the destination is not yet known on first
transmit (i.e. out of the oob caches).

So, I would say that evl could meet the requirements you stated above by
implementing the following:

- Honor MSG_PROBE for oob_sendmsg(), so that only the general call
  sanity and route resolution to the destination host is performed when
  set in the request flags, without actually sending any data. On
  success of such call, we would know that the routing information is
  readily available from the oob caches, no offload to in-band would
  have happened if we had not given this flag. The absence of routing
  information to the destination from some oob cache would yield a
  specific error, so that the caller may decide what to do next.

- Extend the effect of receiving MSG_DONTWAIT (and more generally
  O_NONBLOCK on fildes) to what we would do upon missing routing
  information: if present, return with a specific error code _without_
  relaying the packet to the in-band stack. The caller may then decide
  to handle the case locally. Otherwise, proceed as usual (i.e. relay to
  the in-band stack, then notify the caller with -EINPROGRESS).

- Provide a way to synchronize with the route resolution process in evl,
  i.e. a syscall that would block until a given destination is available
  from the oob cache. This call already exists, evl_net_solicit() can be
  used for that purpose (if a resolution request is already in flight,
  subsequent ones to the same destination won't cause any harm).

Points 1 and 2 are implemented in [1]. Feedback greatly appreciated and
important when you have time. Usability for real-world applications is
key.

> It would also be nice to have an "evl net" command to list the
> entry's. I tried the normal arp command but it doesn't behave nicely
> with evl.

Could you please elaborate on this issue? Currently, updates to the
in-band cache are propagated to the oob cache (by registering a hook
into the relevant notifier chain in the kernel). So I would expect all
destinations of interest to oob which are visible from the in-band arp
cache to be available from the evl map as well.

This said, I agree that we need a way to inspect the oob cache
specifically. Working on it.

[1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/wip/net-solicit?ref_type=heads

-- 
Philippe.
