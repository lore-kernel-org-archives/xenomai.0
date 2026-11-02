Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631364;
	b=IsdClGk/bV611ggNsFqcaJSIbZ/EQURiSWUxWgL31HpmUJdqerIEF7O9KngeOoF4lqez
	 zha3G1BB+0/1b2SgxjOpY6TuLAAU0W565MdSoJuhBGnwhQ2pvQSsa6yAs8zJPV2NDsalA
	 4+fhWmyHUo01dYJ5VTSi5lnaJtzR6EtawLOrPLWQwj4sQmVfJYTdr4L2NjFzkRoRQDlkI
	 rAf8b6nnqhaEtxz58yIQ6A8VtOm89C+9bZqZiOWdzeSrcT3fbKScKy3rUpfKLXXQoSAzg
	 PmcUYw2zkFZvVIp3g6jL2b3KDsKiJbA89H9xLhU9fpwm9RAjR4kowbrH1HtRFczalWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631364;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=LMPVYO74S6tjKDADkwBAwey33ahj65KkgiX9fbWsy1M=;
	b=oXSIplCF8iNIFy3E2HorHzz963e5dk2SHsGTbj11QqD9n+FOA1SIbg25eCFQhUGQYsRa
	 n3XET7iWrdvcli7RdrqY44fPgPFkE3PEdM+RK7ClhWlaspEox5OnW3ZefQOQbcXpVsrR5
	 wfmCAACTtT1he05ctpppIrVcAaafHJ97yvHdBQgREjGnDqzmwPMr4iCKgNvz7+8Acj3qz
	 jE1NyEaBqTeTGmc6MaXi5RO9Bm2bVXjbM/0CDvOb6SotI4KGHn2+CnRRrIwjf3d/egVSa
	 IWBPeBaQDIOoX5FmNfJCPJldUrRTqYVg7D3lTvuwMitTTxUsMfYus7LyaP3aNsAUVfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Qc4fsxPi;
	arc=none smtp.remote-ip=217.70.183.198
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E369607BDDC
	for <xenomai@lists.linux.dev>; Mon,  2 Nov 2026 14:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E369607BDDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Qc4fsxPi
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF02C3ED67;
	Mon,  2 Nov 2026 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1793631361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LMPVYO74S6tjKDADkwBAwey33ahj65KkgiX9fbWsy1M=;
	b=Qc4fsxPiwGbCLfSDQ5Y/isGyJ/1k/zwr4ZvYKMwvpEs48ghkE6e0DJnay24/x1q6BlghL1
	S5K1bHVoDosHumjq9pBTQjCernqcXlbS4yLrzAhXiqvUK25jQbOzbhmLEdlf0JuiNqiI7j
	Vk7wnRl6USBBKSi+arnDF94qvoVd4+Kvda1VkGbSzEb39kOpjNePrj5s8m5oEGkrmDNalQ
	56WSWIFZtrvVHWnGw9z3mn/IiYu/gy2lqmkQYy940LihvydiAeSmDdmW5gzc7df+gOzYmw
	F4YTqm0YbG0VVytFhUWG+tblx60FnCSH+Que9/UrK7QDdjlGndcl4cqIhVuETQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [PATCH 7.2.y] net: dovetail: Restore accidentally lost mp_ops
 cleanup
In-Reply-To: <c08f9acd-711b-4e9c-a3ea-f34d322e4c01@siemens.com> (Jan Kiszka's
	message of "Mon, 2 Nov 2026 11:48:12 +0100")
References: <660c8205-c3d1-414d-8977-6ee6ce1ebe1c@siemens.com>
	<874ie0topt.fsf@xenomai.org>
	<c08f9acd-711b-4e9c-a3ea-f34d322e4c01@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 02 Nov 2026 15:56:00 +0100
Message-ID: <87se1j8epr.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEWwjECflYTsQSM3cQ9wow5acvU3l4gyVgPZHxRmQqya6dnnZR0Ui6mhAGipIvw+iAdC5o8ZGQVYrf+TmuuRBW9L5wGMlU2kefuksa++fgNqDSb0LImmGw5GCnpqIDDb+8BySrzKY6bbz15I3ujGeMWsuasmmfK+jWmzON6+GE7irRrVXzai48/S+wsDf6vuJ9T4WK8KcwrwmDZaXD04YlTH7t2uPRlVJRvMHq9w7IBp0qt205tcipWoHfllVlPL7AOkHTlF4UwSOfD/GojEQm/NbsSImCAU4XWiNrYntDjBiUnF02yGDH2xvT3+2j4P6tEnMVPQvpO99BjqI6m7S5EnKxVgxz9g8IYkwlrnGLG8vM9dXdcskT48rGmRmXZfpFxuVLfcpOet6rQH4bag6cLR2bGR+bpcjEbORWeGYVhYZIEuKhuasibEJsYUDxbzvGevKQVYwlJv8fbHsHX985UQAa8T1t3yKLt6e5FRDJOtFUi59FhHtWC1m8caoTi0JFQKc+OEOay1hVCSt6Yb0yRkJ/aSnuvDhDCGvomAm5lpAqDzGMTotUeHCnC0vJmTzHxs6y85OYkme/MlRaYRrfIrBvHz7FsxX8U8BcL6mTDv1wRSSOHYzMDada+4rGU7V2m5XPD5IEI9SHp0nXN8tjLMZRYLYiN36HmtmNPtOLe3g
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 01.11.26 19:02, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Fixes: 2db757ed1c20 ("net: dovetail: enable out-of-band networking")
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Should go into 7.3 as well.
>>>
>>>  net/core/page_pool.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>> index 13ef7c723a89c..6136471425fe3 100644
>>> --- a/net/core/page_pool.c
>>> +++ b/net/core/page_pool.c
>>> @@ -338,6 +338,11 @@ static void page_pool_uninit(struct page_pool *pool)
>>>  	if (!pool->system)
>>>  		free_percpu(pool->recycle_stats);
>>>  #endif
>>> +
>>> +	if (pool->mp_ops) {
>>> +		pool->mp_ops->destroy(pool);
>>> +		static_branch_dec(&page_pool_mem_providers);
>>> +	}
>>>  #ifdef CONFIG_PAGE_POOL_OOB
>>>  	kfree(pool->alloc.cache);
>>>  #endif
>> 
>> Merged into 7.2, thanks. Noted for 7.3.
>> 
>
> I think you accidentally pushed the update as "7.2-evl-dovetail" to
> linux-dovetail.
>

Yep, sorry for that. Fixed now.


-- 
Philippe.
