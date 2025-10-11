Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899FD2627F9
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760196302; cv=none; b=O6sV8ANG7ttvh3memBHs0XH7oCi1XwQBHOpxp6vR5RZmBkOcnFXX8Ac8Q9/L4GAids8XGWyq1lgGxXEGF1CxwcglObIgWugL0p9uROIFwg7MHn1c/kSgXYZKFNaxK3JOZf7+367SYWRlL/rheK78hznaOcszSymwTVGbry96MLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760196302; c=relaxed/simple;
	bh=kJ/VoVYZKnuMcX0qBoJyTssmLZQPn7JzyP3j9qWRZ7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lcrAMAoelF62aRxx0rXG4tNkpE8Yeiw4avFCFFydss3bbxuC2cOakMRN/mRm65zaqRY27bQGhr1EmhFmziK6V0jv5b/hGpLEZKYTWctBRM1UBrOJRw8VNzDVyoqT/E8hcatqPAI9gEJjM3yaVga13FmAwIxDiwkArQ+5Abo70fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=DkSuu41C; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="DkSuu41C"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A46E43B6F;
	Sat, 11 Oct 2025 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760196292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wn3sNjargWkqXR9HSE5wtHHLxtCHkndQf418LM3SmAE=;
	b=DkSuu41CopVA3t6gLUtDHKPf78GYixNNLi/W+wpCxwavDlwSXu7zsfyk7V+OaHoJ2XLNpA
	9/BnB7hPX6faM09lEt02UpKbfjB8g5zhNGchj5PghZ2BTDFCGYy91cwjzxKaKTvLub6RB2
	sgykg2OcmNn998XyxLWDPntCYvhZcFHpI/Hk0HdubDrhbFw4sz4uQmwQGATewD9yc1bO0Z
	Y8AlGDmYDHfIE/T1/QsehB7LYBQqKeS5fsb5dS89Gjo/74IxelB4sSPtrZdjq6JrLr5SEU
	iEHLDWxXkMtLl3aSk6FbAfCmHvyJoxRIz0IOzyhdT8oZG4qwImxlmWBhrDShEw==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [linux-evl][v6.12.y-evl-rebase branch][PATCH] Remove stale
 CONTEXT_USER (now CT_STATE_USER)
In-Reply-To: <9a8210c9-2eea-dac3-5bb0-31106897aded@bela.io> (Giulio Moro's
	message of "Wed, 8 Oct 2025 18:37:04 -0500")
References: <9a8210c9-2eea-dac3-5bb0-31106897aded@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 11 Oct 2025 17:24:51 +0200
Message-ID: <87ecr9tq9o.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

Giulio Moro <giulio@bela.io> writes:

> From 728b86c0a1964f1a5f6b81b6e3f9807b79ec640e Mon Sep 17 00:00:00 2001
> From: Giulio Moro <giuliomoro@yahoo.it>
> Date: Wed, 8 Oct 2025 13:28:29 +0000
> Subject: [PATCH] Remove stale CONTEXT_USER (now CT_STATE_USER)
>
> Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
> ---
>  arch/arm64/kernel/entry-common.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 52a995f90..125de5b09 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -171,7 +171,6 @@ static __always_inline void __enter_from_user_mode(void)
>  		lockdep_hardirqs_off(CALLER_ADDR0);
>  		WARN_ON_ONCE(irq_pipeline_debug() && test_inband_stall());
>  		CT_WARN_ON(ct_state() != CT_STATE_USER);
> -		CT_WARN_ON(ct_state() != CONTEXT_USER);
>  		stall_inband_nocheck();
>  		user_exit_irqoff();
>  		unstall_inband_nocheck();

Merged, thanks.

-- 
Philippe.
