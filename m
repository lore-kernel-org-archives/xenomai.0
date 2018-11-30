From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH][4.14] arm/ipipe: Add support for userspace return notifier
Message-ID: <517520dc-cae1-3b74-be4f-8baf0e43399d@siemens.com>
Date: Fri, 30 Nov 2018 21:10:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

This adds the arm-specific bits to implement the userspace return
notifier.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/include/asm/thread_info.h |  2 ++
 arch/arm/kernel/entry-common.S     | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 50ccf302c1db..e788080b8aaa 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -182,10 +182,12 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define TIP_MAYDAY	0	/* MAYDAY call is pending */
 #define TIP_NOTIFY	1	/* Notify head domain about kernel events */
 #define TIP_HEAD	2	/* Runs in head domain */
+#define TIP_USERINTRET	3	/* Notify on IRQ/trap return to root userspace */
 
 #define _TIP_MAYDAY	(1 << TIP_MAYDAY)
 #define _TIP_NOTIFY	(1 << TIP_NOTIFY)
 #define _TIP_HEAD	(1 << TIP_HEAD)
+#define _TIP_USERINTRET	(1 << TIP_USERINTRET)
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_ARM_THREAD_INFO_H */
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index be94f2a56c13..d6c0ebd3f166 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -152,8 +152,25 @@ ENTRY(ret_to_user_from_irq)
 	tst	r1, #_TIF_WORK_MASK
 	bne	slow_work_pending
 no_work_pending:
+#ifdef CONFIG_IPIPE
+	get_thread_info tsk
+	ldr	r1, [tsk, #TI_IPIPE]
+	tst	r1, #_TIP_USERINTRET
+	bne	call_user_intret_notifier
+goto_user:
+#endif
 	asm_trace_hardirqs_on save = 0
 	slow_restore_user_regs
+
+#ifdef CONFIG_IPIPE
+call_user_intret_notifier:
+	enable_irq_notrace
+	bl	__ipipe_notify_user_intreturn
+	cmp	r0, #0
+	beq	ret_slow_syscall
+	disable_irq_notrace
+	b	goto_user
+#endif
 ENDPROC(ret_to_user_from_irq)
 ENDPROC(ret_to_user)
 
-- 
2.16.4

