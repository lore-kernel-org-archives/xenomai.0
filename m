Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1E2E1C64
	for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827177; cv=none; b=KGhb1UduqOcYwhIT9ZKDX12bzmuhxBZVC2mxZBKlgZdX8ufIwEXJ0FqfzS5fYCltA25t6Itpyt6GoeEZgRwktFZnvMYGElIvetII+nXLCw/1XVs1rWgbKd3I4/4ED1n6HL8biH8S1TExsNaM76xcj6TqvkSwdqi0DAmvIv6nvUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827177; c=relaxed/simple;
	bh=8HxMmjnvivsh7Xb8sJs9MunKMK898wSCWM+qe0KYZOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olD/XJVwN9Te2yEP6loRmt0nHB8b/wtBzKEmBcSTh41AZv/QxpDetz238TJ2NxMhMStrQ48wMznAN2YtPlFmAEAL/zljiFgLffQNxtXQew1Iu5PF642+TqK5amecwWxdfO8G4wtRpqyjj3+0FlKoyVGDLYu+D3YV3+2c6LqkCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=HOJbYKJM; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="HOJbYKJM"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 804731092DE;
	Thu, 30 Oct 2025 13:26:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1761827167;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YgmN5yxHJ0h5Qx1/5g32xKmz1TROmCew3bK3u25KmUs=;
	b=HOJbYKJMaHOXgNYqWGuI9Qmpg33RhAJQTWjQB2zqncfsE0LlO2VBMrvVDtROF1YfZJ8SSF
	fZSJflTYeW2n9dWHaGHioKMA0Ck5aun/u9fFnUqH0jjbnNld0cDhu2eBuYqjWok+UzAxII
	myLOh8lFxL+JDzxVfTooV2TGn8H9ZzeoXtsjUtfrb306du0k1uQbGqyZ+ub6KW/vZumDW+
	upgfFEB40SzuPrWId2TE1l48eaXehrkIvFnoe/1Vkg0TGqdTw/8sDv89HyFWqQEr/L1/6A
	sN/tmahSq/A8hs9XnpKcgQc6thNtNDRDC9dmGQoRm1VpXVSe2vNzuUAYAtGBmw==
Date: Thu, 30 Oct 2025 13:26:02 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Giulio Moro <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251030132602.2d1ccfcc@wsk>
In-Reply-To: <20251029145125.71debaab@wsk>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org>
	<87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org>
	<20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org>
	<20251027120535.7933c720@wsk>
	<20251027172505.29eecfb2@wsk>
	<875xbyawx7.fsf@xenomai.org>
	<20251029145125.71debaab@wsk>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Philippe,

> Hi Philippe,
>=20
> > Hi =C5=81ukasz,
> >=20
> > =C5=81ukasz Majewski <lukma@nabladev.com> writes:
> >  =20
> > > Hi Philippe,
> > >   =20
> > >> > so either some
> > >> > traces are missing,     =20
> > >>=20
> > >> I will check if I can add more tracing.   =20
> > >
> > > On one console:
> > > ---------------
> > > evl trace -eirq -f; sleep 1; latmus -c 2 -p 1000 -P 99
> > >
> > >
> > > On the second one:
> > > ------------------
> > > test_prog/stress_prog_NO_IO &
> > > sleep 5
> > > test_prog/stress_prog_NO_IO &
> > >
> > > echo 0 > /sys/kernel/tracing/tracing_on
> > > evl trace -p > Xenomai4-ISW-trace-6.6-logs.txt
> > >
> > > First trace:
> > > ############
> > >
> > > The relevant dmesg output:
> > >
> > > [   75.214527] EVL: timer-responder:743 switching in-band
> > > [pid=3D745, excpt=3D14, user_pc=3D0x77d08492a5fe]
> > >
> > > When I do look into logs - there is also a "hole" when the ISW is
> > > reported by dmesg.
> > >
> > >
> > > However, there are some hints when we look around evl_latmus:
> > >
> > > timer-responder-745     [002] d.~2.    75.868139: evl_latspot: **
> > > latency peak: 18843.649 us **
> > >
> > > On CPU 20:
> > > stress_prog_NO_-752     [020] ...2.    75.868139:
> > > folio_add_lru_vma <-__handle_mm_fault
> > >
> > > Which ends with folio_add_lru()...
> > > And after that we do have the ~18ms latency peak.
> > >
> > > And the "folio_*" is a relatively new feature added to Linux
> > > kernel [1].
> > >
> > > The logs can be fetched from:
> > > https://nextcloud.swupdate.org/index.php/s/EjHo5EAwMTeY5ya
> > >
> > >
> > > Second trace [*]:
> > > #################
> > >
> > >
> > > [ 1610.086961] EVL: timer-responder:768 switching in-band
> > > [pid=3D770, excpt=3D14, user_pc=3D0x72e9d35af5fe]
> > >
> > > <idle>-0 [008] *..1.  1610.076068: rcu_dyntick: Start 1 0 0x2ec
> > > <idle>-0 [003] *.~1.  1610.102242: rcu_dyntick: Endirq 0 1 0x404
> > > <idle>-0 [003] *.~2.  1610.102242: arch_handle_irq
> > > <-arch_pipeline_entry <idle>-0 [003] *.~2.  1610.102242:
> > > irq_to_desc <-arch_handle_irq <idle>-0 [003] *.~1.  1610.102242:
> > > ma_read: mtree_load Node: 00000000c4071949 (0
> > > 18446744073709551615) range: 4355-4355 <idle>-0 [003] *.~2.
> > > 1610.102242: rcu_oob_prepare_lock <-mtree_load <idle>-0 [003]
> > > *.~2. 1610.102242: __rcu_read_lock <-mtree_load <idle>-0 [003]
> > > *.~2. 1610.102242: __rcu_read_unlock <-mtree_load
> > >
> > >
> > > Now some questions:
> > > 1. Why '~' (i.e. oob stage) is on CPU=3D3 as we pinpointed execution
> > >    of the 'latmus' to CPU=3D2 (and the command line has isolcpu=3D2) ?
> > >   =20
> >=20
> > Dovetail always switches up front to the oob stage before calling an
> > irq handler, so this trace is normal (upgrading the execution stage
> > for the current context is a lightweight operation, this is entirely
> > different from switching a task from inband to oob mode which is
> > heavyweight). =20
>=20
> Thanks for the explanation.
>=20
> >  =20
> > > 2. The mtree_load() is called in the OOB context... IMHO, this
> > > shall be done before we do start the latmus?
> > >   =20
> >=20
> > mtree_load() is simply the lookup call into a maple tree. In this
> > context, the call fetches the IRQ descriptor corresponding to the
> > interrupt number in a descriptor table managed as a tree of such
> > kind. No issue there. =20
>=20
> Ok.
>=20
> >  =20
> > > 3. In this case - there is also a "hole" between the ISW time
> > > (1610.086961) and the ones between rcu_dyntick: Start / Endirq
> > >
> > >
> > > Link to the full log:
> > > https://nextcloud.swupdate.org/index.php/s/nPRAnqCLFDibX6r
> > >
> > >   =20
> >=20
> > Ok, so this trace is interesting. Since the timer responder thread
> > was pinned on CPU2, the first investigation needs to focus on that
> > CPU specifically. Filtering out all activity from other CPUs for
> > now, here are some observations:
> >=20
> >           <idle>-0       [002] *.~2.    75.864279: evl_core_tick
> > <-lapic_oob_handler <idle>-0       [002] *.~2.    75.864279:
> > do_clock_tick <-evl_core_tick <idle>-0       [002] *.~1.
> > 75.864279: evl_timer_expire: timer=3Dlatmus_pulse_handler <idle>-0
> >  [002] *.~2.    75.864279: latmus_pulse_handler <-do_clock_tick
> > <idle>-0       [002] *.~2.    75.864279: evl_flush_wait_locked
> > <-latmus_pulse_handler <idle>-0       [002] *.~1.    75.864280:
> > evl_flush_wait: wchan=3D&wf->wait
> >=20
> > CPU2 received an oob IRQ timer event for waking up the
> > timer-responder thread which measures latency. evl_flush_wait() is
> > the wake up call that posts an evl 'flag' which the responder waits
> > on for the next event.
> >=20
> >           <idle>-0       [002] *.~2.    75.864280: evl_insert_tnode
> > <-do_clock_tick <idle>-0       [002] *.~2.    75.864280:
> > evl_program_proxy_tick <-do_clock_tick <idle>-0       [002] *.~2.
> > 75.864280: lapic_next_deadline <-evl_program_proxy_tick <idle>-0
> >  [002] *.~2.    75.864280: do_trace_write_msr <-lapic_next_deadline
> > <idle>-0       [002] *.~1.    75.864280: write_msr: 6e0, value
> > 340012ec56 <idle>-0       [002] *.~1.    75.864280: evl_timer_shot:
> > [proxy-timer/2] at 75.864790 (delay: 510 us, 134693 cycles)
> >=20
> > On exit from the IRQ handling process, we program the timer for the
> > next shot, which should be 510 us ahead. With a 1Khz frequency, this
> > means that we consumed half of the time budget already, which is a
> > lot. But some guy is pounding the hardware with OOM-prone activity,
> > so this may make sense anyway. So far so good. The next oob tick
> > should occur as close as possible to 75.864790.
> >=20
> >           <idle>-0       [002] *.~1.    75.864280: local_timer_exit:
> > vector=3D236 <idle>-0       [002] *.~1.    75.864280:
> > irq_handler_exit: irq=3D4355 ret=3Dhandled <idle>-0       [002] *.~1.
> >  75.864280: irq_pipeline_exit: irq=3D4355 <idle>-0       [002] *.~1.
> >   75.864280: irq_enable: caller=3Darch_pipeline_entry+0x9f/0x110
> > parent=3Dsysvec_apic_timer_interrupt+0x12/0x20 <idle>-0       [002]
> > #.~2.    75.864280: handle_irq_pipelined_finish
> > <-arch_pipeline_entry <idle>-0       [002] #.~1.    75.864280:
> > rcu_dyntick: --=3D 3 1 0xc <idle>-0       [002] #.~2.    75.864280:
> > preempt_count_sub <-handle_irq_pipelined_finish <idle>-0
> > [002] #.~2. 75.864281: preempt_count_sub
> > <-handle_irq_pipelined_finish
> >=20
> > At this point (i.e. on IRQ exit), I would expect to see a call to
> > evl_schedule(), to switch to the timer-responder thread we have just
> > woken up (the irq_exit_pipeline() hook in Dovetail ends up calling
> > the rescheduling procedure the real-time core provides, for evl
> > that would be evl_exit_irq()). It does not happen, so this must be
> > that such thread did not get a chance to go back waiting on the evl
> > flag yet, i.e. evl_flush_wait() did not wake up anyone. This is
> > interesting: this would mean that after 500+ =C2=B5s, the timer
> > responder is still busy doing "something else" (in fact, some
> > kernel activity is borrowing time from it). we don't have enough
> > traces to figure out why yet.
> >=20
> >           <idle>-0       [002] *.~2.    75.864791:
> > generic_pipeline_irq_desc <-arch_handle_irq <idle>-0       [002]
> > *.~1.    75.864791: irq_pipeline_entry: irq=3D4355 <idle>-0
> > [002] *.~2.    75.864791: handle_apic_irq
> > <-generic_pipeline_irq_desc <idle>-0       [002] *.~2.
> > 75.864791: handle_oob_irq <-handle_apic_irq <idle>-0       [002]
> > *.~2.    75.864791: do_oob_irq <-handle_oob_irq <idle>-0
> > [002] *.~1.    75.864791: irq_handler_entry: irq=3D4355
> > name=3DOut-of-band LAPIC timer interrupt <idle>-0       [002] *.~2.
> >  75.864791: lapic_oob_handler <-do_oob_irq <idle>-0       [002]
> > *.~1.    75.864791: local_timer_entry: vector=3D236 <idle>-0
> > [002] *.~2. 75.864791: evl_core_tick <-lapic_oob_handler <idle>-0
> >     [002] *.~2.    75.864791: do_clock_tick <-evl_core_tick
> >=20
> > As expected, the latest timer tick scheduled by evl occurs close to
> > the target, only off by one microsecond (75.864791 vs 75.864790). So
> > we have no timing issue here. Something else is at work.
> >=20
> > Could you get me a trace which goes back up to two secs before the
> > time reported by evl about the inband switch of the timer responder?
> > e.g.

Why is it 2 seconds? Is it related to latmus "refresh time"? (which is
1s)

> >=20
> > [   75.214527] EVL: timer-responder:743 switching in-band [pid=3D745,
> > excpt=3D14, user_pc=3D0x77d08492a5fe]
> >=20
> > In the above case, I would need a trace going back to 73.214527 or
> > so.=20
>=20
> Apparently the ftrace buffer was too small. I will adjust it to store
> more data and share results.

It is also interesting, that:

bash-5.2# echo 16384 > /sys/kernel/debug/tracing/buffer_size_kb
bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
16387
bash-5.2# evl trace -eirq -f
tracing enabled
bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
131

Reduces the buffer size...

Hence, I've used the "normal" ftrace with enabled evl functions - the
detailed information about the ftrace config is with log files:
https://nextcloud.swupdate.org/index.php/s/czBd3Ydq9B9noZ7


To extract the cpu2 specific data:
bash-5.2# grep -rnE '\[002\]' Xenomai4-ISW-trace-6.6-logs.txt > cpu2.txt

Here again the ISW happens in the cpu2 execution "hole":
[  128.466459] EVL: timer-responder:736 switching in-band [pid=3D738,
excpt=3D14, user_pc=3D0x7588e71985fe]

Happens for cpu2 between:

11832546:          <idle>-0     [002] *..2.   128.466438:
	sched_idle_set_state <-cpuidle_enter_state
11832547:          <idle>-0     [002] *..2.   128.466468:
	handle_irq_pipelined_prepare <-arch_pipeline_entry

However, now the log is large enough to inspect what has happened in
the system for ~4s before.


With the logs:
timer-responder-738     [002] *.~2.   128.466214: evl_timer_shot:
[proxy-timer/2] at 128.466467 (delay: 253 us, 66918 cycles)

and after ISW:

<idle>-0       [002] *.~1.   128.466469: evl_timer_shot:
latmus_pulse_handler at 128.467208 (delay: 739 us, 195206 cycles)

Why there is such increase in "delay" (253 vs 739 us) ?=20

It looks like we have only 2us delay as the timer has fired on
128.466469 vs. expected 128.466467.

>=20
> > TIA,
> >  =20
>=20
>=20
>=20

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
