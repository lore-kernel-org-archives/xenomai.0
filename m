From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] xnthread_relax: Make sure wakework irq work has a stack
Date: Tue,  5 Apr 2022 13:40:52 +0200
Message-Id: <20220405114052.7385-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Richard Weinberger <richard@nod.at>, Florian Bezdeka <florian.bezdeka@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>

While testing some workload the following KASAN splat arose.
irq_work_single+0x70/0x80 is the last line of irq_work_single():
(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);

So, writing to &work->node.a_flags failed.
atomic_read() and atomic_set() right before work->func(work) didn't
trigger KASAN. This means the memory location behind &work vanished
while the work function ran.

After taking a brief look for irq work users in Xenomai, I found that
xnthread_relax() posts irq work via pipeline_post_inband_work(&wakework);
where wakework in on the stack.
To my best knowledge it is not guaranteed that xnthread_relax() will
stay around until the irq work has finished.

This can explain the KASAN splat. xnthread_relax() returned while
the irq work was still busy.

To fix the problem, add a new helper, pipeline_sync_inband_work(),
which will synchronize against the posted irq work and ensures
that the work is done when xnthread_relax() is about to return.

On the other hand, on ipipe does suffer from this problem because
ipipe has it's own irq work mechanism which takes a copy of the
work struct before processing it asynchronously.

BUG: KASAN: stack-out-of-bounds in irq_work_single+0x70/0x80
Write of size 4 at addr ffff88802f067d48 by task cobalt_printf/1421
CPU: 1 PID: 1421 Comm: cobalt_printf Tainted: G           OE     5.15.9xe=
no3.2-x8664G-rw #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-=
g155821a-rebuilt.opensuse.org 04/01/2014
IRQ stage: Linux
Call Trace:
 <IRQ>
 dump_stack_lvl+0x6e/0x97
 print_address_description.constprop.11.cold.17+0x12/0x32a
 ? irq_work_single+0x70/0x80
 ? irq_work_single+0x70/0x80
 kasan_report.cold.18+0x83/0xdf
 ? irq_work_single+0x70/0x80
 kasan_check_range+0x1c1/0x1e0
 irq_work_single+0x70/0x80
 irq_work_run_list+0x4a/0x60
 irq_work_run+0x14/0x30
 inband_work_interrupt+0xa/0x10
 handle_synthetic_irq+0xbb/0x200
 arch_do_IRQ_pipelined+0xab/0x550
 </IRQ>
 <TASK>
 sync_current_irq_stage+0x28a/0x3d0
 __inband_irq_enable+0x62/0x70
 finish_task_switch+0x14f/0x390
 ? __switch_to+0x31e/0x710
 ? finalize_oob_transition+0x24/0xc0
 __schedule+0x7b4/0xfd0
 ? pci_mmcfg_check_reserved+0xc0/0xc0
 ? hrtimer_run_softirq+0x100/0x100
 ? __debug_object_init+0x327/0x6b0
 schedule+0xbf/0x120
 do_nanosleep+0x166/0x2d0
 ? schedule_timeout_idle+0x30/0x30
 ? __hrtimer_init+0xbb/0xf0
 hrtimer_nanosleep+0x110/0x230
 ? nanosleep_copyout+0x70/0x70
 ? hrtimer_init_sleeper_on_stack+0x60/0x60
 __x64_sys_nanosleep+0x10d/0x160
 ? __ia32_sys_nanosleep_time32+0x160/0x160
 do_syscall_64+0x4c/0xa0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff22aa620b0
Code: 3d 00 f0 ff ff 77 43 c3 66 90 55 48 89 f5 53 48 89 fb 48 83 ec 18 e=
8 af f5 ff ff 48 89 ee 48 89 df 89 c2 b8 23 00 00 00 0f 05 <48> 3d 00 f0 =
ff ff 77 2a 89 d7 89 44 24 0c e8 ed f5 ff ff 8b 44 24
RSP: 002b:00007ff21327ce40 EFLAGS: 00000293 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 00007ff22b097ff0 RCX: 00007ff22aa620b0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ff22b097ff0
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ff21327d700
R10: 00007ff21327d9d0 R11: 0000000000000293 R12: 00007ffe1dc7af9e
R13: 00007ffe1dc7af9f R14: 00007ffe1dc7b020 R15: 00007ff21327cf40
 </TASK>

Cc: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Cc: "Jan Kiszka" <jan.kiszka@siemens.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/cobalt/kernel/dovetail/pipeline/inband_work.h | 3 +++
 kernel/cobalt/thread.c                                | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/cobalt/kernel/dovetail/pipeline/inband_work.h b/incl=
ude/cobalt/kernel/dovetail/pipeline/inband_work.h
index af3d70fc6..826785e43 100644
--- a/include/cobalt/kernel/dovetail/pipeline/inband_work.h
+++ b/include/cobalt/kernel/dovetail/pipeline/inband_work.h
@@ -25,4 +25,7 @@ struct pipeline_inband_work {
 #define pipeline_post_inband_work(__work)				\
 			irq_work_queue(&(__work)->inband_work.work)
=20
+#define pipeline_sync_inband_work(__work)				\
+			irq_work_sync(&(__work)->inband_work.work)
+
 #endif /* !_COBALT_KERNEL_DOVETAIL_INBAND_WORK_H */
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index ff12f288a..beda67e18 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2087,6 +2087,15 @@ void xnthread_relax(int notify, int reason)
 	xnthread_suspend(thread, suspension, XN_INFINITE, XN_RELATIVE, NULL);
 	splnone();
=20
+#ifdef CONFIG_DOVETAIL
+	/*
+	 * Make sure wakework has finished before we continue and our
+	 * stack vanishes.
+	 * On ipipe this is not a problem because ipipe copies the work.
+	 */
+	pipeline_sync_inband_work(&wakework);
+#endif
+
 	/*
 	 * Basic sanity check after an expected transition to secondary
 	 * mode.
--=20
2.26.2


