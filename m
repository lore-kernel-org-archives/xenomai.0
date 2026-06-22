Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6553537CD
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167445; cv=none; b=bkGk7/BY36UUHgQzL6s6RNyyJ7fD4iTEPrTeXrSuU7LZcXEsgKJ4iif81qMtycUmUKTvn0rMcuhEWErH4kO6uRhOq+TM4OU31bpKPv5u65Fz8bqvnRLd2O4GstCe3S+2c80ol1TmL/19NotGSf/w5Z9g2589jiPSsFejYZ+9CDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167445; c=relaxed/simple;
	bh=7KWueh9AC5Yziz1Hiay8ANOQpivW6ta13ki/0E2ka/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ft9L3j2KODK4/sJDOqcRlochDDlc0bJQuFdCaMpb7xn4zrRifIhXCZB+o0NHvGg1v+XTXtxD0lnqNocl5f5WHezxhmEvS8BCVnan7Wv5o4e30jHGuq2xypoKGyLwyvnYnKx6wXqOFete1MW16KAi/ANgpEJUrfOv5QRQ591bdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=nPwShKy3; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="nPwShKy3"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260622223037b673cf85f900020771
        for <xenomai@lists.linux.dev>;
        Tue, 23 Jun 2026 00:30:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mWW2E/zYUgU8vWy+Lg4p4lrlpnUQk8qxh+3tmed3Z4M=;
 b=nPwShKy3Ze3DswZy7FtHRhVdQWah79YWo5ynACBkaQpYeY7H+zGGTjjp+yUCe5jZxd6jJ5
 wJzwsaRnr6jKW5Mpwc5ZasJ9dlszjmUed1Ev1IVF/fKpBgnKOVg/hIloxBI2T2D0mcIWzZJp
 X0aCrhVj5eQtE9Pvf6IpTkUR7hAcvIjNgnLrNv7+MleI1hsLtzmFE+C8xwL9ZtZbtaBs1RDr
 z7r3jkkJpOEX/xYUP+WK9Ot1UvtQ9UzdzriAXOCNrqDD7sDyYdb3OjKGnfmyOGuRecgDovY5
 IphJcyobhpUsEJDHPPwvIio9oRybGOQ9ekWjU/FaQtaUZFxA8KP2xu9A==;
Message-ID: <ac2a054ac1e75c91efcde7f68821f4150f8d200a.camel@siemens.com>
Subject: Re: EVL 7.1 and below on armhf: System hang when running the
 testsuite under stress
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>, Tobias
 Schaffner <tobias.schaffner@siemens.com>
Date: Tue, 23 Jun 2026 00:30:37 +0200
In-Reply-To: <87v7bbdj7d.fsf@xenomai.org>
References: <32c49c1fb7fa18b0cbb206198b67bc6cf0c7452b.camel@siemens.com>
	 <87v7bbdj7d.fsf@xenomai.org>
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

On Mon, 2026-06-22 at 11:21 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> <snip>
>=20
> > sem-wait: OK
> > simple-clone: OK
> > [ No futher output, seems we are stuck in stax-lock test]
> > [ It's always within this test ]
> >=20
> > I was able to fetch the following rcu warning from the serial console
> > via gdb/lx-dmesg. Wasn't that helpful for me, but maybe it rings a bell=
.
> >=20
> > [=C2=A0=C2=A0 57.488273] EVL: fault:1957 switching in-band [pid=3D1957,=
 excpt=3D0, __copy_to_user_std+0x74/0x374]
> > [=C2=A0=C2=A0 57.489105] EVL: fault:1957 resuming out-of-band [pid=3D19=
57, excpt=3D0, __copy_to_user_std+0x360/0x374]
> > [=C2=A0=C2=A0 57.489398] EVL: fault:1957 switching in-band [pid=3D1957,=
 excpt=3D0, user_pc=3D0x4707ea]
> > [=C2=A0=C2=A0 86.772645] EVL: fault:4193 switching in-band [pid=3D4193,=
 excpt=3D0, __copy_to_user_std+0x74/0x374]
> > [=C2=A0=C2=A0 86.772942] EVL: fault:4193 resuming out-of-band [pid=3D41=
93, excpt=3D0, __copy_to_user_std+0x360/0x374]
> > [=C2=A0=C2=A0 86.773029] EVL: fault:4193 switching in-band [pid=3D4193,=
 excpt=3D0, user_pc=3D0x4507ea]
> > [=C2=A0 177.579348] EVL: watchdog triggered on CPU0 -- runaway thread '=
post-many-flags:10780.9' signaled
> > [=C2=A0 374.037157] EVL: fault:25707 switching in-band [pid=3D25707, ex=
cpt=3D0, __copy_to_user_std+0x74/0x374]
> > [=C2=A0 374.037582] EVL: fault:25707 resuming out-of-band [pid=3D25707,=
 excpt=3D0, __copy_to_user_std+0x360/0x374]
> > [=C2=A0 374.037705] EVL: fault:25707 switching in-band [pid=3D25707, ex=
cpt=3D0, user_pc=3D0x4507ea]
> > [=C2=A0 493.107954] EVL: watchdog triggered on CPU0 -- runaway thread '=
post-many-flags:2062.4' signaled
> > [=C2=A0 599.153154] EVL: fault:9187 switching in-band [pid=3D9187, excp=
t=3D0, __copy_to_user_std+0x74/0x374]
> > [=C2=A0 599.153624] EVL: fault:9187 resuming out-of-band [pid=3D9187, e=
xcpt=3D0, __copy_to_user_std+0x360/0x374]
> > [=C2=A0 599.153725] EVL: fault:9187 switching in-band [pid=3D9187, excp=
t=3D0, user_pc=3D0x4007ea]
> > [=C2=A0 627.334572] EVL: fault:11456 switching in-band [pid=3D11456, ex=
cpt=3D0, __copy_to_user_std+0x74/0x374]
> > [=C2=A0 627.335530] EVL: fault:11456 resuming out-of-band [pid=3D11456,=
 excpt=3D0, __copy_to_user_std+0x360/0x374]
> > [=C2=A0 627.335752] EVL: fault:11456 switching in-band [pid=3D11456, ex=
cpt=3D0, user_pc=3D0x4907ea]
> > [=C2=A0 730.251556] EVL: watchdog triggered on CPU0 -- runaway thread '=
post-many-flags:18782.6' signaled
> > [=C2=A0 747.230444] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > [=C2=A0 747.231393] rcu:=C2=A0	(detected by 1, t=3D2102 jiffies, g=3D10=
3469, q=3D1205 ncpus=3D4)
> > [=C2=A0 747.231467] rcu: All QSes seen, last rcu_sched kthread activity=
 2100 (44723-42623), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
> > [=C2=A0 747.231599] rcu: rcu_sched kthread starved for 2100 jiffies! g1=
03469 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
> > [=C2=A0 747.231628] rcu:=C2=A0	Unless rcu_sched kthread gets sufficient=
 CPU time, OOM is now expected behavior.
> > [=C2=A0 747.231642] rcu: RCU grace-period kthread stack dump:
> > [=C2=A0 747.231701] task:rcu_sched=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
state:R=C2=A0 running task=C2=A0=C2=A0=C2=A0=C2=A0 stack:0=C2=A0=C2=A0=C2=
=A0=C2=A0 pid:15=C2=A0=C2=A0=C2=A0 tgid:15=C2=A0=C2=A0=C2=A0 ppid:2=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 task_flags:0x208040 flags:0x00000000
> > [=C2=A0 747.232543] Call trace:=20
> > [=C2=A0 747.233011]=C2=A0 __schedule from schedule+0x20/0x130
> > [=C2=A0 747.233751]=C2=A0 schedule from schedule_timeout+0x84/0xf4
> > [=C2=A0 747.233784]=C2=A0 schedule_timeout from rcu_gp_fqs_loop+0xe8/0x=
450
> > [=C2=A0 747.233807]=C2=A0 rcu_gp_fqs_loop from rcu_gp_kthread+0xf0/0x11=
0
> > [=C2=A0 747.233871]=C2=A0 rcu_gp_kthread from kthread+0xe8/0x10c
> > [=C2=A0 747.233901]=C2=A0 kthread from ret_from_fork+0x14/0x30
> > [=C2=A0 747.233957] Exception stack(0xf0879fb0 to 0xf0879ff8)
> > [=C2=A0 747.234087] 9fa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 00000000 00000000 00000000 00000000
> > [=C2=A0 747.234108] 9fc0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
> > [=C2=A0 747.234122] 9fe0: 00000000 00000000 00000000 00000000 00000013 =
00000000
> > [=C2=A0 747.234251] rcu: Stack dump where RCU GP kthread last ran:
> > [=C2=A0 747.234387] Sending NMI from CPU 1 to CPUs 0:
> > [=C2=A0 747.234579] Spurious and unmasked percpu IRQ23 on CPU0
>=20
> Hard to say at the moment whether the pressure imposed on the
> virtualized system by the test is responsible for this hang, or the
> inter-stage synchronization in the core has issues. Any change with this
> patch in?
>=20
> diff --git a/tests/stax-lock.c b/tests/stax-lock.c
> index 51576d9..87511ef 100644
> --- a/tests/stax-lock.c
> +++ b/tests/stax-lock.c
> @@ -66,18 +66,17 @@ static void *test_thread(void *arg)
> =C2=A0	me =3D 1 << serial;
> =C2=A0
> =C2=A0	oob =3D !!(serial & 1);
> +	delay =3D running_on_vm() ? 1000000 : 100000;
> =C2=A0	if (oob) {
> =C2=A0		__Tcall_assert(tfd, evl_attach_self("stax.%ld:%d",
> =C2=A0					serial / 2, getpid()));
> =C2=A0		do_ioctl =3D oob_ioctl;
> =C2=A0		do_usleep =3D evl_usleep;
> -		delay =3D 100000;
> =C2=A0		/* Any in-band presence is invalid. */
> =C2=A0		invalid =3D 0x55555555;
> =C2=A0	} else {
> =C2=A0		do_ioctl =3D ioctl;
> =C2=A0		do_usleep =3D usleep;
> -		delay =3D 100000;
> =C2=A0		/* Any oob presence is invalid. */
> =C2=A0		invalid =3D 0xAAAAAAAA;
> =C2=A0	}

Yep, that helps.

>=20
> Clearly, an improvement would not rule out some issue in the
> implementation of the stax mechanism, but this might give us a valuable
> hint anyway.
>=20
> >=20
> > This problem is unrelated to the arm pipelining cleanup series. I'm
> > going to post v3 now.
> >=20
> > Another finding triggered by some analysis is that we disable a couple
> > of tests in CI. There are two tests failing often in this arm qemu
> > setup:
> > =C2=A0 =C2=A0- clock-timer-periodic
> > =C2=A0=C2=A0 - sched-tp-accuracy
> >=20
> > The timer test is especially failing when there is some load on the
> > host.
>=20
> Since r58, we have the running_on_vm() predicate available to test code,
> which checks whether the "EVL_ON_VM" environment variable is set to
> 1/y/yes/Y/YES (unfortunately, I'm not aware of any way to detect this
> without user input like the valgrind vm allows via some hypercall).

systemd-detect-virt implements a couple of mechanisms to detect a lot of
different hypervisors. Could we depend on it?

>=20
> sched-tp-accuracy, sched-tp-overrun, and monitor-event-untrack have been
> fixed up accordingly not to trigger false positive on vm.

Nice.

Tobias, any plans to clean that up in the CI setup?

>=20
> >=20
> > Now the question - mainly in the direction of Tobias:
> > Why are the other tests disabled in CI? Namely:
> > =C2=A0=C2=A0 - sched-quota-accuracy
> > =C2=A0=C2=A0 - sched-tp-accuracy
> > =C2=A0=C2=A0 - sched-tp-overrun
> > =C2=A0=C2=A0 - monitor-event-untrack
> >=20
> > Shouldn't we better fix the tests than simply disable them? Haven't see=
n
> > any failures on arm64. x86 pending.
> >=20
>=20
> Yes, it would be better to fix them specifically for vm context, even if
> that means disabling some checks based on timing accuracy.
>=20
> --
> Philippe.
