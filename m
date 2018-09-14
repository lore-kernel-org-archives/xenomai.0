From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 14 Sep 2018 18:14:41 +0200
Message-Id: <20180914161442.2406-5-henning.schild@siemens.com>
In-Reply-To: <20180914161442.2406-1-henning.schild@siemens.com>
References: <20180914161442.2406-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [PATCHv2 3/4] cobalt: fixup for kernel 4.14+
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/syscall.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index f11ade8e7..3873fa634 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -20,7 +20,12 @@
 #define _COBALT_ASM_GENERIC_SYSCALL_H
 
 #include <linux/types.h>
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
 #include <asm/uaccess.h>
+#else
+#include <linux/uaccess.h>
+#endif
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/wrappers.h>
 #include <asm/xenomai/machine.h>
-- 
2.19.0


