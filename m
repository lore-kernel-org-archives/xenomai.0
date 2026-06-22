Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453E3655E5
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113396; cv=none; b=ScTf/uW0us+6+HPlTFPQiQAfkSBiZ7vIWBtVW0lExXdQYh3MhuXABSjSh4uXDayoZhcb1AL+lFTC5w/uiV6U7XvD56VyXdeKBwn55ndjZXrLDplrSsblALM5vTXsk/A1NvGtykFGeANbqRIfIsnf/4hSd4CZBlBrtqFRAqGZqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113396; c=relaxed/simple;
	bh=mGcUgYW7Xu4wlF0etFAMXfBiEsYcAfeA+flvTix7YnI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=hIVA3iaUsJY+xFYkV5hRWlqSIXloYhjMKcMlhwg3yEp0+5XtBELHapHro1qSTuyKpnEmLryTr0X2SJ2a70NB70fSgzkG514z+7lyvbXA2viSlkTJ4JPB54vfC9f0487lk73kJtqD+nEWE+iGKb/dO6YzYZcN3HbLD/+AGk4VHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=k1G7RJl+; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="k1G7RJl+"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260622072949d33eeaf39b00020715
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jun 2026 09:29:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=hoGlbVfu8ICD67GNI/zu5kMAd4OQTIkSEe2B/r4IU8c=;
 b=k1G7RJl+OyU6ifwa19bSrOWEuyMM4k2bZoWTPQYPJqr+tAlMWW1uBjDRhel4ITbd91oRZO
 meT79nA86ZsRRu2F28LzZHQ3J7Ugv61l48hHfyEJih/FD4O5Vudqwnrj8NbB0tdQ4z1LS7lW
 JFCEn3jhmu+j8n33uQikBx9C06SlE04PllEzRbFCDropT4TmNbjZM180lVNcAWq6eRJsNYQA
 tgp2D1f29cq0FZLeznD3UM6q4Y9PJ4uP+bzIGqyeHCgRTju8GwqoFqk3nTGm2ppc2OS5mSQT
 PwYEJTL9rXXOymGbxFJG0e9kALBrO+U0HkFg6PeoTEWW98/3Rmg+uGUg==;
Message-ID: <32c49c1fb7fa18b0cbb206198b67bc6cf0c7452b.camel@siemens.com>
Subject: EVL 7.1 and below on armhf: System hang when running the testsuite
 under stress
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>, Tobias
 Schaffner <tobias.schaffner@siemens.com>
Date: Mon, 22 Jun 2026 09:29:49 +0200
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

Hi Philippe,

while testing the 7.1 based EVL branches I noted a system hang on arm
when trying to execute the evl testsuite multiple times in a row while
stressing the system at the same time.

Environment: Nested virtualization, a x86 VM running the armhf tests in
another VM. Might not be that common but other archs are running fine
with this setup.

I tested against 7.1 and 7.0 rebase branches - both affected - but was
not able yet to go below 7.0 as time is limited.

I also enabled PROVE_LOCKING but that did not trigger any warning but
made the problem go away...

The stressor cmdline:
# stress-ng --cpu 8 --iomix 4 --vm 2 --vm-bytes 128M --fork 4 &

Example output

# evl test -k
basic-xbuf: OK
clock-timer-periodic: OK
clone-fork-exec: OK
detach-self: OK
duplicate-element: OK
element-visibility: OK
fault: OK
file-dup: OK
fpu-preload: OK
fpu-stress: OK
heap-torture: OK
hectic: OK
mapfd: OK
monitor-count-inband: OK
monitor-deadlock: OK
monitor-deboost-stress: OK
monitor-event: OK
monitor-event-sigrel: OK
monitor-event-targeted: OK
monitor-event-untrack: OK
monitor-flags: OK
monitor-flags-broadcast: OK
monitor-flags-inband: OK
monitor-pi: OK
monitor-pi-deadlock: OK
monitor-pi-deboost: OK
monitor-pi-stress: OK
monitor-pp-dynamic: OK
monitor-pp-lazy: OK
monitor-pp-lower: OK
monitor-pp-nested: OK
monitor-pp-pi: OK
monitor-pp-raise: OK
monitor-pp-tryenter: OK
monitor-pp-weak: OK
monitor-recursive: OK
monitor-steal: OK
monitor-trylock: OK
monitor-wait-multiple: OK
monitor-wait-requeue: OK
observable-hm: OK
observable-inband: OK
observable-onchange: OK
observable-oob: OK
observable-race: OK
observable-thread: OK
observable-unicast: OK
poll-close: OK
poll-flags: OK
poll-many: OK
poll-multiple: OK
poll-nested: OK
poll-observable-inband: OK
poll-observable-oob: OK
poll-sem: OK
poll-xbuf: OK
proxy-echo: OK
proxy-eventfd: OK
proxy-pipe: OK
proxy-poll: OK
ptrace-sync: OK
ring-spray: OK
rwlock-read: OK
rwlock-write: OK
sched-quota-accuracy: 78.4%
** sched-tp-accuracy: BROKEN
sched-tp-overrun: OK
sem-close-unblock: OK
sem-flush: OK
sem-timedwait: OK
sem-wait: OK
simple-clone: OK
[ No futher output, seems we are stuck in stax-lock test]
[ It's always within this test ]

I was able to fetch the following rcu warning from the serial console
via gdb/lx-dmesg. Wasn't that helpful for me, but maybe it rings a bell.

[   57.488273] EVL: fault:1957 switching in-band [pid=3D1957, excpt=3D0, __=
copy_to_user_std+0x74/0x374]
[   57.489105] EVL: fault:1957 resuming out-of-band [pid=3D1957, excpt=3D0,=
 __copy_to_user_std+0x360/0x374]
[   57.489398] EVL: fault:1957 switching in-band [pid=3D1957, excpt=3D0, us=
er_pc=3D0x4707ea]
[   86.772645] EVL: fault:4193 switching in-band [pid=3D4193, excpt=3D0, __=
copy_to_user_std+0x74/0x374]
[   86.772942] EVL: fault:4193 resuming out-of-band [pid=3D4193, excpt=3D0,=
 __copy_to_user_std+0x360/0x374]
[   86.773029] EVL: fault:4193 switching in-band [pid=3D4193, excpt=3D0, us=
er_pc=3D0x4507ea]
[  177.579348] EVL: watchdog triggered on CPU0 -- runaway thread 'post-many=
-flags:10780.9' signaled
[  374.037157] EVL: fault:25707 switching in-band [pid=3D25707, excpt=3D0, =
__copy_to_user_std+0x74/0x374]
[  374.037582] EVL: fault:25707 resuming out-of-band [pid=3D25707, excpt=3D=
0, __copy_to_user_std+0x360/0x374]
[  374.037705] EVL: fault:25707 switching in-band [pid=3D25707, excpt=3D0, =
user_pc=3D0x4507ea]
[  493.107954] EVL: watchdog triggered on CPU0 -- runaway thread 'post-many=
-flags:2062.4' signaled
[  599.153154] EVL: fault:9187 switching in-band [pid=3D9187, excpt=3D0, __=
copy_to_user_std+0x74/0x374]
[  599.153624] EVL: fault:9187 resuming out-of-band [pid=3D9187, excpt=3D0,=
 __copy_to_user_std+0x360/0x374]
[  599.153725] EVL: fault:9187 switching in-band [pid=3D9187, excpt=3D0, us=
er_pc=3D0x4007ea]
[  627.334572] EVL: fault:11456 switching in-band [pid=3D11456, excpt=3D0, =
__copy_to_user_std+0x74/0x374]
[  627.335530] EVL: fault:11456 resuming out-of-band [pid=3D11456, excpt=3D=
0, __copy_to_user_std+0x360/0x374]
[  627.335752] EVL: fault:11456 switching in-band [pid=3D11456, excpt=3D0, =
user_pc=3D0x4907ea]
[  730.251556] EVL: watchdog triggered on CPU0 -- runaway thread 'post-many=
-flags:18782.6' signaled
[  747.230444] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  747.231393] rcu: 	(detected by 1, t=3D2102 jiffies, g=3D103469, q=3D1205=
 ncpus=3D4)
[  747.231467] rcu: All QSes seen, last rcu_sched kthread activity 2100 (44=
723-42623), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
[  747.231599] rcu: rcu_sched kthread starved for 2100 jiffies! g103469 f0x=
2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[  747.231628] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM=
 is now expected behavior.
[  747.231642] rcu: RCU grace-period kthread stack dump:
[  747.231701] task:rcu_sched       state:R  running task     stack:0     p=
id:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00000000
[  747.232543] Call trace:=20
[  747.233011]  __schedule from schedule+0x20/0x130
[  747.233751]  schedule from schedule_timeout+0x84/0xf4
[  747.233784]  schedule_timeout from rcu_gp_fqs_loop+0xe8/0x450
[  747.233807]  rcu_gp_fqs_loop from rcu_gp_kthread+0xf0/0x110
[  747.233871]  rcu_gp_kthread from kthread+0xe8/0x10c
[  747.233901]  kthread from ret_from_fork+0x14/0x30
[  747.233957] Exception stack(0xf0879fb0 to 0xf0879ff8)
[  747.234087] 9fa0:                                     00000000 00000000 =
00000000 00000000
[  747.234108] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[  747.234122] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  747.234251] rcu: Stack dump where RCU GP kthread last ran:
[  747.234387] Sending NMI from CPU 1 to CPUs 0:
[  747.234579] Spurious and unmasked percpu IRQ23 on CPU0

This problem is unrelated to the arm pipelining cleanup series. I'm
going to post v3 now.

Another finding triggered by some analysis is that we disable a couple
of tests in CI. There are two tests failing often in this arm qemu
setup:
 =C2=A0- clock-timer-periodic
  - sched-tp-accuracy

The timer test is especially failing when there is some load on the
host.

Now the question - mainly in the direction of Tobias:
Why are the other tests disabled in CI? Namely:
  - sched-quota-accuracy
  - sched-tp-accuracy
  - sched-tp-overrun
  - monitor-event-untrack

Shouldn't we better fix the tests than simply disable them? Haven't seen
any failures on arm64. x86 pending.

Best regards,
Florian
