Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653EC37A829
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517644; cv=none; b=nmvoVRag6u6zoN3iTarmuWteGPqJkGe7lNbyMOGq4ng86zlprTDdRMdbLKwa2AgY/gmWhWP8ihTtJuxI+lW7TnPygfMrL4T8g1Qkazj8JC5REXgKYjiNhnFdPMWrYsmGPefAVBWp6ZJjojvZUsAstPFwaElRKJPtkX0YsmtIZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517644; c=relaxed/simple;
	bh=90CHD8QOhQwIFcfNamfr1RzCkTkYKoinaao4+rGDp/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FJY5Ys3uMZlVMC+bvapcwjnISc/sihI56N1Hr84cM22GkjRdytYVsgJz0Vrw7vBwLB1UvSG7gxwQDDh5oSibZRj6+J6bYpC8pcECuKypS2UoHCmwEjmqV1SS/Wj5vU/2Y+FY9dOTfKEnYXuedHaKJxqosX8BCgEpCXD2hjl051s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Oc5AbItV; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Oc5AbItV"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 270EA586500
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 09:26:06 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 053EE3E97F;
	Fri,  4 Sep 2026 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788513964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9cgf76sZPCZ7ch9IF2ne/W1LJYEv4ITgYapH5VWsDBI=;
	b=Oc5AbItVjeIOW2ljII/y2UM4JYe42wikFpJtWwPfbfRrVUb473qHZ8o/DlwxBrAcY+IvGd
	c9tO8xKQBjhiSC70KuQ/S5VKIbzhvG4SHr9/J3GSMohhsHu0DWnEVKdvJyX5y7uZBCC3VT
	GerwpdQFx4AfrfDh207HJWfJONxwzto5ar5iOucC8m6VP/05voRWC5oWvWFnOfggtlh0sl
	4K+Y7hTPW+TEJXVZT38st1zvYzsSYcp3fQ6IMrDOhub49xULKIWAQt3NkjR2FsdM9Bvaa7
	DNp1XLtKuKVilFbps+Wrg+4roMuU4twSSq2sQBKkiTFPPjG8mkSc30ZkgFi50Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH] tests: sched-quota: Simplify disruption
In-Reply-To: <72486647-41b3-448b-bfe3-85135c1ad53f@siemens.com> (Jan Kiszka's
	message of "Mon, 31 Aug 2026 19:50:25 +0200")
References: <72486647-41b3-448b-bfe3-85135c1ad53f@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 11:26:03 +0200
Message-ID: <877bl1fjv8.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTF+ycvcnhyU/kVVwGmVp74xwaZiJ0ie3mDlFYDeuYyRAYt6wBjC+dpCVLYsfCb9kw1jxmErAiQZe5J12+TlRQBzUU8IH4CS4UU5Saw5Qtqvv5O5S2hmhc2hry66lrOBTiB9ilJcGObpQpOsF9HsOdqPaEjtUrcbpYKHux+hH6S5r65N16DwbPsZTYqSq9Zg7Tf0up6J+V0Rc8/CP2bd5HL00pijYr3OxUu1KlwWfw+vdGctVdSq3pCclSUY68iLwlLfxIMV/eTNJG1FwCVUaBFA/lxeL7d/99i79Rvv1sanqQIs+ZSVrOt8pRH3f8ygvZYeIrJA9MAoqYwWTlabLiVQccfaqrmWvYUmdjXJ23d8sRuul32xmGHszmT08FZr9/mUNJSkHJ3a5ivcwjB5YMfclZbGaM7q0jDvH/MKfI4yrqEK7GBw1G0Kq8KBAXBLV74uUP/xbOubobSODH7f02dkHEA7HExrBIXl2ce538Vclw+14JPz7mi+woYqVk0VK5zVrgtz1HrSphojfNh2he/iemqSLkzJGiwu/yu3CpPP1IwhI4xUlcr++tN1v9x1v/rrVZ/I5+NHR8TfbxWgxw8QiqDPVcFvYogqVSILW67uvl2se1AJeJV+Mk3A7frIUM+Hb77JYEFfTQf8iwziUYQzo8g6P7tRNNRzvU7Kmgl6Aw

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> No need to spawn an extra thread here and also play ping-pong with it to
> generate an oscillating load. The main thread can do the very same thing
> within a few lines of code.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> On top of my previous patches.
>
>  tests/sched-quota-accuracy.c | 52 +++---------------------------------
>  1 file changed, 3 insertions(+), 49 deletions(-)
>
> diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
> index ac04449..251ea30 100644
> --- a/tests/sched-quota-accuracy.c
> +++ b/tests/sched-quota-accuracy.c
> @@ -26,15 +26,13 @@
>  
>  #define MAX_THREADS	8
>  #define QUOTA_PRIO	1
> -#define DISRUPTOR_PRIO	2
> -#define MAIN_PRIO	3
> +#define MAIN_PRIO	2
>  
>  enum runtime_phase {
>  	idle_phase,
>  	calibration_phase,
>  	accuracy_measurement_phase,
>  	noise_measurement_phase,
> -	disruption_phase,
>  } current_phase = idle_phase;
>  
>  static struct quota_thread_desc {
> @@ -111,23 +109,6 @@ static void wait_phase(enum runtime_phase phase)
>  	__Tcall_assert(ret, evl_unlock_mutex(&lock));
>  }
>  
> -static void wait_edge(enum runtime_phase phase)
> -{
> -	enum runtime_phase old_phase = phase;
> -	int ret;
> -
> -	__Tcall_assert(ret, evl_lock_mutex(&lock));
> -	for (;;) {
> -		if (current_phase == phase) {
> -			current_phase = old_phase;
> -			break;
> -		}
> -		old_phase = current_phase;
> -		__Tcall_assert(ret, evl_wait_event(&barrier, &lock));
> -	}
> -	__Tcall_assert(ret, evl_unlock_mutex(&lock));
> -}
> -
>  static void start_phase(enum runtime_phase phase)
>  {
>  	int ret;
> @@ -191,24 +172,6 @@ static void *quota_thread(void *arg)
>  	return NULL;
>  }
>  
> -static void *disruptor_thread(void *arg)
> -{
> -	int ret;
> -
> -	__Tcall_assert(ret, evl_attach_self("quota-disruptor:%d", getpid()));
> -
> -	wait_phase(noise_measurement_phase);
> -
> -	for (;;) {
> -		wait_edge(disruption_phase);
> -		do_trace("(...disrupting...)");
> -		do_work(NULL, DISRUPT_NS);
> -		start_phase(noise_measurement_phase);
> -	}
> -
> -	return NULL;
> -}
> -
>  static int cleanup_group(void)
>  {
>  	union evl_sched_ctlparam p;
> @@ -236,7 +199,6 @@ static struct accuracy_results run_quota(void)
>  	union evl_sched_ctlparam p;
>  	union evl_sched_ctlinfo q;
>  	struct timespec now, next;
> -	pthread_t disruptor;
>  	struct sigaction sa;
>  	int ret, n;
>  
> @@ -304,10 +266,6 @@ static struct accuracy_results run_quota(void)
>  
>  	do_trace("CPU%d: starting noise measurement", test_cpu);
>  
> -	/* Start the disruptor thread then wait for sync. */
> -	new_thread(&disruptor, SCHED_FIFO, DISRUPTOR_PRIO, disruptor_thread, NULL);
> -	__Tcall_assert(ret, evl_get_sem(&ready));
> -
>  	reset_quota_period(PERIOD_NS);
>  	start_phase(noise_measurement_phase);
>  
> @@ -316,17 +274,13 @@ static struct accuracy_results run_quota(void)
>  		evl_read_clock(EVL_CLOCK_MONOTONIC, &now);
>  		timespec_add_ns(&next, &now, DISRUPT_NS);
>  		__Tcall_assert(ret, evl_sleep_until(EVL_CLOCK_MONOTONIC, &next));
> -		start_phase(disruption_phase);
> -		wait_phase(noise_measurement_phase);
> -		__Tcall_assert(ret, evl_get_sem(&ready));
> +		do_trace("(...disrupting...)");
> +		do_work(NULL, DISRUPT_NS);
>  	}
>  
>  	for (n = 0; n < nrthreads; n++)
>  		pthread_join(threads[n].tid, NULL);
>  
> -	pthread_cancel(disruptor);
> -	pthread_join(disruptor, NULL);
> -
>  	for (n = 0, loops_with_disruption = 0; n < nrthreads; n++) {
>  		loops_with_disruption += threads[n].loops;
>  		do_trace("CPU%d: noise: quota_thread[%d]: loops=%llu",

Merged, thanks.

-- 
Philippe.
