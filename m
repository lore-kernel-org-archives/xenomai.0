From: Philippe Gerum <rpm@xenomai.org>
Date: Fri, 7 Sep 2018 11:04:00 +0200
Message-Id: <E1fzGi4-0003y4-3S@xenomai.org>
Subject: [Xenomai] [PATCH 1/1] arm64: ipipe: route debug exceptions to
 co-kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Cc: xenomai@xenomai.org

---
 arch/arm64/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7dc5906d586f..70c72c2a7f7e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -939,6 +939,9 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	struct siginfo info;
 	int rv;
 
+	if (__ipipe_report_trap(IPIPE_TRAP_BREAK, regs))
+		return 1;
+
 	/*
 	 * Tell lockdep we disabled irqs in entry.S. Do nothing if they were
 	 * already disabled to preserve the last enabled/disabled addresses.
-- 
2.14.4


