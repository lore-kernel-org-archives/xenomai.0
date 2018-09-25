From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:27:15 +0200
Message-Id: <20180925102716.4492-11-rpm@xenomai.org>
In-Reply-To: <20180925102716.4492-1-rpm@xenomai.org>
References: <20180925102716.4492-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 10/11] arm64: ipipe: route all access traps to
 co-kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Notifying the co-kernel about major faults occurring in kernel context
or user-space was overlooked. We need the co-kernel to restore the
root stage whenever applicable before we may attempt to handle the
fault.
---
 arch/arm64/mm/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 70c72c2a7f7e..afef7738fc63 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -401,6 +401,9 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 	const struct fault_info *inf;
 	unsigned long irqflags;
 
+	if (__ipipe_report_trap(IPIPE_TRAP_ACCESS, regs))
+		return;
+
 	/*
 	 * If we are in kernel mode at this point, we have no context to
 	 * handle this fault with.
@@ -473,6 +476,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	unsigned long vm_flags = VM_READ | VM_WRITE, irqflags;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
+	if (__ipipe_report_trap(IPIPE_TRAP_ACCESS, regs))
+		return 0;
+
 	irqflags = fault_entry(regs);
 
 	if (notify_page_fault(regs, esr))
-- 
2.14.4


