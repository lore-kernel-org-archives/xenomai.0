From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] Bump ABI revisions
Message-ID: <8adb41e5-0f68-e0c6-f305-889aac9cbde6@siemens.com>
Date: Thu, 7 Oct 2021 11:11:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

The introduction of dovetail support with the change in the realtime
clock semantics and related interface changes (vDSO usage) is an ABI
change that needs a revision bump.

Strictly spoken, PowerPC is only theoretically affected as it lacks
dovetail support, but it's simpler to bump than to safely exclude all
possibly side effects even on this arch.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h     | 2 +-
 kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h   | 2 +-
 kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h | 2 +-
 kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
index c3c777cb93..43b7afb107 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
@@ -22,7 +22,7 @@
 #define _COBALT_ARM_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   17UL
+#define XENOMAI_ABI_REV   18UL
 
 #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
 
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
index 74423f68bc..b98a963924 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
@@ -22,7 +22,7 @@
 #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   1UL
+#define XENOMAI_ABI_REV   2UL
 
 #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
 
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
index f6e67d884b..ed54882105 100644
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
@@ -19,7 +19,7 @@
 #define _COBALT_POWERPC_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   17UL
+#define XENOMAI_ABI_REV   18UL
 
 #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
 
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
index 67c7625f86..65f8164a02 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
@@ -19,7 +19,7 @@
 #define _COBALT_X86_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   17UL
+#define XENOMAI_ABI_REV   18UL
 
 #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
 
-- 
2.31.1

