Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC937F0F3
	for <xenomai@lists.linux.dev>; Wed, 14 Jan 2026 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378814; cv=none; b=V0COPlHL+P5Q7AtQNw9oSxry746SH+OWbK1lj9n4gF6iylUrlPtR7pd6UJPWcd2L4TysVs0VTGax83LQY4Rm/gIrTqtiPKfOG7hqLZogpvqP+N45xzS/q4QlnViBQYRen5t1XAPgvGGeZHQ0JRm155L9NGElcfT5dDRimLxEirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378814; c=relaxed/simple;
	bh=YGil5uX6J7AxNuUCUCWrxnmWJWfIFCWjcI0Jj2Qr8DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZxnWJB4AdyLYfpO4wDa18Lq01OT2cDP8XKyeemLRZ77ZWswb41ZodejHumyq1tIk2yWD60j2SOubfhDoBcr+On2icF/EQO76foIUjejEfppMImUFlaxvLRVGd/ZILcVnYtzrZN8vb7HdSmCqSJa4EveJszEwFxpr5TLZ3agR8tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=gRzwcVco; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="gRzwcVco"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 245A144340;
	Wed, 14 Jan 2026 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1768378799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wedP7jMiCweo6EKIEMfzxohAptghlJr3/9gADEKtGaQ=;
	b=gRzwcVcoxONHSdXb8s57hr3KmhUwgXjNtxcA0BtZ2Lm+5u0Rdf7r4DU9E3o22Kxd1wka2M
	tZ5Wpg+Ud3uJsJfktkIckPGX3hPvn9ZhvzHBFOteaSC3HqWu7sa8/2eHkR8OrFzdd2bUtC
	F51LrN6Mao9o2b5+4zkppJ6yYiO0xDnGFNZOc+KXR0WlI8fQkgKot2iMX1/OFKsqfptfKK
	ZbLK6BQ9fNMeXt0s8LsBoSajoynm5NDQ7sf1JjTvAnKRR5Ku5Fgg3zFnrQo+ebMJGJNsL5
	7HUE8VbQb9+Ue8D1ejOQgqQsBvUTQYGDS94LPkcuS5gre2G5LM9ipXJNptSsag==
From: Philippe Gerum <rpm@xenomai.org>
To: "Chang, Junxiao" <junxiao.chang@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,  "Wang, Yuan1"
 <yuan1.wang@intel.com>
Subject: Re: [PATCH] evl/net: export sock_oob_bind symbol
In-Reply-To: <DS0PR11MB8134CDAE8606193786327437EC8FA@DS0PR11MB8134.namprd11.prod.outlook.com>
	(Junxiao Chang's message of "Wed, 14 Jan 2026 06:13:12 +0000")
References: <20260113094852.2806192-2-junxiao.chang@intel.com>
	<20260114092711.3204218-1-junxiao.chang@intel.com>
	<874iop36pf.fsf@xenomai.org>
	<DS0PR11MB8134CDAE8606193786327437EC8FA@DS0PR11MB8134.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 14 Jan 2026 09:19:54 +0100
Message-ID: <87fr8838t1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddvieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeeulefggfehtdefgeekgfffudetkeekhfehudehfeeigffgjeekkeelfeekjeeuveenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupedvgeehtedugeegfeegtddpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohephihurghnuddrfigrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjuhhngihirghordgthhgrnhhgsehin
 hhtvghlrdgtohhm
X-GND-State: clean

"Chang, Junxiao" <junxiao.chang@intel.com> writes:

> Philippe Gerum <rpm@xenomai.org> wrote:
>>
>>Junxiao Chang <junxiao.chang@intel.com> writes:
>>
>>> API sock_oob_bind symbol should be exported because it might be used
>>> in other kernel modules.
>>>
>>> Fixes: 9afaf877fa08 ("evl: add net core (EXPERIMENTAL)")
>>> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
>>> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
>>> ---
>>>  kernel/evl/net/socket.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/evl/net/socket.c b/kernel/evl/net/socket.c index
>>> 4c61a1c1f6d0..69593470d62b 100644
>>> --- a/kernel/evl/net/socket.c
>>> +++ b/kernel/evl/net/socket.c
>>> @@ -449,6 +449,7 @@ int sock_oob_bind(struct sock *sk, struct sockaddr
>>> *addr, int len)
>>>
>>>  	return esk->proto->bind(esk, addr, len);  }
>>> +EXPORT_SYMBOL_GPL(sock_oob_bind);
>>>
>>>  /*
>>>   * In-band call from the common network stack to shutdown the
>>
>>Almost there, I just figured out that there is an even better option though, so
>>that we can keep this hunk in the code which actually defines the interface. This
>>patch would sit on the dovetail side (not evl):
>
> Yes, below patch makes sense. For evl/dovetail, your suggestion is that we should submit below patch to below repo and branch? https://gitlab.com/Xenomai/linux-dovetail/-/tree/v6.18.y-dovetail-rebase 
>

Yes please.

-- 
Philippe.
