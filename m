Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16B13CF9C
	for <xenomai@lists.linux.dev>; Thu, 23 May 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451150; cv=none; b=Hpolf3LBHRgMFRoPFDvNwsc6fl7KcqWg5uJ83sLquv5805FXgWaLpm24MD/uHSCBdjgH1HKt3CEm4qquTiCEqmSErQFDy8CIglri2HQO7mG9BTqm0lURNZPhV94QsfWImIfEnX0Kzwxc1jDxtEihwAGEc8hP58rmDW6cK09EIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451150; c=relaxed/simple;
	bh=rnkcbQ0HrT/F++5uLzQLuXGm/kBYGSyLVsMiviFq8vk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=TmYRifhJUqFuzcQbhjYCjbG9odwKHkQ0sxXpREcitBOi3GD+Kx0XRtAOj05gFcapAPdhKwmftbfMJVO+uz4nXxbzcbaZ0m7e8Rzz/hZ1VvDeoGkX92NHRBqRUs+WACteOXvF69Dg5o8CrgYC0xA8PIqrt4hJJBTPceYgxQjBz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420180b5898so48947525e9.2
        for <xenomai@lists.linux.dev>; Thu, 23 May 2024 00:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451146; x=1717055946;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEB4SGr5LZ5j4nXZqFGAJFHw4LHlPwXtd22gvvznu5g=;
        b=LjrX4kd9BWGs+rDjT7zWD5wNBs9YvtJNbQyklm27cta3nZtvos0UbcJER2vw3GSyuY
         jc5YIUwcGZ/RcOCcVw46lWHVNl/vHNpCF5gRLzTamK9M5lAItq5RJJRT+hWhbmHQs3Dj
         HDZVAm5pcXrKwFkWOnnjqhXGEITadI8bkgQsj4OPl3NXqqpJ0qQ99x6Uons1D9Lsjsds
         ElpsSvoQPYplihDK6FgEEuWfeED5llXoACNhBp/n+7VMX6rGpdQZfxqZnMACjKa8o/+/
         /PJWDZvPIPSiFxJmTfvG3ae8YN9YXDZ1knRqlEYrxc7LYyLYcIerOJB/6E2M0UClC9Ud
         yf0g==
X-Gm-Message-State: AOJu0YyKCTsJqZE2iLw33QxVes451KAGuzm5OQMVBejZfm0DasImiZ8v
	bj3/GdptDyKLOHCfh/EmcEdu43QwMHVXAqyNpnAbw60SkJI+HXo8CrG2vgwD
X-Google-Smtp-Source: AGHT+IFX/FXV3JO0NIQfVue6GsLna6Jz0wUpvTAMq8CPFPYZLf3cOkclSkDBlgu4u/idTLplhS3JNw==
X-Received: by 2002:a05:600c:68c5:b0:41c:7bd:5a84 with SMTP id 5b1f17b1804b1-420fd30e3e3mr26733895e9.17.1716451146158;
        Thu, 23 May 2024 00:59:06 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f5a80asm17243665e9.25.2024.05.23.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:59:05 -0700 (PDT)
References: <Zk68Q+2tgdwEkcS9@2956c958a175>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: 87ed9urpex.fsf@xenomai.org
Cc: xenomai@lists.linux.dev
Subject: Re: A problem regarding SMP
Date: Thu, 23 May 2024 09:52:06 +0200
In-reply-to: <Zk68Q+2tgdwEkcS9@2956c958a175>
Message-ID: <87r0dtrmbe.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


JiajunDu <wonderboy512@163.com> writes:

> Thanks for your reply!
>
> By using a barrier to synchronize all evl kthreads, I did achieve the
> effect of multiple processes running in parallel. My solution is
> in the next patch, and the branch I tried on is the latest
> `v5.13-evl-rebase`.
>
> But I still ran into two other problems while trying this solution.
>
> The first problem is that `evl_flag` cann't solve the problem. The wait
> condition in `evl_wait_flag_timeout` is `evl_read_flag`, in which the
> flag is set to false as soon as the flag is found to be raised in
> `evl_raise_flag`, so `evl_raise_flag` can only wake up one waiting process
> at a time. And it's not possible to wake up more processes by calling
> `evl_raise_flag` multiple times, because it's not possible to determine
> the time when processes are woken up in the SMP environment. If we did, it's
> possible to have a situation where two processes are woken up at the same
> time after the flag was raised twice, and then only one of them can be
> woken up at the same time. So in light of this, I defined two new functions,
> `evl_wait_flag_same` and `evl_wait_flag_timeout_same`, to read flags using
> `evl_peek_flag`.

The semantics you are looking for are available from evl_wait_queue,
which basically implements a condition variable.

>
> The second problem is that after using barrier, load balancing is no longer
> possible when creating processes using `kthread_run`, which is called in
> `evl_run_kthread`. The phenomenon is that all processes are created on the
> same CPU. Therefore, I can only specify CPUs manually for load balancing
> purpose by calling `evl_run_kthread_on_cpu`.

Which is not an issue, is it? Since dynamic load balancing is not
supported by design by evl (or any earlier xenomai cores for that
matter), static pinning is the way. So evl_run_kthread_on_cpu should
indeed be used. Another option would be that each spawned kthread pins
itself to the right CPU when emerging (set_cpus_allowed).

>
> The code I tried is available in the next patch. Is there anything we can do
> about these two problems?
>
> Best regards,
> Jiajun


-- 
Philippe.
