From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:38:06 +0200
Message-Id: <20180925103809.4932-30-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 29/32] x86: ipipe: restrict WARN_ON_IN_IRQ() to
 the root domain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We have no way to figure out the current context unless the root
domain is active. Make sure we won't trigger false positives with
WARN_ON_IN_IRQ() which may be invoked through calls to access_ok()
from the head domain.
---
 arch/x86/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index aae77eb8491c..b17f4b74573f 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -7,6 +7,7 @@
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 #include <linux/string.h>
+#include <linux/ipipe.h>
 #include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/smap.h>
@@ -70,7 +71,7 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 })
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-# define WARN_ON_IN_IRQ()	WARN_ON_ONCE(!in_task())
+# define WARN_ON_IN_IRQ()	WARN_ON_ONCE(ipipe_root_p && !in_task())
 #else
 # define WARN_ON_IN_IRQ()
 #endif
-- 
2.14.4


