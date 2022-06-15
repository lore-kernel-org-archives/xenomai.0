From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH stable/3.0.x 2/2] x86: cobalt/switchtest: Enable FPU tests
 unconditionally
Date: Wed, 15 Jun 2022 11:57:18 +0200
Message-Id: <20220615095718.2445543-3-florian.bezdeka@siemens.com>
In-Reply-To: <20220615095718.2445543-1-florian.bezdeka@siemens.com>
References: <20220615095718.2445543-1-florian.bezdeka@siemens.com>
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

Parts of the FPU tests were skipped when one of the following config
options was enabled, shadowing a real test issue that was triggered by
high load on the system. The options:
  - CONFIG_X86_USE_3DNOW
  - CONFIG_MD_RAID456
  - CONFIG_MD_RAID456_MODULE

As the FPU initialization is fixed now, we can enable the tests
unconditionally.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
index ccf7afa11..7a2b17d75 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
@@ -36,19 +36,6 @@ static inline void fp_init(void)
 
 static inline int fp_linux_begin(void)
 {
-#if defined(CONFIG_X86_USE_3DNOW) \
-	|| defined(CONFIG_MD_RAID456) || defined(CONFIG_MD_RAID456_MODULE)
-	/* Ther kernel uses x86 FPU, we can not also use it in our tests. */
-	static int once = 0;
-	if (!once) {
-		once = 1;
-		printk("%s:%d: Warning: Linux is compiled to use FPU in "
-		       "kernel-space.\nFor this reason, switchtest can not "
-		       "test using FPU in Linux kernel-space.\n",
-		       __FILE__, __LINE__);
-	}
-	return -EBUSY;
-#endif /* 3DNow or RAID 456 */
 	kernel_fpu_begin();
 	/* kernel_fpu_begin() does no re-initialize the fpu context, but
 	   fp_regs_set() implicitely expects an initialized fpu context, so
-- 
2.30.2


