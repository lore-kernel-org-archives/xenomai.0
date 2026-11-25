Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616323;
	b=gK4DQCyU8DQEeAGrR5tzLYbkDx92fN5O2+0NTUPOYkt8ZstUpvPOFVFsdHBr539qxIcc
	 wKxPTgcICD7tNGGPrjr5oheKmlqwhQcZlvuOCYxuSRDMlrOLP13bv83fKm4OSQ+OQshoq
	 Ciu17vOgIVsalb2j5CA3DzugP15POH/CSLHT9idXTzsdvbf9Q7rK5iYyQM5AsDyBIdqX/
	 9QXXWPC8iAySqJuXPAkQfvHC0z0slHN/iq8joyfitYiItwOe+USwaIqAACMOQifPhW5M3
	 W0l0EY3t5md78ihn1eJ+/9yD8LYdKjM+9HhIu52fV5IJMMl9OBhQok3egIZet2uhrDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616323;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=FozgVW2H9Z244JKY5b6JFwxiChPfASaPwPdG1B8IlCw=;
	b=SUk7/gkACTyfwIWVnZk8FlyyKFzaulMHTqDnKbFIdvT6u2I3YTrlE4nCcjYmu987FhFw
	 EdmkrQl4vWOELQ0t5JKlQfNm1pl0Y4mDDfGrNyuSMk5SvmM9DWUEW3YdwQbAprfGjnAQ2
	 Mi2XQOWcQyvs7JGs9tcSrcMplQho6A359ABMvEUKDYZN/QpAaprd9vIOVyglknIqWi29G
	 5ko6FNMAe2si71AVv+MtSp89C3dozr1dr1U76/ri7FkkiKhc3atDLdZJHpSYwRg009APa
	 L9IYxebT7DA/f4euT+cZOGxNubNaXOBd75x3cRQrpNZXj+Jv29qyYGhhqzQ8LlSQ1cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=ONbI75gs;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33966606A333
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 14:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33966606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=ONbI75gs
Received: by mail.gandi.net (Postfix) with ESMTPSA id 181E53EDBC;
	Wed, 25 Nov 2026 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795616321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FozgVW2H9Z244JKY5b6JFwxiChPfASaPwPdG1B8IlCw=;
	b=ONbI75gs/wy9E91Vwg4I84yeC+K0lAX+6C3xt/lhIkD37qHQJv9U54NU63JhLT5FwCO/gw
	n27mvVU5WtB0VOwBc7aIg+Ticq2loW5beNaMgX2xKsXuj62URMdSNmbdRTizF22f16pOsL
	JR9QE6YZPSUyZU4ANLTNLHFOCjRoBUtlJZOoas3UGYzoj/lXAW7RxTecGu7ZBtQGvNxsQc
	VKdByJSf7nDrsAjrUgbFLCj/z2Rrs2IKVpqYUTSC/Y4hNL7z/n6k7//VlkBDx8gFcI49Xh
	BXwHtFmtmAkfphS45mFmikFXRIaUv8Y/AIjTS5pmBYb7Jvjd2Sp8UEkJdhhdyg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [PATCH 7.2.y] net: dovetail: Restore accidentally lost mp_ops
 cleanup
In-Reply-To: <9a4375f6-be1e-4626-91d9-ad906eec7571@siemens.com> (Jan Kiszka's
	message of "Wed, 25 Nov 2026 12:35:41 +0100")
References: <660c8205-c3d1-414d-8977-6ee6ce1ebe1c@siemens.com>
	<874ie0topt.fsf@xenomai.org>
	<9a4375f6-be1e-4626-91d9-ad906eec7571@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 25 Nov 2026 15:18:40 +0100
Message-ID: <87o6bd0zb3.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTE0RDVY/Frx7zIxC/NTrIShJ6DrGJtBPVpyyOJJvOj8x1GzImQp28Ge9xkIbAOZupUAzvTtUhtZyXFpG5iZ7DoJ2Ujk6lUfkPD7erlJ8josVYvig6wwNSjdqxZpwkYOdEOuEvritjsU3G38eoTLt0/X8fxYSTNY79nfZwen5lI8vn5WbW/XgGs7WNdYRzn7UpFboXSVh7lMbysXLCLjegBygs9NUSpOJQVqWmZQU6V1zhcPb+KNpwzWENRcoEYJRoHpSRx+ecA9YO7oH7qHmDACF+9yGA2VWmPedg7yjH1APG6ZcI1m9EdAiYr/pfDhzZPEigfpm4gOBmtVNOjE7SMzWvEtEnpl9Y+TScmkZ+yLXBuuQ3aYNlw9oY5fKjtj0wGdCV7TixREe3oqisuiuvNzzLozT2L9sozLg3nWYQGLRoiF5ei6ZBdYYNXEk0Qki4va8AYay1BaaT2ohfWq1Dxqeoalvk2j5kLoPIl6lcwx57BbGLOfoHE4PzTx7bg1g7RPxK6TklzLUbFg1uQGFNhMRBeCK++WaqS2wUB1KpVWR78BcPMqzW3lqEIVNqh3W5AkZueLm4vdAJVkHN3olnGYCJ7RBGa6va5XXcbLM6eohS+g3hU0yqskREN0QJWd5o8vDOg7Um6YzA5PKcGljzKdVROZjmSI1rBPaK+koQuh+g
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
> ...but forgotten now (AI finding): please apply to v7.3.
>

Oopsie! Done.

-- 
Philippe.
