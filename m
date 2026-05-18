Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CFE3E51F0
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095438; cv=none; b=RimrmJxXloi8Wqgd1JualJTAgWapy8jhf1XnbLyZZxFF7JR1g1ik/9QcwVhwTq4nHUMnS4ZqEZ8pl23PdRByuYh86vY9mgsg/mzTsppf2MxgNBwb6ekt85SoUie0VKYIq1MHJWLS3tJ8S0kp7oyiuewrbe+7T8wCX8/+iWiRKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095438; c=relaxed/simple;
	bh=RvQHyjwqKTZhGnkHbFaBXplizVHFqGB8aWLRnPnu3lc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NymrSp+L0PzonXBfoEB0MmMBF6pJqjx+r/Ne+UKEdAthAIYKhSxvHarvQP5OLsqU3UYti1DK5X6he4glmCftd2+5KHNqWrc68fEw7NWraMq3WARtJTNaJChBM5rFNRBCw0jqdtaZuCeBWgw5MPNI5O11KIWXAZNwjbs0BD1mj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=AV0NJhtB; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="AV0NJhtB"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202605180910246fc6d9161300020799
        for <xenomai@lists.linux.dev>;
        Mon, 18 May 2026 11:10:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zuSFB2CyZhuQWPp18HRm1wZc6S000odzcepmJeRm/ss=;
 b=AV0NJhtBrRiXvI39xXYg7MrAdFLP4yYDJozPNfdBVrUqC70XwYF22exvDwf/xxiVLHrtWw
 3M+IQyyoPUYUyWVCniq4UxtGWdaF57qrswyhthWxoEbF7lnx3/7zCyLRjoQm1kjKyQrqyct6
 7kwYkrwXDi1igkxk21FoOhNDBdAXK6xUJjbSVmLXqYH8W2OOvqmrPZH2IclGWlqGB0lv2n0u
 sglr5wbvn+s9U8z3/0YaiYYTQBgn1J6zFm8Grw+ZrazYltPqiU7D2mdNeWs2ty24nhlr0S8F
 05x3RabSYbzntVDOCycOhjwoH2kd+F881kSrpLGBhUnDFqlG40K/6gwA==;
Message-ID: <a006030cc98da209b4764b5117c41d93fa3d9399.camel@siemens.com>
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Richard Weinberger <richard@nod.at>
Date: Mon, 18 May 2026 11:10:23 +0200
In-Reply-To: <87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
References: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
	 <87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Sat, 2026-05-16 at 17:48 +0200, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >=20
> > When a remote thread is suspended, xnthread_suspend checks if it is
> > currently relaxed and then calls it into hardened state via SIGSHADOW.
> > However, this signal may race with the thread entering primary mode on
> > its own, e.g. via a syscall. In that case, the thread will be kicked ou=
t
> > of its suspension state by the pending signal, and the migrate syscall
> > it then executes will not perform the expected suspension anymore.
> >=20
> > Plug this race by introducing two thread state flags, one for pending
> > XNSUSP and another one for XNHELD. After having performed the requested
> > hardening on SIGSHADOW_ACTION_HARDEN, we are now testing for those
> > pending suspension states and replay them via self-suspension as needed=
.
> > If a resume took place in the meantime, the state flags were cleared
> > again, and nothing will happen after the migration step.
> >=20
> > Reported-by: Richard Weinberger <richard@nod.at>
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >=20
> > Didn't check yet if EVL solves this topic differently or is exposed to=
=20
> > similar race. But given that Richard found the pattern even in Xenomai=
=20
> > 2, it's likely worth to check EVL carefully.
> >=20
>=20
> Unlike v3, v4 does not use signals for internal synchronization, so it
> does not suffer that particular issue related to suspending a thread
> (no SIGSHADOW in evl). However, this issue is only a symptom of a much
> broader problem both v3 and v4 have when it comes to dealing with
> signals pending for suspended threads, and your patch won't solve it.
>=20
> To illustrate this, let's say (A) and (B) are Cobalt threads running
> oob, (X) may be any in-band context:
>=20
> CPU0                                          CPU1
> ----                                          ----
>=20
> A: xnthread_signal(B, SIGxx)                  B: core_syscall()
>    <schedule irq_work>                              core_suspend(B, XNPEN=
D)
> A: core_suspend(B, XNSUSP)                    B: <schedules out>
>       core_add_state(B, T_SUSP)
>    core_reschedule()
>       core_resched_ipi(CPU1)                 =20
> X: irq_work_handler()
>       send_sig(B, SIGxx)
>          handle_inband_event(B, INBAND_TASK_SIGNAL)
>             core_resume(B, XNPEND)
>             core_resume(B, XNSUSP)
>             core_add_state(B, XNKICKED)
>          core_reschedule()
>             core_resched_ipi(CPU1)                   =20
>                                               X: <ipi-handler>
>                                                     core_reschedule()
>                                               B: <resuming oob>
>                                               B: XNKICKED: prepare_for_si=
gnal()
>                                                     xnthread_relax()
>                                               B: <running in-band>
>                                               B: migrate_syscall()
>                                                  nop (XNPNDSUSP was not s=
et)
>                                               B: <still running in-band>
>=20
> Remoteness of CPUs does not even matter, e.g. with prio(A) > prio(B),
> we might observe:
>=20
> CPU0
> ----
>=20
> B: core_syscall()
>       core_suspend(B, XNPEND)
> B: <schedules out>
> X: send_sig(B, SIGxx)
>       handle_inband_event(B, INBAND_TASK_SIGNAL)
>          core_resume(B, XNPEND) /* B is now fully unblocked */
>          core_add_state(B, XNKICKED)
> <IRQ>: core_resume(A)
> A: <resuming oob>
> A: core_suspend(B, XNSUSP)
>       unblocked + XNKICKED set -> abort: XNSUSP ignored
> B: <resuming oob>
> B: XNKICKED: prepare_for_signal()
>       xnthread_relax()
> B: <still running in-band>
>=20
> There is clearly no shortage of possible variations of the scenarios
> above especially if we bring up more complex multi-CPU configurations,
> all of them causing some sort of breakage. IOW, there is a general issue
> with signals wrt forcible suspension, not just with SIGSHADOW-based
> synchronization in xnthread_suspend() vs migrate() which in addition,
> has its own set of flaws.
>=20
> A way to address this properly may require to break an ancient
> invariant, which states that a thread with any blocking bit set must not
> be linked to any runqueue. On the contrary, a way to make sure that a
> suspend request remains pending across a stage migration in order to
> deal with an in-band signal is precisely to allow that request to linger
> as long as necessary in a thread state mask, only to be considered once
> the 'kicked' flag is cleared, ignored and left pending
> otherwise. Meanwhile, that thread should be allowed to run.
>=20
> I need to have a closer look, but at first glance it seems fairly
> straightforward to implement this in v4 at least.
>=20
> --=20
> Philippe.

Uh... All of that sounds a bit scary...

There was a reprocuder provided by Richard on the list as well, right?
Please make sure that we integrate a test case at the same time as the
fixes. Otherwise the testcase might never be added.
