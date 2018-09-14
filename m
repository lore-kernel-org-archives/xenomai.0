From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 14 Sep 2018 18:14:40 +0200
Message-Id: <20180914161442.2406-4-henning.schild@siemens.com>
In-Reply-To: <20180914161442.2406-1-henning.schild@siemens.com>
References: <20180914161442.2406-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [PATCHv2 2/4] cobalt/x86: add ipipe-4.4 eager fpu support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Linux 4.4.138 switched to eager fpu, set IPIPE_X86_FPU_EAGER
accordingly.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
index 00f0aaae5..a47730106 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
@@ -28,6 +28,10 @@
     LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
 #define IPIPE_X86_FPU_EAGER
 #endif
+#if LINUX_VERSION_CODE > KERNEL_VERSION(4,4,137) && \
+    LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#define IPIPE_X86_FPU_EAGER
+#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
 #include <asm/i387.h>
-- 
2.19.0


