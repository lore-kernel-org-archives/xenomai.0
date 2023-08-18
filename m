Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE19D62B
	for <xenomai@lists.linux.dev>; Fri, 18 Aug 2023 17:31:15 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E16821BF204;
	Fri, 18 Aug 2023 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1692379873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CsqisBIwLkNSfZ+y3mvCVGK3bSiHyGadUN8VCpz3DA=;
	b=CSlp3TIOzPEQd0oudQCCthnyOmBeUyib6Apa4FpSn9LP2c4pNnhMuM2BazA20yDqPZWVkx
	/zMGV9vAo/Mny/S91LQ7USJokuWIdGrbCz1g3cJOiY2uuB4+TKTTQDqAZzdyYqz+HKvILu
	teKYuUcCeC6GpCpOfGvoT+HqQhsJ4SyAHux5KspiiVX/viTL6jTgidP+Hy/QhBulOuyvSs
	OSJdLseyVw3jTwIKHanZ4K4bCdE3HKvi5Pa7L7Kc84mqbrWkRnF9mbosOu/PfDhqxZXyOb
	vupZx26+5ic/mbeiGH/5Kxj4C13oHSwYKDT7Wt39Jdxjh8llmtg9mJNCgZ8Lqw==
References: <48358551.MN2xkq1pzW@somecomputer>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard@sigma-star.at>
Cc: xenomai@lists.linux.dev
Subject: Re: Task exit via rt_task_suspend()?
Date: Fri, 18 Aug 2023 19:26:15 +0200
In-reply-to: <48358551.MN2xkq1pzW@somecomputer>
Message-ID: <87fs4gqmu7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Richard Weinberger <richard@sigma-star.at> writes:

> Hi!
>
> I have a not yet understood deadlock in a Xenomai application on my desk.
> It looks like the deadlock is caused by the fact that rt_task_suspend()
> can cause the calling thread to exit.
>
> So, a thread puts itself into suspend and never returns (and exists).
> Debugging indicates that ret = __RT(kill(pid, SIGSUSP)); in threadobj_suspend()
> is the place where it enters the kernel and never return and inside the
> kernel exits.
>
> Can this be? :-S
>
> Thanks,
> //richard

Cobalt signal handling may not be the cause of such exit, syscall
handling could be, i.e. any code path crossing xnthread_test_cancel()
starting from cobalt/posix/syscall.c. The best way to find out would be
ftracing.

-- 
Philippe.
