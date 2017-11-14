From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 14 Nov 2017 11:43:15 +0100
Message-Id: <20171114104315.2982-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH] x86/ipipe: fix compile error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

61553d8dcb9f introduced a call of "fixup_exception" with too many args,
probably a backporting problem. Remove the arg that the 4.4-version of
the function did not need.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 arch/x86/kernel/ipipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 6b02e3ea4d9a..668ac6a8ba98 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -347,7 +347,7 @@ int __ipipe_trap_prologue(struct pt_regs *regs, int trapnr)
 	 * the standard recovery procedure in that case anyway.
 	 */
 	if (unlikely(!root_entry && faulthandler_disabled())) {
-		if (fixup_exception(regs, trapnr))
+		if (fixup_exception(regs))
 			return 1;
 	}
 
-- 
2.13.6


