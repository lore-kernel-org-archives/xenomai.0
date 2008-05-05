Message-ID: <481F2FF8.6040903@domain.hid>
Date: Mon, 05 May 2008 18:04:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <481F2B6A.802@domain.hid>
In-Reply-To: <481F2B6A.802@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Houston, we have a circular problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Hi,
> 
> after hacking away the barriers I-pipe erected in front of lockdep
> (patches will follow on adeos-main), I was finally able to "visualize" a
> bit more what our colleagues see in reality on SMP: some ugly, not yet
> understood circular dependency when running some Xenomai app under gdb.
> What lockdep tries to tell us remains unclear, unfortunately:
> 
> [  874.356703]
> [  874.356957] =======================================================

Got it!

[    0.000000]
[    0.000000] =======================================================
[    0.000000] [ INFO: possible circular locking dependency detected ]
[    0.000000] 2.6.24.6-xeno_64 #313
[    0.000000] -------------------------------------------------------
[    0.000000] gdb/4385 is trying to acquire lock:
[    0.000000]  ((spinlock_t *)&sighand->siglock){....}, at: [<ffffffff802867c1>] schedule_event+0x7f/0x578
[    0.000000]
[    0.000000] but task is already holding lock:
[    0.000000]  (&rq->rq_lock_key){++..}, at: [<ffffffff80477235>] schedule+0x176/0x7ff
[    0.000000]
[    0.000000] which lock already depends on the new lock.
[    0.000000]
[    0.000000]
[    0.000000] the existing dependency chain (in reverse order) is:
[    0.000000]
[    0.000000] -> #2 (&rq->rq_lock_key){++..}:
[    0.000000]        [<ffffffff80257b70>] __lock_acquire+0xb91/0xd80
[    0.000000]        [<ffffffff80258524>] lock_acquire+0x9d/0xbc
[    0.000000]        [<ffffffff8022e546>] task_rq_lock+0x7f/0xb8
[    0.000000]        [<ffffffff80479d65>] _spin_lock+0x2a/0x36
[    0.000000]        [<ffffffff8022e546>] task_rq_lock+0x7f/0xb8
[    0.000000]        [<ffffffff8022e6b6>] try_to_wake_up+0x29/0x306
[    0.000000]        [<ffffffff8022e9a5>] default_wake_function+0x12/0x14
[    0.000000]        [<ffffffff8022bdc7>] __wake_up_common+0x4b/0x7a
[    0.000000]        [<ffffffff8022de9f>] complete+0x3d/0x51
[    0.000000]        [<ffffffff80231321>] migration_thread+0x0/0x22b
[    0.000000]        [<ffffffff8024ad18>] kthread+0x2c/0x7c
[    0.000000]        [<ffffffff8020d238>] child_rip+0xa/0x12
[    0.000000]        [<ffffffff8020c8e8>] restore_args+0x0/0x30
[    0.000000]        [<ffffffff8024acec>] kthread+0x0/0x7c
[    0.000000]        [<ffffffff8020d22e>] child_rip+0x0/0x12
[    0.000000]        [<ffffffffffffffff>] 0xffffffffffffffff
[    0.000000]
[    0.000000] -> #1 ((spinlock_t *)&q->lock){++..}:
[    0.000000]        [<ffffffff80257b70>] __lock_acquire+0xb91/0xd80
[    0.000000]        [<ffffffff80258524>] lock_acquire+0x9d/0xbc
[    0.000000]        [<ffffffff8022ded6>] __wake_up_sync+0x23/0x53
[    0.000000]        [<ffffffff8047a07b>] _spin_lock_irqsave+0x69/0x79
[    0.000000]        [<ffffffff8022ded6>] __wake_up_sync+0x23/0x53
[    0.000000]        [<ffffffff802419f1>] do_notify_parent+0x1ea/0x207
[    0.000000]        [<ffffffff802db7a6>] kmem_cache_free+0xc6/0xcf
[    0.000000]        [<ffffffff803727b6>] _raw_write_lock+0xe/0x90
[    0.000000]        [<ffffffff80239451>] do_exit+0x5fd/0x7e0
[    0.000000]        [<ffffffff8023955b>] do_exit+0x707/0x7e0
[    0.000000]        [<ffffffff80246135>] __call_usermodehelper+0x0/0x61
[    0.000000]        [<ffffffff802464fe>] request_module+0x0/0x166
[    0.000000]        [<ffffffff8020d238>] child_rip+0xa/0x12
[    0.000000]        [<ffffffff8020c8e8>] restore_args+0x0/0x30
[    0.000000]        [<ffffffff8024637b>] ____call_usermodehelper+0x0/0x183
[    0.000000]        [<ffffffff8020d22e>] child_rip+0x0/0x12
[    0.000000]        [<ffffffffffffffff>] 0xffffffffffffffff
[    0.000000]
[    0.000000] -> #0 ((spinlock_t *)&sighand->siglock){....}:
[    0.000000]        [<ffffffff802556db>] print_circular_bug_entry+0x4d/0x54
[    0.000000]        [<ffffffff80257a72>] __lock_acquire+0xa93/0xd80
[    0.000000]        [<ffffffff80258524>] lock_acquire+0x9d/0xbc
[    0.000000]        [<ffffffff802867c1>] schedule_event+0x7f/0x578
[    0.000000]        [<ffffffff80479d65>] _spin_lock+0x2a/0x36
[    0.000000]        [<ffffffff802867c1>] schedule_event+0x7f/0x578
[    0.000000]        [<ffffffff80274c20>] __ipipe_dispatch_event+0xe4/0x1db
[    0.000000]        [<ffffffff80477667>] schedule+0x5a8/0x7ff
[    0.000000]        [<ffffffff80238cd1>] do_wait+0xb5e/0xc4c
[    0.000000]        [<ffffffff80372466>] _raw_read_unlock+0xe/0x2d
[    0.000000]        [<ffffffff80238d00>] do_wait+0xb8d/0xc4c
[    0.000000]        [<ffffffff8022e993>] default_wake_function+0x0/0x14
[    0.000000]        [<ffffffff8022211c>] mcount+0x4c/0x72
[    0.000000]        [<ffffffff80238dec>] sys_wait4+0x2d/0x2f
[    0.000000]        [<ffffffff8020c1a2>] system_call+0x92/0x97
[    0.000000]        [<ffffffffffffffff>] 0xffffffffffffffff
[    0.000000]
[    0.000000] other info that might help us debug this:
[    0.000000]
[    0.000000] 1 lock held by gdb/4385:
[    0.000000]  #0:  (&rq->rq_lock_key){++..}, at: [<ffffffff80477235>] schedule+0x176/0x7ff
[    0.000000]
[    0.000000] stack backtrace:
[    0.000000] Pid: 4385, comm: gdb Not tainted 2.6.24.6-xeno_64 #313
[    0.000000]
[    0.000000] Call Trace:
[    0.000000]  [<ffffffff80255f76>] print_circular_bug_tail+0x75/0x80
[    0.000000]  [<ffffffff802556db>] print_circular_bug_entry+0x4d/0x54
[    0.000000]  [<ffffffff80257a72>] __lock_acquire+0xa93/0xd80
[    0.000000]  [<ffffffff80258524>] lock_acquire+0x9d/0xbc
[    0.000000]  [<ffffffff802867c1>] schedule_event+0x7f/0x578
[    0.000000]  [<ffffffff80479d65>] _spin_lock+0x2a/0x36
[    0.000000]  [<ffffffff802867c1>] schedule_event+0x7f/0x578
[    0.000000]  [<ffffffff80274c20>] __ipipe_dispatch_event+0xe4/0x1db
[    0.000000]  [<ffffffff80477667>] schedule+0x5a8/0x7ff
[    0.000000]  [<ffffffff80238cd1>] do_wait+0xb5e/0xc4c
[    0.000000]  [<ffffffff80372466>] _raw_read_unlock+0xe/0x2d
[    0.000000]  [<ffffffff80238d00>] do_wait+0xb8d/0xc4c
[    0.000000]  [<ffffffff8022e993>] default_wake_function+0x0/0x14
[    0.000000]  [<ffffffff8022211c>] mcount+0x4c/0x72
[    0.000000]  [<ffffffff80238dec>] sys_wait4+0x2d/0x2f
[    0.000000]  [<ffffffff8020c1a2>] system_call+0x92/0x97
[    0.000000]


My quick translation is that we must not send signals from the
schedule_event callback, at least as that hook is currently placed. Any
ideas? Or better interpretations?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

