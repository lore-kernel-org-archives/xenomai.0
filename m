Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724E10F1
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288160; cv=none; b=i4hspMuowHSTuqGB97DNJrNnsd75UZJOsoJl+Qu3emaVFN3R9D2pqKhykNx4nzPeggwzVP/QA+N782MmLB55Idvq2cFKWaH7becOoHGaNhfP6kdU0zG+h6iwjczvKtr5ha6idfzIyddepewxiqAL+8zXvWiCqNGMZrD65BccQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288160; c=relaxed/simple;
	bh=Vop5+RG5eYUSmhKe5GVU15ObIbfOXAFwa0f7ZhIk2Kk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=e/trfwkhEI2qJhUJIqSowcDY3n7UBt7Jr18vA+fRNT0RM/Lp0hLmakNvQzWyJC2kn9ZQILO5Zx2HbKNEgA5Gy67jsOtEMZhb/fPiU1JguuJPIRK0k20eqx9Iu5TwROosW2uowDK/5Kx4RGygqMeALnSi02ezK0PQhM+Ckiz///o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4218180a122so8243735e9.1
        for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 07:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718288157; x=1718892957;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S82BAAJLa3VW8ChR5QDCpwAUL6PlKMe5B+HAZIxorno=;
        b=VsMD5y8YqxDbAq1MsC+KZH/nYZwVvK6tNaXXnxeNzgkmzCYwWI6c9o7JEtfrQIV5Gh
         F2iZ+zej9VBsAdh6taM3uKJ/FIYSZ6/LQnRcXZAIguEPZ5svej2QsuxhAeFqxeK4WnEl
         ZS6wAyAOEnxC0uBFPwL1f7YLrpyyV/WvcO3/fnNBEYSHhAOY+8MPtvPVN16C1LwHo+gN
         mOssFEzNmwp8uQ7aCvFuXB/0Uqqzb7K/GOmU2dZHP3Bh8SIdPjLWVrWtdM2Z0L+hjaBn
         YQAdhZwJv6bYlCnzUHpxdknBXQ1OEkenJJQK7nthzM/gJrF7mT7dDvtH9A5RvmdjrgzK
         mJXw==
X-Gm-Message-State: AOJu0YzrydduWAgROPmD3zQlvZG2VQNmMBWU/cPnXNGbcRK6uw8Uxw7q
	BMvZJ1jP8R9C6x/BlrJw7XRbramSs1rVe/dqJTP2mOpInAs49mxsU3BPKdm6
X-Google-Smtp-Source: AGHT+IGsQPIuI/GJqCWI5YM/qkFZ5GotZDkVwPr2BEVY6KMKOGFIWZyh5ZxgZ7ud6n7j23ZvXnVpSA==
X-Received: by 2002:a05:600c:3543:b0:41b:60ae:7827 with SMTP id 5b1f17b1804b1-422863ad596mr42695855e9.24.1718288156533;
        Thu, 13 Jun 2024 07:15:56 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e7e3sm26535965e9.12.2024.06.13.07.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:15:56 -0700 (PDT)
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-3-tobias.schaffner@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Subject: Re: [libevl][PATCH 2/4] evl-test: Measure worst case latencies
Date: Thu, 13 Jun 2024 16:09:06 +0200
In-reply-to: <20240613134557.4013044-3-tobias.schaffner@siemens.com>
Message-ID: <87o785q67c.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Run latmus for 30 seconds after running the unittests to measure the
> worst case latencies.
>
> Allow to run with -u to solely run unittests.
>
> Drop getopt to simplify argument parsing in the process.

Reading the code, I'm not sure this simplifies anything. What is the
actual upside of dropping getopt?

>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  utils/evl-test | 55 ++++++++++++++++++++++++--------------------------
>  1 file changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/utils/evl-test b/utils/evl-test
> index bc7440f..5c1c3da 100644
> --- a/utils/evl-test
> +++ b/utils/evl-test
> @@ -7,44 +7,37 @@ if test \! -d $EVL_TESTDIR; then
>  fi
>  
>  usage() {
> -   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h] [test-list]"
> +   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h][-u] [test-list]"
>  }
>  
> -args=$(getopt -n $(basename $0) 'h@klL' "$@")
> -if [ $? -ne 0 ]; then
> -   usage $0
> -   exit 1
> -fi
> -
> -help=false
>  keep_going=false
>  do_list=false
>  full_path=false
> +unittests_only=false

Unit testing should be on by default, with a full-mode switch including
latmus, because this is the original way for running unattended
tests. Since latmus won't trigger any error on unacceptable latency,
there is no upside to have it on unless we really want to attend the
test, looking at its output.

>  
> -set -- $args
> -for opt
> -do
> -case "$opt" in
> -   -k) keep_going=true;
> -       shift;;
> -   -h) help=true;
> -       shift;;
> -   -l) do_list=true;
> -       shift;;
> -   -L) full_path=true;
> -       do_list=true;
> -       shift;;
> -   -@) echo "run the EVL tests"
> -       exit 0;;
> -   --) shift; break;;
> +while :; do
> +   case "$1" in
> +      -k) keep_going=true
> +          shift;;
> +      -l) do_list=true
> +          shift;;
> +      -L) full_path=true
> +          do_list=true
> +          shift;;
> +      -u) unittests_only=true
> +          shift;;
> +      -@) echo "run the EVL tests"
> +          exit 0;;
> +      --) shift
> +          break;;
> +      "") break;;
> +      -h) usage $0
> +          exit 0;;
> +      *)  usage $0
> +          exit 1;;
>     esac
>  done
>  
> -if test x$help = xtrue; then
> -   usage $0
> -   exit 0
> -fi
> -
>  test_list=
>  for t in "$@"; do
>      test_list="$test_list $(eval echo $EVL_TESTDIR/$t)"
> @@ -89,4 +82,8 @@ for t in $test_list; do
>      fi
>  done
>  
> +if test x$unittests_only = xfalse; then
> +    latmus -T 30
> +fi
> +
>  exit 0


-- 
Philippe.
