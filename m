From: Greg Gallagher <greg@embeddedgreg.com>
Subject: [PATCH v2 2/2] kernel: cobalt: Fix up elf_hwcap
Date: Wed,  3 Feb 2021 02:01:59 -0500
Message-Id: <20210203070159.3610435-2-greg@embeddedgreg.com>
In-Reply-To: <20210203070159.3610435-1-greg@embeddedgreg.com>
References: <20210203070159.3610435-1-greg@embeddedgreg.com>
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

Update to use ELF_HWCAP instead of elf_hwcap directly.

Signen-off-by: Greg Gallagher <greg@embeddedgreg.com>
---
 kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h   | 2 +-
 kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
index a76f1e6bb..b8c627bed 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
@@ -23,7 +23,7 @@
 #include <asm/hwcap.h>
 
 #ifdef CONFIG_VFP
-#define have_vfp (elf_hwcap & HWCAP_VFP)
+#define have_vfp (ELF_HWCAP & HWCAP_VFP)
 #else /* !CONFIG_VFP */
 #define have_vfp 0
 #endif /* !CONFIG_VFP */
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


