Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F434433058
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620267; cv=none; b=eRslIP4w9wugtA/zyhbkOWF1qI0BeBjZdmO4yPJda/MkSFyC5/OvAbCjyXeMrUh/7qUaU01zESwC5W3i+QO6o4ncugG+X1NbnpUV1dWLYxoByEDdY0Vi6S2Es7Cjsf3Wk4QK5K6WcVr8NemYCslZ1nOprhqleMVTRjjuuJUPMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620267; c=relaxed/simple;
	bh=ZFxwXNvEImu9M/xUZ1HpPOg/8MG3BL6GCld3wmB/dA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ObR4s3dkmjgCalRsCcrvK3NvVU8pRjOP5B45NMAD8e8BRxRgRn2foMMvz+6o/t+MPmny7CLRlnRTht8ru9QiutOj5fyF4Y//g9GGzPDvMUaeTLlIC0ugqLsvyWcIiBPGsuLGXf882r+r4zPNxkdJLcTkZ4goz+t/U3gIMehDNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ln+odeJ6; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ln+odeJ6"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 356041F75D;
	Tue, 21 Jul 2026 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784620262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ARSakIbMHekgpoqjkd9ZmsAN4b0FihILl6P8ElpcAg=;
	b=ln+odeJ63QPDzHrGuonULJBTeD4+S6Q7zqbBIMfCVCx1VoAJxn7AGK9vMKWVeYPowbxovr
	P6shzasmZ+BiS4/hF2jJQkqEIXM9iDDuC5GH2r3gVNIF55N4vIfFZa2ZP67XYrbQbzuzjP
	vxwjOOlQdQq+NA/BGeK/2NMn/jgfB0vU+tBx83do7Wr/j4LW9kQk59QuG9mLpzuKhxq1ms
	Z9D2fYKe/JAUtBvMkbWfJSs0FB4tItQ/91gDbaFKijDJAHDHXWrO5wDpCOHYvZC3PK0wYW
	75LNWDoCllXvneEVBr4YlLXxedI0Br9n7ltKrt1Cf8WhGRFtwLRJJesCNQj4CQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
In-Reply-To: <11409ae1-be7b-4003-8d40-f5e1cb34d2ec@gmail.com> (Hannes
	Diethelm's message of "Mon, 20 Jul 2026 22:03:52 +0200")
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
	<20260528194459.6117-2-hannes.diethelm@gmail.com>
	<87a4te64vn.fsf@xenomai.org> <874ijm62yu.fsf@xenomai.org>
	<3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com>
	<87ik7d86kn.fsf@xenomai.org>
	<6c0d9a13-732b-49c5-886b-3dda8b1f5cab@gmail.com>
	<87o6gmzlpn.fsf@xenomai.org>
	<13bb8457-8148-4758-84d5-1ab324e978bd@gmail.com>
	<8733xd20u3.fsf@xenomai.org>
	<11409ae1-be7b-4003-8d40-f5e1cb34d2ec@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 21 Jul 2026 09:51:00 +0200
Message-ID: <87se5ckcgr.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGOJCRIejnbBcrGsI2UryL41FR6125THwXJfzarE4MyuEc8wTwIgOXz6R59d6XDeQIsThjZz0jYw1VorjfYAjnbBhqQhPR4DZMc1LXz22tjPxkeOs2vV8OqMdFcieDtS2IWFmvgBMErkmxfidvWoCo/+nL+mZ9m06jf4+jZO3gFARR/mxq2NSGMzlVL3AKey2Zuda2ni6R3v7snEuUv3if0AwpOcK21vbd9y/ANN2VCA06kNaxqZ3xPInxVyQveu33eqIlAuJAQ4pGpgSeyS9r/9NKik+lArC6KllOznZfm7+odR6JgB3fSdJUEaWbac4o91PUfwKacebGQwfCX8t8TlfzWlBoQXbux9F3woGLHdpj1aOJCfrmxsVXCsmhJ9L1JdeTLNhw+j2qkN2h6orquJmTG+nlg8VizYnHNsHEZL+b6Hd/soUy3gtNscFAhIg5e6XrfFVHzJVr89m0OE/QK7rwjBJtkT0DENeTN+XvElVypxKGdP9UWH+BDyECgS50QBRVlaJBQN7yig303HIwK7stY/z7Eu7Pf8tm2NEEW/1rrLuFnQb9kQpnwmGQItdE6DFL1itgF1f2gqMfHTwoDPWt7HTQk3QvSUTyWnNNFaL3bkdqtLhwmmSQrRghmkybRX92+vszvY1seWxL58p/E4CS1T3/KWVdFKsgTLLjDcg

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 20.07.26 um 16:27 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>> 
>>> Am 04.07.26 um 19:52 schrieb Philippe Gerum:
>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>
>>>>> Am 20.06.26 um 19:28 schrieb Philippe Gerum:
>>>>>> - Honor MSG_PROBE for oob_sendmsg(), so that only the general call
>>>>>>      sanity and route resolution to the destination host is performed when
>>>>>>      set in the request flags, without actually sending any data. On
>>>>>>      success of such call, we would know that the routing information is
>>>>>>      readily available from the oob caches, no offload to in-band would
>>>>>>      have happened if we had not given this flag. The absence of routing
>>>>>>      information to the destination from some oob cache would yield a
>>>>>>      specific error, so that the caller may decide what to do next.
>>>>>
>>>>> It seams the flag MSG_PROBE is kernel only? I did not find any occurrence
>>>>> in /usr/include or in libevl.
>>>>>
>>>> Yep, my bad. Using MSG_PROBE is not the right way, since that would
>>>> conflict with MSG_PROXY in userland which has a totally different
>>>> meaning. I have revisited the implementation, simplifying it actually:
>>>> since the evl netstack already accepts zero-sized messages, sending such
>>>> a datagram to the UDP layer now amounts to returning early with the
>>>> address resolution status, short-circuiting the logic before the actual
>>>> transmission happens.
>>>> IOW, passing a NULL or empty iov into the msghdr struct does what
>>>> MSG_PROBE was intended to do.
>>>
>>> I tested this variant. It works. But I wonder:
>>> If I use:
>>> ret = oob_sendmsg(s, &msghdr, NULL, 0); errno is set to EHOSTUNREACH
>>> If I use:
>>> ret = oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT); errno is set to EWOULDBLOCK
>>>
>>> Is this intended? EHOSTUNREACH is like halve correct. Yes, the host can not be reached
>>> but only due to no ARP request is sent.
>>>
>> EHOSTUNREACH was intended as a way to distinguish from EWOULDBLOCK
>> wrt
>> lack of buffer space for the outgoing message, this code was the only
>> option close enough to the idea to be conveyed available from the errno
>> list that would not conflict with other situations. Now, since such
>> probing mode needs no message space in the first place, this is guarding
>> against the impossible, which does not make sense. Returning
>> -EWOULDBLOCK in both cases above would still be
>> practical. e.g. something along these lines:
>> diff --git a/kernel/evl/net/ipv4/udp.c b/kernel/evl/net/ipv4/udp.c
>> index d819616c3b5b..5912a1fbcfb5 100644
>> --- a/kernel/evl/net/ipv4/udp.c
>> +++ b/kernel/evl/net/ipv4/udp.c
>> @@ -417,22 +417,22 @@ static ssize_t send_udp(struct evl_socket *esk,
>>   	 * address.
>>   	 */
>>   	ret = find_egress_path(esk, daddr, &ert, &earp, &pseudo_earp, msg_flags);
>> -	if (ret == -EMULTIHOP)
>> -		return ret;	/* MSG_DONTROUTE cannot be honored. */
>> -
>>   	if (ret) {
>> +		if (ret != -EHOSTUNREACH)
>> +			return ret;
>> +
>> +		if (datalen == 0)
>> +			return -EWOULDBLOCK; /* Address probe failed. */
>> +
>>   		/*
>> -		 * No route known from the front cache - bummer. We
>> -		 * may have to offload the transmit operation to the
>> -		 * in-band stack, unless only probing or MSG_DONTWAIT
>> -		 * is set.
>> +		 * We have a message to send but no route was found in
>> +		 * the front cache - bummer. We may have to offload
>> +		 * the transmit operation to the in-band stack, unless
>> +		 * only probing or MSG_DONTWAIT is set.
>>   		 */
>>   		if (msg_flags & MSG_DONTWAIT)
>>   			return -EWOULDBLOCK;
>>   -		if (datalen == 0)
>> -			return ret;
>> -
>>   		/*
>>   		 * We always charge the socket even when offloading to
>>   		 * the in-band stack although we won't consume any
>> 
>
> I think in this case, it is fine as it is. You also won't expect EWOULDBLOCK or EAGAIN as long as you
> don't set MSG_DONTWAIT.
>
> But now there are two ways of probing. Either with or withouth MSG_DONTWAIT that behave slightly different.
> Might be just support MSG_DONTWAIT -> EWOULDBLOCK and drop the other
> variant?

You mean detect a probing request when receiving MSG_DONTWAIT and a
zero-sized buffer? That is an option. Another option would be to always
return EHOSTUNREACH/??? on failed probe regardless of whether
MSG_DONTWAIT is set. I would preferably go for the second option iff we
can settle on a unconfusing, unambiguous error status.

> Or is there a reason
> for the variant withouth MSG_DONTWAIT?
>

In fact, the original intent was to assume that receiving a zero-sized
message should be considered as a probing request. Then the effect of
detecting MSG_DONTWAIT too in this particular code path was overlooked,
which unexpectedly introduced another variant, which is indeed one too
many.

>>> For oob-net-udp server mode, this variant is a bit wastefull due to oob_sendmsg() would
>>> either always be called twice or I would have to keep the list of clients.
>>>
>> Which brings back the option of some MSG_xxx operation flag so that
>> we
>> could pass a valid buffer _and_ a probing flag, but then we'd need
>> Dovetail to add one to the standard list (in userland) because I don't
>> see any standard one to piggyback off of.
>> 
>
> Is there a reason to pass a valid buffer to only probe? Either you probe
> with a NULL buffer / size 0 or you pass a buffer and set MSG_DONTWAIT so
> the message is sent if possible. If not, evl_net_solicit() and retry.
>
> BTW: NULL buffer / size 1 fails. But it also makes no sense.
>

Yep, in this case, -EFAULT is a reasonable outcome since the key
argument is the message size. If the core is told that at least one byte
is valid, then a valid pointer to at least one byte should be given.

>>>>
>>>>>> - Extend the effect of receiving MSG_DONTWAIT (and more generally
>>>>>>      O_NONBLOCK on fildes) to what we would do upon missing routing
>>>>>>      information: if present, return with a specific error code _without_
>>>>>>      relaying the packet to the in-band stack. The caller may then decide
>>>>>>      to handle the case locally. Otherwise, proceed as usual (i.e. relay to
>>>>>>      the in-band stack, then notify the caller with -EINPROGRESS).
>>>>>
>>>>> So the oob-net-udp server code can be changed to use MSG_DONTWAIT and
>>>>> if the return value is EWOULDBLOCK, call evl_net_solicit() and try again instead
>>>>> of holding a list of IP's right?
>>>>>
>>>> Yep.
>>>
>>> This works nicely, I will send a patch changing oob-net-udp server mode to use this.
>>>
>>> The only disadvantage is that if for what ever reason, the client is already in the ARP
>>> cache but not permanent, it is cleared after a timeout, so evl_net_solicit() can happen
>>> later than expected.
>>>
>> Yep, because at the moment, the core mirrors to the front cache all
>> insertions and deletions happening into the inband cache
>> unconditionally. We could force a permanent state for any entry we are
>> about to insert into the front cache in order to prevent what you
>> described, but I'm wary about unwanted side-effects.
>
> Right now you can use evl_net_solicit(..., EVL_NEIGH_PERMANENT) to make shure it is
> permanent but this is an in band call according to the doc. So if you want to stay
> out of band, you need to probe.
>
> Now the probing doesn't show if the arp entry is permanent or going to disapear soon. So it
> can pass at the first try and fail later. Right now, you are better off doing evl_net_solicit()
> for every client if you want to be shure.
>
> With ioctl(s, SIOCGARP, &arp_request), you can check if the entry is permanent
> (arp_request.arp_flags & ATF_PERM) and then use evl_net_solicit(..., EVL_NEIGH_PERMANENT) if not.
> But the ioctl is also in band.
>
> An option would be either to support of oob_ioctl() for SIOCGARP. Or create something like
> evl_net_routeinfo(s, addr) returning flags would make probing obsolete.
>
> Flags could be:
> EVL_ARP_COM        Lookup complete (If this is not set, no ARP entry)
> EVL_ARP_PERM       Permanent entry
> EVL_ROUTE_MULTIHOP More than one hop away (Will fail with MSG_DONTROUTE)
>

Having oob_ioctl(SIOCGARP) which would perform a lookup into the oob
front cache managed by the core is perfectly doable, then we could
provide evl_net_routeinfo() as syntactic sugar building on it.

I would consider reusing the ATF_* flags directly instead of adding yet
another set of EVL_* flags only to alias to the former, since both
caches hold the very same routing entries, therefore do provide the same
information. In that sense, EVL_NEIGH_PERMANENT seems redundant since it
fundamentally means ATF_PERM. Documenting ATF_PERM in the API docs while
aliasing EVL_NEIGH_PERMANENT to ATF_PERM for backward compat may be a
reasonable trade-off, until we can drop the former in order to further
reduce the namespace pollution.

-- 
Philippe.
