From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 14/17] cobalt/clock: dovetail: abstract interface to hardware
 TSC
Date: Fri, 11 Jun 2021 20:05:40 +0200
Message-Id: <dbda3c2c6e4b4eca052bb0cbbd059ead174f33cc.1623434743.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623434743.git.jan.kiszka@siemens.com>
References: <cover.1623434743.git.jan.kiszka@siemens.com>
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

Unlike the I-pipe, Dovetail does not need to expose the underlying
timestamp counter to applications. The best equivalent to this counter
would be the common monotonic clock, expressing time as a count of
nanoseconds.

Fork the implementation accordingly between Dovetail and I-pipe
configurations, depending on which pipeline flavour was detected at
init.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/sys/cobalt.h                    |  2 ++
 include/copperplate/clockobj.h                 | 12 ++++++++++--
 lib/cobalt/arch/arm/include/asm/xenomai/tsc.h  |  2 +-
 .../arch/arm64/include/asm/xenomai/tsc.h       |  2 +-
 .../arch/powerpc/include/asm/xenomai/tsc.h     |  2 +-
 lib/cobalt/arch/x86/include/asm/xenomai/tsc.h  |  2 +-
 lib/cobalt/clock.c                             |  6 +++---
 lib/cobalt/internal.c                          | 18 ++++++++++++++++--
 lib/copperplate/clockobj.c                     | 12 +-----------
 testsuite/smokey/tsc/tsc.c                     |  2 +-
 10 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/include/cobalt/sys/cobalt.h b/include/cobalt/sys/cobalt.h
index 1687e2be2..46096e880 100644
--- a/include/cobalt/sys/cobalt.h
+++ b/include/cobalt/sys/cobalt.h
@@ -134,6 +134,8 @@ void cobalt_register_tsd_hook(struct cobalt_tsd_hook *th);
 
 void cobalt_assert_nrt(void);
 
+unsigned long long cobalt_read_tsc(void);
+
 extern int __cobalt_control_bind;
 
 #ifdef __cplusplus
diff --git a/include/copperplate/clockobj.h b/include/copperplate/clockobj.h
index 24c748557..58ec56652 100644
--- a/include/copperplate/clockobj.h
+++ b/include/copperplate/clockobj.h
@@ -70,8 +70,6 @@ void clockobj_get_distance(struct clockobj *clkobj,
 			   const struct itimerspec *itm,
 			   struct timespec *delta);
 
-ticks_t clockobj_get_tsc(void);
-
 void clockobj_caltime_to_timeout(struct clockobj *clkobj, const struct tm *tm,
 				 unsigned long rticks, struct timespec *ts);
 
@@ -112,6 +110,7 @@ void __clockobj_ticks_to_timespec(struct clockobj *clkobj,
 #ifdef CONFIG_XENO_COBALT
 
 #include <cobalt/ticks.h>
+#include <cobalt/sys/cobalt.h>
 
 /*
  * The Cobalt core exclusively deals with aperiodic timings, so a
@@ -121,6 +120,13 @@ void __clockobj_ticks_to_timespec(struct clockobj *clkobj,
  * equivalent to Copperplate TSC units, and Copperplate ticks are
  * periods of the reference clockobj which Cobalt does not know about.
  */
+
+static inline ticks_t clockobj_get_tsc(void)
+{
+	/* Guaranteed to be the source of CLOCK_COPPERPLATE. */
+	return cobalt_read_tsc();
+}
+
 static inline sticks_t clockobj_ns_to_tsc(sticks_t ns)
 {
 	return cobalt_ns_to_ticks(ns);
@@ -142,6 +148,8 @@ void clockobj_ns_to_timespec(ticks_t ns, struct timespec *ts)
 
 #else /* CONFIG_XENO_MERCURY */
 
+ticks_t clockobj_get_tsc(void);
+
 static inline sticks_t clockobj_ns_to_tsc(sticks_t ns)
 {
 	return ns;
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/tsc.h b/lib/cobalt/arch/arm/include/asm/xenomai/tsc.h
index 594c4adac..2be4009d8 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/tsc.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/tsc.h
@@ -40,7 +40,7 @@ struct __xn_full_tscinfo {
 extern struct __xn_full_tscinfo __xn_tscinfo;
 
 static inline __attribute__((always_inline))
-unsigned long long cobalt_read_tsc(void)
+unsigned long long cobalt_read_legacy_tsc(void)
 {
 	return __xn_tscinfo.kuser_tsc_get(__xn_tscinfo.kinfo.counter);
 }
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/tsc.h b/lib/cobalt/arch/arm64/include/asm/xenomai/tsc.h
index b145403c8..e664adb07 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/tsc.h
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/tsc.h
@@ -46,7 +46,7 @@ static inline uint64_t get_counter(void)
 }
 
 static inline __attribute__((always_inline))
-unsigned long long cobalt_read_tsc(void)
+unsigned long long cobalt_read_legacy_tsc(void)
 {
 	return get_counter();
 }
diff --git a/lib/cobalt/arch/powerpc/include/asm/xenomai/tsc.h b/lib/cobalt/arch/powerpc/include/asm/xenomai/tsc.h
index f6fc24af0..b4ff85218 100644
--- a/lib/cobalt/arch/powerpc/include/asm/xenomai/tsc.h
+++ b/lib/cobalt/arch/powerpc/include/asm/xenomai/tsc.h
@@ -18,7 +18,7 @@
 #ifndef _LIB_COBALT_POWERPC_TSC_H
 #define _LIB_COBALT_POWERPC_TSC_H
 
-static inline unsigned long long cobalt_read_tsc(void)
+static inline unsigned long long cobalt_read_legacy_tsc(void)
 {
 	union {
 		unsigned long long t;
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/tsc.h b/lib/cobalt/arch/x86/include/asm/xenomai/tsc.h
index 6f3f5c45a..bf400e850 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/tsc.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/tsc.h
@@ -19,7 +19,7 @@
 #ifndef _LIB_COBALT_X86_TSC_H
 #define _LIB_COBALT_X86_TSC_H
 
-static inline unsigned long long cobalt_read_tsc(void)
+static inline unsigned long long cobalt_read_legacy_tsc(void)
 {
 #ifdef __i386__
 	unsigned long long t;
diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index cacc19186..490426499 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -136,7 +136,7 @@ static int __do_clock_host_realtime(struct timespec *ts)
 	 * mechanism in the kernel.
 	 */
 	unsynced_read_block(&tmp, &hostrt_data->lock) {
-		now = cobalt_read_tsc();
+		now = cobalt_read_legacy_tsc();
 		base = hostrt_data->cycle_last;
 		mask = hostrt_data->mask;
 		mult = hostrt_data->mult;
@@ -175,12 +175,12 @@ static int gettime_via_tsc(clockid_t clock_id, struct timespec *tp)
 		break;
 	case CLOCK_MONOTONIC:
 	case CLOCK_MONOTONIC_RAW:
-		ns = cobalt_ticks_to_ns(cobalt_read_tsc());
+		ns = cobalt_ticks_to_ns(cobalt_read_legacy_tsc());
 		tp->tv_sec = cobalt_divrem_billion(ns, &rem);
 		tp->tv_nsec = rem;
 		return 0;
 	case CLOCK_REALTIME:
-		ns = cobalt_ticks_to_ns(cobalt_read_tsc());
+		ns = cobalt_ticks_to_ns(cobalt_read_legacy_tsc());
 		ns += cobalt_vdso->wallclock_offset;
 		tp->tv_sec = cobalt_divrem_billion(ns, &rem);
 		tp->tv_nsec = rem;
diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index 303d86f99..42b60c35b 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -31,6 +31,8 @@
 #include <stdarg.h>
 #include <pthread.h>
 #include <asm/xenomai/syscall.h>
+#include <asm/xenomai/tsc.h>
+#include <cobalt/ticks.h>
 #include <cobalt/sys/cobalt.h>
 #include "internal.h"
 
@@ -553,7 +555,7 @@ int cobalt_xlate_schedparam(int policy,
 
 	if (priority < 0)
 		priority = -priority;
-	
+
 	memset(param, 0, sizeof(*param));
 	param->sched_priority = priority;
 
@@ -566,6 +568,18 @@ void cobalt_assert_nrt(void)
 		pthread_kill(pthread_self(), SIGDEBUG);
 }
 
+unsigned long long cobalt_read_tsc(void)
+{
+	struct timespec ts;
+
+	if (cobalt_use_legacy_tsc())
+		return cobalt_read_legacy_tsc();
+
+	__cobalt_vdso_gettime(CLOCK_MONOTONIC, &ts);
+
+	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+}
+
 unsigned int cobalt_features;
 
 void cobalt_features_init(struct cobalt_featinfo *f)
@@ -574,4 +588,4 @@ void cobalt_features_init(struct cobalt_featinfo *f)
 
 	/* Trigger arch specific feature initialization */
 	cobalt_arch_check_features(f);
-}
\ No newline at end of file
+}
diff --git a/lib/copperplate/clockobj.c b/lib/copperplate/clockobj.c
index 43928d753..b57bb46e7 100644
--- a/lib/copperplate/clockobj.c
+++ b/lib/copperplate/clockobj.c
@@ -229,22 +229,12 @@ int clockobj_set_resolution(struct clockobj *clkobj, unsigned int resolution_ns)
 #ifdef CONFIG_XENO_COBALT
 
 #include <cobalt/arith.h>
-#include <asm/xenomai/tsc.h>
+#include <cobalt/sys/cobalt.h>
 
 #ifdef CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED
 #error "restricted CLOCK_COPPERPLATE not available"
 #endif
 
-/*
- * NOTE: we can't inline this routine, as we don't want to expose
- * lib/cobalt/arch/.../include/asm/xenomai/tsc.h.
- */
-ticks_t clockobj_get_tsc(void)
-{
-	/* Guaranteed to be the source of CLOCK_COPPERPLATE. */
-	return cobalt_read_tsc();
-}
-
 ticks_t clockobj_get_time(struct clockobj *clkobj)
 {
 	ticks_t ns = cobalt_ticks_to_ns_rounded(cobalt_read_tsc());
diff --git a/testsuite/smokey/tsc/tsc.c b/testsuite/smokey/tsc/tsc.c
index 2865e338b..f9ae82fec 100644
--- a/testsuite/smokey/tsc/tsc.c
+++ b/testsuite/smokey/tsc/tsc.c
@@ -30,7 +30,7 @@
 
 #include <smokey/smokey.h>
 
-#include <asm/xenomai/tsc.h>
+#include <cobalt/sys/cobalt.h>
 
 #define DURATION 10000000
 
-- 
2.26.2


