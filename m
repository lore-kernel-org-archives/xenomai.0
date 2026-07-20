Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F73B811F
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557648; cv=none; b=JvTGUgvRywM7ZsH154J7OJgHgqBR+7+y9swwoH3oWfNI6rXTOaodI1WoxG0L+UU68xhgRpMgJYIv2rSYUWszpSRpLfMtOr9lUldzpn9ewYXpX2d8y/nm0WtFYrhz58NRNkJ7FrbSn+g2/ohkzBIgl6eBLJOUkQAGqDnUy1bGY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557648; c=relaxed/simple;
	bh=wgIB6u9JNbQnXtzup9Td0lWx3nKWntF54IJLYLFh5Ho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q0f9eCZtYO4Suj6/UcDffKAxE8aTIP+j3nG4qY/SKWMfrBHmvyhTNe+iTpSmahJxhwTvgItxalItbE3oa1kmwknSTl4SL5zVPrsPkNmkGg7ZHtmsDJha3Jul+g5Q/5L6NgPqZ4rFDWxC+hcmMRDxrdZ2sNU1ND+u+M+L4miGJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=BafaXMPK; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="BafaXMPK"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C013B3EBBE;
	Mon, 20 Jul 2026 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784557638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQLzsreQPPpuLBcdwZmfJq13+TjwFK9BDHsJdPrKcjw=;
	b=BafaXMPKiX4LGA55i0322DqS6RN318vVm5fGoTuqaxHG1S8XHDApa4Aj9sZem1pl+z+vN5
	XGZN3ETA8upiDWdb9Q5qdcp1/ALxxafZvLUfLq6Q63Fhj/M5DAbemmX0GROrP7zHXqqP4n
	5X8whLCdfrvtUDgaILbT/xUa9tJO2i/UFmlGIihREikCy1CzM8Ex8uYHbtFJRvqJ9AAfC+
	yWuuJ2gzmDGOea/odkew2kgMGGWOVeC44d3jgA54xRsWDfB8IMDikqTvOc/N8vauTuFbck
	M5zlrF6RygUQG/7UuK09Q9pO9iuvECUTPCTWlEqXI1Rllm0Bc6cjnBbWo/pYGA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
In-Reply-To: <13bb8457-8148-4758-84d5-1ab324e978bd@gmail.com> (Hannes
	Diethelm's message of "Fri, 17 Jul 2026 21:19:03 +0200")
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
	<20260528194459.6117-2-hannes.diethelm@gmail.com>
	<87a4te64vn.fsf@xenomai.org> <874ijm62yu.fsf@xenomai.org>
	<3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com>
	<87ik7d86kn.fsf@xenomai.org>
	<6c0d9a13-732b-49c5-886b-3dda8b1f5cab@gmail.com>
	<87o6gmzlpn.fsf@xenomai.org>
	<13bb8457-8148-4758-84d5-1ab324e978bd@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 20 Jul 2026 16:27:16 +0200
Message-ID: <8733xd20u3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEuYjK+D8THlpKfYyiAXc2L431I4LYng6JrMd+2RqQi/pAIKWu+JYBw0Bf3WjBxcF16lrU6M2wd0l51cJHHdkGkB1XFcTCEjuV5NRLeaHbcertgXUUpmZKaivyQ+qnP4erCmLnVLuzTK6gklTNVnmZJuJapidjganzslWpvMo5VOnw6gB2NYOdCx6fxBU4oFjt250C/FPR309Puyh63kXfUVLCpBME9Lp4BUk7Yur5GQ9M1bTmLorO6QymwykRGMl1DAABGhLk5Y3z5qmTBhXp+0z4xpoatZweFK42Pv8HMU64C86gU9hchsMRq+M3cFkFilsf+cCCXcjA1A+kdB39AX5aSxkZx99jh5kE8Ehdfhr6CeiUMxTeWkzDROo82tqMAMXJ0W97C8l7FlADtSGVxb3GtYevaeWqxiohquebHWpSIWewfYAMYQE6PQmBqHoZjT/GJeFryU7SuUUv3K2PmXY8XUslKoCDDJndwIlJRkUeE8rS4IM7PmCTB7/+nQKm4dj8uSPKYmc9jDwscgxAUKivRZhhl2vrbzMaaJyZi1anYRQfMZjDbz13woWSwkqmgtZCwFMIk7pwkL2067TLKbVV3tdZ6aZxlpzFRI/8rsQnNJEWwAdf0/A5WsbkIQt+ybFrWRLyi4dYpqNQ9kfChPaj3P02RjG/HC19KWdnHbA
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 04.07.26 um 19:52 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>> 
>>> Am 20.06.26 um 19:28 schrieb Philippe Gerum:
>>>> - Honor MSG_PROBE for oob_sendmsg(), so that only the general call
>>>>     sanity and route resolution to the destination host is performed when
>>>>     set in the request flags, without actually sending any data. On
>>>>     success of such call, we would know that the routing information is
>>>>     readily available from the oob caches, no offload to in-band would
>>>>     have happened if we had not given this flag. The absence of routing
>>>>     information to the destination from some oob cache would yield a
>>>>     specific error, so that the caller may decide what to do next.
>>>
>>> It seams the flag MSG_PROBE is kernel only? I did not find any occurrence
>>> in /usr/include or in libevl.
>>>
>> Yep, my bad. Using MSG_PROBE is not the right way, since that would
>> conflict with MSG_PROXY in userland which has a totally different
>> meaning. I have revisited the implementation, simplifying it actually:
>> since the evl netstack already accepts zero-sized messages, sending such
>> a datagram to the UDP layer now amounts to returning early with the
>> address resolution status, short-circuiting the logic before the actual
>> transmission happens.
>> IOW, passing a NULL or empty iov into the msghdr struct does what
>> MSG_PROBE was intended to do.
>
> I tested this variant. It works. But I wonder:
> If I use:
> ret = oob_sendmsg(s, &msghdr, NULL, 0); errno is set to EHOSTUNREACH
> If I use:
> ret = oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT); errno is set to EWOULDBLOCK
>
> Is this intended? EHOSTUNREACH is like halve correct. Yes, the host can not be reached
> but only due to no ARP request is sent.
>

EHOSTUNREACH was intended as a way to distinguish from EWOULDBLOCK wrt
lack of buffer space for the outgoing message, this code was the only
option close enough to the idea to be conveyed available from the errno
list that would not conflict with other situations. Now, since such
probing mode needs no message space in the first place, this is guarding
against the impossible, which does not make sense. Returning
-EWOULDBLOCK in both cases above would still be
practical. e.g. something along these lines:

diff --git a/kernel/evl/net/ipv4/udp.c b/kernel/evl/net/ipv4/udp.c
index d819616c3b5b..5912a1fbcfb5 100644
--- a/kernel/evl/net/ipv4/udp.c
+++ b/kernel/evl/net/ipv4/udp.c
@@ -417,22 +417,22 @@ static ssize_t send_udp(struct evl_socket *esk,
 	 * address.
 	 */
 	ret = find_egress_path(esk, daddr, &ert, &earp, &pseudo_earp, msg_flags);
-	if (ret == -EMULTIHOP)
-		return ret;	/* MSG_DONTROUTE cannot be honored. */
-
 	if (ret) {
+		if (ret != -EHOSTUNREACH)
+			return ret;
+
+		if (datalen == 0)
+			return -EWOULDBLOCK; /* Address probe failed. */
+
 		/*
-		 * No route known from the front cache - bummer. We
-		 * may have to offload the transmit operation to the
-		 * in-band stack, unless only probing or MSG_DONTWAIT
-		 * is set.
+		 * We have a message to send but no route was found in
+		 * the front cache - bummer. We may have to offload
+		 * the transmit operation to the in-band stack, unless
+		 * only probing or MSG_DONTWAIT is set.
 		 */
 		if (msg_flags & MSG_DONTWAIT)
 			return -EWOULDBLOCK;
 
-		if (datalen == 0)
-			return ret;
-
 		/*
 		 * We always charge the socket even when offloading to
 		 * the in-band stack although we won't consume any

> For oob-net-udp server mode, this variant is a bit wastefull due to oob_sendmsg() would
> either always be called twice or I would have to keep the list of clients.
>

Which brings back the option of some MSG_xxx operation flag so that we
could pass a valid buffer _and_ a probing flag, but then we'd need
Dovetail to add one to the standard list (in userland) because I don't
see any standard one to piggyback off of.

>> 
>>>> - Extend the effect of receiving MSG_DONTWAIT (and more generally
>>>>     O_NONBLOCK on fildes) to what we would do upon missing routing
>>>>     information: if present, return with a specific error code _without_
>>>>     relaying the packet to the in-band stack. The caller may then decide
>>>>     to handle the case locally. Otherwise, proceed as usual (i.e. relay to
>>>>     the in-band stack, then notify the caller with -EINPROGRESS).
>>>
>>> So the oob-net-udp server code can be changed to use MSG_DONTWAIT and
>>> if the return value is EWOULDBLOCK, call evl_net_solicit() and try again instead
>>> of holding a list of IP's right?
>>>
>> Yep.
>
> This works nicely, I will send a patch changing oob-net-udp server mode to use this.
>
> The only disadvantage is that if for what ever reason, the client is already in the ARP
> cache but not permanent, it is cleared after a timeout, so evl_net_solicit() can happen
> later than expected.
>

Yep, because at the moment, the core mirrors to the front cache all
insertions and deletions happening into the inband cache
unconditionally. We could force a permanent state for any entry we are
about to insert into the front cache in order to prevent what you
described, but I'm wary about unwanted side-effects.

>> 
>>>> - Provide a way to synchronize with the route resolution process in
>>>> evl,
>>>>     i.e. a syscall that would block until a given destination is available
>>>>     from the oob cache. This call already exists, evl_net_solicit() can be
>>>>     used for that purpose (if a resolution request is already in flight,
>>>>     subsequent ones to the same destination won't cause any harm).
>>>> Points 1 and 2 are implemented in [1]. Feedback greatly appreciated
>>>> and
>>>> important when you have time. Usability for real-world applications is
>>>> key.
>>>
>>> I am a bit busy right now, but I would like to test it. However, It can
>>> take a week or two.
>>>
>> Np. Your contribution has been valuable, so it's worth waiting for
>> it.
>> 
>>>>
>>>>> It would also be nice to have an "evl net" command to list the
>>>>> entry's. I tried the normal arp command but it doesn't behave nicely
>>>>> with evl.
>>>> Could you please elaborate on this issue? Currently, updates to the
>>>> in-band cache are propagated to the oob cache (by registering a hook
>>>> into the relevant notifier chain in the kernel). So I would expect all
>>>> destinations of interest to oob which are visible from the in-band arp
>>>> cache to be available from the evl map as well.
>>>>
>>>
>>> The issue was on my side, I need to run "arp -n" so it does not resolve host
>>> names. Otherwise, it takes quite some time. But this makes sense, with OOB
>>> active, it will never receive the answer on the request, so it times out.
>>>
>> Ok, this is not user-friendly. I'll have a look.
>> 
>>> By the way: Since some time, all incoming network traffic goes to the OOB
>>> stage when it is enabled. However, all outgoing traffic from the in-band stage
>>> is still sent. Would it make sense to block all outgoing traffic after
>>> "evl net -ei" except might be ARP requests if they are initialized by evl_net_solicit()?
>>>
>> I believe this may break some use cases I'm aware of. Some people do
>> currently use such asymmetry between ingress-oob and egress-inband on
>> the same interface on purpose.
>
> In this case, it is fine.
>
>> 
>>> At the moment, this is done using nftables for linuxcnc, this works fine
>>> for preemt_rt and xenomai, so not really needed.
>>>
>> Currently, it is assumed that any outgoing inband traffic has a
>> purpose,
>> even on an oob-enabled interface. What kind of egress inband traffic
>> could/should be dropped safely when flowing through an oob interface?
>
> Mostly unintended traffic by either user error or some running services
> sending discovery messages to all interfaces. Using nftables works nicely
> so there is no real need to do anything else.
>

Ok.

>> 
>>>> This said, I agree that we need a way to inspect the oob cache
>>>> specifically. Working on it.
>>>> [1]
>>>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/wip/net-solicit?ref_type=heads
>>>>
>> 
>
> I've seen this commits are already on v6.12.y-cip-evl-rebase? I did these tests on v6.12.y-cip-evl-rebase.

Yep, because this probing mode is here to stay, although I'm considering
another way to provide this using a dedicated MSG_xx flag. Problem ATM
is that I'd like not to pollute the namespace uselessly by creating
non-std flags. This said, it may be legitimate to extend the existing
set in this case.

-- 
Philippe.
