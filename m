Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AB1E00B6
	for <xenomai@lists.linux.dev>; Fri, 31 Jan 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738339769; cv=none; b=mnxlanyAmYhLLN556mQJT10nyDbyHntCaR9AEvkw0/Ltyo/YmFqqWlVIBrGKMdRZcue1ZrFyoqXa5lH8DmlYuSWtmsZHUlE7Zkbl0yyLCp3evwm+MS5wP00n0JximIzlicOBKPrueLD5pwdR4N+5eSSEMBmnqmPhqyIejl2N7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738339769; c=relaxed/simple;
	bh=dLm6gVVJgzgLXKt9NoWIjpPzSdjweRbLD1FZ8JSGfvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WaMJalMBoE2mzMdUCpHvUuwvD2E2bVgx/kkc56YVXgvnxG59Wahgc56tid3Yux5O9st9LneVlmVxh3Ml70w56yNC5z1+VnURcUYm91JQumI+RyNse+nzvjg1RlBBEpdgFP2d7o3sV8ZEzHo1Kf8rhYVBDrAM9aRfL3iWbzZbksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ZVqRIdzH; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ZVqRIdzH"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC7D1433F7;
	Fri, 31 Jan 2025 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1738339759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxrQNlT4wjGS5pQGn0oIhpS4qfyb7NsGYUTEkxW9liw=;
	b=ZVqRIdzHP31pzoOTocr161QT/YcGXOGbuMCHtfNYK591N4BFOUlQL67W4RddrVX8znUNF5
	C/7MHCmv1Eo5hGC40JtFg8to5jZnZTnrH7sXadl7SyefCz1ebKJ4UgCFsz1NRh7zeICT0h
	AIJTxlsSin/dqsmmFvyKyYfPU/qAZ3/AZCvivh1XfA1h+/YbtuXZheQFVHY8j4EWjIXEZ7
	RNqyBG4b7prJdzG6NyhLV7UY5W9FFdLthDDPJgsyqUgTopwEXA3bS/NCGo+0rwYgyIO3um
	6n67rsc+sU8UO7Txke62fmLDZ+8eHXWUnE7Znd8hAL6p19Sq61+kq62S4Z90Mg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RFC] latency: measure min/avg/max execution time for a
 non-blocking syscall
In-Reply-To: <20250131154200.1221616-1-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Fri, 31 Jan 2025 16:41:59 +0100")
References: <68d9f583-59de-4bbf-8ea2-af8ece427495@siemens.com>
	<20250131154200.1221616-1-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 31 Jan 2025 17:09:18 +0100
Message-ID: <87tt9fx8wh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> RFC only. Will be referenced in the following mail as "measurement
> patch".
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/latency/latency.c | 63 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
> index fe688b9b8..74a6d6ea6 100644
> --- a/testsuite/latency/latency.c
> +++ b/testsuite/latency/latency.c
> @@ -107,6 +107,58 @@ static inline long long diff_ts(struct timespec *left, struct timespec *right)
>  		+ left->tv_nsec - right->tv_nsec;
>  }
>  
> +#include <cobalt/syscall.h>
> +#include <stdbool.h>
> +
> +static unsigned int min_sc_exec_time = 0;
> +static unsigned int max_sc_exec_time = 0;
> +static double avg_sc_exec_time = 0;
> +static unsigned int nr_sc_calls = 0;
> +
> +static inline void inject_syscall(bool *do_init)
> +{
> +	struct timespec t1, t2;
> +	struct ts64 {
> +		int64_t tv_sec;
> +		int64_t tv_nsec;
> +	} now;
> +	long long delta_in_ns;
> +	int ret;
> +
> +	/*
> +	 * Syscall under test: clock_gettime64 (non-blocking)
> +	 * We get called every cycle (1ms) with load (do_hell) running in
> +	 * parallel. That should give us a cold cache.
> +	 */
> +
> +	ret = clock_gettime(CLOCK_MONOTONIC, &t1);
> +	if (ret)
> +		error(1, errno, "unable to fetch t1\n");
> +
> +	/* do the syscall (no vdso!) */
> +	ret = XENOMAI_SYSCALL2(sc_cobalt_clock_gettime64, CLOCK_MONOTONIC,
> +			       &now);
> +	if (ret)
> +		error(1, errno, "syscall injection failed\n");

sc_cobalt_sched_{minprio, maxprio} may be lighter than sc_cobalt_clock_gettime64.

-- 
Philippe.
