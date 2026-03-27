Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CAE3D75B4
	for <xenomai@lists.linux.dev>; Fri, 27 Mar 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600409; cv=none; b=hngOJpRverCIv04fQvUZVKilx3CtKmkjjioUyT4d/pX8Ic4GbGGgV1NQFk+3LyAK6MtafHZ1jUozRK7ijAMmc3nSp7Lnl6A3N0lC3JJlFwevTD1dkJdqJ0Y2JTTg2uQ278xP194ZTy7VE4+xEGz2E4jOWLGr2rJHojXb759Lpko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600409; c=relaxed/simple;
	bh=tjVJm7wSBMoGHYmoL5XK6ngBrseGtkyklwSoETvV6F0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k7Knee2yiF8ZUdgf69iqvkaMUaZF+xGNOSYXi3I9SM0NTr8vdpvfkh/E+eDZ1hUfmTnFu3Gr5x5a/4RGaDXIsAttWO4YV+0+c6/+9xNA7j5XkLKmWauTmP8UC1aUQrFKfOKdebziqZYeMv/W3BFp9IezdyLfFRxBPFrQjeo/WrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=RC2FyEHX; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="RC2FyEHX"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E0B83ED61;
	Fri, 27 Mar 2026 08:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1774600398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUVH0VO6A9yecC8dPbxxOEpT89fl4scSw9GHRYcMtaU=;
	b=RC2FyEHXkWz8MwpZfjMpu3RzymineO5nRNYJAFhr7qpfdQTHiLxBFnRj47TOwXhsL5yoTt
	NjX5Mwc2mjx9T1KYh2XUISimdCxpzFe3rjRyUY5icn8DwroYTbnpFqTRj15nvLd28XjVJc
	pKW7FMvmArTuZaonKB2bBTpmNWpDYQUcdEsfp62u90DWnix5TcBBQ3i6pCzCWpsnOxA7s6
	zz3tGWmYHRAIlqBjnY3q1GoedUhxAGp0CzYUPmxi5ajwTJf1xYvgJFzHIGCMStnsjTRq6n
	UUvEv7OXaaeVmFkKoFeLC9YrBcbQZLN4R0IxoFPSMLg2PAXswkPOfG2g0hZIwg==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail] net: skbuff: add missing OOB stubs for
 !CONFIG_NET_OOB
In-Reply-To: <5d2efb94-81c2-4243-9801-3ccb7a4a29a7@siemens.com> (Tobias
	Schaffner's message of "Thu, 26 Mar 2026 10:03:35 +0100")
References: <20260320211911.2151219-1-tobias.schaffner@siemens.com>
	<877br0j725.fsf@xenomai.org>
	<5d2efb94-81c2-4243-9801-3ccb7a4a29a7@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 27 Mar 2026 09:33:13 +0100
Message-ID: <87ecl5r7sm.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdelkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepvdfgtdeukeefgfffiedupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Hi!
>
> On 3/25/26 15:51, Philippe Gerum wrote:
>> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>> 
>>> skbuff.c calls skb_mark_oob() and variants behind runtime running_oob()
>>> checks but these are only implemented in the CONFIG_NET_OOB section.
>>>
>>> Add the missing stubs to the !CONFIG_NET_OOB section.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>   include/linux/skbuff.h | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>> index 73dd4a58d181..1278d0a58677 100644
>>> --- a/include/linux/skbuff.h
>>> +++ b/include/linux/skbuff.h
>>> @@ -5630,6 +5630,22 @@ static inline struct sk_buff *get_oob_skb(void)
>>>   	return __get_oob_skb();
>>>   }
>>>   +static inline void skb_mark_oob(struct sk_buff *skb)
>>> +{
>>> +}
>>> +
>>> +static inline void skb_mark_oob_released(struct sk_buff *skb)
>>> +{
>>> +}
>>> +
>>> +static inline void skb_mark_oob_timestamped(struct sk_buff *skb)
>>> +{
>>> +}
>>> +
>>> +static inline void skb_mark_oob_managed(struct sk_buff *skb)
>>> +{
>>> +}
>>> +
>>>   #endif	/* !CONFIG_NET_OOB */
>>>     #endif	/* __KERNEL__ */
>> All current users of skb_oob_mark_*() calls are currently guarded by
>> CONFIG_NET_OOB sections, or enable CONFIG_NET_OOB, like the evl
>> core. Did you observe a build failure with CONFIG_NET_OOB=n, or is it
>> preventive fixup?
>
> I am building without CONFIG_NET_OOB at the moment and the build fails
> because of the unguarded skb_mark_oob calls in net/core/skbuff.c.
>

Correct, I overlooked the call to skb_mark_oob() introduced in
v7.0. Merged, thanks.

-- 
Philippe.
