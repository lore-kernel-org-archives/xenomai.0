Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F8B484.9010803@domain.hid>
Message-Id: <20081017154601.562580026@domain.hid>
Date: Fri, 17 Oct 2008 17:46:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081017154559.420723261@domain.hid>
Subject: [Xenomai-core] [PATCH 13/13] Catch inconsistent SMP feature support
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>


With fast xnsynch/mutex support in place, the importance of getting the
user space library configuration right increases significantly. If the
user fails to provide --enable-smp, (s)he risks to break the mutex fast
path in a very subtle way.

This patch catches the case that the kernel support SMP while userland
does not.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/features.h |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

Index: b/include/asm-generic/features.h
===================================================================
--- a/include/asm-generic/features.h
+++ b/include/asm-generic/features.h
@@ -26,13 +26,14 @@
 #endif /* __KERNEL__ */
 
 #define __xn_feat_smp         0x80000000
-#define __xn_feat_fastsynch   0x40000000
-#define __xn_feat_nofastsynch 0x20000000
+#define __xn_feat_nosmp       0x40000000
+#define __xn_feat_fastsynch   0x20000000
+#define __xn_feat_nofastsynch 0x10000000
 
 #ifdef CONFIG_SMP
 #define __xn_feat_smp_mask __xn_feat_smp
 #else
-#define __xn_feat_smp_mask 0
+#define __xn_feat_smp_mask __xn_feat_nosmp
 #endif
 
 #ifdef CONFIG_XENO_FASTSYNCH
@@ -41,22 +42,29 @@
 #define __xn_feat_fastsynch_mask __xn_feat_nofastsynch
 #endif
 
-#define __xn_feat_generic_mask     (__xn_feat_smp_mask | __xn_feat_fastsynch_mask)
-
-#define __xn_feat_generic_man_mask (__xn_feat_fastsynch | __xn_feat_nofastsynch)
+/* List of generic features kernel or userland may support */
+#define __xn_feat_generic_mask \
+	(__xn_feat_smp_mask | __xn_feat_fastsynch_mask)
+
+/* List of features both sides have to agree on:
+   If userland supports it, the kernel has to provide it, too. */
+#define __xn_feat_generic_man_mask \
+	(__xn_feat_fastsynch | __xn_feat_nofastsynch | __xn_feat_nosmp)
 
 static inline const char *get_generic_feature_label (unsigned feature)
 {
-    switch (feature) {
-    	case __xn_feat_smp:
-	    return "smp";
-        case __xn_feat_fastsynch:
-	    return "fastsynch";
-        case __xn_feat_nofastsynch:
-	    return "nofastsynch";
-    	default:
-	    return 0;
-    }
+	switch (feature) {
+	case __xn_feat_smp:
+		return "smp";
+	case __xn_feat_nosmp:
+		return "nosmp";
+	case __xn_feat_fastsynch:
+		return "fastsynch";
+	case __xn_feat_nofastsynch:
+		return "nofastsynch";
+	default:
+		return 0;
+	}
 }
 
 #endif /* !_XENO_ASM_GENERIC_FEATURES_H */


