Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA573C3C14
	for <xenomai@lists.linux.dev>; Fri, 28 Aug 2026 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903368; cv=none; b=eCMf3YanpNN1Fz1MDYiVJ9wDhDuJY+YZHUN/sZe0iBqY+/HWfEWp1mK4VXsAPPSzh0a8dsRnFhMDY0qnkorS0isFHw/xnWTrJn2MB1faH6FYwbO4Nd7fiH9xqCCl6j8EKCqezpFODAvUYkLoXGth7vPHBJkvxKZ++3k0F5QqCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903368; c=relaxed/simple;
	bh=tXzqIuUsr0n9/hPHovgy609KSfae9yTOB9M0qngbYWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OY0nZSRJiCLOpIJkth+im4E1u9dvhl+zke/G/4Q2xChY7S3RxUj8krJSuNjPTvUE2eiybHxjWKtTHJMoCEevXtT4mXPHB+4hZLKDp99A9gIewkcuJ6zaiqdIU57qJcxfnYO+1coQMfqMMn9m8VNMtoIQKk3gAPFAvAk97y5MZXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ndHCcRfy; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ndHCcRfy"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8F873F5B3;
	Fri, 28 Aug 2026 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1787903357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pHVhjXhkZCvuMrDU+YTx7DEOHSJldjnStGr/LcJUDM=;
	b=ndHCcRfyrFzYDRCRyEocGcI9gNHXCjKmdog5dg4sh1nUkRG+t/mVsDrK65cdxoDMZQNyJa
	jZU3dA3+O/XdfbHAq/kchfdR7wWhdyffCPfTKSNLD2T+6DnwZW8488NcFeE0I+FI3cOJfX
	XymxNqOVpAxyzHTpfd4cgEnVhcT8W4uZCzek9AqvyBf8Ru5iFZKp4Z4ghoR31aXYSFD9DX
	hfgCjjNF9nxVKK4HFp59cc54BgoxmFd9j2TbgyO6PRqUiJIqIE+JpCzAo/Vxw9UxeIe+TP
	wcM1fYMeXS5EkkwAU2ejp3bEFE7GhgSxlVAICDtwx7x0HcQ62ZjFFkFv3KOT5Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH] tests: sched-quota-accuracy: Fix test cpu
 selection
In-Reply-To: <a5498e33-54ca-4c7c-b260-3c8922685dfc@siemens.com> (Jan Kiszka's
	message of "Fri, 28 Aug 2026 07:46:27 +0200")
References: <a5498e33-54ca-4c7c-b260-3c8922685dfc@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 28 Aug 2026 09:49:16 +0200
Message-ID: <87tsoebs77.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGX3clCgi3/O1mdA/e8hLI7c6wRNQauLepgvnHSz0LGQoKWnmKdyw/2ZEoZgv3DPLgrgGCwHeqIqqUBVTyp/6WnuTbvs1KPVmYSGWeKeSi9Lw0cjR8Sy7jJxbxAA00DLsQOYmL8O6mjzpMONWQ7RwuPyiuNBR7ydhw20YgKUp3UJlgGI74Ukn33R0ZVTxJyu+EMuKVywVTNkvAihpg/xx/uqmPSneK+LGLo4+hfB8zdLuni48j2bQEdSDOorvgskq42I0gBAQEbdT3aJc7MUoiOg2R39u6crx4+uQ71UiNoi15fZb1GQHnPSdVUBnh017631dyJqispjRNS7oPinEcYA2OUe625xfnBxff0VDtHlHCsMzo3/8ohZu//QckYKzEJbX+OWcTnOIYPfl8Y2VbGL0vfGUvL/upa1IOkfHUhsX5rQGxrGpKscFsDmU8E4gXUCLLz3sjfRHcl5ahZVvXo8dLlKWNn8PV31dmYbZmvnLUHkrI5iqhhaoaO/v7R6wR7eodCHUBKrB+ZZzkZY9cL9EpJtL9r81oJxPrNPi9vWOocoNGIhTee8ok7tiWCJ26C5+3qljyRw0g7YnYTQpCJlQjVBNpph5a6dJF1nnm1Wfc7F16WULBBzVHTf26fRQVhiECSvGYcTnBXeHGj/KV0p8V3OaWsaSQae1RE4bWl3Q

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> pick_test_cpu() is adjusting test_cpu to the system's possibilities.
> That is 0 for a single-core machine, but it can also be something else
> on multicore machines if the OOB cpuset is restricted. And this causes
> the test to fail:
>
> sched-quota-accuracy: ** BROKEN
> ../tests/sched-quota-accuracy.c:96: FAILED: sched_setaffinity(0, sizeof(affinity), &affinity) (=Operation not permitted)
>
> Fixes: 245a2eac29eb ("tests: sched-quota-accuracy: extend measurement to preemption noise")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  tests/sched-quota-accuracy.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
> index 2c4daed..2a2dc38 100644
> --- a/tests/sched-quota-accuracy.c
> +++ b/tests/sched-quota-accuracy.c
> @@ -389,15 +389,6 @@ int main(int argc, char *argv[])
>  	}
>  
>  	atexit((void (*)(void))cleanup_group);
> -	set_cpu_affinity();	/* All test threads inherit this. */
> -
> -	param.sched_priority = MAIN_PRIO;
> -	__Tcall_assert(ret, pthread_setschedparam(pthread_self(), SCHED_FIFO, &param));
> -	__Tcall_assert(ret, evl_attach_self("quota-accuracy:%d", getpid()));
> -
> -	__Tcall_assert(ret, evl_new_sem(&ready, "quota-ready:%d", getpid()));
> -	__Tcall_assert(ret, evl_new_event(&barrier, "quota-barrier:%d", getpid()));
> -	__Tcall_assert(ret, evl_new_mutex(&lock, "quota-lock:%d", getpid()));
>  
>  	/*
>  	 * We need all threads to be pinned on the same (oob-capable)
> @@ -407,6 +398,15 @@ int main(int argc, char *argv[])
>  	 */
>  	test_cpu = pick_test_cpu(test_cpu, false, NULL);
>  	do_trace("picked CPU%d for execution", test_cpu);
> +	set_cpu_affinity();	/* All test threads inherit this. */
> +
> +	param.sched_priority = MAIN_PRIO;
> +	__Tcall_assert(ret, pthread_setschedparam(pthread_self(), SCHED_FIFO, &param));
> +	__Tcall_assert(ret, evl_attach_self("quota-accuracy:%d", getpid()));
> +
> +	__Tcall_assert(ret, evl_new_sem(&ready, "quota-ready:%d", getpid()));
> +	__Tcall_assert(ret, evl_new_event(&barrier, "quota-barrier:%d", getpid()));
> +	__Tcall_assert(ret, evl_new_mutex(&lock, "quota-lock:%d", getpid()));
>  
>  	if (nrthreads <= 0)
>  		nrthreads = 3;

Merged, thanks.

-- 
Philippe.
