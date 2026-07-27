Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72EF3CF051
	for <xenomai@lists.linux.dev>; Mon, 27 Jul 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141429; cv=none; b=tVNq1aB10ueqPFuz1ydjYcA0BquZ+dRDFgfPKbS8c2mO6PkwgxGMEJ8RurAwimlbwcCBmUAN/pHRPZyHH7eDP3th2gVS30wLJktPIsvi9thkYu1x1ktSLxi77rVsEZyWylztxWrz58AZDBch6wxv/zZDI1fyWJi5YNzSDeAOPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141429; c=relaxed/simple;
	bh=ppcOqIk3JAO+KGyvEGPi0soY0S6vKOGqoq7IKp2+0WY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d0IYi8aOWy+1teY995OZg3VEezDMuNJHnmvfcMUEbIyM6ag0qN+nTGZBmwmWpSsiqCTdDDlt6xGHvO5kJlSOf/SI/BcZhvjNsRieVp9+mFP7Y7thaQ/7MwGliOVyPMFtodNzv0LfS5BDu0anrjgay09BcaT97HzJj12AjpJ3UHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=X6Jiyiyf; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="X6Jiyiyf"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 779AB3E972;
	Mon, 27 Jul 2026 08:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1785141416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m87J+qOBY+g5wI0RVSOvcsPrtdeomeAyQPYMBSYaCJg=;
	b=X6JiyiyfNp2M4JiLMZxxyBQCmh98cycaHVjT3p+ZSUkHdSIHc+uOONXadNt6UBP+m+9GP6
	np3haEu4ri4LVyLeo5WcwFEW7BxM2y+QECHfgmnSbuNqq7r2ObAa8F/LKkhtJnLjOJtcb9
	yTzjbYPtVsEoFQ4wUvBNTvphutzPgBoHPEv0dyx7C0yEp77nQlBOgHrdRxuQtonqkI6/SJ
	BU8nXq2DP7Z8e0siuwoUo0CrSyVQySeXm3ZhM+Gxub3w5dCLPzJ1yoNAULD+oZ4muBYkxI
	PPY3S43zpI/e7XlqoGmrSsSFtEJXZwzZ9DcaTJnHU7cMZ2UnMWN1VGK3KsZgHw==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
In-Reply-To: <eda638e0-cabb-4b3c-9dc3-bd5ee4d167f4@gmail.com> (Hannes
	Diethelm's message of "Sat, 25 Jul 2026 00:07:19 +0200")
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
	<87jyqodrq0.fsf@xenomai.org>
	<3105aa6e-ba08-4e5a-b228-233473aa5675@gmail.com>
	<dc6c2532-08e4-417d-85dd-8d2e89b34ae7@gmail.com>
	<87h5lrh503.fsf@xenomai.org> <87tspqg9bu.fsf@xenomai.org>
	<fc1b080c-54ed-4449-8958-fd8be91e1d8f@gmail.com>
	<87cxwe170w.fsf@xenomai.org>
	<eda638e0-cabb-4b3c-9dc3-bd5ee4d167f4@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 27 Jul 2026 10:36:55 +0200
Message-ID: <875x207rrs.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTF6Vys6DH9sDcGRoKQKdvVEiXX2y5y/KYtdcT73k5BgM8l1NhUVpdchJl4UJRbXUeozbgheiE01Bc78RykE+G2ppaOvCQMAsBnebnTDKs2h8qbh1vJiDGNm2lQ2rD1Iaj04BJ6fkDz6sC1iwXSf6Kiv/wxlkz8YJzR2QDN4Y027pP7NqVEv+ev/Xzl4BznRW0DPezCK7UkdBimWBw77vTf8DK6x+LsIMyyT8EsEvyHaBUQuwe3VzushizM06EhpmzXayP8agC0CdXUwK4QuzTodMyc5mOLxdWSKfMEisLgixHf39ntQIPH4gSwh53vTrMNdZZMPaqVdBtGqw9NjRvLCZ+IhoT0PXeWc4282pPIFKD+p2tTVmZKEflRbUo7MQcz4JwkJaoLfkv66Irc5z06vQS90voiq/NFiHmEq+cyS2toNWs7GWLo3dCxyMkFLlukSXBqlQCx4hHVUttjM+195GTm3+TxOkgkVpWU/uBguwdO1Tm2dgvElpzxC6RjKruUt0zOM0HWNHE957FEjbGdWTNyw2pn8P1htyZY/LQfaSuaxSbvuwLEjcQ62F+zsKaXnmzzSRUWCA2UHXdWI6wMQ45XYU6YbR5DNjU/miuYELqvowQBtj31vnmRu1LptufZDbxHZwdM6E2XhaLruJJUm9534s1VtrPVho62Lki7zHg
X-GND-State: clean

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 23.07.26 um 09:47 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>=20
>>> Am 22.07.26 um 20:36 schrieb Philippe Gerum:
>>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>>
>>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>>
>>>>>> Am 22.07.26 um 00:36 schrieb Hannes Diethelm:
>>>>>>> Am 21.07.26 um 22:15 schrieb Philippe Gerum:
>>>>>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>>>>>
>>>>>>>>> Am 20.07.26 um 16:27 schrieb Philippe Gerum:
>>>>>>>>>
>>>>>>>>> An option would be either to support of oob_ioctl() for
>>>>>>>>> SIOCGARP. Or create something like
>>>>>>>>> evl_net_routeinfo(s, addr) returning flags would make probing obs=
olete.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Not entirely. The issue with solely having SIOCGARP or any probe-o=
nly
>>>>>>>> explicit request is that you would have to pair two syscalls at ea=
ch
>>>>>>>> transmit at least, one to probe for the sender address before poss=
ibly
>>>>>>>> soliciting that peer if absent from the oob cache, another one for
>>>>>>>> sending the message eventually. i.e., for every packet:
>>>>>>>>
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 ioctl(SIOCGARP)
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !ATF_COM?=
 -> evl_net_solicit()
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 oob_sendmsg(..., 0)
>>>>>>> You are right, that is an unneeded syscall as long as you don't keep
>>>>>>> a
>>>>>>> list of clients as before. This can remove the need from calling
>>>>>>> evl_net_solicit() in the case the client is already in ARP and
>>>>>>> permanent but
>>>>>>> this will be the only change and won't help that much.
>>>>>>>
>>>>>>>>
>>>>>>>> OTOH, with the latest attempt to address this issue, we can send a
>>>>>>>> probe-only request by passing MSG_PROBE (EHOSTUNREACH), or a reque=
st
>>>>>>>> that does not attempt to defer transmit to the inband stage on pro=
be
>>>>>>>> failure by passing MSG_DONTWAIT (EWOULDBLOCK). i.e., for every pac=
ket
>>>>>>>>
>>>>>>>> redo:
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 oob_sendmsg(..., MSG_DONTWAIT)
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EWOULDBLO=
CK?
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 oob_sendmsg(..., MSG_PROBE)
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EHOSTUNREACH?
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 evl_n=
et_solicit()
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
redo
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 otherwise assume ENOMEM
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 otherwise=
 all done
>>>>>>>>
>>>>>>>> IOW, using a proper combination of MSG_DONTWAIT and MSG_PROBE in t=
he
>>>>>>>> right sequence would either succeed to send the packet immediately=
 on
>>>>>>>> the first oob_sendmsg() call, otherwise fail on memory shortage or
>>>>>>>> missing route from the oob cache. In the latter case, which could =
only
>>>>>>>> happen once for each new peer under normal circumstances, we could
>>>>>>>> disambiguate the EWOULDBLOCK status using an explicit probe.
>>>>>>>>
>>>>>>>> A better way to do this in a single step unambiguously would requi=
re the
>>>>>>>> addition of another operation flag, like MSG_DONTDEFER, preventing=
 the
>>>>>>>> deferral to inband on failed probe and causing oob_sendmsg() to re=
turn
>>>>>>>> with a specific error code. e.g. something as simple as the follow=
ing
>>>>>>>> would cover all requirements:
>>>>>>>>
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oob_sendmsg(..., MSG_DONTDEFER) -=
> EADDRNOTAVAIL on failed probe.
>>>>>>>>
>>>>>>>> Now, we might also piggyback off of MSG_OOB instead of defining yet
>>>>>>>> another operation flag, as a way to say "oob only, don't relay to
>>>>>>>> inband", but I'm still pondering whether this would be nicely witt=
y or
>>>>>>>> utterly confusing..
>>>>>>>>
>>>>>>> Yes, this is a variant. I was not aware that MSG_DONTWAIT ->
>>>>>>> EWOULDBLOCK
>>>>>>> can also mean ENOMEM.
>>>>>>> Now after considering all options, i start to prefer the variant
>>>>>>> before
>>>>>>> this patch, keeping a list of already solicit'ed clients. It is str=
aight
>>>>>>> forward, simple and fast. And you know exactly when to expect an in=
 band
>>>>>>> call. Might be we should just drop this patch instead of adding unn=
ecessary
>>>>>>> complexity for example code?
>>>>>>
>>>>>> BTW: With drop this patch I don't mean the one already in but this o=
ne:
>>>>>> [PATCH] tidbits: net-udp: use MSG_DONTWAIT for server mode
>>>>>> https://lore.kernel.org/xenomai/20260717192541.15829-1-hannes.diethe=
lm@gmail.com/T/#u
>>>>>>
>>>>>
>>>>> Got it, it may be worth waiting for the dust to settle in the core
>>>>> regarding the probing issue before adapting this tidbit anyway. I'm
>>>>> going to consolidate the points we have discussed so far, in order to
>>>>> come up with an implementation that satisfies all the requirements.
>>>> Here is a new proposal that should cover all the cases we discussed
>>>> so
>>>> far (next/v6.12.y-cip-evl-rebase branch). A new flag is introduced,
>>>> namely MSG_STEADY, which tells the core to only accept cache lookups
>>>> that deliver permanent ARP records. This flag can be combined with
>>>> MSG_PROBE and MSG_DONTWAIT for extended semantics. Meanwhile, a
>>>> zero-sized message is still accepted in order to request a mere address
>>>> probe without having to pass any meaningful data. This goes like this:
>>>> Function: probe-only
>>>> 	      oob_sendmsg(s, &msghdr, NULL, MSG_PROBE)
>>>> 	          -> EADDRNOTAVAIL if no peer address found
>>>> Function: probe-only, permanent peer address required
>>>>     	      oob_sendmsg(s, &msghdr, NULL, MSG_PROBE|MSG_STEADY)
>>>> 	          -> EADDRNOTAVAIL if no permanent peer address found
>>>>                        (also upon match of aging ARP record)
>>>> Function: send, no deferral (to inband) allowed
>>>> 	      oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT)
>>>> 	          -> EADDRNOTAVAIL if no peer address found
>>>> 	          -> EWOULDBLOCK on memory shortage
>>>> Function: send, no deferral (to inband) allowed, permanent peer
>>>> address required
>>>> 	      oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT|MSG_STEADY)
>>>> 	          -> EADDRNOTAVAIL if no permanent peer address found
>>>>                        (also upon match of aging ARP record)
>>>> 	          -> EWOULDBLOCK on memory shortage
>>>> Function: send, permanent peer address required
>>>> 	      oob_sendmsg(s, &msghdr, NULL, MSG_STEADY)
>>>> 	          -> EADDRNOTAVAIL if no permanent peer address found
>>>>                        (also upon match of aging ARP record)
>>>>
>>>
>>> Looks promising. This also means after
>>> oob_sendmsg(..., MSG_DONTWAIT|MSG_STEADY)
>>> no second call oob_sendmsg(..., MSG_PROBE) is needed to handle
>>> -ENOMEM right?
>> Correct.
>>=20
>>>
>>> oob_sendmsg(s, &msghdr, NULL, 0) is the only case with deferral to inba=
nd
>>> as it looks in udp.c:421...423?
>>> if (ret !=3D -EADDRNOTAVAIL ||
>>> 	msg_flags & (MSG_PROBE|MSG_DONTWAIT|MSG_STEADY))
>>> 		return ret;
>>>
>>>
>> Open question: does it still make sense to have MSG_DONTWAIT prevent
>> the
>> deferral to the inband stage, now that MSG_STEADY can be used for this?
>> i.e.:
>>=20
>>>> Function: send, no deferral (to inband) allowed
>>>> 	      oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT)
>>>> 	          -> EADDRNOTAVAIL if no peer address found
>>>> 	          -> EWOULDBLOCK on memory shortage
>> Not considering MSG_DONTWAIT (alone) anymore as a way to prevent
>> deferral would make MSG_STEADY the only option for this, tightening the
>> requirement from "any cached destination address" to "permanent
>> destination address". This being said:
>> - If $user wants a sure shot wrt to oob transmission, then a
>> permanent
>>    address is most likely desired, in which case MSG_STEADY should be
>>    given. Otherwise, what would be the point of sending to a peer using
>>    an aging ARP record _and_ being concerned about timeliness and
>>    deterministic behavior in general (therefore denying deferral)?
>> - As it is, the implementation somewhat abuses the dont-wait
>>    semantics. As a matter of fact, inband deferral won't make the caller
>>    wait at all, only the packet will be delayed until the regular
>>    netstack picks it. Meanwhile, EWOULDBLOCK is conventionally paired
>>    with MSG_DONTWAIT, not EADDRNOTAVAIL.
>>=20
>
> MSG_DONTWAIT denying inband was only introduced in 644d55e78e8e, right?
>

Yes, this can still be considered as a tentative, undocumented so far.

> In this case I agree. Either you'd like to stay out of band now and in
> the future -> MSG_STEADY or you don't care -> 0.
>
> Otherwise, it might break already existing applications.

--=20
Philippe.
