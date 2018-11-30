From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH][4.14] x86/ipipe: Add support for userspace return notifier
Message-ID: <0bbfd08c-19a8-b04f-fa1d-f7d4312d03e6@siemens.com>
Date: Fri, 30 Nov 2018 21:08:11 +0100
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
To: Xenomai <xenomai@xenomai.org>

This adds the x86-specific bits to implement the userspace return
notifier.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/entry/common.c            | 12 ++++++++++++
 arch/x86/include/asm/thread_info.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index c27b10d1dce1..568f45c47063 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -209,11 +209,23 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
 
 	lockdep_sys_exit();
 
+again:
 	cached_flags = READ_ONCE(ti->flags);
 
 	if (unlikely(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
 		exit_to_usermode_loop(regs, cached_flags);
 
+	if (ipipe_user_intret_notifier_enabled(ti)) {
+		int ret;
+
+		enable_local_irqs();
+		ret = __ipipe_notify_user_intreturn();
+		disable_local_irqs();
+
+		if (ret == 0)
+			goto again;
+	}
+
 #ifdef CONFIG_COMPAT
 	/*
 	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 28622abbd84b..28f3bc7df5be 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -162,10 +162,12 @@ struct thread_info {
 #define TIP_HEAD	0	/* Runs in head domain */
 #define TIP_NOTIFY	1	/* Notify head domain about kernel events */
 #define TIP_MAYDAY	2	/* MAYDAY call is pending */
+#define TIP_USERINTRET	3	/* Notify on IRQ/trap return to root userspace */
 
 #define _TIP_HEAD	(1 << TIP_HEAD)
 #define _TIP_NOTIFY	(1 << TIP_NOTIFY)
 #define _TIP_MAYDAY	(1 << TIP_MAYDAY)
+#define _TIP_USERINTRET	(1 << TIP_USERINTRET)
 
 #define STACK_WARN		(THREAD_SIZE/8)
 
-- 
2.16.4

