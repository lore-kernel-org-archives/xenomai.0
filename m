Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3433B13D62B
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381599; cv=none; b=UW6WpoogJaq8reDPoPXVHEtRNZzFPbKBVGxG6Jh+zqhIvkCOKv/UeJOYEFqQCRDwDgOwjLDOosqJ50RVEGBETbE9qIOpfV/Hv8rrkew9YEBYIQl+4f3Gp+pltHCLF3Eo7+tXR9B82G9z6FE3T3Geb7jS5S86RoZVx5iBAza/LTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381599; c=relaxed/simple;
	bh=G48BCf8zWs1H1ZCZCB4iPNnCB2lQ2dNwLwg1LVOVG7w=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=DuFlRHm4t0Wdolk3/ml5xkUAXWv/KzjiBc/o+BE/G5pTxmj7vHQ4t1J5XT+44no8W+uRR0alD33fPLIQfa3KXxeENR7/2jhZM97iNZlqMElDItHLe9p1JIXCsrbVYE52AV21KooiBNsaRZYrVFzAtt3KLUWNoo3Ndfmr0CpLp+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-420104e5336so4451955e9.1
        for <xenomai@lists.linux.dev>; Wed, 22 May 2024 05:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381595; x=1716986395;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHSRGrUVlJKS/s61tLnGkcemZfdrSpDcJNQHNzAThsQ=;
        b=EJehXFI4hWa53pmU+XDKnczrwhNHxHBQ4Y5Fs8oX9dLBXDqJSv3W0sx+gkqzGtJ0FH
         VRpL4Qp/9AE5i2/dmyyuEUhVLMb6q7YyqM9QnT51dk3pwjKgc7Aq4cCUvfbh7OK8bDnh
         ak8jbVcAfSS6Cq8WvxSym4KygCwtk2OSuPsd/MyBUgn8931Dr4wyk1AQ5dJ1PBZkVxA2
         O0OYq4279SWVV8zNUSgIXPX8VtmG6YoBKY6+cDs/FZJCXq4wckOlXh5CZUqqNuSt9IA7
         dAYlOfYTrPwSOIaSyc/h87VI7GlCiLr1+e8faYZQqglg2+dPQ0RmzxOnI39QBfqXZxbx
         +1xA==
X-Gm-Message-State: AOJu0YwydtyhNdo+7KrF4GPiYMT9bknSDKBRfgS08pCJ4a1+BdxUJwB2
	EOdXB8wL6MLz2PyqxQqj0l3ioITQqwlQw6xAJF4AbehDt8XlQsx0rAv0pQ==
X-Google-Smtp-Source: AGHT+IHQbs6F3/WPQxl9FTlxD9+DKUeJh6lxz+BrHW8cTKQ3wS8q4kLzeiDKEGx/XQtrdcyNwZj1Bg==
X-Received: by 2002:a05:600c:4589:b0:41a:8035:af77 with SMTP id 5b1f17b1804b1-420e19f0868mr101103415e9.12.1716381595206;
        Wed, 22 May 2024 05:39:55 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe1277sm483627015e9.42.2024.05.22.05.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:39:54 -0700 (PDT)
References: <Zk3E0XfaeikSP2Kr@2956c958a175>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: JiajunDu <wonderboy512@163.com>
Cc: xenomai@lists.linux.dev
Subject: Re: A problem regarding SMP
Date: Wed, 22 May 2024 14:32:45 +0200
In-reply-to: <Zk3E0XfaeikSP2Kr@2956c958a175>
Message-ID: <87ed9urpex.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


JiajunDu <wonderboy512@163.com> writes:

> Hello!
>
> Currently I encountered a problem with SMP while using linux-evl core.
>
> I created multiple kernel processes sequentially in the kernel state using
> `evl_run_kthread` and would like to have them run in parallel on multiple
> CPUs, but the parallelism I was expecting is not happening in EVL core.
>
> After reading the relevant code in the EVL kernel, I discovered the reason
> as follows. When calling `evl_run_kthread` in the master process to create
> multiple processes sequentially, the master process creates the first process
> first and then waits for the first process to finish initializing:
>
> wait_for_completion(&kthread->done);
>
> The newly created process enters the `kthread_trampoline` function and switches
> the OOB state first, then calls `irq_work_queue` to put the inband irq_work
> that wakes up the master process into the current CPU. However, this results
> in that the inband irq_work that wakes up the master process having no way to
> be handled until the first created process finishes executing, because it is
> OOB. This would also cause the creation and running of the second process being
> delayed, since these events occur in the master process. So in summary, there
> is no way to run all the processes in parallel.
>

Well, yes there is: you need all evl kthreads to synchronize on a
barrier (e.g. evl_flag) before entering their work loop. The master
process would post that barrier when evl_run_kthread() has returned for
the last kthread, unleashing them all on each CPU you placed them. Per
the property you mentioned, we know for sure that an evl kthread is
ready to run when the master process resumes execution after a call to
evl_run_kthread().

> By the way, the /kernel/evl/thread.c file also exists a comment explaining this
> problem:
>
> /*
> * We are now running OOB, therefore __evl_run_kthread() can't
> * start us before we enter the dormant state because
> * irq_work_queue() schedules the in-band wakeup request on
> * the current CPU. If we fail switching to OOB context,
> * kthread->status tells __evl_run_kthread() not to start but
> * cancel us instead.
> */
>
> Now I'm thinking that theoretically this phenomenon is correct for RTOS, since
> the main process that creates the new processes is not OOB, so it does should
> be woken up using inband ways. But this does cause a lot of wasted CPU
> resources in SMP environments, because it would have been possible to have the
> inband processes and the OOB processes running at the same time on different
> CPUs.
>
> So, here I would like to ask, should this problem to be solved? And is there
> anyone in the community working on this?
>

I don't think there is any problem in this case. You only need to
account for the inband/oob duality of any evl (k)thread. Inband is where
the basic OS resources are allocated, oob is where scheduling happens
with real-time guarantee.

-- 
Philippe.
