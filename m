Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902A244661
	for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876872; cv=none; b=XfOMlNZ44yfmyvz19daDutjTa+lIYlcytIVERz2Lxg0MzIwyGR9jNIhqNhNKNk5qLOy6TscbtfBCC7kKR0MCcq+m6+S5OVEc2kAAAQcBT79dxsWX5jMdhNHlsAgakthcrrr7vBcxsb22wiGdDSIJmYV/dljd+s+osRlFSAITt9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876872; c=relaxed/simple;
	bh=8AMhhmdRMNeWJny5rfUdAkR0WBx6u9uANwh+7HsSvS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G2UwJL5p32D5viH8ISzM6RbI8cUKFZg2P+Ypi+fBoYt0PimAqA5lVYLqrMs362AemJgZelcNp6GXBb04RkTH7v50LH9aYG359jDvXHPrEqoNFvcsF3PuEi6n2M1TMlobA248L57ctvaNblVp/CLnacO7VDyPHm5rgQ7SWP7FxnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=OZ6LvWG/; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="OZ6LvWG/"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 8E358580C75
	for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 08:50:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3898F4327C;
	Fri, 26 Sep 2025 08:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1758876632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAF80xjBT8fUWo+3D/ql3fprnbS6DkJuFrvgg8E5ZPE=;
	b=OZ6LvWG/SeXgCuuKImNpAs15CK2mQ4dT6OtV41m+B/kmetXGeeuGj2HMYC2USE164GgP2q
	1Z4McNN8weyj9W7zuw7jJklKscrDOHixb0lkZfxzqa0w6qYJLRy2tDaBztSNSDMuOAk1h8
	tajrChT+FeBef683AXFq4HZlhACBXTA43wB3qXUmJ1TdwgAByjmbdbfuojHCdMxSS5R8iA
	mLBnPXlUFHwd9rmhsR2S69bBCjTC3lXZUqxbkazudcK5rk64eYiePJhGLLw6lIpBP7mY0I
	+ep2xhlZPcJYguAWEqKjTHWEovUjFU6eyV/uj+V98s5VSxXwySyAbRrI5bJFEQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH RFC Dovetail 6.16 3/5] kernel/irq/chip: Simplify
 may_start_flow()
In-Reply-To: <20250925-wip-flo-cleanups-based-on-6-16-v1-3-8c4ac7b52cd8@siemens.com>
	(Florian Bezdeka's message of "Thu, 25 Sep 2025 15:05:49 +0200")
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
	<20250925-wip-flo-cleanups-based-on-6-16-v1-3-8c4ac7b52cd8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 26 Sep 2025 10:50:31 +0200
Message-ID: <87cy7dha20.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikeelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> There was something like IRQ_FLOW_PILEUP in the past which does no
> longer exist. We can now clean up and simplify may_start_flow().
> No functional change.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/irq/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 5774fd96ec6c5..8593cdfb6e2ca 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -479,7 +479,7 @@ enum {
>  
>  static inline bool may_start_flow(int flow)
>  {
> -	return flow != IRQ_FLOW_REPLAY && flow != IRQ_FLOW_FORWARD;
> +	return flow == IRQ_FLOW_START;
>  }
>  
>  void irq_clear_deferral(struct irq_desc *desc)

Ack.

-- 
Philippe.
