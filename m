Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842902C11E7
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513761; cv=none; b=GULyu8Mv1lyDWW97gNVP9MUyMmx50iD4509nJzxv6hofx2kHJRjFIYBd17sVydXdVzIOkNtO0c5IZvidVRo0v30sJ5OQTFEnjiM6rlMBWrlKcAyXM3IvGP1E68qvDOjp2O5/6yapfvjGSm5JVd1BszjlSdsyvOXcHWbjzBIQPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513761; c=relaxed/simple;
	bh=fcl738yzK9lAp4vn6vrV8Dsk1Dg1RyVJ5AfNrwmS0Rk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UhbwXeNrdj/sPpGTZtebPfQqpAlmX3ZsPrHJvayMZMnusS96wyOBoSiTQpQcAF8ws38v2DSn6V6k38CM7LxSCyYZxi3BXGNMjtRqJ1t8I7/T6lapprGNZUhgwQUuYfcypMUvqok7D276eXnklBkdjIfc6DfYsg7K9bhSX2D3q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=gm9BSv+7; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="gm9BSv+7"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C5DD20CC8;
	Fri,  4 Sep 2026 09:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788513741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WcDKiVL9g8DkgyEnTA9Mq4y7YJyA9oEVG9n/4E3s7AE=;
	b=gm9BSv+7nX4cqMn032NV3gugQl0j4Nkh1oS7GZd5upnyIl/ffqvJwoRX+pOa2fcDdXiiY9
	B4r+CpMaimyxm5yNwAEEfX0trWA85299B8KJPkpAKNKBTL0g6orjNzHgDiN2xACn4dRcJV
	zHyiFGnZhAaBRgO+bZFSHTpHGRbgWJRl/l2Q0QJ9SL0yGoh+5/rkhfkPmKjM9u45MS+658
	xW1xVKErE9Kk9G/g0yQbvb3oGxIiTpSmGYOHPH6f+ls0R2Jur7ioOKGBpdmQ+tyjudx2yD
	YlDm3Bbu4TML1wcJS5cwtuWEnG29ImyK+3AqY87qgRExj/I5R6BnE007aTmKxg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH] tests: sched-quota: Perform calibration without
 quota again
In-Reply-To: <b78962e2-2109-49c8-9c88-8acb4b282f67@siemens.com> (Jan Kiszka's
	message of "Mon, 31 Aug 2026 16:56:35 +0200")
References: <b78962e2-2109-49c8-9c88-8acb4b282f67@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 11:22:20 +0200
Message-ID: <87cxutfk1f.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEhJeKkYA2AYI4ApzErhFgJ33Rn1zVYTaGMCJ3H2EWnCmzmj28A8C4ef7AZE2TBstYXU89biRkG1fE0skp8s3NI3bxsxZxK4WetC/hZnQc1tXPV3qULrJNDol9S2/mezh84msxiMJoyXXOzmMRco2JzjJt8BKmEk+zvCqtDu69n5ktTa96v/rk5Iq7TVbrus+RhPuSK8Uk0NQWn5QcXB9AvoiIYtSk7msM2tXa3ABlHOJncLvOUyBZixiDURMCS5VcHEnKVBciZ2z6iNozYE2hZPUHyb+Pb5Qehz8NHtLD6dYbkNdCfCzu5Zvbdwh4Dp0etzEOGstUc8pfrRTkarZCXOCmumiawwO6WLDf4PfDr40nZ15pplxhUMpz97O3qPWksRYDX2J8N8f9tCEjcfB+F7X5uG8ep7lwKLCO7Nlzw+tMTk2e5fko3cPJZNs3BHlyVqS9vSEVCJHkY1XZHVmadlFevX3ai1fXMG10AXCLLG2nNFuqIh0BRI1qAlJVqeeqQL9smNs/+ppzu0QUZLM0E+QczNifznzGfkWiAjSDh6S++h6pRcKIAhLgaWZI5rQxXFgIVnIeYqrppKPdKSRrbAy8BCt2jM6MMingsp1PoPChUTh6WyZxiXsfdEPNqnUNrftdsafYU2CHYUrjKdhnVtPYOId8nG3/qztoGN3gUjQ
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> It defeats the purpose of the test when we calibrate under quota as we
> can no longer compare the actual cap against the configured value.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  tests/sched-quota-accuracy.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
> index 1bf5eb9..ac04449 100644
> --- a/tests/sched-quota-accuracy.c
> +++ b/tests/sched-quota-accuracy.c
> @@ -171,15 +171,15 @@ static void *quota_thread(void *arg)
>  	__Tcall_assert(t->efd, evl_attach_self("quota-runner:%d.%d",
>  						getpid(), serial));
>  
> +	wait_phase(calibration_phase);
> +
> +	do_work(t, PERIOD_NS * NR_PERIODS);
> +
>  	attrs.sched_policy = SCHED_QUOTA;
>  	attrs.sched_priority = QUOTA_PRIO;
>  	attrs.sched_quota_group = tgid;
>  	__Tcall_assert(ret, evl_set_schedattr(t->efd, &attrs));
>  
> -	wait_phase(calibration_phase);
> -
> -	do_work(t, PERIOD_NS * NR_PERIODS);
> -
>  	wait_phase(accuracy_measurement_phase);
>  
>  	do_work(t, PERIOD_NS * NR_PERIODS);
> @@ -338,7 +338,8 @@ static struct accuracy_results run_quota(void)
>  	 * expressed as a percentage. The closest to the QUOTA_PERCENT
>  	 * target, the better.
>  	 */
> -	results.accuracy = ((double)loops_at_accuracy * 100.0) / (double)loops_at_calibration;
> +	results.accuracy = 100.0 *
> +		((double)loops_at_accuracy * 100.0 / QUOTA_PERCENT) / (double)loops_at_calibration;
>  
>  	/*
>  	 * Level of noise observed for the disrupted run compared to
> @@ -346,7 +347,8 @@ static struct accuracy_results run_quota(void)
>  	 * run was faster than the calibration one, which would still
>  	 * be correct.
>  	 */
> -	results.noise = 100.0 - (((double)loops_with_disruption * 100.0) / (double)loops_at_calibration);
> +	results.noise = 100.0 - (100.0 *
> +		((double)loops_with_disruption * 100.0 / QUOTA_PERCENT) / (double)loops_at_calibration);
>  
>  	__Tcall_assert(ret, cleanup_group());

Merged, thanks.

-- 
Philippe.
