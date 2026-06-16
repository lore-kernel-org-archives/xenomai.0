Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C93DA7CA
	for <xenomai@lists.linux.dev>; Tue, 16 Jun 2026 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590176; cv=none; b=aB7bOVL5IYhmkpZvfKu8fMUgj5v/fPOI++O8OCfW0/FybYbJVlLeg1ILNGINPv9535KFFLl7QcJbZfRX0FIm+mcrz2vWKwg1C2Kn5A5GShPCUJEcnrb2Q/yssPNuIhD0x36jouKtpFUhQ7TCV0ix9uTGK3nHga3dLsMzVTwnXqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590176; c=relaxed/simple;
	bh=ApB3WdCmqEnJbMYX68KhulcutVxfM/u0Zso61q+q77U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tzi1opeQ2h/62c9YLH6w1dFNt/kEIUkTEoIkK2bMnaQGr7Wf+auI9yFVBPIsikwlOw/ZnMSDlRvIob37XA67xYIj6ffnpRwAG+6aHsD1jPPDUm1WkZQ9I4AvPLvoTeGvei3EvtvdRDYw/RoE7wUxsbsNlsqIzXPEl5v9Ka6vK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=NbpwlMzp; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="NbpwlMzp"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D04FB3F6CB;
	Tue, 16 Jun 2026 06:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781590172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RpLYP4ztjpWR9P85abUkRAI3+GI0mngZ8qB27fmqm+E=;
	b=NbpwlMzpVQ3rdFPaKG6Y3RBz1T6pAy9Y9+lGFsnZSC2LQkhaUw2/e5P7VOFdWB0eyJr7XR
	ZZCvSn9vb8yltd1iwWE/W+AdyPynT0pCDFgPYAcY63GxUETU7vCeFqDIzzRI5irtB84Wy4
	wXYthGotw88FcF0ih+dhh/+zmRtQfk3cwzyKVF/G3GmsfeVde734yW4wLreFdzMFPXa1ug
	ONepeb2XxWeyrSP5+FMMxLWRZcMZKnTSzKA3Mxp0yO/rnz1Hs7owVBoH0Yp5lhu3EwsxcQ
	31QWYbqLrwu1CGv6laLlXVF5Oyqe1IaQRTA+c/VDnXZWnkcLMeQ9S5PUTCmdTw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 2/2] tests: sched-quota-accuracy: Add preempting
 FIFO thread
In-Reply-To: <38c143a3-5021-4617-ab2f-ff3c9f3adc74@siemens.com> (Jan Kiszka's
	message of "Sun, 14 Jun 2026 21:37:26 +0200")
References: <83bfeeef-c3b2-473e-b94f-8d270b0a512c@siemens.com>
	<38c143a3-5021-4617-ab2f-ff3c9f3adc74@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 16 Jun 2026 08:09:21 +0200
Message-ID: <87zf0vow32.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFx4BxrMuhbzvl129BXHL4rDFP6Wr80rOXKEMlr8Za6QrvVLE+HXtEQkEVoFnGggLrQnrOmScRYsRcMwx9TLRcsUcEFLfSMNZJ0mvVRRJU9xyr4h76OOmyOJzSA+ejSh/4A7nZtmx0j7/IHLZVMMn1arktRnZuu/uB7iPRgZD47OLQh/+ax71Mt34GVmGLoQ5CGG6WhyVl045FC00ITjS1sSKReyRPTTPplXVtWjVq8zeqJpSlGaB1uA5fmldS3xOt+TyoQ+UiFI/OetctTSHEYO66YK/pHpFC13dW1yLD2rsqEtouV+mE80ag4nOv+Abl6BB4fF50lsnTak/CvdVKfJikVXrirwcR0FdkRyMIyB3V3cHOj53x0SURTN+ZTIGVyjGnV4dFOeGRGNQUn4p7CHMwEQVdmAic+K2Hu9WyqulqB1JR6On5/VKnKZ5rVTZCgjHql+zY28txExQHR8T4CW15HTJzL9EI8HX3U/QVDikydKuoRm4belluV6McO/DJhNu1z062fNrv+5aYABayTjMLeITXaAIa0TYe1SUdTVeuE4cKLMn+Ixh5g+QBkaYhjoRsyHz1FU5o+urfml/DUUP/S8xh73/KiU2EfS/55TYaxw74MHZ5p9xyZblbutMuccbD9p8l2vSgP9KjNcBQ1V7y/e585F+DflG+RQv2GtA

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Test that higher-prio SCHED_FIFO threads do not run on the bill of
> SCHED_QUOTA threads and that their accounting is not otherwise
> disturbed.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  tests/sched-quota-accuracy.c | 55 +++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
> index 278ff1b..f48f034 100644
> --- a/tests/sched-quota-accuracy.c
> +++ b/tests/sched-quota-accuracy.c
> @@ -34,7 +34,7 @@ static struct quota_thread_desc {
>  	pthread_t tid;
>  	struct evl_sched_attrs attrs;
>  	unsigned long count;
> -} threads[MAX_THREADS];
> +} threads[MAX_THREADS + 1];
>  
>  static int nrthreads = 3;
>  
> @@ -165,6 +165,41 @@ static void *quota_thread(void *arg)
>  	return NULL;
>  }
>  
> +static void *disruption_thread(void *arg)
> +{
> +	int serial = (int)(long)arg;
> +	struct quota_thread_desc *t = threads + serial;
> +	struct timespec now, to;
> +	unsigned long loops;
> +	int ret;
> +
> +	set_thread_affinity();
> +
> +	loops = crunch_per_sec / 1000; /* yield every 1 ms */
> +
> +	__Tcall_assert(t->efd, evl_attach_self("disrupt"));
> +
> +	evl_put_sem(&ready);
> +
> +	__Tcall_assert(ret, evl_lock_mutex(&lock));
> +	for (;;) {
> +		if (started)
> +			break;
> +		__Tcall_assert(ret, evl_wait_event(&barrier, &lock));
> +	}
> +	__Tcall_assert(ret, evl_unlock_mutex(&lock));
> +
> +	while (!done) {
> +		do_work(loops, &t->count);
> +
> +		__Tcall_assert(ret, evl_read_clock(EVL_CLOCK_MONOTONIC, &now));
> +		timespec_add_ns(&to, &now, 1000000);
> +		__Tcall_assert(ret, evl_sleep_until(EVL_CLOCK_MONOTONIC, &to));
> +	}
> +
> +	return NULL;
> +}
> +
>  static void create_quota_thread(int tgid, int serial)
>  {
>  	struct quota_thread_desc *t = threads + serial;
> @@ -175,13 +210,13 @@ static void create_quota_thread(int tgid, int serial)
>  	new_thread(&t->tid, SCHED_FIFO, 1, quota_thread, (void *)(long)serial);
>  }
>  
> -static void create_fifo_thread(int serial)
> +static void create_fifo_thread(void *(*thread_func)(void *), int serial)
>  {
>  	struct quota_thread_desc *t = threads + serial;
>  
>  	t->attrs.sched_policy = SCHED_FIFO;
> -	t->attrs.sched_priority = 1;
> -	new_thread(&t->tid, SCHED_FIFO, 1, quota_thread, (void *)(long)serial);
> +	t->attrs.sched_priority = 2;
> +	new_thread(&t->tid, SCHED_FIFO, 2, thread_func, (void *)(long)serial);
>  }
>  
>  static int cleanup_group(void)
> @@ -235,6 +270,9 @@ static double run_quota(int quota)
>  		__Tcall_assert(ret, evl_get_sem(&ready));
>  	}
>  
> +	create_fifo_thread(disruption_thread, n);
> +	__Tcall_assert(ret, evl_get_sem(&ready));
> +
>  	__Tcall_assert(ret, evl_lock_mutex(&lock));
>  	started = true;
>  	__Tcall_assert(ret, evl_broadcast_event(&barrier));
> @@ -256,6 +294,8 @@ static double run_quota(int quota)
>  	for (n = 0; n < nrthreads; n++)
>  		pthread_join(threads[n].tid, NULL);
>  
> +	pthread_join(threads[nrthreads].tid, NULL);
> +
>  	/*
>  	 * Percentage of completion of the SCHED_QUOTA run for the
>  	 * given quota value, compared to the calibration run which
> @@ -301,7 +341,7 @@ static unsigned long long calibrate(void)
>  	crunch_per_sec = (((unsigned long long)count) * ONE_BILLION) / ns;
>  
>  	for (n = 0; n < nrthreads; n++) {
> -		create_fifo_thread(n);
> +		create_fifo_thread(quota_thread, n);
>  		__Tcall_assert(ret, evl_get_sem(&ready));
>  	}
>  
> @@ -400,12 +440,13 @@ int main(int argc, char *argv[])
>  	effective = run_quota(quota);
>  
>  	if (verbose)	  /* Percentage of quota actually obtained. */
> -		do_trace("CPU%d: %d thread%s: cap=%d%%, effective=%.1f%%",
> +		do_trace("CPU%d: %d thread%s: cap=%d%%, effective=%.1f%%, disruption=%.1f%%",
>  			test_cpu,
>  			nrthreads,
>  			nrthreads > 1 ?	"s": "",
>  			quota,
> -			effective);
> +			effective,
> +			threads[nrthreads].count * 100.0 / loops_per_sec);
>  
>  	/*
>  	 * The accuracy value is the alignment of the observed runtime

Merged, thanks.

-- 
Philippe.
