From: Greg Gallagher <greg@embeddedgreg.com>
Subject: [PATCH 1/2] kernel: cobalt: Fix up elf_hwcap
Date: Wed, 27 Jan 2021 00:43:47 -0500
Message-Id: <20210127054348.2128285-1-greg@embeddedgreg.com>
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

Update elf_hwcap to ELF_HWCAP, this will work for newer 5.4 kernels

Signen-off-by: Greg Gallagher <greg@embeddedgreg.com>
---
 kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
index b7e3f52f2..291c9e5f0 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
@@ -23,7 +23,7 @@
 #include <asm/xenomai/uapi/fptest.h>
 #include <asm/hwcap.h>
 
-#define have_fp (elf_hwcap & HWCAP_FP)
+#define have_fp (ELF_HWCAP & HWCAP_FP)
 
 static inline int fp_kernel_supported(void)
 {
-- 
2.25.1


