From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 3/6] ipipe: Add missing include for ipipe_root_only
Date: Thu, 11 Jul 2019 21:56:14 +0200
Message-Id: <bb8f4fd8da4befa9cfb96178891ddae4f40e31c7.1562874977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
References: <cover.1562874977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
References: <cover.1562874977.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Breaks in non-debug builds otherwise, e.g.
https://travis-ci.com/xenomai-ci/xenomai/jobs/212725223

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 50b1e0c878e0..edd37052e585 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -14,6 +14,7 @@
 #include <linux/printk.h>
 #include <linux/build_bug.h>
 #include <asm/byteorder.h>
+#include <asm-generic/ipipe.h>
 #include <uapi/linux/kernel.h>
 
 #define USHRT_MAX	((u16)(~0U))
-- 
2.16.4


