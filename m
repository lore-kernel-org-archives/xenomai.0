Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0463C8716
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618677; cv=pass; b=hMUjvSAYPyO9EeEUsze/jDSUUg0xmnX993FhJiMxXPuPrSetUBWerezisGtG0CNLwcWTLqEwTodJxmCc0xslkALUloPR5sr+VtcL4reC2/k4I3lvutPGBcV9sonoYFvXEiVokgKSA4eKdjKeIvtwYbXLXS8o/Fu5VhyGdlk4plw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618677; c=relaxed/simple;
	bh=0I2J9SuzEH0W1vxTU5qrdxGH0s/h4U9dU9oZ76ady8o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=SpymXhEd94ne4WNOk0oz+cfEYSUW9aEEQOBSfMpiNb1dHelW4mCUz1tRy438cb/Se3LwC7m1ZhFJNUTpK+P6KNU7wZuHEmFVY3w47JY/yJt7/tAmKHQ1yte5vf4U11v4EqdoRgpTkgjLNjmkAe3rU3GqmJ9T0SVc/wRJSs6lRz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibv-augsburg.net; spf=none smtp.mailfrom=ibv-augsburg.net; dkim=pass (2048-bit key) header.d=ibv-augsburg.net header.i=@ibv-augsburg.net header.b=FGkj4z1P; dkim=permerror (0-bit key) header.d=ibv-augsburg.net header.i=@ibv-augsburg.net header.b=kPq4XVuv; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibv-augsburg.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ibv-augsburg.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibv-augsburg.net header.i=@ibv-augsburg.net header.b="FGkj4z1P";
	dkim=permerror (0-bit key) header.d=ibv-augsburg.net header.i=@ibv-augsburg.net header.b="kPq4XVuv"
ARC-Seal: i=1; a=rsa-sha256; t=1784618492; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=h+TCB1opL0nLCY0NX+LlFtsKP8BBkBEdP8Ok88zbjUwwH6V02GztXYjqOu/8Cv8eRo
    FFtxQaxtg7v6YBcjtiWX/3P1LfjAXtZ7v/GVSh/PnB0GjWTV3mqZG0Rh/SeBdFbjZLjQ
    5OxR2oxzVthDOCl2WhuW358sM5wqgDAGPIjLJbZe8R0UwQL5gnw7PS0iwcmNqSnWPDrc
    oHjH6wYNkdY8II+yv6L35IvNPLTkGOErVomsFpHOgYfCgwkTKn8KBQurJXYIS+56Kicf
    m0AYVJxvZejlMsgW/KUXKsur1Wn4s/WeDQb5QE9YustJ3wX7CDaAMZTvTl7K2mREK18Q
    RUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784618492;
    s=strato-dkim-0002; d=strato.com;
    h=To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=+84OvTgYIDybYfWSWLtDzv7X2eK7MvkJm4O8Eg2NA1k=;
    b=CZbBshLBTdf+MdgLHbAprfR3PX+xyUb4OwFUvyTQfHWj6LUAHgq00uYkXpMAn4xLNq
    QLh1HE/j9orRpIp5eYnU3ChDNCFHBteRRYG54Tp1P92guabokQDjQyQlKPRIpoq73f70
    tHZNnHk+OiknJ7sgDXf5bXnWyGPt+ohBi2s4gbFPNAT9+VxAeiBOLdnb2eNmEfKs9b+O
    OU4B3cVhqrB8uqEKFIH+mD1m/KWHqkIv1OB8RXeiOy1XKWB/f08VI0Sfa/ETdhxjuARo
    9BfxjCwOCA3Rj5rRmfFVPgg7cwBunJasMhqkBoR82pz/Bv88yTE0k+ufyLU86D01um6c
    1+yQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784618492;
    s=strato-dkim-0002; d=ibv-augsburg.net;
    h=To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=+84OvTgYIDybYfWSWLtDzv7X2eK7MvkJm4O8Eg2NA1k=;
    b=FGkj4z1PgLjc54cMDmKJpPT7HzRmEfiA5lF/85EkT4IT0QrDP9vZddUqhZVE9PoMCK
    k9YhylODiNzVWCw2T3H0kB7w5SRKJxdLyneT/DP3UOtiv/0Ivc1N8crqZGOEhxIygBJ0
    qpy86XwWMkY1lVsn4pCAohQgpoZha+pJDlYjslznC82L6rmQ1ZXn4epgzja+3IimR02D
    IxHqVtm/zAYohTPJkMopwEf2DLbBMknLVcitSutw7c+vn2e/1ZiwRQNWpxYznXbrNv23
    Bjcu9UNOh4WexnbzoSeRHklRasHpDNR4JZ4T1C9PpEIGbYq6SI9B6FzE/MTXlsesUdKp
    0Weg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784618492;
    s=strato-dkim-0003; d=ibv-augsburg.net;
    h=To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=+84OvTgYIDybYfWSWLtDzv7X2eK7MvkJm4O8Eg2NA1k=;
    b=kPq4XVuvHTs/VDKyIUhKCgde9ZrYtlDqrinQe2IUtsb/DnZ+X3k4uWgArcQ6LC3qbA
    eHTFF0UvXA417laF+QCg==
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9JMCwOG/8exKYiOUajXIudlAcw+7La"
Received: from [192.168.178.181]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Nec57f26L7LWCXt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <xenomai@lists.linux.dev>;
    Tue, 21 Jul 2026 09:21:32 +0200 (CEST)
Message-ID: <8b51814b-b91a-480b-bb7e-2cbf13660f21@ibv-augsburg.net>
Date: Tue, 21 Jul 2026 09:21:31 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dominic Rath <dominic.rath@ibv-augsburg.net>
Subject: Hang during smokey posix_cond test w/ cobalt and PREEMPT_RT enabled
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Xenomai team,

we're seeing a hang during the execution of the posix_cond test in 
smokey. When breaking into the stuck test, I can see that the main 
thread is waiting on a semaphore in thread_spawn, and the newly spawned 
thread appears to be stuck in cobalt_thread_harden, before it had a 
chance to post the semaphore.

Apart from that single test, all other tests run successfully, and our 
application was running fine, too.

We're using Xenomai 3.3.3 on an ARM64 running Linux kernel 6.12 with
PREEMPT_RT enabled. The kernel is a heavily patched vendor tree based on 
v6.12.y-cip merged with v6.12.y-cip-dovetail, and I can't rule out that 
we've made some mistake there.

When running the tests without PREEMPT_RT enabled, the tests complete 
successfully.

Looking at some tracepoints and function traces we noticed that the 
newly spawned thread actually wanted to relax again, but instead the 
kernel is in an endless loop calling lostage_task_wakeup on the main thread.

What happened is that the main thread wanted to relax, hardened again,
and called xnthread_relax again. On that second relax the
relax_work.inband_work was queued via irq_work_queue again, while it was 
already on the lazy_list, resulting in the endless loop.

It seems that the main thread is continuing execution in the Linux 
domain after the first call to xnthread_relax without 
lostage_task_wakeup running first. That gives it a chance to harden and 
call relax the second time, where the endless loop on the lazy_list gets 
created. Only afterwards is irq_work_run_list executing again and calls 
cobalt_lostage_wakeup, eventually in an endless loop.

This is possible, because relax_work.inband_work gets completely 
initialized on each call to xnthread_relax via IRQ_WORK_INIT.
This causes the check for pending irq_work in irq_work_queue to not 
detect that this item was already queued.

I was able to fix this by moving the initialization of thread-> 
relax_work.inband_work to __xnthread_init. With that changed, the test 
successfully completes even with PREEMPT_RT enabled.

I believe the reason why this works without PREEMPT_RT, or when using 
IRQ_WORK_INIT_HARD (tried that, too), is that the irq_work is called 
immediately when the core is back in secondary mode, whereas with 
PREEMPT_RT it is deferred (to the next tick?).

What I'm not so sure about is the following:

- is running Xenomai 3 with cobalt on a kernel with PREEMPT_RT 
supported, i.e. should this work?

- is it conceivable that the main thread continues execution in the 
Linux domain before lostage_task_wakeup got called? Or does this 
indicate that there's something else wrong with our setup?

I've enabled all of the Xenomai, dovetail and PREEMPT_RT debug checks 
that made sense to me and I'm not getting any errors, but of course I 
might have missed some useful CONFIG option.

Best Regards,
Dominic
