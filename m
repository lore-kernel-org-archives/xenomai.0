From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:54 +0200
Message-Id: <20180925103809.4932-18-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 17/32] x86/nmi: ipipe: disallow user copy from
 head domain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Copying user memory from NMI context is deemed unsafe when the
interrupt has preempted the head domain.

Revisit: why?
---
 arch/x86/lib/usercopy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
index 3f435d7fca5e..1168c90acd88 100644
--- a/arch/x86/lib/usercopy.c
+++ b/arch/x86/lib/usercopy.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/uaccess.h>
+#include <linux/ipipe.h>
 #include <linux/export.h>
 
 #include <asm/tlbflush.h>
@@ -18,7 +19,7 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long ret;
 
-	if (__range_not_ok(from, n, TASK_SIZE))
+	if (!ipipe_root_p || __range_not_ok(from, n, TASK_SIZE))
 		return n;
 
 	if (!nmi_uaccess_okay())
-- 
2.14.4


