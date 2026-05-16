Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F61EB5FD
	for <xenomai@lists.linux.dev>; Sat, 16 May 2026 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778946518; cv=none; b=iDktKY5LoGn5NwsPj12sVDEWMWkTOAHwZJ91MrUc5RDQWKNBKJvDa1TGZyfFHyGmmpkUonihXYK6jBAvVkt2R8D8W9rS+AXCe+ChxhfzIP/ND6PdVcZ7LP0UOS0DNO3qhGWCoS8akuytM4Rln0B8E3+o9RvV7c1zJppAV8rXVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778946518; c=relaxed/simple;
	bh=RLmKq3jsmdWvohOQ5jeFxCmpI2M4qqLDivWokVf8pG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oS50bRlLgMcSx0vtQ/Hs2EJUJqgXkrem8Kj7JUbN2eWFsaLUegLBYrJJmC9I90VmiSIaEDuP+WNuOWzoLPL0n+vfJ0G7tcz0RGUbQSNU9HRoWGTaDBH5Wjo1QqEv12XhVvdL44ZuA0Qwk3UD2I6ZX+M1I7qUhxVhfdNSANUn5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=HBLty6fu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="HBLty6fu"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B5673ED56;
	Sat, 16 May 2026 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1778946514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QIMxuUcEe9ds8efJtiPvp6S7xPFYptEuo8vpT4ylC5k=;
	b=HBLty6fuPAS1Z2dhJyNwKHOXvSr71JU3F/UsJtNI37v8HzJBRdT2xgMqLbf+RWC3OT/Gna
	I3pF2t5SSBwEsPeUl+ODKIoQ39JTIS/vCD8U+riDa/tLRsq9sCDtTUouKHOk793xHl4vA+
	zg3KAGbBbbs6Hhwsr89ndYQfqT4vHbLAi+6+FrQ2VW3c7myQ3iWbNugxH3830s2BtERYBD
	BtlIx6v3FIoA6ZHmhG7hEyWPDHprA+1TUuIZQpBEHxAxXUTFoxIQiOgnVlS0GUwhmteZbw
	viXPeqa17IGPHJmmbO14BTtddGQgH8VTJZFkZpsV7slnjhjOrnCHYwdqeQOjNA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
In-Reply-To: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com> (Jan Kiszka's
	message of "Fri, 15 May 2026 10:16:37 +0200")
References: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 16 May 2026 17:48:31 +0200
Message-ID: <87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTF2+aRBQYTerkvTOla/6SMOmMttQENiMvvxCIQnRteHyMG1tjF7Kg/FTddHiJm3NkuRmjYpE5YOAdVNDE3M0mwJ58i01ua6Tl5tBfssksPVGTsNy7MMZErWFxk3/KJJt6qedNiRkf+6+BJphOLoOjDQ8a3dxn013WHx5Br7UFACFUuJ0Z++kX/Hgv27GQY/fQoROoAnCaTzqdlSotrhRau3CKAaekwpFKvq1OxXKeB4toD3afov/UXFL+24rDKIH47r8ohwZ2X2LHfhzA4ARd9e236PCx9X8hS3Vochm61bVRH7S/no3JKcyAKacpDC8+N1bI6RRUBqR2xBU6xmkgfyuAMIsjY9/GOjoqhQYGtLh5xl8GIwDc9GU1nbqZtb/fGpW6459ypI+HJuX0X+e1JzpxX5afcAT4ARoIXdendQTGWhwEKIQ8vuY0zRuQfigyWON414UBW1QZ0RgbNGC50AmYFYgtAtdnsPaWGcXR44HIIjWAkK/cYxiP674HHqbjmipaLSNxZnu63xeYTWaozK581lkwKBSr3NQbJ1z2yy/GcQDXGn7sJiKOpzKnOfxJzxcKwqoL4F0xnbBKbdPxfMxvUfeVxyfPEnADaeBHORWyFE+/DomTztMoyNYyr5BI22hy6wDGDhInd6QtYjenwuqaSA/6UCuLZyGAYDiJg/9w
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> When a remote thread is suspended, xnthread_suspend checks if it is
> currently relaxed and then calls it into hardened state via SIGSHADOW.
> However, this signal may race with the thread entering primary mode on
> its own, e.g. via a syscall. In that case, the thread will be kicked out
> of its suspension state by the pending signal, and the migrate syscall
> it then executes will not perform the expected suspension anymore.
>
> Plug this race by introducing two thread state flags, one for pending
> XNSUSP and another one for XNHELD. After having performed the requested
> hardening on SIGSHADOW_ACTION_HARDEN, we are now testing for those
> pending suspension states and replay them via self-suspension as needed.
> If a resume took place in the meantime, the state flags were cleared
> again, and nothing will happen after the migration step.
>
> Reported-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Didn't check yet if EVL solves this topic differently or is exposed to 
> similar race. But given that Richard found the pattern even in Xenomai 
> 2, it's likely worth to check EVL carefully.
>

Unlike v3, v4 does not use signals for internal synchronization, so it
does not suffer that particular issue related to suspending a thread
(no SIGSHADOW in evl). However, this issue is only a symptom of a much
broader problem both v3 and v4 have when it comes to dealing with
signals pending for suspended threads, and your patch won't solve it.

To illustrate this, let's say (A) and (B) are Cobalt threads running
oob, (X) may be any in-band context:

CPU0                                          CPU1
----                                          ----

A: xnthread_signal(B, SIGxx)                  B: core_syscall()
   <schedule irq_work>                              core_suspend(B, XNPEND)
A: core_suspend(B, XNSUSP)                    B: <schedules out>
      core_add_state(B, T_SUSP)
   core_reschedule()
      core_resched_ipi(CPU1)                  
X: irq_work_handler()
      send_sig(B, SIGxx)
         handle_inband_event(B, INBAND_TASK_SIGNAL)
            core_resume(B, XNPEND)
            core_resume(B, XNSUSP)
            core_add_state(B, XNKICKED)
         core_reschedule()
            core_resched_ipi(CPU1)                    
                                              X: <ipi-handler>
                                                    core_reschedule()
                                              B: <resuming oob>
                                              B: XNKICKED: prepare_for_signal()
                                                    xnthread_relax()
                                              B: <running in-band>
                                              B: migrate_syscall()
                                                 nop (XNPNDSUSP was not set)
                                              B: <still running in-band>

Remoteness of CPUs does not even matter, e.g. with prio(A) > prio(B),
we might observe:

CPU0
----

B: core_syscall()
      core_suspend(B, XNPEND)
B: <schedules out>
X: send_sig(B, SIGxx)
      handle_inband_event(B, INBAND_TASK_SIGNAL)
         core_resume(B, XNPEND) /* B is now fully unblocked */
         core_add_state(B, XNKICKED)
<IRQ>: core_resume(A)
A: <resuming oob>
A: core_suspend(B, XNSUSP)
      unblocked + XNKICKED set -> abort: XNSUSP ignored
B: <resuming oob>
B: XNKICKED: prepare_for_signal()
      xnthread_relax()
B: <still running in-band>

There is clearly no shortage of possible variations of the scenarios
above especially if we bring up more complex multi-CPU configurations,
all of them causing some sort of breakage. IOW, there is a general issue
with signals wrt forcible suspension, not just with SIGSHADOW-based
synchronization in xnthread_suspend() vs migrate() which in addition,
has its own set of flaws.

A way to address this properly may require to break an ancient
invariant, which states that a thread with any blocking bit set must not
be linked to any runqueue. On the contrary, a way to make sure that a
suspend request remains pending across a stage migration in order to
deal with an in-band signal is precisely to allow that request to linger
as long as necessary in a thread state mask, only to be considered once
the 'kicked' flag is cleared, ignored and left pending
otherwise. Meanwhile, that thread should be allowed to run.

I need to have a closer look, but at first glance it seems fairly
straightforward to implement this in v4 at least.

-- 
Philippe.
