Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8AE36D9EB
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513698; cv=none; b=KBG9ebd8DnGvU1wNxmwp7D9DANjp4hN6RHZChcqIr0Y5L9nW+4GFkxhiORluVhDmEqYOQiZTox2UvhmmTN0LxpE6NSiOzR+TBEM0zJcbasOqxYi7/n4w9vfNHjjy3pG0nL+BZM9ATysxvEwfodWl01eLxYX1Bqw4MHPvuQ2rxb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513698; c=relaxed/simple;
	bh=zPoFJOO5zsq3eStUXtpVwhe9xXdx3Pf/kwwHZXAv5xA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gbUL/hcLv1WnfOtQpVIjavSzqh3qnQqp/Vq2xwWLS/bSKbQui68Fp2sv7h5+HyEjMEgVeA7+9G2oxnTkKpurcbXPiQ3jmICq56IRYeIPZPKcVrnQIcLQ2Mia2W0l0Tvj3k4Nb+Ppei5VHsk/Vj2+gmXShephzPbccfU6WxgWeJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=docqkut4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="docqkut4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 615EE3E985;
	Fri,  4 Sep 2026 09:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788513693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7RI2PZc55IcMxq87en5NlJMFc6jwRLuqL1Yk5JkPmSI=;
	b=docqkut4YYtuvLLeP9sgsUa+cp9UgQJ9GCHxXfkJZT5vtD/S90NzH/NjIeKWLtKsGxiiNs
	e+TqA5LkPTnzklauhzXthGyt7pg/HEn0eTPYXSIZ2h06j+hKXl6lgoqgNVwZA677NffAZx
	DmaOSngrIUBo3J+qNEX+6pt/y6QpeZLxvqWPg2D3Jpe5zhRnWbV+NbCgxPbFPxx8uvSvCg
	CQhwSW6f31X78Q0XX5CSKZUVGspN65dD+0Vw6R0XTgR0jBvlbNZgwIrvMbsH8jNpEfH3+7
	YexUkGTxA7RGW1UNxMQz8EW6SDf49gHW7KJymQhpXTV1AHbqAaTOhQL7ZWskGw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH] tests: sched-quota: Synchronize all threads
 before readings stats
In-Reply-To: <2776b343-0622-4f57-b806-094f0120b220@siemens.com> (Jan Kiszka's
	message of "Mon, 31 Aug 2026 15:30:14 +0200")
References: <2776b343-0622-4f57-b806-094f0120b220@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 11:21:32 +0200
Message-ID: <87ik4lfk2r.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEhJeKkYA2AYI4ApzErhFgJ33Rn1zVYTaGMCJ3H2EWnCmzmj28A8C4ef7AZE2TBstYXU89biRkG1fE0skp8s3NI3bxsxZxK4WetC/hZnQc1tXPV3qULrJNDol9S2/mezh84msxiMJoyXXOzmMRco2JzjJt8BKmEk+zvCqtDu69n5ktTa96v/rk5Iq7TVbrus+RhPuSK8Uk0NQWn5QcXB9AvoiIYtSk7msM2tXa3ABlHOJncLvOUyBZixiDURMCS5VcHEnKVBciZ2z6iNozYE2hZPUHyb+Pb5Qehz8NHtLD6dYbkNdCfCzu5Zvbdwh4Dp0etzEOGstUc8pfrRTkarZCXTfqGlJZuDohCKozrhk9/kFyp+lV5sdN5HR0VfO6aCKDpCRKXYbjeN9NJtumYW8iF1Gqw8YnW9PYPv23z/qvZxBZsxxSV970xFFEfeARoiUr60hngbZzxqibpMl0N6jbqpCORy9tzpHnCVMKMwNNGFDbegAj/6HxpEkkii4lKZRMhsw6ONrPZu2ooNCRC4dJaFuDc67oqvxy00mSKLX30oNesfAUfM7+dynmsw66ZS8+Y/djzaUiMkGIaGVj3Y/7ABFRl+XVsG4nBt50hQIRn6dcrxJXHQ0Okx1JdYWCDb9Vjv189omBhjPg0s870HQJnjp0vide9++/w+d+L3VJM3w
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The quota threads may complete their work in a random order. Wait for
> them all first before starting to read out their stats. This avoids
> inconsistencies.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  tests/sched-quota-accuracy.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
> index 2a2dc38..1bf5eb9 100644
> --- a/tests/sched-quota-accuracy.c
> +++ b/tests/sched-quota-accuracy.c
> @@ -275,8 +275,9 @@ static struct accuracy_results run_quota(void)
>  	 * number of loops we should be able to run during the
>  	 * allotted quota, even in case of runtime disruption.
>  	 */
> -	for (n = 0, loops_at_calibration = 0; n < nrthreads; n++) {
> +	for (n = 0; n < nrthreads; n++)
>  		__Tcall_assert(ret, evl_get_sem(&ready));
> +	for (n = 0, loops_at_calibration = 0; n < nrthreads; n++) {
>  		do_trace("CPU%d: calibration: quota_thread[%d]: %llu loops",
>  			test_cpu, n, threads[n].loops);
>  		loops_at_calibration += threads[n].loops;
> @@ -292,8 +293,9 @@ static struct accuracy_results run_quota(void)
>  	 * Wait for the accuracy measurement to end, then collect the
>  	 * numbers.
>  	 */
> -	for (n = 0, loops_at_accuracy = 0; n < nrthreads; n++) {
> +	for (n = 0; n < nrthreads; n++)
>  		__Tcall_assert(ret, evl_get_sem(&ready));
> +	for (n = 0, loops_at_accuracy = 0; n < nrthreads; n++) {
>  		do_trace("CPU%d: accuracy: quota_thread[%d]: %llu loops",
>  			test_cpu, n, threads[n].loops);
>  		loops_at_accuracy += threads[n].loops;

Merged, thanks.

-- 
Philippe.
