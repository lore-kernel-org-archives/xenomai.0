Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F1342CBA
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925733; cv=none; b=OpfFJO+37tSNgFx8W6MPf/Fzqf8DH+IwI1Kii8J/zDpS7NQALa4JmyjvXts3Uze5X9J5rIG3KrnqZ/yZZJmk0HuxyfxhYfnBIpQ4MA/tvsvSdjwcKGQuYyMTNKVT1ysabXGLdqB064jQwxZSEJ91gf7X/CSERLpzVrGA1HFTteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925733; c=relaxed/simple;
	bh=uiHTXFk1i2VCRKSL0/kMj/xtbnm8KhTVk2K8GCba15M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e9aN1rRnKXSCsUACG+uvcC6mb53hk0+EhbsGsUikHEkv2oyR9KauUzeSXe2KcRDEXjvPpLTl03PFlHhgLWy5OL//yJZVqac8c41fh9w1yxX+0+/ZfOT4ObT1ytjcQEshlavG/gzfr2ScUyMVChw6yo8I6Jm4vbWKXnMl5v2EMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=VZgmn977; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="VZgmn977"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 829813F618;
	Mon, 13 Jul 2026 06:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783925724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dv0llW4+N32Mgo8+ofeR5hx2UFXNlSPeab74AeSyX6U=;
	b=VZgmn977kxQG0ag1zXb1m/L2Oxay43Kl51RsD5epVLQZeZFJnm8M5kLCZGyfJ3E3+G1hKb
	2mEPnzbz6U4o5+zcIdeZcb0LRr/IPiylsuh00MRL6RbAAGhfDZeBn4+bkyeQsgZmTwtKhJ
	t2Ka/ACYEkTekNHeALrQYNJGl8wOqtbBaYc1sFRdu48hDdaLSAd3g5k9cDYL6EoEosr9+i
	oInmHN12x1sVuy0cNKLmf3HabwHyYZ5AgihBec0v9ji/aNzqlMW0kFTE4SdMmNa7SAsgd+
	So62BvLLQG463dFMNJ8tVTJZBMq5RZC5Upot9scY/MDRX6VAFWvP0duSvxU9SA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] test: hectic: sem_post task_init on failure
In-Reply-To: <20260712200749.9210-1-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Sun, 12 Jul 2026 22:07:49 +0200")
References: <87h5max6sb.fsf@xenomai.org>
	<20260712200749.9210-1-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 13 Jul 2026 08:55:23 +0200
Message-ID: <871pd7750k.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEa9uR43egCQzlslEB3/RDCXdeS1io0m+cu9Vc41LaIYk3FYrwYaaZ/jVt52ojIVtmV5iLOGzO+N1suZzyCdvMYIsLAZmgo38sA4HRxDYJ8V2uf1fNNFf5Dd+3+6OcvL+6RPXu0Nlw/y1sobTR7b5KrJR/rssOVLqIXYHE03+HLdtVvdgRffyztRu7sgleb/ZwZFC3gVLx5gJreHjXG+3Vww53bVjM1rJ3WuTNmpzMIMbtS1plCXNh/E4AP2TUw6DX9iqKwjMbqyVX7+gERzX6HDFK0pQfY8bpyO22gIGvExwK6Uj8cO6s6DPf0UyXjXo5+tcyxYHWWlNvGtFTOJwdWYaUqHf1paeC7M21h3XZ2MWN76zUq2KHQRxq8Y1kMr4TMQG0YDsryA//l+buTiINmsGlHoRFRtbQtfg69A/huN2gMAOTnZAy2K40VWfQouHzV4a0S99HLDmidNXQJrUvOm7fElhRy5uXjIJJgPH0jQ6AMLbzhcTKRxLgms676QAHiiggeT5emVoseKbCT2LxpMxbzeYpEABL1BuXjXiqf/Rq6LBa6p20GIlAfKV26NeEEtIEcEU4yAiOlphMNq42UyZ3A9OeoDxESHYQ2TWk4MjAPtTNiDoGM3AHlJ1iS4PW/CBLOa+K0DS6r63MMwPGCJDls4xXZOZGHpMFT8LUuWg
X-GND-State: clean

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> This fixes the issue where hectic doesn't exit on init failure when
> there are for example not enough resources due to to many available
> CPU's.
>
> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
> ---
>  tests/hectic.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/tests/hectic.c b/tests/hectic.c
> index af8f988..b07e074 100644
> --- a/tests/hectic.c
> +++ b/tests/hectic.c
> @@ -270,6 +270,7 @@ static void *sleeper_switcher(void *cookie)
>  	CPU_SET(param->cpu->index, &cpu_set);
>  	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
>  		perror("sleeper: sched_setaffinity");
> +		sem_post(&task_init);
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> @@ -379,6 +380,7 @@ static void *fpu_stress(void *cookie)
>  	CPU_SET(param->cpu->index, &cpu_set);
>  	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
>  		perror("sleeper: sched_setaffinity");
> +		sem_post(&task_init);
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> @@ -399,19 +401,14 @@ static void *fpu_stress(void *cookie)
>  	return NULL;
>  }
>  
> -static void attach_thread(struct task_params *param)
> +static int attach_thread(struct task_params *param)
>  {
>  	char buffer[64];
> -	int efd;
>  
>  	task_name(buffer, sizeof(buffer), param->cpu,param->swt.index);
>  
>  	/* Make it a public thread only for demo purpose. */
> -	efd = evl_attach_self("/%s:%d", buffer, getpid());
> -	if (efd < 0) {
> -		perror("evl_attach()");
> -		clean_exit(EXIT_FAILURE);
> -	}
> +	return evl_attach_self("/%s:%d", buffer, getpid());
>  }
>  
>  static void *rtup(void *cookie)
> @@ -423,12 +420,17 @@ static void *rtup(void *cookie)
>  	cpu_set_t cpu_set;
>  	unsigned i = 0;
>  
> -	attach_thread(param);
> +	if (attach_thread(param) < 0) {
> +		perror("evl_attach()");
> +		sem_post(&task_init);
> +		clean_exit(EXIT_FAILURE);
> +	}
>  
>  	CPU_ZERO(&cpu_set);
>  	CPU_SET(param->cpu->index, &cpu_set);
>  	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
>  		perror("rtup: sched_setaffinity");
> +		sem_post(&task_init);
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> @@ -503,12 +505,17 @@ static void *rtus(void *cookie)
>  	cpu_set_t cpu_set;
>  	unsigned i = 0;
>  
> -	attach_thread(param);
> +	if (attach_thread(param) < 0) {
> +		perror("evl_attach()");
> +		sem_post(&task_init);
> +		clean_exit(EXIT_FAILURE);
> +	}
>  
>  	CPU_ZERO(&cpu_set);
>  	CPU_SET(param->cpu->index, &cpu_set);
>  	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
>  		perror("rtus: sched_setaffinity");
> +		sem_post(&task_init);
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> @@ -600,12 +607,17 @@ static void *rtuo(void *cookie)
>  	cpu_set_t cpu_set;
>  	unsigned i = 0;
>  
> -	attach_thread(param);
> +	if (attach_thread(param) < 0) {
> +		perror("evl_attach()");
> +		sem_post(&task_init);
> +		clean_exit(EXIT_FAILURE);
> +	}
>  
>  	CPU_ZERO(&cpu_set);
>  	CPU_SET(param->cpu->index, &cpu_set);
>  	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
>  		perror("rtuo: sched_setaffinity");
> +		sem_post(&task_init);
>  		clean_exit(EXIT_FAILURE);
>  	}

Merged, thanks.

-- 
Philippe.
