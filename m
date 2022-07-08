Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF93229
	for <xenomai@lists.linux.dev>; Fri,  8 Jul 2022 18:14:06 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 20C53D998D
	for <xenomai@lists.linux.dev>; Fri,  8 Jul 2022 18:05:50 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 70DE21BF206;
	Fri,  8 Jul 2022 18:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1657303541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dzmb51yMnk6hFr8yZOnb3yA8ZeHZvJYYm09RIfPTPYE=;
	b=Xspbgy9wVkETeojHBDTe614NOaO7cO4EsRxHiejE+aGRgmJhnv3YJpGF3SY8MSqiYUbmBW
	8Y8kQcx4QQAH6JjyUhXDMhRHFrJsBbus4JX1CDlkPaJGdQ0hwH29jfac54CFTAfqFdlQnd
	VhCveg5pfgtQ+XExBwrrpBNmQPUqeMurfz0Jftci2gyT4KZUCosg25zwcBkOmdYwvDMwbL
	RQml+UdGBwROt8xQVY+U0lQ1w3JzfEz2vUbmGREUZmDKaGekZCWaxPb2FO9pwohBK8j0OW
	/ls/kocsXgBGj/T0Pc1vwFUb2PIyHBdj5TSysWZ2iYGoQJpH/AL/k2tsGD5Ayw==
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 0/3] prove of concept
Date: Fri, 08 Jul 2022 19:42:54 +0200
In-reply-to: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
Message-ID: <875yk7mqdn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Johannes Kirchmair <johannes.kirchmair@sigmatek.at> writes:

> This is a prove of concept implementation of exception handling in Xenomai real
> time.
>
> It implements an interface similar to the posix signals but with a much smaller
> feature set.
>
> For now, this feature can be used for handling floating point exception (fpe)
> and illegal opcode exception in user space without losing real time.
>
> The fpe exception handling can be used for fixing division by zero errors in
> user space code without dropping out of the real time domain.
>
> The illegal opcode exceptions can be used for implementing breakpoints. This
> can be done by replacing the breakpoints original instruction by an illegal
> opcode. At the time a task tries to execute the instruction an illegal opcode
> exception will be triggered. The thread can be  suspended in the signal handler
> in user space. There are two main advantages of having it done in real time.
>
> The first is if a task does some time critical IO or has to meet some watchdog
> constrains, the signal handler can be used to bring the IO into a sane state
> before the task is stopped. Same for the watchdog, it can be stopped before it
> sends the whole process into an error state.
>
> The second advantage is for processes that have several real time tasks. For
> example consider a process with rt tasks task1 and task2, where task1 is of a
> higher priority than task2. If task1 triggers an exception and is relaxed to
> the Linux domain, task2 of a lesser priority would take over and could block
> the handling of the maybe more imported work/exception handling in task1.
>
> Disclaimer:
> This implementation is far from being ready to merge. It is mainly intended to
> be a starting point for discussions about rather we (the community) want some
> kind of exception handling interface in Xenomai and what a maintainable
> interface for this could look like.
>

Thanks for taking a close look to this. Since the proposal is about
handling CPU traps in user-space, I have a couple of observations
regarding the kernel side of things, and some questions regarding the
intended use cases application-wise.

With respect to x86, the traps roughly fall into these categories:
   
- #NM, #XF, #XM, #MF, #DB, #PF, #AC and #BP may need some kernel fixup
  to be applied when taken from non-privileged mode, we cannot just
  return from the oob handler and be done with it in every possible
  case.

- #DF, #MC, #SS and #TS do not involve user-space activity, so let's
  ignore these, along with any trap involved in virtualization
  management, there is no point in routing them to a user-space handler
  anyway.

- #GP, #DE, #OF, #BR and #UD either do not need further kernel fixup, or
  at least such fixup can be done transparently on the oob stage with no
  impact on the worst-case latency. Routing them to a rt signal handler
  in user-space could be done.

The first set looks problematic though:
  
* duplicating the original fixup code in the real-time core
  (e.g. Cobalt, EVL) would be a bad idea (obsolescence, portability
  issues, prone to hidden regressions). We have been there with the
  I-pipe and FPU management offloaded to Cobalt already. This is the
  reason why Dovetail provides built-in scheduling and FPU management in
  oob mode, offloading such tasks to the real-time core can only end up
  in some interstellar mess.

* however, reusing the existing kernel fixup code may require to
  re-enter the regular inband execution context. In most cases, the
  portion of that code which handles user-originated traps cannot
  support out-of-band traversal (e.g. takes regular spinlocks we
  certainly do not want to convert to hard locks). Dovetail already
  tries hard not to notify the core about any fault which can be fixed
  up without switching in-band first, IOW: we leave oob mode only when
  we really have to, not systematically upon trap.

Because of this, generalizing the ability for the core to bypass the
kernel fixups for any kind of trap does not look right.

This does not impede us from looking for a way to catch the events from
the 3rd set which could be handled safely from user-space in oob mode
though. You mentioned so far the following use cases:

- unchecked maths: #DE handling

- I/O stall detection: watchdog disabling, hw cleanup then
  self-suspension on #UD (used as a way to force a breakpoint)

What a handler would do looks obvious with respect to receiving a
forced #UD, the user code may even be allowed to resume normally
from the suspension point at some point later.

However, it is unclear to me what a handler might do upon other traps,
such as #DE, #GP, #OF and so on: the faulty thread could not be allowed
to resume execution from the code location which caused the exception,
as I don't see how the original issue could be fixed reliably from the
rt signal handler.

I see two options for this handler:

- it does a siglongjmp() to some recovery point in the call stack:
  fairly ugly and basically unreliable for any state machine above
  trivial.

- it notifies some health monitoring agent to take over, in order to run
  some recovery steps, then self-suspends the current thread. We would
  not need POSIX signal semantics to implement this.

In other words, is a generic async signal API the best - and required -
way to address the issue(s) at hand?

-- 
Philippe.
