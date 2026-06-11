Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13AA36CE1C
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164172; cv=none; b=Z6AI28+tUfWpgGIr7YIiC4lFW8w/bPO+nWlX8ZgXTGLF5+00Vfzxh8ia4NhynlTLndRrBhe+wBqYw3rJrsZJt0/3OeMpTE/FytYLF/bzy9E5l4wCMw+6FOGOFi2A3Re07+W4+doqAJ9PbETxjRN4vUDXmSMuYVhEexA0U9Y7SBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164172; c=relaxed/simple;
	bh=GR04ESn07Ql+1Vwfo1a69uHV2+vhtoipz+1NA+XLjzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VNQD7b2XaLxith/1p8pQkGi+AnVfKPBbUVujN4ZR6xlfduUX6SAnyNP8fH00Riuu9YBA7zgVx+HZmnDOKSzJa8x+lSQLD8ZqVAJ9yfhYP9nLRAvg9ezyns884R9LrmofuJf+fNexRR4pyLDuR4TkEo/TYIl2DivXz+x+vWGFzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Uu9S+8Hj; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Uu9S+8Hj"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0F331F75E;
	Thu, 11 Jun 2026 07:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781164169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0HW3OJSl6tQMQHRV7ksPkOUmA/DlccKnRfAePrgDgSg=;
	b=Uu9S+8Hjl9QCOrzb2i9+x5fl69JZxgj9CtXiB3jCz3QmtabMoUu3UvZhaE9ZjA+XkncMVR
	GHVRHgq77xk6oqHztC5299cNscZkTA6bWvasVJ7mRTWqTE4uE5HUDSjHxQAU7PN0Pq7Lf5
	uyz5DMLpMKAW2nkZHu36+A21snNfUDhLqlvr3Y3qHHki5kX8KmUJLwV0aNPdp0D9gwIBhG
	EjBULzfvADaPQwFIqdTxZYOw6NJxp6j3IVlYOyY72+EEXL/BmX0gqyyv4fXHlvB7C+9cKh
	zk23L0mCYkeaX8yu0bHxYZPuh8pNjhn+wJO2V5f4AqA0eQWW64dzsYlW6hUc5g==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: SCHED_SPORADIC in Xenomai 3
In-Reply-To: <30be9f34-4fd0-47fc-932f-70970217acb0@siemens.com> (Jan Kiszka's
	message of "Thu, 11 Jun 2026 07:38:57 +0200")
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
	<5bb1aace-8083-400b-9e74-5a047873a1ed@siemens.com>
	<c5761187-9689-45b1-9527-89cc8a5b2763@siemens.com>
	<2227cdf6-d2cc-4f5a-87ab-d09861d4ce26@siemens.com>
	<30be9f34-4fd0-47fc-932f-70970217acb0@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 11 Jun 2026 09:49:25 +0200
Message-ID: <87y0glbjp6.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEAE6yjc3vantOyFGH3bRdxs80/fkeYzf2qh8ZNCg7C1SpOcolb/E91i1komFD16vnHno9991CyCkwrcMREwZtJHpqujRClLLhLEWNGz/IrX4/dnlvJZoGoWMV6RvOGfxPP+vSEPlO76KRHiVC87ml9hGgJacrFjrngn0IJnyilbb88mjoxqCASHSDZMY9bs2KclizVi8kZK/aLJV6XzA4OFfkuhtgtgAL3c2i3p9CGN/8gZfImOOiffAgxtnrl7HoQFfe0w+uv9sfoxQDkS4G0t850FGNG1AKBecjYkzSsR8Zz3vUXrwZzJg51qon+d2puCHsTmM26O0cUzsyIboQCLR8dTKh/vyn1KtSxyW90CwnKPque59++eWIBmKX7s1QG/njvm4yotu7Oa91rEQegtQQsWyY5gBhe8G1fTrR27+gNEJD+wwxvbxTkm4ZKYYVGj0ywIIBjxtE/O5LwrfNJwzZGgqPh8Qhl9G6EqSzxbtiIpuEZd77y7aXKhJiIva+tbX/LLOLnMvSwmRAmCMc1MrX2bWcrhp3uCtgRMPmhkp9mYmQedZw4PD1DZW1kPE8k6KikQzP2UGtbnPMt6Bc04BdbfRuG6c9/iOaCSRDuLl1wLVwuNjEcboOjqQ0OoBxJgmCKKgHEDotT/fS6busvmIC42QyjKyXz1D8LWfm2sA

Jan Kiszka <jan.kiszka@siemens.com> writes:

> diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
> index d527b6be2c..6dfbf83220 100644
> --- a/kernel/cobalt/sched.c
> +++ b/kernel/cobalt/sched.c
> @@ -895,6 +895,7 @@ static inline void do_lazy_user_work(struct xnthread *curr)
>  
>  int ___xnsched_run(struct xnsched *sched)
>  {
> +	struct xnsched_class *prev_schedclass __maybe_unused;
>  	bool switched = false, leaving_inband;
>  	struct xnthread *prev, *next, *curr;
>  	spl_t s;
> @@ -933,6 +934,13 @@ int ___xnsched_run(struct xnsched *sched)
>  
>  	prev = curr;
>  
> +#ifdef CONFIG_XENO_OPT_SCHED_CLASSES
> +	prev_schedclass = prev->sched_class;
> +	if (prev_schedclass->weight < next->sched_class->weight &&
> +	    prev_schedclass->sched_out)
> +		prev_schedclass->sched_out(prev);
> +#endif

I would call the scheduling out hook unconditionally, the sched class
has all the information required to sort this out, do the right thing,
which the generic scheduler does not.
>
> Something analogous for sched-sporadic does not help. It looks broken in 
> its algorithm, specifically that is schedules consumed budget for 
> recharge on preemption, rather than reducing the remaining budget.

Since the original implementation did not account for the preemption
case in budget-tracking classes, that makes sense.

-- 
Philippe.
