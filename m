Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7985337BA6
	for <xenomai@lists.linux.dev>; Wed, 29 Apr 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451158; cv=none; b=bQihTenGuSbC0jHfHAPYeMxLNoVFjJSeKgt1VWAPGjViFmwJVMnvZNBnPPbYVp26hN+GvrGmwN3vXmkX1ego6f/s9B1WeoaAy9x3TfiFXWLPgwL07iETxjOKo63vj0z8a5qy/dxaEm+dVLMd3csNmzQZYYGrh7RUYPkV7QfeLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451158; c=relaxed/simple;
	bh=pILN1b1arrd5KCqMWzeFHE6gmD6trDVXL0LZMCdSTfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hkZDn3fCa888Md+to7p3E/nTvwnluus1U3N6sQAqVHZu1bLUfe30Z42/WxJBHFX9uZvessgYiawQts+Bje5vGw+ViOcqppVPMn+49XNfIHs1GXRAYy8fKMRglQa+1lKJBrQkho0CPWkEFHBuw+sD6tPiWF0TZMkMFzrDxezSgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=BEidzNO2; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="BEidzNO2"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3E353EBB8;
	Wed, 29 Apr 2026 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1777451149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MWgP2nUh8d5jB0zoiasg7KDmrZpVW2XCdHK2b71gXks=;
	b=BEidzNO2ypmikC0jcv7+POoDk7Lg8AUegcS+qrKmpqqzY19c5M64o0t0fCbSb/grONet64
	tqvceZ3M7AeLMkEX51R//3Lk/NkYM8tbmYjd5tucn64Caag+nfg6ZgJUW3xk5fpTiTbmjn
	AEZ0kq/1w+FXX6s4OcWBMVXYW5RYqlTE5bynMA364/6PDs+J5pbcQwAmnIjOfp8EJRfHzt
	RoUfsPGbWuIy408dzp4/ZCHDS10xFGTyIjZ8v90FwDvKbJBcZkdmveiv8Vbzi7SGu/3kZk
	bVVUs9rswmn8Inr1ZqUI56vzsy/gyFwaBvF915Zb1hFcXwVGwSa6aI2P4T02wg==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  florian.bezdeka@siemens.com,
  jan.kiszka@siemens.com
Subject: Re: [PATCH dovetail 00/11] riscv: Add dovetail support
In-Reply-To: <20260417210154.2290819-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 17 Apr 2026 23:01:43 +0200")
References: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 29 Apr 2026 10:25:42 +0200
Message-ID: <87pl3ii35l.fsf@2a01cb0804738000b42250ae26cae50b.ipv6.abo.wanadoo.fr>
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
X-GND-Cause: dmFkZTFFHG6eJr9cl5pK1QKDVFmDMUAaemdWN6YBX3/2m9CJuf/DcLLK4Kvx7wxAWsjN9/hN0o433u53XUVnMrNasnFnr9m89u7cXy31UZRLqBh13p2glZc66YlXj87U2TOxOj3Wao69xtaJPqz708IuGMBKY12VFBde8iJ2MvTMbGuXO2/5GRnYt0RCtA65ea3gkd8rcK1FPXVE1iQ3Gy65FXvm9oXbFJRlqcDKOxVCDaL9agsK4o3QjcZ9uOrWX7ZZLaUeBYzXPll4NlJtRmDdscOFTAIT/y/GbG6H5qWcM1ZNBNcWBCai1aFR6OGd8lbll6E+K7sBFuFe+gKKKOEW6VkXQQtFkofXCCRhZ12yrhHn/fo8G94ZhDT61nQKXG60cOzv9k4x5ZBIIQG2FJ4MYMaFjx+8QSCKYRr1ULgDjjRSVL5fSIB0ZAaH5nDRdmJhccHW1ggJsynwP3z2aqmsyiLKCg2NWnPvMLVcDpCrIIZaz1X6buCj+k1/eNuzgMJiIU2vez+/MXiEDQeuFi7uhWKIgDmo83wT38HtjpyYyueNTzCgv5GyaTjlgpxsbp2FB9RtXXnkl1Irluy9SZLbBCaZNsTqNRj33yBCFfBScQxlQdUAGVWRjIFxNc9LVz9FUxQD700fXrEm7YhtiFuvxGwSeZWDSWb5c3wT1R5D7r6o3w

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

>
> Changes since v5:
>  * Use mark_trap_entry/exit_raw for kernel mode exception paths which
>    use irq_nmi_entry/exit for now, as the nmi irq handlers expect hard
>    irqs to stay off. This may be be subject to further optimization at
>    a later stage, but I do not see any negative impact latency wise in
>    my tests.
>

Agreed. All traps branching to the nmi_entry code seem to denote some
kernel breakage or a debugger stop, so latency may be the least of our
problem if taken anyway.

However, we may still have to mirror the hardware irq state into the
stall bit when running in-band, to pass sanity checks like
WARN_ON(irqs_disabled()) if any.

-- 
Philippe.
