Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA21DF26E
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120082; cv=none; b=UMitbf3nbflbMObKE+1lMroHkRqNVGETbUDO8k6MOQX4qA+I8iR47LAg8opQxKjk4FLbNU1ESXU+1r+BRaOUKl7N5NYeVSCTzumAVv0nwZwJCLVCq8t+ePIT0RygUiRPxYvjBb3DPts70vgEa9PySvaiGvFqjNGv2+pntViqRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120082; c=relaxed/simple;
	bh=26MTBGAWMGpdKIG4FbkQyGUXsM/Cz9e/O/0Lf6jl2w8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mKnk76mAmc08++l8F3C4WKJ3TB0IkalJxhgIBJzH7gnCkYWLuhAA+4dFiaRi2CufxoFz68tJ30boYNCqcs0ZXpmXJHRYqmF9+sz34u0FhKRHEr/nz/nGnzRQ39yWM/z1H+NXC6+MllpvVHloQh2SF9OgcafRLcANbi90dBnjWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ZdQvKilc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ZdQvKilc"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D4343EB1D;
	Mon, 22 Jun 2026 09:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1782120070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIp/b+716mKpQulMTux1AQ93aiMyyvkLSBq7ry3vj/8=;
	b=ZdQvKilcRXNs0fFwJTh9IYbfvSEvc1wfV40saZIZHkKu4t7ghlJ2lf4DtSvhkBpWZBM4dx
	YY3XzDm1/BsQjVkevwhjsaBqPH8YYPq/p6BHaNOcDj7zuTpiqTpNmVeEgWfmkCvMt5+q0z
	oMJnSfcYV9sAhLytDf34v/TugJAWp2noNHg9nJQy9Wvoudnh9ZeMZSPy6TPtb8y5UZbkb4
	7Q0QzKtOggSpi15WwXxvxAq9vParF6Qi7SGWYvqVPE+PlzbLdVQ7u6Ai3Hpvh7pCyPEZT1
	xLlqrFeLO88b5laxzJsn3blZLrkZejA3xU8tJwGgpgQkvtQr/JWWekuvIlpldQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>
Subject: Re: EVL 7.1 and below on armhf: System hang when running the
 testsuite under stress
In-Reply-To: <32c49c1fb7fa18b0cbb206198b67bc6cf0c7452b.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 22 Jun 2026 09:29:49 +0200")
References: <32c49c1fb7fa18b0cbb206198b67bc6cf0c7452b.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 22 Jun 2026 11:21:10 +0200
Message-ID: <87v7bbdj7d.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGkxQ0RWGDfdInMmLg+FiT9wQVhWBvoPkB8nqQ2rEY1WPM3kmtmKCCrtTus++QpTc7BfxsNElGSuqv1+4rubKi5+nOBThlINal7ongfSaHVFALHzoCnEPCZnL8b61pUHAtGi1ej7PFfTLTrezLBdpuYCT2bOoVpuZPgqZuGMBglXKMaDYod+F3+IvZ4N9qJSV/hsXtfmC9dvvYpGHsKwyDK8/XkWq8lbZtVEvpyHs+3rS0c8a7eLqbttbb/x78iWp8BR9WJuVQn96YT8RV4dQ+AZksJVeI2ShdJy89JIbGeQuKeAQkFcXQfbGEJ3Pb5lQqDnyRnwiLAvfRhfAkbyQXcGJMqTz1BKl6cGkCjTJCRJL/HHOMF8ySrnLv1UAXcSUI41LRme7RCbziZrUIPvk9hliLyJugyEW8UPxw2d50b+e7SbQrp6HS+igAf/HZRk3C+ZzQl+VwAwkElsOyg6w0GukjHVwa7+XaSinGnjr4Pz3iYW/nWbKHAWG5sdzVBLC3AKhIYqWsQkICCtK+DP2J1IsYQz0nvLc6yrWGHvr0sjd6uL9tJ7Okc2zuy9XWTrcAyCI1ng/MeeZC3Q3s53N1aV5ais4hyzczwzGrvRaSovOkfeL8asDk00ROU81U05b51s/C0+73G8gLaeRjboStfL4MhOEcqDBDoLwIo7blK7Q

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

<snip>

> sem-wait: OK
> simple-clone: OK
> [ No futher output, seems we are stuck in stax-lock test]
> [ It's always within this test ]
>
> I was able to fetch the following rcu warning from the serial console
> via gdb/lx-dmesg. Wasn't that helpful for me, but maybe it rings a bell.
>
> [   57.488273] EVL: fault:1957 switching in-band [pid=3D1957, excpt=3D0, =
__copy_to_user_std+0x74/0x374]
> [   57.489105] EVL: fault:1957 resuming out-of-band [pid=3D1957, excpt=3D=
0, __copy_to_user_std+0x360/0x374]
> [   57.489398] EVL: fault:1957 switching in-band [pid=3D1957, excpt=3D0, =
user_pc=3D0x4707ea]
> [   86.772645] EVL: fault:4193 switching in-band [pid=3D4193, excpt=3D0, =
__copy_to_user_std+0x74/0x374]
> [   86.772942] EVL: fault:4193 resuming out-of-band [pid=3D4193, excpt=3D=
0, __copy_to_user_std+0x360/0x374]
> [   86.773029] EVL: fault:4193 switching in-band [pid=3D4193, excpt=3D0, =
user_pc=3D0x4507ea]
> [  177.579348] EVL: watchdog triggered on CPU0 -- runaway thread 'post-ma=
ny-flags:10780.9' signaled
> [  374.037157] EVL: fault:25707 switching in-band [pid=3D25707, excpt=3D0=
, __copy_to_user_std+0x74/0x374]
> [  374.037582] EVL: fault:25707 resuming out-of-band [pid=3D25707, excpt=
=3D0, __copy_to_user_std+0x360/0x374]
> [  374.037705] EVL: fault:25707 switching in-band [pid=3D25707, excpt=3D0=
, user_pc=3D0x4507ea]
> [  493.107954] EVL: watchdog triggered on CPU0 -- runaway thread 'post-ma=
ny-flags:2062.4' signaled
> [  599.153154] EVL: fault:9187 switching in-band [pid=3D9187, excpt=3D0, =
__copy_to_user_std+0x74/0x374]
> [  599.153624] EVL: fault:9187 resuming out-of-band [pid=3D9187, excpt=3D=
0, __copy_to_user_std+0x360/0x374]
> [  599.153725] EVL: fault:9187 switching in-band [pid=3D9187, excpt=3D0, =
user_pc=3D0x4007ea]
> [  627.334572] EVL: fault:11456 switching in-band [pid=3D11456, excpt=3D0=
, __copy_to_user_std+0x74/0x374]
> [  627.335530] EVL: fault:11456 resuming out-of-band [pid=3D11456, excpt=
=3D0, __copy_to_user_std+0x360/0x374]
> [  627.335752] EVL: fault:11456 switching in-band [pid=3D11456, excpt=3D0=
, user_pc=3D0x4907ea]
> [  730.251556] EVL: watchdog triggered on CPU0 -- runaway thread 'post-ma=
ny-flags:18782.6' signaled
> [  747.230444] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [  747.231393] rcu: 	(detected by 1, t=3D2102 jiffies, g=3D103469, q=3D12=
05 ncpus=3D4)
> [  747.231467] rcu: All QSes seen, last rcu_sched kthread activity 2100 (=
44723-42623), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
> [  747.231599] rcu: rcu_sched kthread starved for 2100 jiffies! g103469 f=
0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
> [  747.231628] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, O=
OM is now expected behavior.
> [  747.231642] rcu: RCU grace-period kthread stack dump:
> [  747.231701] task:rcu_sched       state:R  running task     stack:0    =
 pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00000000
> [  747.232543] Call trace:=20
> [  747.233011]  __schedule from schedule+0x20/0x130
> [  747.233751]  schedule from schedule_timeout+0x84/0xf4
> [  747.233784]  schedule_timeout from rcu_gp_fqs_loop+0xe8/0x450
> [  747.233807]  rcu_gp_fqs_loop from rcu_gp_kthread+0xf0/0x110
> [  747.233871]  rcu_gp_kthread from kthread+0xe8/0x10c
> [  747.233901]  kthread from ret_from_fork+0x14/0x30
> [  747.233957] Exception stack(0xf0879fb0 to 0xf0879ff8)
> [  747.234087] 9fa0:                                     00000000 0000000=
0 00000000 00000000
> [  747.234108] 9fc0: 00000000 00000000 00000000 00000000 00000000 0000000=
0 00000000 00000000
> [  747.234122] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [  747.234251] rcu: Stack dump where RCU GP kthread last ran:
> [  747.234387] Sending NMI from CPU 1 to CPUs 0:
> [  747.234579] Spurious and unmasked percpu IRQ23 on CPU0

Hard to say at the moment whether the pressure imposed on the
virtualized system by the test is responsible for this hang, or the
inter-stage synchronization in the core has issues. Any change with this
patch in?

diff --git a/tests/stax-lock.c b/tests/stax-lock.c
index 51576d9..87511ef 100644
--- a/tests/stax-lock.c
+++ b/tests/stax-lock.c
@@ -66,18 +66,17 @@ static void *test_thread(void *arg)
 	me =3D 1 << serial;
=20
 	oob =3D !!(serial & 1);
+	delay =3D running_on_vm() ? 1000000 : 100000;
 	if (oob) {
 		__Tcall_assert(tfd, evl_attach_self("stax.%ld:%d",
 					serial / 2, getpid()));
 		do_ioctl =3D oob_ioctl;
 		do_usleep =3D evl_usleep;
-		delay =3D 100000;
 		/* Any in-band presence is invalid. */
 		invalid =3D 0x55555555;
 	} else {
 		do_ioctl =3D ioctl;
 		do_usleep =3D usleep;
-		delay =3D 100000;
 		/* Any oob presence is invalid. */
 		invalid =3D 0xAAAAAAAA;
 	}

Clearly, an improvement would not rule out some issue in the
implementation of the stax mechanism, but this might give us a valuable
hint anyway.

>
> This problem is unrelated to the arm pipelining cleanup series. I'm
> going to post v3 now.
>
> Another finding triggered by some analysis is that we disable a couple
> of tests in CI. There are two tests failing often in this arm qemu
> setup:
>  =C2=A0- clock-timer-periodic
>   - sched-tp-accuracy
>
> The timer test is especially failing when there is some load on the
> host.

Since r58, we have the running_on_vm() predicate available to test code,
which checks whether the "EVL_ON_VM" environment variable is set to
1/y/yes/Y/YES (unfortunately, I'm not aware of any way to detect this
without user input like the valgrind vm allows via some hypercall).

sched-tp-accuracy, sched-tp-overrun, and monitor-event-untrack have been
fixed up accordingly not to trigger false positive on vm.

>
> Now the question - mainly in the direction of Tobias:
> Why are the other tests disabled in CI? Namely:
>   - sched-quota-accuracy
>   - sched-tp-accuracy
>   - sched-tp-overrun
>   - monitor-event-untrack
>
> Shouldn't we better fix the tests than simply disable them? Haven't seen
> any failures on arm64. x86 pending.
>

Yes, it would be better to fix them specifically for vm context, even if
that means disabling some checks based on timing accuracy.

--=20
Philippe.
