Message-ID: <481F2B6A.802@domain.hid>
Date: Mon, 05 May 2008 17:44:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Houston, we have a circular problem
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

Hi,

after hacking away the barriers I-pipe erected in front of lockdep
(patches will follow on adeos-main), I was finally able to "visualize" a
bit more what our colleagues see in reality on SMP: some ugly, not yet
understood circular dependency when running some Xenomai app under gdb.
What lockdep tries to tell us remains unclear, unfortunately:

[  874.356703]
[  874.356957] =======================================================

Here it hangs because of this (catched via QEMU):

(gdb) bt
#0  __delay (loops=1) at arch/x86/lib/delay_64.c:34
#1  0xffffffff80372712 in _raw_spin_lock (lock=0xffff81000232c6c0) at lib/spinlock_debug.c:111
#2  0xffffffff80479d3d in _spin_lock (lock=0xffff81000232c6c0) at kernel/spinlock.c:182
#3  0xffffffff8022e546 in task_rq_lock (p=0xffff81002e792000, flags=0xffff81002f487910) at kernel/sched.c:615
#4  0xffffffff8022e6b6 in try_to_wake_up (p=0x1, state=<value optimized out>, sync=341) at kernel/sched.c:1562
#5  0xffffffff8022e9a5 in default_wake_function (curr=<value optimized out>, mode=0, sync=341, key=0xf48791c8) at kernel/sched.c:3840
#6  0xffffffff8024ae51 in autoremove_wake_function (wait=0x1, mode=0, sync=341, key=0xf48791c8) at kernel/wait.c:132
#7  0xffffffff8022bdc7 in __wake_up_common (q=<value optimized out>, mode=1, nr_exclusive=1, sync=0, key=0x0) at kernel/sched.c:3861
#8  0xffffffff8022df43 in __wake_up (q=0xffffffff805a6240, mode=1, nr_exclusive=1, key=0x0) at kernel/sched.c:3880
#9  0xffffffff80235838 in wake_up_klogd () at kernel/printk.c:1013
#10 0xffffffff80235a30 in release_console_sem () at kernel/printk.c:1059
#11 0xffffffff802360be in vprintk (fmt=0x12 <Address 0x12 out of bounds>, args=0xffff81002f487a72) at kernel/printk.c:807
#12 0xffffffff802361e5 in printk (fmt=0xffffffff8054c0fd "\n", '=' <repeats 55 times>, "\n") at kernel/printk.c:664
#13 0xffffffff80256268 in print_circular_bug_header (entry=0xffffffff809cb8c0, depth=2) at kernel/lockdep.c:902
#14 0xffffffff80256f84 in check_noncircular (source=<value optimized out>, depth=1) at kernel/lockdep.c:973
#15 0xffffffff80256f8e in check_noncircular (source=<value optimized out>, depth=0) at kernel/lockdep.c:975
#16 0xffffffff80257a45 in __lock_acquire (lock=0xffff81002e9ff960, subclass=0, trylock=0, read=0, check=2, hardirqs_off=1, ip=18446744071564715933) at kernel/lockdep.c:1324
#17 0xffffffff80258500 in lock_acquire (lock=0x1, subclass=0, trylock=-2140427232, read=-192441912, check=2, ip=<value optimized out>) at kernel/lockdep.c:2703
#18 0xffffffff80479d35 in _spin_lock (lock=0xffff81002e9ff948) at kernel/spinlock.c:181
#19 0xffffffff8028679d in schedule_event (event=<value optimized out>, ipd=0x0, data=0xffff81002e198000) at kernel/xenomai/nucleus/shadow.c:2197
#20 0xffffffff80274bfc in __ipipe_dispatch_event (event=33, data=0xffff81002e198000) at kernel/ipipe/core.c:828
#21 0xffffffff80477637 in schedule () at kernel/sched.c:1897
#22 0xffffffff80247598 in worker_thread (__cwq=<value optimized out>) at kernel/workqueue.c:314
#23 0xffffffff8024ad16 in kthread (_create=<value optimized out>) at kernel/kthread.c:78
#24 0xffffffff8020d238 in child_rip ()
#25 0x0000000000000000 in ?? ()

The lock in question should be task->sighand->siglock, but as we hit the
bug inside the scheduler, printk deadlocks now :(. Need to dig out some
patch of Steven Rostedt (IIRC) that may overcome the second deadlock.

But maybe someone already hears a bell ringing. Would be highly
appreciated as gdb is effectively unusable here.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

