Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D118347C7
	for <xenomai@lists.linux.dev>; Mon, 25 May 2026 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733164; cv=none; b=UpDs8/eDlYgfSWjN+02lEkJ8RBKISaqxkXAD3i1sDjlmaRqzeqBBJVVExr3Uno9wA+1u6DbKnh0IXsHqijkXaar7/vzNr075DXulkfrMV+js7RjrYUrHD9XgBcatL66OaBS3+ZYFG3+NZI2eWYTKsf4l4NfHSlQReqqyLgmFqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733164; c=relaxed/simple;
	bh=600HB2RL2J4xrsfERnNLzeZvWNUyPLzuaq0+Ou40XYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJftgCfe3g/Ip4KPEx1BjS6eE5/pwvMFDZ4SnlluiyyweucKJh49UDRVPZ+BQf8BMipLvkTlaHfstDqbwcOBQ5qK3TmXlsUwe6XMhUvdR9Fmb9FV3eC+932zVG8f0Qs+OHO4DX00zPyMzshLqsjiag/9beG9dQ8Ahmntz/MvKo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=HNe/2/Xa; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="HNe/2/Xa"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 819963ED74;
	Mon, 25 May 2026 18:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779733155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQwyPPviNbKX0cN2GFRIO9mQ4E80GI5Ix3ymXgcdH30=;
	b=HNe/2/XatwXrAyYHLyabTNII5C/H5w9/MR22qVT1Bl9wp8nSLhYaviLlUAHiUmT4lt1+H+
	wNSLF1myqBk9t0KTwEP1EvODEs4MD9wn7QD30uYV1c3KXCdhNHpTdeVvp++CInUwGzPzsZ
	GHhPdo4S08jmDd7aRAKwjC5uWiyR2ripkNkOvbLySHmIti7C4mD32GdLIl/YgJLXFpW49O
	qSVcEhocUev1197tsfil4pb5dR72miYF0iriiByuCkspa2i74dCy6svf4FsZNuaMhW8YBW
	mzAK0FxYG61qEQErrQdBM6r8GKGJOZiOydaxRzguySa2AHPs+SwTMme5oT+5pQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>,  Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
In-Reply-To: <535f40eb-3af9-427e-85db-2afaf69b847e@siemens.com> (Jan Kiszka's
	message of "Mon, 18 May 2026 11:18:21 +0200")
References: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
	<87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
	<a006030cc98da209b4764b5117c41d93fa3d9399.camel@siemens.com>
	<535f40eb-3af9-427e-85db-2afaf69b847e@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 25 May 2026 20:19:14 +0200
Message-ID: <87h5nvl5ct.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFKjZdzetlKUlHmLDx8QKR/hpRq8RKDyKXXpLs56/J/EonVzLXOG4GHmCMl+CIKP132e/ba4ZFaQY759uZNPhiacbaQqlROSBs/VGL4/Y+PgXMDFAjvYjUqYDjKSNkgJc4apROyjMn0CbQDCA56P16wkx5MgTrV/XlD1ooevYzqAm2B3QRdC0NAKEm5Y8kroAP8VrHmoDeYEIFuBcYUmpUllId4XgbtmpTm2zKQNCRMF05+AKhp+h5Mtr7cEG5Fb5CrmJvL6ysSVek9C+GH8eeXg5Siqf/QpuCkjYA0f0prUsCd5Y3Ox5snSD6x9SuAP4Yrt8WM3msnujODcrMds0okCDecjeRGFps1CcuuCyIDWvM2+Cz460V87Cenn56qYTdGpt+V2Ac3rB6gk4nUm39UCTUa4Jwrxat9JpXTXofuGIcI2kmkO1gnSfAtKFhg314QcQvDL20wvltGSk4F6GMhuSdZLHOQybwCFv/okHgFuesQ7VXpeSl/nbWxDR5HmNBmvwBanC9g6eiUrFC6RBzGCnANa9xEhdpWo3jWpYv/nT9r2GgsAWbySeooTrHC7eYI4Nuqv0LRruo7T46k/04rxDmd7LB20GBQbN//SMJ9vtOU6wgCLeLlMf7RdfnqrUyiEfvsgDu0wBlGBVhLm83NMc7XpTNG+pDuIzsIobP6sg
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 18.05.26 11:10, Florian Bezdeka wrote:
>> On Sat, 2026-05-16 at 17:48 +0200, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> When a remote thread is suspended, xnthread_suspend checks if it is
>>>> currently relaxed and then calls it into hardened state via SIGSHADOW.
>>>> However, this signal may race with the thread entering primary mode on
>>>> its own, e.g. via a syscall. In that case, the thread will be kicked out
>>>> of its suspension state by the pending signal, and the migrate syscall
>>>> it then executes will not perform the expected suspension anymore.
>>>>
>>>> Plug this race by introducing two thread state flags, one for pending
>>>> XNSUSP and another one for XNHELD. After having performed the requested
>>>> hardening on SIGSHADOW_ACTION_HARDEN, we are now testing for those
>>>> pending suspension states and replay them via self-suspension as needed.
>>>> If a resume took place in the meantime, the state flags were cleared
>>>> again, and nothing will happen after the migration step.
>>>>
>>>> Reported-by: Richard Weinberger <richard@nod.at>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>
>>>> Didn't check yet if EVL solves this topic differently or is exposed to 
>>>> similar race. But given that Richard found the pattern even in Xenomai 
>>>> 2, it's likely worth to check EVL carefully.
>>>>
>>>
>>> Unlike v3, v4 does not use signals for internal synchronization, so it
>>> does not suffer that particular issue related to suspending a thread
>>> (no SIGSHADOW in evl). However, this issue is only a symptom of a much
>>> broader problem both v3 and v4 have when it comes to dealing with
>>> signals pending for suspended threads, and your patch won't solve it.
>>>
>>> To illustrate this, let's say (A) and (B) are Cobalt threads running
>>> oob, (X) may be any in-band context:
>>>
>>> CPU0                                          CPU1
>>> ----                                          ----
>>>
>>> A: xnthread_signal(B, SIGxx)                  B: core_syscall()
>>>    <schedule irq_work>                              core_suspend(B, XNPEND)
>>> A: core_suspend(B, XNSUSP)                    B: <schedules out>
>>>       core_add_state(B, T_SUSP)
>>>    core_reschedule()
>>>       core_resched_ipi(CPU1)                  
>>> X: irq_work_handler()
>>>       send_sig(B, SIGxx)
>>>          handle_inband_event(B, INBAND_TASK_SIGNAL)
>>>             core_resume(B, XNPEND)
>>>             core_resume(B, XNSUSP)
>>>             core_add_state(B, XNKICKED)
>>>          core_reschedule()
>>>             core_resched_ipi(CPU1)                    
>>>                                               X: <ipi-handler>
>>>                                                     core_reschedule()
>>>                                               B: <resuming oob>
>>>                                               B: XNKICKED: prepare_for_signal()
>>>                                                     xnthread_relax()
>>>                                               B: <running in-band>
>>>                                               B: migrate_syscall()
>>>                                                  nop (XNPNDSUSP was not set)
>>>                                               B: <still running in-band>
>>>
>>> Remoteness of CPUs does not even matter, e.g. with prio(A) > prio(B),
>>> we might observe:
>>>
>>> CPU0
>>> ----
>>>
>>> B: core_syscall()
>>>       core_suspend(B, XNPEND)
>>> B: <schedules out>
>>> X: send_sig(B, SIGxx)
>>>       handle_inband_event(B, INBAND_TASK_SIGNAL)
>>>          core_resume(B, XNPEND) /* B is now fully unblocked */
>>>          core_add_state(B, XNKICKED)
>>> <IRQ>: core_resume(A)
>>> A: <resuming oob>
>>> A: core_suspend(B, XNSUSP)
>>>       unblocked + XNKICKED set -> abort: XNSUSP ignored
>>> B: <resuming oob>
>>> B: XNKICKED: prepare_for_signal()
>>>       xnthread_relax()
>>> B: <still running in-band>
>>>
>>> There is clearly no shortage of possible variations of the scenarios
>>> above especially if we bring up more complex multi-CPU configurations,
>>> all of them causing some sort of breakage. IOW, there is a general issue
>>> with signals wrt forcible suspension, not just with SIGSHADOW-based
>>> synchronization in xnthread_suspend() vs migrate() which in addition,
>>> has its own set of flaws.
>>>
>>> A way to address this properly may require to break an ancient
>>> invariant, which states that a thread with any blocking bit set must not
>>> be linked to any runqueue. On the contrary, a way to make sure that a
>>> suspend request remains pending across a stage migration in order to
>>> deal with an in-band signal is precisely to allow that request to linger
>>> as long as necessary in a thread state mask, only to be considered once
>>> the 'kicked' flag is cleared, ignored and left pending
>>> otherwise. Meanwhile, that thread should be allowed to run.
>>>
>>> I need to have a closer look, but at first glance it seems fairly
>>> straightforward to implement this in v4 at least.
>>>
>>> -- 
>>> Philippe.
>> 
>> Uh... All of that sounds a bit scary...
>> 
>> There was a reprocuder provided by Richard on the list as well, right?
>> Please make sure that we integrate a test case at the same time as the
>> fixes. Otherwise the testcase might never be added.
>
> Yes, I already asked for a reworked version (Richard and/or the AI).
>
> What may also be valuable here is derive a test case that plays with
> regular signal injections like Philippe sketched above. To my
> understanding, that would even be (structurally) shareable between
> Xenomai 3 and 4.
>

Agreed. A fix for this issue ([1] and subsequent) is now available for
v4. As I mentioned, the basic idea behind it is to make the forcible
'suspend' request a lazy condition, which comes into force only when the
'kicked' condition is cleared, and the latter can only happen as a
result of switching in-band. Forcing the target thread to switch back
oob at the first opportunity afterwards causes the suspension to take
effect eventually. Because this is a 'systemic' approach when it comes
to the scheduling rules, there is no risk of partial fixing depending on
particular code locations to enforce the logic or not, so we won't have
to play whack-a-mole with this issue.

This change does not broadly affect the overall scheduling logic in the
core but rather refines it, it is mainly composed of the following
steps:

- suspending a kicked thread (XNSUSP|XNHELD for v3, EVL_T_SUSP for v4)
  requires to link it to its runqueue, which enables lazy handling of
  the suspend condition.

- the code releasing a thread must be made aware that a suspended thread
  being released might be linked to the runqueue (if kicked only).

- the scheduler in-band tail code should allow a thread to resume
  execution if a lazy-suspend condition is pending for it. This is
  merely about filtering out such condition from a sanity
  check/assertion in that code if any.

- on preemption by the rescheduling procedure (xnsched_run() /
  evl_schedule()), a kicked thread must be left into the runqueue, even
  if suspended.

- the in-band migration code should clear the 'kicked' marker bit on
  entry (with all locking provisions in place until dovetail_leave_oob()
  is called).

- the thread kicking service (xnthread_kick() / evl_kick_thread())
  should stop lifting the forcible suspend conditions, obviously, only
  unblocking threads which are in some synchronous wait state (XNPEND /
  EVL_T_PEND). This way, a sigwake event won't inadvertently remove the
  suspend bits like Richard noticed.

- A (Dovetail) RETUSER request should be used to force a thread to
  switch oob, getting rid of the flaky SIGSHADOW scheme for
  this. dovetail_request_ucall() enables a synchronous call from the
  target thread back to the oob core, which is much better and saner.

This is still a sketchy and stodgy description, but I would not consider
this fix as a major change when it comes to v4, and since it does not
interfere with the locking model at all, I believe v3 could follow the
same path to address this problem.

Finally, there is a now a fairly exhaustive test in libevl to exercise
this fix which could be easily ported to v3, see [2]. It managed to
trigger several tricky issues when debugging the fix, so this may help.

HTH,

[1]
https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/5e708006ebb97c7c23ed3ee3c6fbebac4a4fd99f

[2] https://gitlab.com/Xenomai/xenomai4/libevl/-/blob/next/tests/thread-suspend.c?ref_type=heads

-- 
Philippe.
