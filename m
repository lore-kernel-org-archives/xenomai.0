From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 07/25] cobalt/x86: ipipe: Drop unused strncpy_from_user_nocheck
Date: Thu, 20 May 2021 23:44:17 +0200
Message-Id: <abfe05a2dd210d4942512c2d46a2dfc749ef52bd.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../x86/ipipe/include/asm/xenomai/machine.h   |  4 ----
 kernel/cobalt/arch/x86/ipipe/machine.c        | 19 -------------------
 2 files changed, 23 deletions(-)

diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
index aad700fb67..750eb1ec50 100644
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
+++ b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
@@ -29,10 +29,6 @@ static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
 
 #define XNARCH_HOST_TICK_IRQ	__ipipe_hrtimer_irq
 
-long strncpy_from_user_nocheck(char *dst,
-			       const char __user *src,
-			       long count);
-
 /* Read this last to enable default settings. */
 #include <asm-generic/xenomai/machine.h>
 
diff --git a/kernel/cobalt/arch/x86/ipipe/machine.c b/kernel/cobalt/arch/x86/ipipe/machine.c
index 95d2ab2fff..d51a91f975 100644
--- a/kernel/cobalt/arch/x86/ipipe/machine.c
+++ b/kernel/cobalt/arch/x86/ipipe/machine.c
@@ -23,25 +23,6 @@
 #include <asm/xenomai/smi.h>
 #include <asm/xenomai/c1e.h>
 
-long strncpy_from_user_nocheck(char *dst, const char __user *src, long count)
-{
-	int ret;
-	char c;
-	long n;
-	
-	for (n = 0; n < count; n++, src++, dst++) {
-		ret = __xn_get_user(c, src);
-		if (ret)
-			return -EFAULT;
-		*dst = c;
-		if (c == 0)
-			break;
-	}
-
-	return n;
-}
-EXPORT_SYMBOL_GPL(strncpy_from_user_nocheck);
-
 static int mach_x86_init(void)
 {
 	int ret;
-- 
2.26.2


