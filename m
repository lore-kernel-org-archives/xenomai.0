Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C5341DEE4
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431811; cv=none; b=H/pEE3ulau+gfyG3d9vmK0x/LMoyhqGVTGlPqk89pdkn6IuL6+othxh4FjTnT3rVU39oHW2C/ciTvBc+V7wTtGS43G9oT7WNlivxkoh6LpDO7r8JMpHgWqHuaqyoPkZfqaa5BFZiTVikmRaoEuk/gHfQQDrj+0qgk8MbrA/U4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431811; c=relaxed/simple;
	bh=t/oiYvKHShvadrGUJCuSnbSIGZ4tX22MFNOIeKBY68Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EaekCunJu92c7aCuaUQddB+OpCPfCTBNu1lFIFzZ2Cd2/bIN7Onq97mpcXbMd39lCtcKG6e02UyVn1vBfYw3vAZwrgqZqq2LBe+HzL5ONkBNL2eruDRjC6KRULqFqcmslUMYplMntAhUm6J8+HrNTDarDLAIEjIIt/dT780p5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=d+iN7RmP; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="d+iN7RmP"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 345753EC6A;
	Tue,  7 Jul 2026 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783431802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4iRQjfvpuM+n9KW2Na6y/F+r83HaZr44BgZViB+KDU=;
	b=d+iN7RmPBe8bSMSh/B3eu/gf32bPql6bN9NXjR4A95d33AB/vddzS/0YJ5OFAuJMKATxi+
	qUFIxKgpQ8DvSJfOEGhN4MuzT6947PUaloMINacBX9woZi0Hc0hsarLFLUkSgeqX0vNEfX
	/cEeHCZqmcLdzEqNSed3hfZHEnz+9rZivGVoobn9NhYkP92UoqgHawaV8d15/D7JCV9B1z
	POmg/c2yvwSiRcj8csaD3pqnWCG++GeHI/RJk9pPKsItEosGrTWtuPozk1mLtE2NmtBGWM
	uIZkzBzns4xcYp5bxc+ebwwZVB/LZLzuvWNSU7VTQpuDIagBctwn/lNeIq1jYw==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] utils: test: show test name before running it
In-Reply-To: <20260707110109.10253-1-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Tue, 7 Jul 2026 13:01:09 +0200")
References: <20260707110109.10253-1-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 07 Jul 2026 15:43:21 +0200
Message-ID: <87bjcix6di.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGZ8fBD8ZX9Sxhk98YoVfg1bQVxtlt5MBUHTjChbGFbWUJhER/kxiF6scf10Ur4Tq7TLP0qHaDHNdxnPZb7jSV1JWKHv3IhpsUMXmUUgXSgn/Ljrq2HoIK+J38y0bDnATdAsuogr/jatTLYJX8mQbSWb3uqSz+ACBLFE23my82BKtJJigwSqd6tovR+6YpHyXf3g6ejv6vYyJaV0xlrQTIzBczDQTyG8wo6ZinYhzFEu7Xozu7pYW2rTX5OOPNQA33R01T1K2H/xrI4ENRHlcQahsEWClDtmZ3bVuGKB6Fy0ZRLjUZRfhTn5K94aprrQpZhAumEZ6Wqzj2TVHsWOU/QYloOqfSStiqnd2BuL2WB5Yd7HX8Qlol/1m0Bpz+Izau4z7VAbDgj9B0t4HURPrDNL0Z9r95NTgV17vYL94HqzRjzhCpQMWMAU4v3Nm5UnEuVPszSt7NMlLxK4kErXNtw61vy/2CFCNLMnB3so+b6JH0WXUGJoExesnFjxB5JfEgRKplnkruL9/SJt6E7SH/SMSGtbA47dihQC+1F5f0/QhrZ1H+Fklx88AHhlXZ8aIiElUlXgG5rTLSyJkcXvWgyQqe3z/+UId+JdlR1oNDkiTf6wV2fRt4i5K59cMVyw1UfoxE5EDKs/r2qELRCKJqzZuEtnSUF7o2mKAFEkGG8lQ
X-GND-State: clean

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> This way, the running test is visible. This helps for longer running or
> freezed tests.
>
> The log is now shown after the test name.
>
> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
> ---
>  utils/evl-test | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/utils/evl-test b/utils/evl-test
> index fa3ef73..5139d09 100644
> --- a/utils/evl-test
> +++ b/utils/evl-test
> @@ -83,22 +83,23 @@ result=0
>  while : ; do
>        for t in $test_list; do
>  	  test \! -x $t && echo "$(basename $0): $(basename $t): no such test" && exit 2
> +	  echo -n "$(basename $t):"
>  	  # Swap stdout<->stderr for the test, capturing stderr into $log.
>  	  log=$($t $test_arg_list 3>&1 1>&2 2>&3)
>  	  status=$?
>  	  if test $status = 43; then
> -	      echo "$(basename $t): $log"
> +	      echo " $log"
>  	  else
> -	      test -n "$log" && echo "$log"
>  	      if test $status = 0; then
> -		  echo "$(basename $t): OK"
> +		  echo " OK"
>  	      elif test $status = 42; then
> -		  echo "$(basename $t): no kernel support"
> +		  echo " no kernel support"
>  	      else
> -		  echo "** $(basename $t): BROKEN"
> +		  echo " ** BROKEN"
>  		  result=$status
> -		  test x$keep_going = xfalse && break
>  	      fi
> +	      test -n "$log" && echo "$log"
> +	      test $result -ne 0 && test x$keep_going = xfalse && break
>  	  fi
>        done
>        test x$repeat = xfalse && break

Merged, thanks.

-- 
Philippe.
