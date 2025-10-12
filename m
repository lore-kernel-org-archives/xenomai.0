Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935F38FB9
	for <xenomai@lists.linux.dev>; Sun, 12 Oct 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760259281; cv=none; b=YAKezERe6ELW0C30teDVsidvKwJXv0RAqTbe2KSTNntnkgEBZ0lUzKfJRd9q1KmscYqLMiOOy7JeQzM6OG6XCo3PnR2lPCVtgsAQhmdSJOfNmCKaP4S9TGYsp36Gm6raMSERuOHlkCsdGPTcwoAkcSLPzJmulr7pkKl4LTMDVhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760259281; c=relaxed/simple;
	bh=FkUjLhdyapAoBU+nG3wrdxrzhH77C0bFRsY70s9UmXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rXpyw5pezAI2cPsPZ2gMpeu37jlFEONUD5LJc40Gs/I9NixH2ahXfEdR96gALCXuiq7D+t6mvrBTzf/sziuRYV05xPro870BolHh1q5mfaOXjU+o/nrDyjYQQ6U5Y8Vy3hT6su6HJlVFhen9HPs4hkLciXxx30qYnR1OZNnat2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=p3nWg1gw; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="p3nWg1gw"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7167432C5;
	Sun, 12 Oct 2025 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760259271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AK7R/Xr9fGjhhy0gphDPSxVKRuab761yqJQCDO1hH+U=;
	b=p3nWg1gwVtGLocf73GuCy2Otr8Z4PECyGeu4ejH6DjqSr21Hs9vr3WWRYWxvwYGRVqHYDX
	TesTthd69st8g+ZDHbZhZMrB22J0mlDUaxndR08JIAJgaUlUykWnwm+MGq3FH0OgF/Q6wj
	nZ/ZpbnvAPbvxjLG+pOaXT8WNH33iZM18qXSift6gzWIhm/R4juoJUUZG4JFFgTphwyVjn
	t7mjs/XrhHErvvB9Bi1L6FbRRKyr7bDx/zqXCYLS4oX29GEiewzbA+cur053rEryHHSCFA
	m9/HLvZzneHQMieUDc6x4QQpD5pka+fxQEwgW/H/8E2i8RHW0ZG0CVIQiq8unA==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <be366ae4-b0c3-d6b5-25f2-813424f47c3c@bela.io> (Giulio Moro's
	message of "Sat, 11 Oct 2025 14:46:56 -0500")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<874is5s6kw.fsf@xenomai.org>
	<be366ae4-b0c3-d6b5-25f2-813424f47c3c@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 12 Oct 2025 10:54:30 +0200
Message-ID: <87a51wijp5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

Giulio Moro <giulio@bela.io> writes:

>> Quick check: does "evl check" run without any output (as expected)?
>
> Yes
>
> Further update: tested v6.16-evl-rebase and it seems to have the same in-band switching issue. So far the only good one was v6.1.y-cip-evl-rebase.
>
>> Meanwhile, I've been trying to reproduce on x86 and armv8 (odroid c4) using the posted recipe, no luck so far.
>
> Thanks for giving it a try. Wanna have a look at/try my config? https://github.com/giuliomoro/linux/blob/v6.12.y-evl-rebase/.config

Yep, thanks.

-- 
Philippe.
