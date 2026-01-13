Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB9352C4E
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293898; cv=none; b=RJKr+bdIElzXyvzzrsliO6NG0EX97hy18fW1srq6cVfA9UTsW3dmYtM2sdXWTe4u0J3NgalpIaask3ZimanRx0SvdGTlOXSyXOMcZUPhpyHd15JIyP58NqwJWnEfMfmZ5Jem44q+LXa7viw37benDnBLfXFFM2JfNA52OiNZIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293898; c=relaxed/simple;
	bh=3w/flSZ77QbTgktaGKycBUYEC3EWd59bvr5FdyX4KjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KpEVkezvzVYXYkaWoISfb3nzKemVuoFU1aNQYt249+IbFpv69GFYppPM/PSLHRQEQAhnG5yo17sJfv2VM1W/WUGDr06fOT58d8jTb0IqABAKhagkDfb4sSfQM/gqWZe5XEJWldF6UguHe5nfv7vOPedcUC9zWylOJjmwW+JAMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=NsnXPOpH; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="NsnXPOpH"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 70A6458032A
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 08:44:53 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F293F443B7;
	Tue, 13 Jan 2026 08:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1768293886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJld2yndUq4lOniVpoj9fy2CXtRRRcKDPkZmYtejxJo=;
	b=NsnXPOpH6ekQZTreOuE89al2AUkO9SjIVanT8aHno7+PfIghnWVe98zcd/2YZq3j9SBQfD
	UJughhWSxXkWzwHDB8RqkK3sog/iyQhJHa4cAJY1G3wxKk3oMcxmG9sG+5Vlrk0gM6vDGh
	4fhUyKfBTvs+owmY0jXBLVrUXO/f1akQso2ka1ASagFqW01GQ65X81Fn4aBr5wKNJFT83e
	kctgFWBiXvYeEYRhKoXPMlgF1AJ8brPR4YCy8BMmPYTc5hiV77PhtI3Uvw8d4JSGa8TF6q
	zuAe26oQqKH9AYt1qdOfOhazv6LJIcYUr3iKGoej9uQdw2xULbqqL7JD5TJTUg==
From: Philippe Gerum <rpm@xenomai.org>
To: "Chang, Junxiao" <junxiao.chang@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,  "Wang, Yuan1"
 <yuan1.wang@intel.com>
Subject: Re: [PATCH evl 6.18 2/2] evl/net: export sock_oob_bind symbol
In-Reply-To: <DS0PR11MB81343C648D8B2AE5100C453CEC8EA@DS0PR11MB8134.namprd11.prod.outlook.com>
	(Junxiao Chang's message of "Tue, 13 Jan 2026 01:05:25 +0000")
References: <20260113094852.2806192-1-junxiao.chang@intel.com>
	<20260113094852.2806192-2-junxiao.chang@intel.com>
	<87bjizorlw.fsf@xenomai.org>
	<DS0PR11MB81343C648D8B2AE5100C453CEC8EA@DS0PR11MB8134.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 13 Jan 2026 09:44:41 +0100
Message-ID: <87a4yh3nra.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugephfdvleefhfeggeefueejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihuhgrnhdurdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhhunhigihgrohdrtghhrghnghesihhnthgvlhdrtghomh
X-GND-State: clean
X-GND-Score: -100

"Chang, Junxiao" <junxiao.chang@intel.com> writes:

> Philippe Gerum <rpm@xenomai.org> wrote:
>>
>>Junxiao Chang <junxiao.chang@intel.com> writes:
>>
>>> API sock_oob_bind symbol should be exported because it might be used
>>> in other kernel modules.
>>>
>>
>>The routine you are exporting is the implementation of a weak symbol called by
>>the regular network stack in order to allow any real-time core which may be
>>interested to extend the logic of a common networking operation, in this case
>>socket binding as extended by evl. If you were to add some evl-managed
>>protocol, then you would declare it to its network stack, so that sock_oob_bind()
>>could automatically route any relevant request to some handler in your protocol
>>implementation.
>>
>>Therefore, I'm unsure to understand what could be the use case here, why
>>would and evl-based module need to call this routine?
>
> Thank you for reviewing it! It is a minor build issue. When we try
> "make allmodconfig && make -j48" to build EVL kernel, it returns below error:
> ERROR: modpost: "sock_oob_bind" [net/packet/af_packet.ko] undefined!
>
> af_packet.c is built as kernel module(CONFIG_PACKET=m), it calls sock_oob_bind
> API which is defined in kernel/evl/net/socket.c, this API should be exported.
>

Ok, you are building some standard protocol support as modules, makes
sense then. In this case, please resubmit a patch using
EXPORT_SYMBOL_GPL() instead.

-- 
Philippe.
