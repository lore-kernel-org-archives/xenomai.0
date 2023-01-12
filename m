Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939F8468
	for <xenomai@lists.linux.dev>; Thu, 12 Jan 2023 18:19:51 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id EB0266000B;
	Thu, 12 Jan 2023 18:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1673547584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVsJwj8FRxW5kUUR2MJDkiKvW00Gvhjgj9Efr6G5YJU=;
	b=VAzHuDkgm5hhX299zXeELu7kRjEufXKPB1mC3JGshJb1CHiSXA5eyKAs+k5K6QKddGN1pB
	gQYVGNoKGMnqa7TC2JcMOY337ojJ5O2Olfk666a0TDoZ9TLKODmyQM7GPMuXx/W+l4cvn4
	DV3TeEVLOdmvWxMHTlmxFpVE02nj0kSbSm/qCvAiFTf0xdXCmPTYFpVgsLU2PlsK1K68CF
	H2IjPVd0XPN2+LrLMmiApL1LGg6Bp6MFLu0ZLhIutlExvdap5NMAXb24CnGilMb6c84umL
	m8RkOCkzNDR7ge6n7srUrBU1Ko9T45+2UH8Bxk6ocuVGf4aBn6OjvG6dggj+pw==
References: <PH1P110MB105032AE6426F4599E6A080CE2F59@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10507C980109C793A20E6910E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10507AF7439E0794AC183597E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050C8C197F9CF9FC17F84B1E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>
Subject: Re: Conflicting EVL Processing Loops
Date: Thu, 12 Jan 2023 18:23:30 +0100
In-reply-to: <PH1P110MB1050C8C197F9CF9FC17F84B1E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87fscfboox.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> I went ahead and put together a very simple test appllication that proves
> what I am seeing when it comes to the EVL heap performance being
> substantially slower than the Linux STL Heap. In the app, there are 2
> pthreads that are attached to EVL and started one after the other. Each
> thread creates/destroys 100k std::strings (which use new/delete behind the
> scenes). The total thread time is calcluated and printed to the console
> before the app shutsdown. If enabling the EVL heap, the global new/delete is
> overridden to use the EVL Heap API.
>
> Scenario 1 is an EVL application using the STL Heap. Build with the
> following command: " g++ -Wall -g -std=c++11 -o test test.cpp
> -I/opt/evl/include -L/opt/evl/lib -levl -lpthread". When this app is run on
> my x86 system, I can see that the average time for the 2 threads to complete
> is about 0.01 seconds.
>
> Scenario 2 is an EVL application using the EVL Heap. Build with the
> following command: " g++ -Wall -g -std=c++11 -o test test.cpp
> -I/opt/evl/include -L/opt/evl/lib -levl -lpthread -D EVL_HEAP". When this
> app is run on my x86 system, I can see that the average time for the 2
> threads to complete is about 0.8 seconds.
>
> This is a very simple example, but even here we can see that there is a
> significant slow down using the EVL heap. That is only magnified when
> running our much more complex application.
>
> Is this expected behavior out of the EVL heap? If so, is using multiple EVL
> heaps the recommendation? If not, where do we think the problem lies?
>
>
> Thanks,
>
> Russell
>
> [2. application/octet-stream; test.cpp]...
>
> [[End of S/MIME Signed Part]]

That is fun stuff, sort of. It looks like the difference in the
performance numbers between the EVL heap (which is a clone of the
Xenomai3 allocator) and malloc/free boils down to the latter
implementing "fast bins". A fast bin links recently freed small chunks
so that the next allocation can find and extract them very quickly would
they satisfy the request, without going through the whole allocation
dance.

- The test scenario favors using the fast bins every time, since it
  allocates then frees the very same object at each iteration.

- Fast bins do not require serialization via mutex, only a CAS operation
  is needed to pull a recycled chunk from there.

- The test scenario runs the very same code loops on separate CPUs in
  parallel, making conflicting accesses very likely.

With fast bins, a conflict goes unnoticed, since we only need one CAS
operation to push/pull a block on free/alloc operations, without jumping
to the kernel. Without fast bin, we always go through the longish
allocation path, leading to a contention on the mutex guarding the heap
when both threads conflict, in which case the code must issue a bunch of
system calls which explains the slow down.

This behavior may be quite random. For instance, this is a slow run
using the EVL heap captured on an imx6q mira board.

root@homelab-phytec-mira:~# ./evl-heap 
Using EVL Heap
Thread 1 woken up
Thread 2 woken up
Thread 1 Total Time: 0.789410
Thread 2 Total Time: 0.809079

And then, the very next run a couple of secs later with no change gave
this:

root@homelab-phytec-mira:~# ./evl-heap 
Using EVL Heap
Thread 1 woken up
Thread 1 Total Time: 0.126860
Thread 2 woken up
Thread 2 Total Time: 0.125764

A slight shift in the timings which would cause the threads to avoid
conflicts explains the better results above, in this case we did not
have any mutex-related syscall showing up, because we could use the fast
locking which libevl provides (also CAS-based) instead of jumping to the
kernel. e.g.:

CPU   PID   SCHED   PRIO  ISW     CTXSW     SYS       RWA	STAT     TIMEOUT      %CPU	CPUTIME       WCHAN                 NAME
  1   11428  fifo    83   1	  1         3         0          Xo         -           0.0	 0:126.945    -                     Thread1
  1   11431  fifo    82   1	  1         3         0          Xo         -           0.0	 0:125.605    -                     Thread2

Likewise, the ISW field remained steady with the malloc-based test,
confirming that no futex syscall had to be issued by malloc/free in
absence of any access conflict (thanks to fast bins).

At the opposite, the first run with the EVL heap had the CTXSW, SYS and
RWA figures skyrocket (> 30k), because the test endured many
sleep-then-wakeup sequences as it had to grab the mutex the slow way.

What could you do to solve this quickly? a private heap like you
mentioned would make sense, using the _unlocked API of the EVL heap. No
lock, no problem.

Now, this allocation pattern is common enough to think about having some
kind of fast bin scheme in the EVL heap implementation as well, avoiding
sleeping locks as much as possible.

-- 
Philippe.
