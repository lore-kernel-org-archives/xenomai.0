From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [PATCH v2 3/3] cobalt uapi: Introducing new feature flag for time64
 availability
Date: Mon, 16 Nov 2020 14:07:17 +0000
Message-ID: <20201116140641.72027-4-florian.bezdeka@siemens.com>
References: <157dbba3-5d17-7f84-6319-9ea9eae35854@tj.kylinos.cn>+EDAFE494B95437A7>
 <20201116140641.72027-1-florian.bezdeka@siemens.com>
In-Reply-To: <20201116140641.72027-1-florian.bezdeka@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, song <chensong@tj.kylinos.cn>

From: Florian Bezdeka <florian.bezdeka@siemens.com>

Adding a new feature flag to allow the library asking for time64
support. That will allow the library to use the new system calls when
available / supported by the kernel.

The feature flag should be removed during next ABI revision bump.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/asm-generic/features.h                  | 6 +++++-
 .../cobalt/arch/arm64/include/asm/xenomai/uapi/features.h   | 1 +
 .../cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h | 1 +
 kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h  | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/asm-generic/features.h b/include/cobalt/ua=
pi/asm-generic/features.h
index 8a4927c49..705729aae 100644
--- a/include/cobalt/uapi/asm-generic/features.h
+++ b/include/cobalt/uapi/asm-generic/features.h
@@ -51,6 +51,7 @@ struct cobalt_featinfo {
 #define __xn_feat_nofastsynch 0x10000000
 #define __xn_feat_control     0x08000000
 #define __xn_feat_prioceiling 0x04000000
+#define __xn_feat_time64      0x02000000
=20
 #ifdef CONFIG_SMP
 #define __xn_feat_smp_mask __xn_feat_smp
@@ -70,7 +71,8 @@ struct cobalt_featinfo {
 #define __xn_feat_generic_mask			\
 	(__xn_feat_smp_mask		|	\
 	 __xn_feat_fastsynch_mask 	|	\
-	 __xn_feat_prioceiling)
+	 __xn_feat_prioceiling		|	\
+	 __xn_feat_time64)
=20
 /*
  * List of features both sides have to agree on: If userland supports
@@ -101,6 +103,8 @@ const char *get_generic_feature_label(unsigned int feat=
ure)
 		return "control";
 	case __xn_feat_prioceiling:
 		return "prioceiling";
+	case __xn_feat_time64:
+		return "time64";
 	default:
 		return 0;
 	}
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h b=
/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
index 74423f68b..f03f483f6 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
@@ -22,6 +22,7 @@
 #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
=20
 /* The ABI revision level we use on this arch. */
+// TODO: Reminder: Remove __xn_feat_time64 feature flag on next ABI_REV bu=
mp
 #define XENOMAI_ABI_REV   1UL
=20
 #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h=
 b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
index f6e67d884..db6dbed24 100644
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
@@ -19,6 +19,7 @@
 #define _COBALT_POWERPC_ASM_UAPI_FEATURES_H
=20
 /* The ABI revision level we use on this arch. */
+// TODO: Reminder: Remove __xn_feat_time64 feature flag on next ABI_REV bu=
mp
 #define XENOMAI_ABI_REV   17UL
=20
 #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h b/k=
ernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
index 67c7625f8..30539a5d1 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
@@ -19,6 +19,7 @@
 #define _COBALT_X86_ASM_UAPI_FEATURES_H
=20
 /* The ABI revision level we use on this arch. */
+// TODO: Reminder: Remove __xn_feat_time64 feature flag on next ABI_REV bu=
mp
 #define XENOMAI_ABI_REV   17UL
=20
 #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
--=20
2.26.2

