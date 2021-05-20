From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 23/25] lib/cobalt: dovetail: allow representing time as count
 of nanoseconds
Date: Thu, 20 May 2021 23:44:33 +0200
Message-Id: <1eeef00e313e980dd9e2e02e26754e3c8a68527e.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

When the core runs on top of Dovetail, all time values are represented
as counts of nanoseconds, in which case a Cobalt tick equals a
nanosecond.

Introduce inline wrappers for tick-to/from-ns conversion which are
nops in the latter case. Cobalt passes us a null clock frequency at
binding time (__cobalt_tsc_clockfreq) when conversion is not needed;
otherwise, the frequency is used in scaled maths for converting
timestamps between their hardware tick and nanosec representation.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/ticks.h | 50 +++++++++++++++++++++++++++++++++++++++---
 lib/cobalt/ticks.c     | 42 +++++++++++++++++++----------------
 2 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/include/cobalt/ticks.h b/include/cobalt/ticks.h
index 2d0132db78..e59d86d499 100644
--- a/include/cobalt/ticks.h
+++ b/include/cobalt/ticks.h
@@ -18,17 +18,61 @@
 #ifndef _COBALT_TICKS_H
 #define _COBALT_TICKS_H
 
+#include <stdbool.h>
 #include <cobalt/uapi/kernel/types.h>
 
+/*
+ * Depending on the underlying pipeline support, we may represent time
+ * stamps as count of nanoseconds (Dovetail), or as values of the
+ * hardware tick counter (aka TSC) available with the platform
+ * (I-pipe). In the latter - legacy - case, we need to convert from
+ * TSC values to nanoseconds and conversely via scaled maths. This
+ * indirection will go away once support for the I-pipe is removed.
+ */
+
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-xnsticks_t cobalt_ticks_to_ns(xnsticks_t ticks);
+extern unsigned long long __cobalt_tsc_clockfreq;
+
+static inline bool cobalt_use_legacy_tsc(void)
+{
+	return !!__cobalt_tsc_clockfreq;
+}
+
+xnsticks_t __cobalt_tsc_to_ns(xnsticks_t ticks);
+
+xnsticks_t __cobalt_tsc_to_ns_rounded(xnsticks_t ticks);
+
+xnsticks_t __cobalt_ns_to_tsc(xnsticks_t ns);
 
-xnsticks_t cobalt_ticks_to_ns_rounded(xnsticks_t ticks);
+static inline
+xnsticks_t cobalt_ns_to_ticks(xnsticks_t ns)
+{
+	if (cobalt_use_legacy_tsc())
+		return __cobalt_ns_to_tsc(ns);
 
-xnsticks_t cobalt_ns_to_ticks(xnsticks_t ns);
+	return ns;
+}
+
+static inline
+xnsticks_t cobalt_ticks_to_ns(xnsticks_t ticks)
+{
+	if (cobalt_use_legacy_tsc())
+		return __cobalt_tsc_to_ns(ticks);
+
+	return ticks;
+}
+
+static inline
+xnsticks_t cobalt_ticks_to_ns_rounded(xnsticks_t ticks)
+{
+	if (cobalt_use_legacy_tsc())
+		return __cobalt_tsc_to_ns_rounded(ticks);
+
+	return ticks;
+}
 
 unsigned long long cobalt_divrem_billion(unsigned long long value,
 					 unsigned long *rem);
diff --git a/lib/cobalt/ticks.c b/lib/cobalt/ticks.c
index 89d7f51e38..8313258117 100644
--- a/lib/cobalt/ticks.c
+++ b/lib/cobalt/ticks.c
@@ -20,7 +20,7 @@
 #include <asm/xenomai/tsc.h>
 #include "internal.h"
 
-static unsigned long long clockfreq;
+unsigned long long __cobalt_tsc_clockfreq;
 
 #ifdef XNARCH_HAVE_LLMULSHFT
 
@@ -31,11 +31,6 @@ static unsigned int tsc_scale, tsc_shift;
 static struct xnarch_u32frac tsc_frac;
 static struct xnarch_u32frac bln_frac;
 
-xnsticks_t cobalt_ns_to_ticks(xnsticks_t ns)
-{
-	return xnarch_nodiv_llimd(ns, tsc_frac.frac, tsc_frac.integ);
-}
-
 unsigned long long cobalt_divrem_billion(unsigned long long value,
 					 unsigned long *rem)
 {
@@ -52,21 +47,26 @@ unsigned long long cobalt_divrem_billion(unsigned long long value,
 	return q;
 }
 
+xnsticks_t __cobalt_ns_to_tsc(xnsticks_t ns)
+{
+	return xnarch_nodiv_llimd(ns, tsc_frac.frac, tsc_frac.integ);
+}
+
 #else /* !XNARCH_HAVE_NODIV_LLIMD */
 
-xnsticks_t cobalt_ns_to_ticks(xnsticks_t ns)
+xnsticks_t __cobalt_ns_to_tsc(xnsticks_t ns)
 {
 	return xnarch_llimd(ns, 1 << tsc_shift, tsc_scale);
 }
 
 #endif /* !XNARCH_HAVE_NODIV_LLIMD */
 
-xnsticks_t cobalt_ticks_to_ns(xnsticks_t ticks)
+xnsticks_t __cobalt_tsc_to_ns(xnsticks_t ticks)
 {
 	return xnarch_llmulshft(ticks, tsc_scale, tsc_shift);
 }
 
-xnsticks_t cobalt_ticks_to_ns_rounded(xnsticks_t ticks)
+xnsticks_t __cobalt_tsc_to_ns_rounded(xnsticks_t ticks)
 {
 	unsigned int shift = tsc_shift - 1;
 	return (xnarch_llmulshft(ticks, tsc_scale, shift) + 1) / 2;
@@ -74,19 +74,19 @@ xnsticks_t cobalt_ticks_to_ns_rounded(xnsticks_t ticks)
 
 #else  /* !XNARCH_HAVE_LLMULSHFT */
 
-xnsticks_t cobalt_ticks_to_ns(xnsticks_t ticks)
+xnsticks_t __cobalt_tsc_to_ns(xnsticks_t ticks)
 {
-	return xnarch_llimd(ticks, 1000000000, clockfreq);
+	return xnarch_llimd(ticks, 1000000000, __cobalt_tsc_clockfreq);
 }
 
-xnsticks_t cobalt_ticks_to_ns_rounded(xnsticks_t ticks)
+xnsticks_t __cobalt_tsc_to_ns_rounded(xnsticks_t ticks)
 {
-	return (xnarch_llimd(ticks, 1000000000, clockfreq/2) + 1) / 2;
+	return (xnarch_llimd(ticks, 1000000000, __cobalt_tsc_clockfreq/2) + 1) / 2;
 }
 
-xnsticks_t cobalt_ns_to_ticks(xnsticks_t ns)
+xnsticks_t __cobalt_ns_to_tsc(xnsticks_t ns)
 {
-	return xnarch_llimd(ns, clockfreq, 1000000000);
+	return xnarch_llimd(ns, __cobalt_tsc_clockfreq, 1000000000);
 }
 #endif /* !XNARCH_HAVE_LLMULSHFT */
 
@@ -101,12 +101,16 @@ unsigned long long cobalt_divrem_billion(unsigned long long value,
 
 void cobalt_ticks_init(unsigned long long freq)
 {
-	clockfreq = freq;
+	__cobalt_tsc_clockfreq = freq;
 #ifdef XNARCH_HAVE_LLMULSHFT
-	xnarch_init_llmulshft(1000000000, freq, &tsc_scale, &tsc_shift);
+	if (freq) {
+		xnarch_init_llmulshft(1000000000, freq, &tsc_scale, &tsc_shift);
 #ifdef XNARCH_HAVE_NODIV_LLIMD
-	xnarch_init_u32frac(&tsc_frac, 1 << tsc_shift, tsc_scale);
-	xnarch_init_u32frac(&bln_frac, 1, 1000000000);
+		xnarch_init_u32frac(&tsc_frac, 1 << tsc_shift, tsc_scale);
+#endif
+	}
 #endif
+#ifdef XNARCH_HAVE_NODIV_LLIMD
+	xnarch_init_u32frac(&bln_frac, 1, 1000000000);
 #endif
 }
-- 
2.26.2


