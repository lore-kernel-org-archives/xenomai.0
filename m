Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3548F42
	for <xenomai@lists.linux.dev>; Wed, 16 Nov 2022 16:01:31 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 9576320011;
	Wed, 16 Nov 2022 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668614487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNnwVy1yRK3Mxg8E8VpH1a0mOrJZfl8sSdxCgV77eo0=;
	b=C0TV3/aAjtW2o78j7E1OqllsmplyNAJyP6bf9Cci0jMMNyGeUYjIWvwzoQmjxK/P4w3MLI
	S/SPqqNoSg9kCe68huaDe//q3kXTO26CdzUMVVJF3QVWAEqF0yJwYDfFKyV8+aVKYiTwZQ
	ZBbDyN72p1uPs0D7lUc+Vy05ZJ7YvC8rIDAI6YbvFsBAkLtKw0uex3/pJIlZgGG1f4kWjN
	eHyvOhxnrJo0QY1TyqQGyPmZ0KDo1TFdWI2r5ICEV/4Pyon7ACIMIfu3aD3yzr/GiOCCur
	PUivOHXamqzedhjmMtMHsRnbAZRUksB8Mb8Cq4DBGURnGt4NYy/PGXyop+yupA==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
 <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgcs4ma1.fsf@xenomai.org>
 <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8ng3vv7.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Wed, 16 Nov 2022 16:48:23 +0100
In-reply-to: <87v8ng3vv7.fsf@xenomai.org>
Message-ID: <87edu2dh2j.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Russell Johnson <russell.johnson@kratosdefense.com> writes:
>
>> [[S/MIME Signed Part:Undecided]]
>> Sometimes I saw this issue in seconds/minutes. However, I did just see it
>> run over night on one system, and it hasn't died yet. I did see one kernel
>> splat from that run though, so I attached it here.
>
> Ok, this splat is a false positive from an assertion which should have
> been removed now that the PI walk is preemptible. The case it complains
> about is valid, I'll push a fix to address this tomorrow.
>
>> I am building the kernel
>> with the parameters you recommended to turn off as we speak. I will share
>> with you what I see once I get it installed and running.
>>
>
> Thanks,

I caught this on a different x86 hardware today, this looks like the
issue you reported, only with more reliable reporting from lockdep when
running oob, thanks to some improvements just added to Dovetail (see the
EVL -next branch).

The bug is highly time dependent it seems, this would explain why an
overnight run may pass. In fact, slowing down the machine seems to help,
among three systems running the test, only the one enabling CONFIG_KASAN
reported it here.

The trace below is clean, this will help fixing the issue. I'll follow
up on this.

[  170.488660] 
[  170.488669] ======================================================
[  170.488673] WARNING: possible circular locking dependency detected
[  170.488677] 5.15.77+ #112 Not tainted
[  170.488683] ------------------------------------------------------
[  170.488685] monitor-trylock/575 is trying to acquire lock:
[  170.488692] ffff88810182f018 (monitor-trylock-B:573){-...}-{0:0}, at: evl_lock_mutex_timeout+0x39a/0xf00
[  170.488726] 
[  170.488726] but task is already holding lock:
[  170.488728] ffff8881017ee018 (monitor-trylock-D:573){-.-.}-{0:0}, at: evl_lock_mutex_timeout+0x39a/0xf00
[  170.488749] 
[  170.488749] which lock already depends on the new lock.
[  170.488749] 
[  170.488751] 
[  170.488751] the existing dependency chain (in reverse order) is:
[  170.488754] 
[  170.488754] -> #2 (monitor-trylock-D:573){-.-.}-{0:0}:
[  170.488767]        evl_lock_mutex_timeout+0x3eb/0xf00
[  170.488776]        monitor_oob_ioctl+0x387/0x1560
[  170.488784]        EVL_ioctl+0x82/0x100
[  170.488792]        do_oob_syscall+0x264/0x6b0
[  170.488800]        handle_oob_syscall+0x162/0x1f0
[  170.488809]        pipeline_syscall+0xb7/0x1d0
[  170.488816]        syscall_enter_from_user_mode+0x40/0xa0
[  170.488828]        do_syscall_64+0x15/0xf0
[  170.488836]        entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  170.488847] 
[  170.488847] -> #1 (monitor-try-main:573){-.-.}-{0:0}:
[  170.488859]        evl_wakeup_thread+0x45/0xe0
[  170.488869]        do_clock_tick+0x1d8/0x6c0
[  170.488876]        evl_core_tick+0x6e/0xe0
[  170.488883]        lapic_oob_handler+0x65/0x90
[  170.488891]        do_oob_irq+0x2d8/0x420
[  170.488899]        handle_oob_irq+0x118/0x250
[  170.488907]        generic_pipeline_irq_desc+0x1b2/0x400
[  170.488916]        arch_handle_irq+0x6c/0x270
[  170.488925]        arch_pipeline_entry+0xb1/0x110
[  170.488934]        asm_sysvec_apic_timer_interrupt+0x16/0x20
[  170.488945]        unlock_stage+0x4f/0x70
[  170.488953]        lock_acquire+0x18d/0x3f0
[  170.488963]        evl_init_thread+0x66a/0x820
[  170.488971]        thread_factory_build+0x25a/0x960
[  170.488980]        ioctl_clone_device+0x15c/0x330
[  170.488988]        __x64_sys_ioctl+0xce/0x110
[  170.488998]        do_syscall_64+0x44/0xf0
[  170.489005]        entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  170.489015] 
[  170.489015] -> #0 (monitor-trylock-B:573){-...}-{0:0}:
[  170.489027]        __lock_acquire+0x1bef/0x35e0
[  170.489037]        lock_acquire+0x162/0x3f0
[  170.489045]        evl_lock_mutex_timeout+0x3eb/0xf00
[  170.489053]        monitor_oob_ioctl+0x387/0x1560
[  170.489061]        EVL_ioctl+0x82/0x100
[  170.489068]        do_oob_syscall+0x264/0x6b0
[  170.489076]        handle_oob_syscall+0x162/0x1f0
[  170.489085]        pipeline_syscall+0xb7/0x1d0
[  170.489092]        syscall_enter_from_user_mode+0x40/0xa0
[  170.489101]        do_syscall_64+0x15/0xf0
[  170.489109]        entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  170.489119] 
[  170.489119] other info that might help us debug this:
[  170.489119] 
[  170.489121] Chain exists of:
[  170.489121]   monitor-trylock-B:573 --> monitor-try-main:573 --> monitor-trylock-D:573
[  170.489121] 
[  170.489136]  Possible unsafe locking scenario:
[  170.489136] 
[  170.489138]        CPU0                    CPU1
[  170.489140]        ----                    ----
[  170.489142]   lock(monitor-trylock-D:573);
[  170.489148]                                lock(monitor-try-main:573);
[  170.489155]                                lock(monitor-trylock-D:573);
[  170.489161]   lock(monitor-trylock-B:573);
[  170.489166] 
[  170.489166]  *** DEADLOCK ***
[  170.489166] 
[  170.489168] 2 locks held by monitor-trylock/575:
[  170.489173]  #0: ffff888108433988 (test573.0){-...}-{0:0}, at: evl_lock_mutex_timeout+0x23c/0xf00
[  170.489196]  #1: ffff8881017ee018 (monitor-trylock-D:573){-.-.}-{0:0}, at: evl_lock_mutex_timeout+0x39a/0xf00
[  170.489218] 
[  170.489218] stack backtrace:
[  170.489223] CPU: 1 PID: 575 Comm: monitor-trylock Not tainted 5.15.77+ #112
[  170.489232] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name, BIOS 5.12.09.16.05 07/26/2017
[  170.489237] IRQ stage: EVL
[  170.489241] Call Trace:
[  170.489246]  <TASK>
[  170.489252]  dump_stack_lvl+0x7d/0xb3
[  170.489269]  check_noncircular+0x1ca/0x200
[  170.489286]  ? print_circular_bug+0x240/0x240
[  170.489306]  ? __lock_acquire+0x85e/0x35e0
[  170.489331]  ? add_chain_block+0x33a/0x360
[  170.489350]  __lock_acquire+0x1bef/0x35e0
[  170.489391]  ? lockdep_hardirqs_on_prepare+0x240/0x240
[  170.489401]  ? check_preemption_disabled+0x12/0xf0
[  170.489414]  ? unlock_stage+0xa/0x70
[  170.489429]  ? __evl_get_element_by_fundle+0xc5/0x1e0
[  170.489449]  lock_acquire+0x162/0x3f0
[  170.489461]  ? evl_lock_mutex_timeout+0x39a/0xf00
[  170.489479]  ? lock_downgrade+0x3a0/0x3a0
[  170.489489]  ? evl_lock_mutex_timeout+0xa63/0xf00
[  170.489502]  ? do_raw_spin_lock+0x106/0x190
[  170.489517]  ? spin_bug+0xa0/0xa0
[  170.489542]  evl_lock_mutex_timeout+0x3eb/0xf00
[  170.489551]  ? evl_lock_mutex_timeout+0x39a/0xf00
[  170.489586]  ? evl_destroy_mutex+0x230/0x230
[  170.489600]  ? reacquire_held_locks+0x290/0x290
[  170.489615]  ? enter_monitor+0xf1/0x170
[  170.489632]  monitor_oob_ioctl+0x387/0x1560
[  170.489641]  ? do_raw_spin_unlock+0x9b/0x100
[  170.489653]  ? check_preemption_disabled+0x12/0xf0
[  170.489665]  ? unlock_stage+0xa/0x70
[  170.489677]  ? lock_acquire+0x18d/0x3f0
[  170.489690]  ? check_preemption_disabled+0x12/0xf0
[  170.489702]  ? unlock_stage+0xa/0x70
[  170.489714]  ? enter_monitor+0x170/0x170
[  170.489723]  ? evl_get_file+0xec/0x130
[  170.489735]  ? reacquire_held_locks+0x290/0x290
[  170.489762]  ? do_raw_spin_unlock+0x9b/0x100
[  170.489789]  EVL_ioctl+0x82/0x100
[  170.489807]  do_oob_syscall+0x264/0x6b0
[  170.489824]  ? EVL_read+0xe0/0xe0
[  170.489836]  ? do_oob_syscall+0x6b0/0x6b0
[  170.489857]  handle_oob_syscall+0x162/0x1f0
[  170.489873]  ? handle_pipelined_syscall+0x770/0x770
[  170.489913]  pipeline_syscall+0xb7/0x1d0
[  170.489931]  syscall_enter_from_user_mode+0x40/0xa0
[  170.489947]  do_syscall_64+0x15/0xf0
[  170.489959]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  170.489971] RIP: 0033:0x7fba0aa0bc2b
[  170.489981] Code: Unable to access opcode bytes at RIP 0x7fba0aa0bc01.
[  170.489985] RSP: 002b:00007fba0a80e960 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
[  170.489995] RAX: ffffffffffffffda RBX: 0000000040106d00 RCX: 00007fba0aa0bc2b
[  170.490001] RDX: 0000000040106d00 RSI: 000000000000000b RDI: 0000000010000002
[  170.490006] RBP: 000000000000000b R08: 0000000000000000 R09: 00007ffd93d65090
[  170.490011] R10: 00007fba0a80ea00 R11: 0000000000000246 R12: 00007fba0a80ea00
[  170.490017] R13: 0000000000000000 R14: 00007ffd93c2fb70 R15: 00007fba0a7ff000
[  170.490056]  </TASK>
[  183.001931] EVL: watchdog triggered on CPU #1 -- runaway thread 'post-many-flags:645.2' signaled
[  214.720837] EVL: fault:954 switching in-band [pid=954, excpt=14, user_pc=0x55a1b74461ec]
[  249.980299] sched: RT throttling activated
[  286.528172] EVL: fault:1500 switching in-band [pid=1500, excpt=14, user_pc=0x5575ebc251ec]
[  322.356198] EVL: watchdog triggered on CPU #1 -- runaway thread 'post-many-flags:1716.0' signaled
[  356.456796] EVL: fault:2037 switching in-band [pid=2037, excpt=14, user_pc=0x55892e4ea1ec]
[  392.208582] EVL: watchdog triggered on CPU #2 -- runaway thread 'post-many-flags:2252.0' signaled
[  423.936215] EVL: fault:2564 switching in-band [pid=2564, excpt=14, user_pc=0x55911362b1ec]
[  459.696676] EVL: watchdog triggered on CPU #3 -- runaway thread 'post-many-flags:2778.1' signaled
[  491.385666] EVL: fault:3096 switching in-band [pid=3096, excpt=14, user_pc=0x564c8f17d1ec]
[  527.246324] EVL: watchdog triggered on CPU #1 -- runaway thread 'post-many-flags:3311.15' signaled
[  558.830749] EVL: fault:3617 switching in-band [pid=3617, excpt=14, user_pc=0x5637705481ec]
[  594.531226] EVL: watchdog triggered on CPU #0 -- runaway thread 'post-many-flags:3832.11' signaled
[  626.164629] EVL: fault:4149 switching in-band [pid=4149, excpt=14, user_pc=0x5589652f01ec]
[  662.032655] EVL: watchdog triggered on CPU #0 -- runaway thread 'post-many-flags:4364.11' signaled
[  693.631577] EVL: fault:4675 switching in-band [pid=4675, excpt=14, user_pc=0x55558d6d91ec]
[  729.450287] EVL: watchdog triggered on CPU #1 -- runaway thread 'post-many-flags:4890.1' signaled
[  761.086870] EVL: fault:5202 switching in-band [pid=5202, excpt=14, user_pc=0x561b37a801ec]


-- 
Philippe.
