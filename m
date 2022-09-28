Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420D7B
	for <xenomai@lists.linux.dev>; Wed, 28 Sep 2022 10:34:23 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 339A824000A;
	Wed, 28 Sep 2022 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1664361255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpdiO242VNnHNMYzq4SD+LTMF5sR48XEPLVy9+01CBw=;
	b=l3BN+fsXT+bOV8hB7Jl/d68hTK8g7YXWs5izUJGlq29v48WD4E34PCjbtb3t8XULBKXoCb
	xNaJglcu1TAU6fr36sIi1kCzB/fkDl8Ii1C3FXQyzD3RzhXQ7rGDM+TM3w2n09XaDeFx1P
	AaEzau4fP4HKaHyA8DP2f4E97FqaP4CUBmdmnJAeFdEYEp93cI10iBZVLyXba9dRuYFNE8
	PPepPYMQJTiZYbKNbPwIsdiA3E1wo0t1onN1LcF753vxQ4Dk1Rg08Ojkpa2XrfcklnZocB
	yE+JJB5b0SxJsx7LHwlWyHRUN4YK4mQFa8jN94WoxTPLl1kz+cM4R5WhQh0WTg==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <BN2P110MB1288DADB384231E5FB72D8EC8F549@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Bryan Butler <Bryan.Butler@kratosdefense.com>
Cc: Russell Johnson <russell.johnson@kratosdefense.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [External] - Re: System hanging when using condition variables
Date: Wed, 28 Sep 2022 12:06:18 +0200
In-reply-to: <BN2P110MB1288DADB384231E5FB72D8EC8F549@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87czbf7pp5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Bryan Butler <Bryan.Butler@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Philippe, 
>
> I have observed a couple of odd things, and wanted to see if these were
> intentional or not:
>
> 1. According to the documentation on evl_attach_thread(), the CPU affinity
> is locked to a the single CPU on which the thread is running at the time.
> Although one can call sched_setaffinity(), at the cost of a one-time in-band
> switch, it doesn't appear that this actually changes the affinity settings.
> It appears the thread will continue to run on the single CPU it was running
> on when it was attached to the EVL scheduler. Is this the intended effect? 
>

No, it's definitely not. Several tests from the test suite actually
depend on being able to migrate to another CPU (e.g. ring-spray,
sched-quota-accuracy etc.). These tests would not work otherwise. How do
you check the current affinity for these threads, e.g. does evl-ps
confirm this issue?

> 2. Through experimentation, it doesn't appear that I can start multiple
> threads which are identical copies of each other. Specifically, it appears
> that if I start multiple threads with an identical entry point, that only
> the last thread actually remains active, at least within the EVL scheduler
> (as reported by "evl ps -l"). If, however, I start each thread with a unique
> entry point, then I can see multiple threads starting up (although this is
> one of the scenarios that is still crashing on us).

In this particular case, I think the app may be doing something
wrong. The entry point of a thread is actually unknown from the EVL
core, this is all dealt with from userland by the *libc. All thread
information maintained by libevl is living in TLS data. Maybe something
in the application is unexpectedly sharing some global data between
those threads, leading to the most recently bootstrapped one to override
all others?

>
> The reason I ask these questions is that we have a thread pool of a variable
> number of identical "worker" threads, any of which can take a task and
> operate on them. I would like to have the pool of worker threads share a
> pool of CPUs, and let the scheduler decide how to allocate them.

The EVL core will always pin every thread to the CPU it emerges on, then
the app may move it to another CPU using sched_setaffinity() in order to
apply some spatial allocation scheme. Bottom line is that we only deal
with user-defined, static allocation of CPUs to threads, the EVL core
does no dynamic load balancing by design because this would be
inefficient wrt the ultra-low latency requirement we have.

> I can work
> around this issue if necessary, but it may constrain the amount of
> parallelism we can achieve. I can work around the second issue as well, but
> it will make for some kind of ugly code.
>

I've been using the worker pool pattern here in many occasions with EVL
threads, the core does affect this unless the placement issued from the
user side is wrong. IOW, you pick a CPU placement for every worker, the
core abides by your choice and always schedules it out-of-band on that
CPU, it never decides for the app which CPU should a thread run on.

As you referred to earlier, picking the initial CPU placement can be
done in two ways:

- inheriting the current CPU placement of the parent thread at the time
  of the call to pthread_create().

- calling sched_setaffinity() any time for the child thread (either from
  its context, or from another thread using a valid, non-zero pid
  argument).

Each time sched_setaffinity() is called in-band for an EVL thread, the
core notices and applies the change to its own out-of-band scheduling
plan.

-- 
Philippe.
