Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF784366049
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163376; cv=none; b=LJ1jm4BSYAuuYWy5IOzEQa8wbGtyVSEqCczEZbOlSMklSrdDChObZKaOaqtQPSGpBIiKRwRyJGtCy6vJ3eYqTY6UCWFYl/pZEJVlvfKHitKIJa/tWETlu+ViyWolBVOQ4/SlJRbNHKIBBuHBzQyXA9HENlO//SFiDwCiNGp3ISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163376; c=relaxed/simple;
	bh=xWl7m4QtFhBiv+Ab45W23BjXJUiYvHM7lpQ+io94+Pk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JQ0E1cpK4PtJ4qIFc1OWyzW3REUo44OPL/jiQ4qfpToyTe+NjbFbERo9z4A5AIU61uwerKPHEGheM9DyRlXUMu09rkIBFFrLyULv8zQxfk2PcccbNCm92YTPimpo4JzHkzmus3KWQLEp+9xVuHVVtlk2W0ay6Uw3TczQKyqcyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=bTcrVkK4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="bTcrVkK4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C3A01F6B5;
	Thu, 11 Jun 2026 07:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781163372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orLmeRIV0x8S+e6UjV6eON9e6HOFOBgFDYpI1Y4ELWk=;
	b=bTcrVkK4nKlSJsFsu1ISk9TrmSRki5INUZyyGf4C0QRcfelVTMtVORwasNmVRn9tbZfwCY
	bu25DgPSr1nQ1YuybmMenb70YGOCRS6x6Ql/Ebpp+OiU/pcttjXZXRTisxTRFNpUj6Xm5z
	j61im2J4AbdJRfjrX8mKfCUjuUel5Xl82Qi4E/S9tEeNsBNuqUJdRwg7kYKYOLzlHYlmK4
	cocrBINMzrm2woqPaROCJB7w6GwIAO8EH8ys3ZtSntw1pTRwD+VlIY97zWnHp7bp7Tyk1k
	U/EcuNoi0I5l1vk4YVMXt9SPAzN2etyZbGcDlyjGpAwFJPZ/C9cCNHNidpKRCw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: SCHED_SPORADIC in Xenomai 3
In-Reply-To: <2227cdf6-d2cc-4f5a-87ab-d09861d4ce26@siemens.com> (Jan Kiszka's
	message of "Wed, 10 Jun 2026 20:17:28 +0200")
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
	<5bb1aace-8083-400b-9e74-5a047873a1ed@siemens.com>
	<c5761187-9689-45b1-9527-89cc8a5b2763@siemens.com>
	<2227cdf6-d2cc-4f5a-87ab-d09861d4ce26@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 11 Jun 2026 09:36:09 +0200
Message-ID: <874ij9cyvq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFk3Beblk3Uahzf4YiaDO7+LvcAY4lWGzfeniBcR8/9p1vEINMNWTsHsJQhcQLizlsEHTRKzJijEGEdTEnvrdvi249CGjo/gprpFzsCaq18mIxlzDz1QITJd3VN05keL1O6zLkehbNeYJmAJUh5AP4j9/+c7Xv6I4Zr00UM0S4xkIgKDrTZwAcrkRIAFXxuccDKiPxJOupaP4508lAqnVgdP2+4hoInBhZakbgL8Op4TstRpKCWpt+N7jLsPZOJmrME0LQfZOnt7abC0YXJ9CGdGdxnVJbMiBAiFq0etKjjlJsb8zbFWe5kDlzpGkTLG3mhdSpOp34cqREtAv9nD3l/MHU5YtLwmHlDczPGrolQDTOxCIPUMI+uxg4BmzUHcz4Ty1H5TO7MjGCobgzcoQNbjIOLafqltaUA3xCnSiphdY4UyPA/koJPTsSgQwPI5zCOoq8tgfVfWyR7BgEfA5gM9DgEGpSf+eMz522sNLF6WnAbSSeoXh4WSmHjzsWUgkKiQQC1d6JY8X6ul0n5czzIiegKFbiMglrkB7rCrQEKqcIKPgxsQFks0WaQFqw/7q7P2+5KS57eVunaAYFWU+cUUpRUX9/CZ1548utZCOkL3vn1ENrbs6P7jyXX4C4JdgGw9Rnk/3a6s0sxQqUsM1GPfIHzCscQv3c/IeEfyjMOQA

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 10.06.26 09:33, Jan Kiszka wrote:
>> On 10.06.26 09:21, Jan Kiszka wrote:
>>> On 10.06.26 08:24, Jan Kiszka wrote:
>>>> Hi Philippe,
>>>>
>>>> while trying to port the signal-while-suspended fix to Xenomai 3, I ran
>>>> into XNHELD, a state only existing there. I suppose that was once
>>>> forward-ported as EVL_T_HALT. The only user of XNHELD in Xenomai 3 is
>>>> SCHED_SPORADIC - so let's dive into that scheduling class.
>>>>
>>>> Turned out it was never documented, not even linked to the POSIX
>>>> standard. But it also slightly differs from it (low_prio =3D -1 -> sus=
pend
>>>> on depletion). There is also no test case, so I asked an AI for one.
>>>> That worked fairly well as it seems to have revealed an issue:
>>>>
>>>> Could it be that we are not properly suspending the budget tracking wh=
en
>>>> a higher-prio task from a different scheduling class is preempting a
>>>> sporadic thread? It looks like that xnsched_sporadic_pick is not invok=
ed
>>>> if a thread is selected from a higher-prio class first, namely sched-rt
>>>> with its weight 4 vs. 3 if sched-sporadic. Or is that an (undocumented)
>>>> limitation/misconfiguration? Is that issue even affecting other
>>>> time-slicing classes as well??
>>>>
>>>> That furthermore makes me wonder if we actually have users of
>>>> sched-sporadic. Likely a hard to answer question, as usual. But such a
>>>> limitation should have been observed earlier under real workload...
>>>>
>>>> Jan
>>>>
>>>
>>> Here is a trace that proves how xnsched_sporadic_pick and, thus,=20
>>> sporadic_suspend_activity are not called:
>>>
>>>          disrupt-1682  [000] d..2.    94.171753: cobalt_head_sysentry: =
syscall=3Dclock_nanosleep64
>>>          disrupt-1682  [000] d..2.    94.171755: cobalt_clock_nanosleep=
: clock_id=3D1 flags=3D0() rqt=3D(0.060000000)
>>>          disrupt-1682  [000] d..2.    94.171757: cobalt_thread_suspend:=
 pid=3D1682 mask=3D0x4 timeout=3D60000001 timeout_mode=3D0 wchan=3D(nil)
>>>          disrupt-1682  [000] d..2.    94.171759: cobalt_timer_start:   =
timer=3D0xffffc900008bbb00(smokey) value=3D60000001 interval=3D0 mode=3D0x0
>>>          disrupt-1682  [000] d..2.    94.171761: cobalt_tick_shot:     =
next tick at 94.231756 (delay: 59995 us)
>>>          disrupt-1682  [000] d..2.    94.171770: cobalt_schedule:      =
status=3D0x10000000
>>>          disrupt-1682  [000] d..2.    94.171771: cobalt_trace_pid:     =
pid=3D1682, prio=3D30
>>>          disrupt-1682  [000] d..2.    94.171776: bprint:               =
xnsched_sporadic_pick: xnsched_sporadic_pick, curr=3D1682 next=3D1681
>>>          disrupt-1682  [000] d..2.    94.171777: bprint:               =
xnsched_sporadic_pick: sporadic_resume_activity, pss->budget 99964473
>>>          disrupt-1682  [000] d..2.    94.171778: bprint:               =
sporadic_schedule_drop: sporadic_schedule_drop, pss->budget 99964473
>>>          disrupt-1682  [000] d..2.    94.171778: cobalt_timer_start:   =
timer=3D0xffffc900008bc4d8(pss-drop) value=3D94216201725 interval=3D0 mode=
=3D0x1
>>>          disrupt-1682  [000] d..2.    94.171779: cobalt_switch_context:=
 prev_name=3Ddisrupt prev_pid=3D1682 prev_prio=3D30 prev_state=3D0x248044 =
=3D=3D> next_name=3Dss-d next_pid=3D1681 next_prio=3D20
>>>             ss-d-1681  [000] d..2.    94.171784: cobalt_trace_pid:     =
pid=3D1681, prio=3D20
>>>             ss-d-1681  [000] d..2.    94.171788: cobalt_synch_acquire: =
synch=3D0xffffc900008bd408
>>>             ss-d-1681  [000] d..2.    94.171789: cobalt_head_sysexit:  =
result=3D0
>>>             ss-d-1681  [000] d..2.    94.171799: cobalt_head_sysentry: =
syscall=3Dmutex_unlock
>>>             ss-d-1681  [000] d..2.    94.171801: cobalt_synch_release: =
synch=3D0xffffc900008bd408
>>>             ss-d-1681  [000] d..2.    94.171801: cobalt_head_sysexit:  =
result=3D0
>>>             ss-d-1681  [000] d..2.    94.231786: cobalt_timer_expire:  =
timer=3D0xffffc900008bbb00
>>>             ss-d-1681  [000] d..2.    94.231789: cobalt_thread_resume: =
name=3Ddisrupt pid=3D1682 mask=3D0x4
>>>             ss-d-1681  [000] d..2.    94.231790: cobalt_trace_pid:     =
pid=3D1682, prio=3D30
>>>             ss-d-1681  [000] d..2.    94.231791: cobalt_timer_stop:    =
timer=3D0xffffc900008bbb00
>>>             ss-d-1681  [000] d..2.    94.231794: cobalt_tick_shot:     =
next tick at 94.271741 (delay: 39948 us)
>>>             ss-d-1681  [000] d..2.    94.231802: cobalt_schedule:      =
status=3D0x10000000
>>>             ss-d-1681  [000] d..2.    94.231803: cobalt_trace_pid:     =
pid=3D1681, prio=3D20
>>>             ss-d-1681  [000] d..2.    94.231805: cobalt_switch_context:=
 prev_name=3Dss-d prev_pid=3D1681 prev_prio=3D20 prev_state=3D0x248048 =3D=
=3D> next_name=3Ddisrupt next_pid=3D1682 next_prio=3D30
>>>          disrupt-1682  [000] d..2.    94.231810: cobalt_trace_pid:     =
pid=3D1682, prio=3D30
>>>          disrupt-1682  [000] d..2.    94.231811: cobalt_head_sysexit:  =
result=3D0
>>>          disrupt-1682  [000] d..2.    94.271767: cobalt_timer_expire:  =
timer=3D0xffffc900008bc4d8
>>>          disrupt-1682  [000] d..2.    94.271771: cobalt_thread_suspend:=
 pid=3D1681 mask=3D0x200 timeout=3D0 timeout_mode=3D0 wchan=3D(nil)
>>>          disrupt-1682  [000] d..2.    94.271772: cobalt_tick_shot:     =
next tick at 95.130203 (delay: 858431 us)
>>>          disrupt-1682  [000] d..2.    94.271914: cobalt_head_sysentry: =
syscall=3Dclock_nanosleep64
>>>          disrupt-1682  [000] d..2.    94.271916: cobalt_clock_nanosleep=
: clock_id=3D1 flags=3D0() rqt=3D(0.060000000)
>>>          disrupt-1682  [000] d..2.    94.271917: cobalt_thread_suspend:=
 pid=3D1682 mask=3D0x4 timeout=3D60000001 timeout_mode=3D0 wchan=3D(nil)
>>>
>>> Jan
>>>
>>> PS: I asked AI (opus-4.7) to confirm or disprove this, and it failed in=
=20
>>> its code analysis. It seems like the way the code is structured and=20
>>> commented misguided it in its conclusions. Sooo statistically human...
>>>
>>=20
>> Asked different ("find a path where..."):
>>=20
>> "You're right =E2=80=94 I need to retract part of my previous
>> answer. Looking at this scenario through the cascade rule,
>> sporadic_suspend_activity() is not invoked when a SCHED_FIFO thread
>> preempts a SCHED_SPORADIC thread.
>>
>>   The path
>>=20
>>   1. A SCHED_SPORADIC thread runs at, say, normal_prio =3D 50. Its
>> drop_timer was armed by sporadic_schedule_drop() at the last
>> cascade, set to fire at resume_date + budget.
>>   2. A SCHED_FIFO thread at priority 80 becomes runnable (wakes from sle=
ep, IRQ unblocks it, etc.) and xnsched_set_resched() marks the CPU.
>>   3. ___xnsched_run() =E2=86=92 xnsched_pick_next() iterates for_each_xn=
sched_class (sched.c:322). RT has the highest weight, so xnsched_rt_pick(sc=
hed) runs first.
>>   4. In xnsched_rt_pick (sched.c:730=E2=80=93762), the head of the highe=
st-priority queue is now the FIFO thread. Its sched_class =3D=3D &xnsched_c=
lass_rt.
>>   5. The cascade check at sched.c:757 (if (unlikely(thread->sched_class =
!=3D &xnsched_class_rt))) is false.
>>   6. xnsched_rt_pick returns the FIFO thread via del_q. The for_each_xns=
ched_class loop sees a non-NULL result and exits.
>>   7. xnsched_sporadic_pick is never called. sporadic_suspend_activity(cu=
rr) never runs on the outgoing sporadic thread."
>>=20
>> This looks more useful.
>>=20
>> Jan
>>=20
>
> The blast radius extends:
>
>  - I added a preempting fifo thread to the sched-quota test as well, and
>    it completely destroyed the thread group accounting: the group no
>    longer gets throttled, rather than getting time stolen by the
>    preemptions.
>
>  - The evl core looks identical here and should be similarly affected,
>    regarding quota-based scheduling.
>

The EVL core inherited the implementation of the quota scheduling class
from Cobalt, therefore suffers the same problem ATM.

--=20
Philippe.
