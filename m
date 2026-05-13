Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983063AC0ED
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664208; cv=none; b=j59aglH3EVuMHORhUhCv/8ieO/OHt+s70PiJwcOR1q1ZuaCUPSwZvHd6mEmApRqWVhAlGbYG+qZ6p5Tu3K8TX24v0sdTrUmpwGQ3uK/WEiIYQ1fligZzb0ocVG+KxFMycwk6re0IKDBnnbYvv5VYlfmWoQZBsgTz8UuIi0aCq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664208; c=relaxed/simple;
	bh=hDJvglkly3DOl3+tE18bppQB/o2fRiulSa7B/Etz9nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WTwnG962/dWS51Ac/OiPJ4MDfcVEnMNoXfweZZ82Suc5DR0VmBcyDBBaU1M06mFZODvMKAFF/lHhJAtCs8ALxiK+7XCuFk2VB1BdR+RA5UIRRnl7/VpE9aw03v03SqkrhixztXvz4p6QytuognfhEUBZF8DG/C4VQH4tZAxAua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=EBr46Ai0; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="EBr46Ai0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C9303EBEF;
	Wed, 13 May 2026 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1778664197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kIX6XSvk33TbcXIeUbIHQL6RBwZXxmezHb65a/wgIU8=;
	b=EBr46Ai0wvYM7dy1hfV+bBbhK1ELxHOmDnZzxwlkUc8LTzXqjf11w9HEaUizXM56dmaYCJ
	2qBSutj/7ezr65WhsGnte++/1uJpaiZ26ienKBJ2sCSyZDLlt9SsMpJFuuvCTu+Xt7W3No
	KnT0Q/lkpMUFZoYhSxEeGIN1qY57CuYysITjeiYje0pFgotGd+lv9R65xPtBCkwJ+NluFa
	aVBzUwScLkdexfZYUWn4VMRlA2tmK92XDCKD6/fFBO0bgeW7o2JgxHdW7h49+kVGHD/v/B
	eLmReJVXY7tcJwbHXFL7d8pa+jjm8nRPov+bO47rqSHmI9o1AuUSXuUQ/t07SA==
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <francois.legal@thom.fr.eu.org>
Cc: "Jan Kiszka" <jan.kiszka@siemens.com>,  "xenomai" <xenomai@lists.linux.dev>
Subject: Re: Getting time in realtime kernel driver
In-Reply-To: <131e-6a043e00-27-5cd69880@210449648> (=?utf-8?Q?=22Fran?=
 =?utf-8?Q?=C3=A7ois?= Legal"'s message
	of "Wed, 13 May 2026 11:02:21 +0200")
References: <131e-6a043e00-27-5cd69880@210449648>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 13 May 2026 11:23:16 +0200
Message-ID: <87wlx7hddn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFoBO5f+9c3W4Wl6uZ1IL3RxX9lceXsj6lTdiNoCET9o+CysHNCe5aHFDF5AesKn/5tMFqDAtKoV1aZco+xW2oZRMfTFsa8TTfyw+N6s1eWtrjVZV+XgBQ9bcaRpEGF0JQn8aVlJT9cVl3vtCWk5RJCR1GWAFXJSeLezqi6z7R8WsLOG/O2sEDuwiP5iVXoywEltu9SyBMN782lnSm6r7exUTJN8Qhv5HkQ42nNVnJshKGOE4vXlKxu6Y2TwZVIOkDgPf8VcVuVf3AzdsBRRmvNM5LtMcRobQwtJkgWtQvYMBaMNLx0U5RyPT1gZh6z8JNAYReYAFD7+K70AIrVpfh5pthVn0fZnCEZSnMe+QISUBbk71qp8XjBmjwDQg1QV2ZI2t6SWoNNFcRsPsAW6zabMKAOZsu92BQYg/LBXTLZveUzytYl7lAUqtuX0Tivzg4Pd7SYkawvYvzc3aax6ktfaebKA7Pv/fNfFkQrpx6xglll0kIhcimewPM7KBRRb8hUYSfe4DI/6Cz1ETLFpfDFN37+oAFR+FG51qj2jQmTrD/hQeVjUYN69evJANZr78zlHEPGOJlJZev9o5O7mXlaJnFZctpeIx7o1B8aG0WeMBCvJKcS1R/m6YtLWF/VfgnKVJ2gx+S9JHtTUu14GkdvryRtKHxS3iZBzfVchnZ/oQ
X-GND-State: clean
X-GND-Score: -100

Fran=C3=A7ois Legal <francois.legal@thom.fr.eu.org> writes:

> Le Mercredi, Mai 13, 2026 09:19 CEST, Philippe Gerum <rpm@xenomai.org> a =
=C3=A9crit:=20
>=20=20
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>=20
>> > On 12.05.26 18:20, Fran=C3=A7ois Legal wrote:
>> >> Hello,
>> >>=20
>> >> I think I already asked about the same question some time ago, but I =
think I did not get a working answer, so here I am again.
>> >>=20
>> >> On xenomai 3.2 + Ipipe (linux 5.4), I need to be able to get in a RT =
driver the current linux wall clock (impacted from NTP or PTP).
>> >> I found out I get the correct value with ktime_get_real_ts64. Was wil=
ling to use __ktime_get_real_seconds but this one is not precise enought fo=
r my application.
>> >>=20
>> >> So my question is : is it safe to use ktime_get_real_ts64 from within=
 an RT driver ioctl function, and if not, which API in xenomai gives the ex=
act same time as this one ?
>> >>=20
>> >
>> > Nope, it's not safe, neither under legacy I-pipe (your kernel is dead
>> > BTW) nor latest dovetail. Userspace access to the wallclock was harden=
ed
>> > for out-of-band accesses, but in-kernel had no use case, thus was never
>> > considered.
>> >
>> > For userland, the easiest answer is moving to a dovetail kernel and th=
en
>> > using CLOCK_REALTIME. Over I-pipe, we had to model this via a separate
>> > clock named CLOCK_HOST_REALTIME.
>> >
>> > Jan
>>=20
>> This may help:
>>=20
>> "ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime."
>>=20
>> Caveat: with this variant, timestamp is not guaranteed to be monotonic
>> across an update.
>>=20
>> --=20
>> Philippe.
>=20=20
> Thanks Philippe.
>
> I tried this one, but I get the same result as with __ktime_get_real_seco=
nds, the date I get is always 1 second late (I get 52 seconds when the actu=
al clock is at 53).
>

What is the exact content of the timespecs?

i.e. as received from:

- ktime_to_timespec64(ktime_get_real_fast_ns()) in kernel space

- clock_gettime(CLOCK_REALTIME, &ts) in userland - assuming this is the
  way you retrieve the reference clock value to compare with.

--=20
Philippe.
