Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE629E11A
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604081; cv=none; b=BkD5K9HybbgqgBTGNZwAk2wa+9adLT0az+qYC4TDmFTysBV4dbdIA3BgfFoqoqTECUtxm3Ur6hKaxeioOFFlphOw6GryR3kt9GG41jTuJe5Tz+0DnA5HVLSQ82ZMLEwaDkjtPHNoo3yAfFnAwsF07sN+dWLYWXHW8gp7KNdk4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604081; c=relaxed/simple;
	bh=f7ihrGp69bhku+iEQm7jG3bhZb306nZgbzwlygmP5p4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fX7RFoFYarooihke9EaQJwXsBxss14sACRYTcKk++I9MYzZRN7SbwaNsuvizAvTe3bPdO4Jnze0PY/Qd4tz+kCubbfb+PAZ5uxQCNJwklSRu1wHP+TvJWJ/zSVs9gdK2z/FwJKOcBbFiHbYkk5E9I+o7vPD0vQsRRovxXMGHwm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=SDc4YpVx; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="SDc4YpVx"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A267B1F749;
	Thu,  9 Jul 2026 13:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783604071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mej/4fPyhFRdJ3YNl782zQEBvJuLuXoDyWYGC5ifs9w=;
	b=SDc4YpVx1FLxWWege+eMVsX6YsgZeUX70eTcuJYmFnGxdAd/UoMJYThauGEY16PgoPzGV0
	viRwwRty8xaUEslNMw9untuOQnHb8To96sDQ/ydzg4Mw/j5LcO4IHCYDBkmVK1dDViHk2y
	Ies6Xzer6cvEfoVsSoz9EhwXM1KxR8pPw1LgPOHNReMmAuL/COFbDq3g7cXNO/pL0xhRtV
	S6wLx7XKYTmsoZWpE+W11jogcPshWq/1IkI0bsTCnTssm95cMmiZLwOkaITZkMwxVJ/wGs
	CYpSMxc1SdhwSoLZ6TCL90U82fm1pouDia+I6vIBiKp8gKG/1xNOJMTrq7QfjA==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH libevl] tests: skip sched-tp-overrun in virtual
 environments
In-Reply-To: <20260709125851.173262-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Thu, 9 Jul 2026 14:58:51 +0200")
References: <20260709125851.173262-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 09 Jul 2026 15:34:24 +0200
Message-ID: <87bjcggucf.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFDXTWpKIOP9nWyyP6jrujwgFGg71fyGfJNRtIAn/DuZ6bkN7PfJvG0nfrZyyljJBnyYijCng8LETC9oZQ5D1c4oa+KNOXFwabh126fJfde100kuT61cmbwF7jUCIi4qo4XnLuDer9turtDStzAdXI8zGnH+x2JVY3apGX2a4UomyEYuxYp1yqV/TtFR7uEltSanWrclmUZWYrcMyVDtLeojznLetABxP3UQm01T5NM+ghL6fsA8YxEHr0VUsO43xpJjIXie+6yhq14IRMtPMdruCgQTQQMggpMVP3mI/lxEEvGPsu+59CGawyw/2Wq88vjHChgYTT9PLE1qXvSH6HhShQRnX6avQpmN3uVUdOE+2Mrfyszh2IWvZCr5xDSGt3pRUdDlqz0uHwyercp9036uYaGumuMBkhD3J/4fspexdEHSTiEyvTp4VspXUU9gBMfQvvt6R7PCjm1bZ5F4ak+la0Uc5W+g/k1dcglg4Sx9O5TLBNvwT3P5F/rxTURCldxTBxFVH9HLdi8lxUdMWL0KF+r7yXvZY33WflDZ5aUjj0Y0AsVwK0XEICtJMXLlrqvgCxIr52CDqZ6RPMSO1JqVUcSt0K7MhVppObNjUIuUK3Fp53gQYVTQVzU/hiE6ht6/sSyIIlH7W+kA8qcidWzgAFtQCVpE+H2wCAC0K/dsw

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Do not try to relax sched-tp-overrun on virtualized environments
> but skip the whole test since the test relies on timing guarantees
> that are not reliable under virtualization and further relaxations
> do not make any sense.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  tests/sched-tp-overrun.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/tests/sched-tp-overrun.c b/tests/sched-tp-overrun.c
> index 3bb6a21..a3ef27f 100644
> --- a/tests/sched-tp-overrun.c
> +++ b/tests/sched-tp-overrun.c
> @@ -128,16 +128,9 @@ static void *tp_thread(void *arg)
>  	 */
>  	__Texpr_assert(nf.event.val == part * 2);
>  
> -	/*
> -	 * Perform the following check on real hardware only, it is
> -	 * likely to be wrong in a virtualized environment for timing
> -	 * accuracy reason.
> -	 */
> -	if (!running_on_vm()) {
> -		/* Check that a single notification was sent. */
> -		__Fcall_assert(ret, evl_read_observable(tfd, &nf, 1));
> -		__Texpr_assert(ret == -EAGAIN);
> -	}
> +	/* Check that a single notification was sent. */
> +	__Fcall_assert(ret, evl_read_observable(tfd, &nf, 1));
> +	__Texpr_assert(ret == -EAGAIN);
>  
>  	return NULL;
>  }
> @@ -177,6 +170,15 @@ int main(int argc, char *argv[])
>  		return 1;
>  	}
>  
> +	/*
> +	 * Skip on virtualized environments since the test relies on
> +	 * timing guarantees that are not reliable under virtualization.
> +	 */
> +	if (running_on_vm()) {
> +		emit_info("unchecked (vm)");
> +		return EXIT_NO_STATUS;
> +	}
> +
>  	param.sched_priority = HIGH_PRIO;
>  	__Texpr_assert(pthread_setschedparam(pthread_self(),
>  				SCHED_FIFO, &param) == 0);

Merged, thanks.

-- 
Philippe.
