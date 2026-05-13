Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C138B130
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656756; cv=none; b=cFCmBS334x4vCb1P8dqWw6YLT0H8Ult5xrkQzjDRcg7f/W9BnvhfdyVvxELD/0rfTuhH6dujcED3YWVXitvgCjpogYl51xis+cwsPpOsPJWhQRKZEx8TSYFR0JuE500zzkqss1tQYxp9bu2x7++WwulSY1YfFhSRxNHTTmYOE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656756; c=relaxed/simple;
	bh=euP4QhEfCBU0ANSfXKLYNMPFR/k2YbJfX5i5FO88r0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YYN6h4w8tAIjwQPlno25o1i4qczrYKfAgbf9o9RsGKDDpcnRecioUilxzA6RK5+7MdmxJKGin5gxSrClcmhmVnllKWq243kHjf1SdeQ/JKT8EDGcYtTkldezr3Z8KygCYl7vK/3YLdt1qfvNLuMUJfjKue9Hrtfe15SEB8OSgkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=U3+q6ptm; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="U3+q6ptm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EDFB3EBB0;
	Wed, 13 May 2026 07:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1778656746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euP4QhEfCBU0ANSfXKLYNMPFR/k2YbJfX5i5FO88r0k=;
	b=U3+q6ptm+Dvyfs9GMw3IpKZC1sKZZxiiekcUNHcr9ZqUdG7UmFpFJNbBGBhS6wJtx7ibFS
	nXmzs97XIH73TkZbyKb6hdTYApn/mJ5MBEdMp2YcH2gRMClwySS+VhXCwNYYhaBIvJaMQi
	puHKJVmXjrX6c4XZSGeZZ8DI8YBUzYILV37Ltr/T5DOuIrNAfZ9XMBBKEb+EPzktu6ZSoi
	YX/DYIesI3otrnMbFtGzZOJ7pBDpoRqg3uOT+wcW5nXgfI89u/kTpLGIsPfBLRCki55eih
	ol/1pOsMK1hZwVn9waANYFAoNPqdKzNLaL22iWm5Ys1OP+WTA/6zSTtV3hBkIw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>,  xenomai
 <xenomai@lists.linux.dev>
Subject: Re: Getting time in realtime kernel driver
In-Reply-To: <e7e975fa-9879-43d1-9f28-60507e1563be@siemens.com> (Jan Kiszka's
	message of "Wed, 13 May 2026 07:36:01 +0200")
References: <131f-6a035380-221-a70b1c0@235187577>
	<e7e975fa-9879-43d1-9f28-60507e1563be@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 13 May 2026 09:19:04 +0200
Message-ID: <875x4rixp3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEFRkr0ALkGZKJA6UtsT1om8fJkWsnQ2aJY++nw9n+ll5xlL+MbYpD0eMIwpI4i5D6mKoNgQ25h1Tz2zRY6n5ZOrSDspD6f4NMKe7YRGwsSRPmD5czVXuSl1QQ9AONKu8BeqlY6+PMWOYa12Ti/41nwGtr0gFGqEiO934qmTVeKx4ml4RyucdcIdTuSUvvsT6DIWUNiAGABFIM1dqBIdxBBD4a2tUkJCQmmf9tP6VGqudGS5+4BpybuAsx9jYbbHGbGTEH+whsFh13wtcdRudwoL5jMnIIrlRGmmjsoVU03/vqQpI99npp7Ru0Np72R8xQvVM6hFNimTJChJMsSFIpQANqgB/ZGNcs8H6ol6LBxZ8IqvTwSv80fbVXgiRuA20iYmYvmj/dO7oI2OfDgXTe+poiasLIx8enYOqBkJByZYYGiUrZmgF3M/U6o7cq0gN+hwKuG7BdJCxOqbMLeZSUA0Q1uz6w/wG3zWkzbjnxOEV8kwoR1X7Kfq0cCpxoomj4XVeugBAT2Zlqw+5RsSwd9Kgv37L0yh3hJviReBroM14ag0IoPL2zhWppTouK1c6BUYev8H5C84AEFOzTIy50PcW6DmUWPRYlEF9iQ4LvnsnRcM/uWC17sgbihp37u6FD6NGXatrssqSbRcX1z/2Bjpd3fRiIrV6TNMIY+Ghjwvg

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 12.05.26 18:20, Fran=C3=A7ois Legal wrote:
>> Hello,
>>=20
>> I think I already asked about the same question some time ago, but I thi=
nk I did not get a working answer, so here I am again.
>>=20
>> On xenomai 3.2 + Ipipe (linux 5.4), I need to be able to get in a RT dri=
ver the current linux wall clock (impacted from NTP or PTP).
>> I found out I get the correct value with ktime_get_real_ts64. Was willin=
g to use __ktime_get_real_seconds but this one is not precise enought for m=
y application.
>>=20
>> So my question is : is it safe to use ktime_get_real_ts64 from within an=
 RT driver ioctl function, and if not, which API in xenomai gives the exact=
 same time as this one ?
>>=20
>
> Nope, it's not safe, neither under legacy I-pipe (your kernel is dead
> BTW) nor latest dovetail. Userspace access to the wallclock was hardened
> for out-of-band accesses, but in-kernel had no use case, thus was never
> considered.
>
> For userland, the easiest answer is moving to a dovetail kernel and then
> using CLOCK_REALTIME. Over I-pipe, we had to model this via a separate
> clock named CLOCK_HOST_REALTIME.
>
> Jan

This may help:

"ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime."

Caveat: with this variant, timestamp is not guaranteed to be monotonic
across an update.

--=20
Philippe.
