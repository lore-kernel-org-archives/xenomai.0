Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9A372EE9
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652506; cv=none; b=oBoK5EaW00tx/083VF78GOTJR/fTWCqz5AKAGIpOs3zfRIROtyftM4gOVE/KgGXow9kQKeED/Jh0TGHQfC3NiKywqjlI7N95NTLOfammSTbPLz1eBi5q/fnM1Htx+7vYu60G0P8+XhFfDZxzm3qOJAy8FkRi+KbCBk2IygXHtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652506; c=relaxed/simple;
	bh=dYoEktHqXBtlP34kduwqmlBLmWpYzRM9x4CLRd/UGPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ixQ/KwFyQdFfpk3n6mZPAVOsmNxcIo6/KRe/IY0wmU4XixXeum7rEPWVigtAYAwNuLcTedyY0mhTGVqtK2ulsavslf4C0UMZHfp3gG2F14ylBBtx0RJxYEiEiXlIMPJwlypZkGIWhhi6urdQNwlBT8p4AN/5R5Qz5ZJVA56mHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=hmMEHhps; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="hmMEHhps"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20C843ECDC;
	Tue, 21 Jul 2026 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784652496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwOUCOOmBf3Vz3EpIsVIILfCQDfgBcH0wG8iQfl6XpE=;
	b=hmMEHhpsmU0o9zb013SjA0FOBUpbpRiNlMeq5UQW7gctl7q4pvlL64jOwdB2ro5fD/GxcJ
	GM6giTmoHjzoVXUXnBz7rXBAWBeFuZ8weGRMBtUn6b//1GwITufB1crlQzNrmpJFP+UMXa
	b8NRNcTTyExz7dfDYtTQTi0F8JVg8XMu+ZdTP2klIZO1P7l97xkT/j+aVUJVE/lF2PfQ8t
	9VgW3nJ16h85ijzjPN+1WIzok7HKQU92suDVjIu3xPdVhcx/dNzhflP5Kvd3K5L5SKLCM2
	Zisk1qA+ilZJiTMIKQPOrrA4ri4InvfPQE+sOPif8RqiMksjtfDWLzvR9YHOPA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
In-Reply-To: <87se5ckcgr.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	21 Jul 2026 09:51:00 +0200")
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
	<87se5ckcgr.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 21 Jul 2026 18:48:15 +0200
Message-ID: <874ihsi90w.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEpwGO4ETaniUuZ+qXFpZ60+o+WFNmv5pmJnHPkjks4bEevU4QCf0jzDXCj881Ml+A6SzJbLmx2nE5MjztggEY9PNnfxrUN13+ek+9+PtCT4KNDrI/UH+m5sI6ZlVpPPB7UoaX8JHGCujm+9QeTloU1Gbx5wLub+gKtKrVg/gb/+kvh7HC8kOam/R6SzIkDBRYtBEZwP1XQLcl/N5ZpOWr5oPh6f8s/VuCPVthLqvWfpqggr5K/nPdyi88vBtVhN8isOKCugUpI9FtpVMqYPffApLa+IVZmJcnswqDZ6RVyukeXrzLQTAOyrCcx+Jbr9hgCGC2y9gHXHvxJUOQx+F4xAIYNYgNwYXH/Rp+2EJ1+WkpiME6HYHFwSA9CyRenu0EpVfKdn7SoP1v9H/ZP79WsUFoI4fkIx8yhKw4uCXjznbMXOJN/LAF01oFfeSVQxdkadPm6t6kv2hONBIo4wVVRdfSTDzs0vxEyoDKlBtOje4qRDiEersuyp+oXz1XtztTJMQEIes+5dOohom89HQuEQnOGdxYv4YvBbjmLnUW0H6mUfDvsuYTag02duRFJ3gYly8Yp70nx4d1gaktTFx8iQbQxC63sYN7qgGE9TBDH4kiwbP9kQYZxdwzVeG3mj+VLzyUoD46UdYDyP2KBooICUT/N2DQDYlEMdJx5KrbeNQ

Philippe Gerum <rpm@xenomai.org> writes:

> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>
>> Am 20.07.26 um 16:27 schrieb Philippe Gerum:
>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>> 
>>>> Am 04.07.26 um 19:52 schrieb Philippe Gerum:
>>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>>
>>>>>> Am 20.06.26 um 19:28 schrieb Philippe Gerum:
>>>>>>> - Honor MSG_PROBE for oob_sendmsg(), so that only the general call
>>>>>>>      sanity and route resolution to the destination host is performed when
>>>>>>>      set in the request flags, without actually sending any data. On
>>>>>>>      success of such call, we would know that the routing information is
>>>>>>>      readily available from the oob caches, no offload to in-band would
>>>>>>>      have happened if we had not given this flag. The absence of routing
>>>>>>>      information to the destination from some oob cache would yield a
>>>>>>>      specific error, so that the caller may decide what to do next.
>>>>>>
>>>>>> It seams the flag MSG_PROBE is kernel only? I did not find any occurrence
>>>>>> in /usr/include or in libevl.
>>>>>>
>>>>> Yep, my bad. Using MSG_PROBE is not the right way, since that would
>>>>> conflict with MSG_PROXY in userland which has a totally different
>>>>> meaning. I have revisited the implementation, simplifying it actually:
>>>>> since the evl netstack already accepts zero-sized messages, sending such
>>>>> a datagram to the UDP layer now amounts to returning early with the
>>>>> address resolution status, short-circuiting the logic before the actual
>>>>> transmission happens.
>>>>> IOW, passing a NULL or empty iov into the msghdr struct does what
>>>>> MSG_PROBE was intended to do.
>>>>
>>>> I tested this variant. It works. But I wonder:
>>>> If I use:
>>>> ret = oob_sendmsg(s, &msghdr, NULL, 0); errno is set to EHOSTUNREACH
>>>> If I use:
>>>> ret = oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT); errno is set to EWOULDBLOCK
>>>>
>>>> Is this intended? EHOSTUNREACH is like halve correct. Yes, the host can not be reached
>>>> but only due to no ARP request is sent.
>>>>
>>> EHOSTUNREACH was intended as a way to distinguish from EWOULDBLOCK
>>> wrt
>>> lack of buffer space for the outgoing message, this code was the only
>>> option close enough to the idea to be conveyed available from the errno
>>> list that would not conflict with other situations. Now, since such
>>> probing mode needs no message space in the first place, this is guarding
>>> against the impossible, which does not make sense. Returning
>>> -EWOULDBLOCK in both cases above would still be
>>> practical. e.g. something along these lines:
>>> diff --git a/kernel/evl/net/ipv4/udp.c b/kernel/evl/net/ipv4/udp.c
>>> index d819616c3b5b..5912a1fbcfb5 100644
>>> --- a/kernel/evl/net/ipv4/udp.c
>>> +++ b/kernel/evl/net/ipv4/udp.c
>>> @@ -417,22 +417,22 @@ static ssize_t send_udp(struct evl_socket *esk,
>>>   	 * address.
>>>   	 */
>>>   	ret = find_egress_path(esk, daddr, &ert, &earp, &pseudo_earp, msg_flags);
>>> -	if (ret == -EMULTIHOP)
>>> -		return ret;	/* MSG_DONTROUTE cannot be honored. */
>>> -
>>>   	if (ret) {
>>> +		if (ret != -EHOSTUNREACH)
>>> +			return ret;
>>> +
>>> +		if (datalen == 0)
>>> +			return -EWOULDBLOCK; /* Address probe failed. */
>>> +
>>>   		/*
>>> -		 * No route known from the front cache - bummer. We
>>> -		 * may have to offload the transmit operation to the
>>> -		 * in-band stack, unless only probing or MSG_DONTWAIT
>>> -		 * is set.
>>> +		 * We have a message to send but no route was found in
>>> +		 * the front cache - bummer. We may have to offload
>>> +		 * the transmit operation to the in-band stack, unless
>>> +		 * only probing or MSG_DONTWAIT is set.
>>>   		 */
>>>   		if (msg_flags & MSG_DONTWAIT)
>>>   			return -EWOULDBLOCK;
>>>   -		if (datalen == 0)
>>> -			return ret;
>>> -
>>>   		/*
>>>   		 * We always charge the socket even when offloading to
>>>   		 * the in-band stack although we won't consume any
>>> 
>>
>> I think in this case, it is fine as it is. You also won't expect EWOULDBLOCK or EAGAIN as long as you
>> don't set MSG_DONTWAIT.
>>
>> But now there are two ways of probing. Either with or withouth MSG_DONTWAIT that behave slightly different.
>> Might be just support MSG_DONTWAIT -> EWOULDBLOCK and drop the other
>> variant?
>
> You mean detect a probing request when receiving MSG_DONTWAIT and a
> zero-sized buffer? That is an option. Another option would be to always
> return EHOSTUNREACH/??? on failed probe regardless of whether
> MSG_DONTWAIT is set. I would preferably go for the second option iff we
> can settle on a unconfusing, unambiguous error status.
>

Ok, I believe that the best option is to go back to an explicit
operation flag for probing eventually, because all other options seem
confusing.  Therefore MSG_PROBE handling was resurrected [1] in the udp
layer, and EHOSTUNREACH is unambiguously used to denote a failed probe
if MSG_PROBE is set.

As you pointed out, the MSG_PROBE definition is missing from the common
socket.h bits in user-space, but the same flag value is defined as
MSG_PROXY in *libc headers, which looks like obsolete. Anyway, to
address this, MSG_PROBE was added to the evl/uapi bits with enough
guards to prevent conflicts or mismatches. It defines the constant
expected by the kernel, which is very unlikely to change since this
belongs to the part of the ABI which is written in stone.

The commit log states the possible outcomes depending on the operation
flags and/or size of the message passed to oob_sendmsg().

[1]
https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/566f032dc3bc4c3e945e94887b7f57cd6e57dfb6

-- 
Philippe.
