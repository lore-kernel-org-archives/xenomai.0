From: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Date: Thu, 18 Jan 2018 01:33:21 +0000
Message-Id: <1516239201-24251-4-git-send-email-dmitriy@oss-tech.org>
In-Reply-To: <1516239201-24251-1-git-send-email-dmitriy@oss-tech.org>
References: <1516239201-24251-1-git-send-email-dmitriy@oss-tech.org>
Subject: [Xenomai] [PATCH 3/3] cobalt/kernel: add missing header for 4.14
	compatibility
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Add missing uaccess.h needed for copy_{to/from}_user_inatomic under Linux 4.14.

Signed-off-by: Dmitriy Cherkasov <dmitriy@oss-tech.org>
---
 kernel/cobalt/include/asm-generic/xenomai/syscall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 84fa2efa9..92007dd23 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -20,6 +20,7 @@
 #define _COBALT_ASM_GENERIC_SYSCALL_H
 
 #include <linux/types.h>
+#include <linux/uaccess.h>
 #include <asm/uaccess.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/wrappers.h>
-- 
2.14.3


