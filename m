Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC933BED11
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317375; cv=none; b=s9qjotIk1SPSb7KRwCnDL9gSLO6E2cEvTUOxl4jcnZ0HUrc0hBThHWLxt4g0NeekjG1V0L9PMTpalbL0QZ2MhymK8sqSqtGixgW8whmvHAtVWrTMix8t0c73jCrPEnZmmqaSG05WRiTrlJjLzv6aez4sNN0a4IBmCTdOrXYLX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317375; c=relaxed/simple;
	bh=yVIfyjsg5C352sh8Tebo9OtRCTd0khpxdWxPLoPtlE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YRmDjwqC+XIxFS1wCFtReBYM6fvybH3hRDuBWu3NsgHvPksN6m5eJm5TC18nSoZTYWWWcBxixZwlJ434ayJ3mHZw5mbHCTWE5PNdVxvjDsslUz344eR61yYiBla/0ryj+PboOCycK8dkKdX32KrK5upZkee3pM/5R8OG5GUrEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=p0eeD6Vo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="p0eeD6Vo"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F09E3ED08;
	Mon,  6 Jul 2026 05:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783317371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=il0+aJgIOw01ZlHDPbZSCYyTqZQotz7mPH09bM7nqJY=;
	b=p0eeD6Vo7jNOc6WOPxjvI5xddy0ItN+RggDqTDfGmlKeyW9REgaxhzitEjqzwF7o3uw0x7
	QQ+pIpSEjWXWQEBzynpqKoUnIEFf8QKU0+i+rdE9dyC3HyOwbaG88BrJs5nueTkpSQyU4r
	caTlxYL4w2F4t8nkmP+PCHBxy9Ngeq5NKJ2ZO7CXRkXPZq1QrBbCOhTzp1Kri3U+uG2nkF
	TqluFMkwPoWY8uEjPzkjs0a/eXI+jzJoUqaZduCcD/Q0JgoU/ObOazcRQ+kJ/aJvY1MDqX
	wT8VU6raPoGO5ofXLbHbFxdAIm3z6gYhdxZJt/+PHjuktSMrf27piA7CD526Ww==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL: Kernel WARNING
In-Reply-To: <871pdhs7tf.fsf@xenomai.org> (Philippe Gerum's message of "Sun,
	05 Jul 2026 18:46:36 +0200")
References: <c88ccba0-23fd-4f4c-a182-0967e79adefb@gmail.com>
	<b5821b4e-cfd9-4255-ac8f-3de55a788d1c@gmail.com>
	<87h5mdmq6w.fsf@xenomai.org>
	<593465e6-53c2-4f54-8d4f-745b028ff289@gmail.com>
	<871pdhs7tf.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 06 Jul 2026 07:56:06 +0200
Message-ID: <87jyr8r79l.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGty/JpZ0ecktrBCe7EQ847ymGCidrRMJecDSvASq180Ui+izAvhzF2TZV1GZWHnZ5Uotjda++bJkPUwO4TI/N3IO+/RgZNjHt3WDETdcW8AGVSY8qdIzI0LgJhvkP/TIfpmd8Q2BTuVm70gGBjcXdejOuuuJXg/kCFRrSo/VuFRoFFUp1oQwookNt3BUE4KjpobiYFXEmsLpkckF/U/fnE/1NkGSdpR0u7O1gt4riex0/6WtDo3hu6eHUMntfgGYthWXVw1yamdZ2YAfnlOF975uVfkHo8v4KnXJT5eRNgjdrJ3QwCZFRLd7Ocy/z7lWYdRTDDZk0U1Lz5ldOqe6RNHFCx31LEvgjcuPzRlbAqFIaXHpUnwecfJdK0FibNp922ilJ2pjyrn5T9/TQ4yvQ21i0vuINpWgO+fXnH6Hqdkq77QjIsA19HI9exQgPOzRcN+j2mm5MAfcwYmCVeRiOb7C9TDOpT5nLY696zEK3TXgyraqyPZDJo7EPygB/Tso+PHFO6LR8FmU4cTvcVXk2mnLe4HNJr7sNMdAA/E5g1M80QYnKqoTmXJB5rspIIM5JSn05zlSM8eFMOdbzz3wnGx78vnTupI/EK/arG4gKBzg6+FKPG1pTktdQCITEnvosta3AOjs0S2T4BxwsKsViXkBj/6itiQDP2zpQbXN4n+A
X-GND-State: clean

Philippe Gerum <rpm@xenomai.org> writes:

> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>
>> Am 05.07.26 um 17:06 schrieb Philippe Gerum:
>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>> 
>>>> - With the good version, I tested ~1M packages, all fine, max 60 us
>>>> response time on the real PC
>>> You mean 60us for the overall round-trip time between two
>>> evl-enabled
>>> targets in full/end-to-end oob mode?
>>> 
>>
>> That's between an evl-enabled host and an FPGA board as a target[1]
>> directly connected with 100M Ethernet and an Intel I350 after some
>> heavy tuning. Most tuning was done for PREEMT_RT. I have to test what
>> is really needed for Xenomai4 and what can be dropped.
>>
>> I don't have two PC's to test (yet).
>>
>> https://store.mesanet.com/index.php?route=product/product&product_id=374
>
> Ok, thanks for the information. Meanwhile, I found the culprit. Now I
> have to figure out why I did that. Oh, well..
>
> commit a793acf3cab9a608d70a39d740f04c6a6a1ec77c
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Tue May 26 10:16:44 2026 +0200
>
>     evl/net: packet: forward status of ETH_P_ALL delivery

Fixed by #bb06b3a8f100.

-- 
Philippe.
