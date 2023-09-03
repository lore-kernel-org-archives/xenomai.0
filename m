Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B63D6E
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:08 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20230903150500bb67704665edd59b9a
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yqh+1w8ns1i30V0e2vFXya7NgyUoO5T+8RdJtwKk5d0=;
 b=BSi8PXmsAJwr+q1U2pXsEoGi6ml8ZixSJlaVYTEyHRKZl27oQE5kmTphHjBRC0TwB31TuG
 DQ87eCJCml9SEJiAyaQL00Dli5Dvhyq5bJ+IrmA0SYCPB81Tr7K8YdymYE36Ls7EaJDjcdhC
 c/ZAzhONwkVFubp9ohBSsjsqs9ayo=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 07/20] lib/cobalt: Drop legacy_tsc code for I-pipe
Date: Sun,  3 Sep 2023 17:04:44 +0200
Message-Id: <4a52c4e3c28fe29d822d97806d293e4b347e2bbf.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

With I-pipe support removed, cobalt_use_legacy_tsc is now always false
because the kernel will report 0 as clock_freq. Drop code that was
guarded by this runtime check. This obsoletes XNARCH_HAVE_LLMULSHFT.
Furthermoe fold gettime_via_vdso directly into clock_gettime as the only
possible case now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/ticks.h                        |  31 -----
 .../arm/include/asm/xenomai/uapi/features.h   |   1 -
 .../arm64/include/asm/xenomai/uapi/features.h |   2 -
 .../x86/include/asm/xenomai/uapi/features.h   |   1 -
 lib/cobalt/arch/arm/features.c                |  46 -------
 lib/cobalt/arch/arm64/features.c              |  42 ------
 lib/cobalt/clock.c                            | 124 +++---------------
 lib/cobalt/init.c                             |   2 +-
 lib/cobalt/internal.c                         |   4 -
 lib/cobalt/internal.h                         |   2 +-
 lib/cobalt/ticks.c                            |  70 +---------
 11 files changed, 28 insertions(+), 297 deletions(-)

diff --git a/include/cobalt/ticks.h b/include/cobalt/ticks.h
index e59d86d499..fe5a6ac21a 100644
--- a/include/cobalt/ticks.h
+++ b/include/cobalt/ticks.h
@@ -21,56 +21,25 @@
 #include <stdbool.h>
 #include <cobalt/uapi/kernel/types.h>
 
-/*
- * Depending on the underlying pipeline support, we may represent time
- * stamps as count of nanoseconds (Dovetail), or as values of the
- * hardware tick counter (aka TSC) available with the platform
- * (I-pipe). In the latter - legacy - case, we need to convert from
- * TSC values to nanoseconds and conversely via scaled maths. This
- * indirection will go away once support for the I-pipe is removed.
- */
-
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-extern unsigned long long __cobalt_tsc_clockfreq;
-
-static inline bool cobalt_use_legacy_tsc(void)
-{
-	return !!__cobalt_tsc_clockfreq;
-}
-
-xnsticks_t __cobalt_tsc_to_ns(xnsticks_t ticks);
-
-xnsticks_t __cobalt_tsc_to_ns_rounded(xnsticks_t ticks);
-
-xnsticks_t __cobalt_ns_to_tsc(xnsticks_t ns);
-
 static inline
 xnsticks_t cobalt_ns_to_ticks(xnsticks_t ns)
 {
-	if (cobalt_use_legacy_tsc())
-		return __cobalt_ns_to_tsc(ns);
-
 	return ns;
 }
 
 static inline
 xnsticks_t cobalt_ticks_to_ns(xnsticks_t ticks)
 {
-	if (cobalt_use_legacy_tsc())
-		return __cobalt_tsc_to_ns(ticks);
-
 	return ticks;
 }
 
 static inline
 xnsticks_t cobalt_ticks_to_ns_rounded(xnsticks_t ticks)
 {
-	if (cobalt_use_legacy_tsc())
-		return __cobalt_tsc_to_ns_rounded(ticks);
-
 	return ticks;
 }
 
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
index fdd5c0e327..4a87c67329 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
@@ -28,7 +28,6 @@
 
 #define XENOMAI_FEAT_MAN (__xn_feat_generic_man_mask)
 
-#define XNARCH_HAVE_LLMULSHFT    1
 #define XNARCH_HAVE_NODIV_LLIMD  1
 
 struct cobalt_featinfo_archdep { /* no arch-specific feature */ };
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
index 301797748c..fba1db391b 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
@@ -28,8 +28,6 @@
 
 #define XENOMAI_FEAT_MAN (__xn_feat_generic_man_mask)
 
-#undef XNARCH_HAVE_LLMULSHFT
-
 #undef XNARCH_HAVE_NODIV_LLIMD
 
 struct cobalt_featinfo_archdep { /* no arch-specific feature */ };
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
index 045adf0c1c..554dc249cb 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
@@ -25,7 +25,6 @@
 
 #define XENOMAI_FEAT_MAN  __xn_feat_generic_man_mask
 
-#define XNARCH_HAVE_LLMULSHFT    1
 #define XNARCH_HAVE_NODIV_LLIMD  1
 
 struct cobalt_featinfo_archdep { /* no arch-specific feature */ };
diff --git a/lib/cobalt/arch/arm/features.c b/lib/cobalt/arch/arm/features.c
index b4eddaad46..c918861025 100644
--- a/lib/cobalt/arch/arm/features.c
+++ b/lib/cobalt/arch/arm/features.c
@@ -27,58 +27,12 @@
 #include <cobalt/wrappers.h>
 #include <cobalt/ticks.h>
 #include <asm/xenomai/syscall.h>
-#include <asm/xenomai/tsc.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/uapi/fptest.h>
 #include "internal.h"
 
-struct __xn_full_tscinfo __xn_tscinfo = {
-	.kinfo = {
-		.counter = NULL,
-	},
-};
-
 void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
 {
-	unsigned long phys_addr;
-	unsigned page_size;
-	int err, fd;
-	void *addr;
-
-	if (!cobalt_use_legacy_tsc())
-		return;
-
-	if (__xn_tscinfo.kinfo.counter != NULL)
-		return;
-
-	err = XENOMAI_SYSCALL2(sc_cobalt_archcall,
-			       XENOMAI_SYSARCH_TSCINFO, &__xn_tscinfo.kinfo);
-	if (err)
-		early_panic("missing TSC emulation: %s",
-			     strerror(-err));
-
-	fd = __STD(open("/dev/mem", O_RDONLY | O_SYNC));
-	if (fd == -1)
-		early_panic("failed open(/dev/mem): %s", strerror(errno));
-
-	page_size = sysconf(_SC_PAGESIZE);
-
-	__xn_tscinfo.kuser_tsc_get =
-		(__xn_rdtsc_t *)(0xffff1004 -
-				((*(unsigned *)(0xffff0ffc) + 3) << 5));
-
-	phys_addr = (unsigned long)__xn_tscinfo.kinfo.counter;
-
-	addr = __STD(mmap(NULL, page_size, PROT_READ, MAP_SHARED,
-			  fd, phys_addr & ~(page_size - 1)));
-	if (addr == MAP_FAILED)
-		early_panic("failed mmap(/dev/mem): %s", strerror(errno));
-
-	__xn_tscinfo.kinfo.counter =
-		((volatile unsigned *)
-		 ((char *) addr + (phys_addr & (page_size - 1))));
-
-	__STD(close(fd));
 }
 
 int cobalt_fp_detect(void)
diff --git a/lib/cobalt/arch/arm64/features.c b/lib/cobalt/arch/arm64/features.c
index 5baabfb69d..044c95db30 100644
--- a/lib/cobalt/arch/arm64/features.c
+++ b/lib/cobalt/arch/arm64/features.c
@@ -27,54 +27,12 @@
 #include <cobalt/wrappers.h>
 #include <cobalt/ticks.h>
 #include <asm/xenomai/syscall.h>
-#include <asm/xenomai/tsc.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/uapi/fptest.h>
 #include "internal.h"
 
-struct __xn_full_tscinfo __xn_tscinfo = {
-	.kinfo = {
-		.counter = NULL,
-	},
-};
-
 void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
 {
-	unsigned long phys_addr;
-	unsigned page_size;
-	int err, fd;
-	void *addr;
-
-	if (!cobalt_use_legacy_tsc())
-		return;
-
-	if (__xn_tscinfo.kinfo.counter != NULL)
-		return;
-
-	err = XENOMAI_SYSCALL2(sc_cobalt_archcall,
-			       XENOMAI_SYSARCH_TSCINFO, &__xn_tscinfo.kinfo);
-	if (err)
-		early_panic("missing TSC emulation: %s",
-			     strerror(-err));
-
-	fd = __STD(open("/dev/mem", O_RDONLY | O_SYNC));
-	if (fd == -1)
-		early_panic("failed open(/dev/mem): %s", strerror(errno));
-
-	page_size = sysconf(_SC_PAGESIZE);
-
-	phys_addr = (unsigned long)__xn_tscinfo.kinfo.counter;
-
-	addr = __STD(mmap(NULL, page_size, PROT_READ, MAP_SHARED,
-			  fd, phys_addr & ~(page_size - 1)));
-	if (addr == MAP_FAILED)
-		early_panic("failed mmap(/dev/mem): %s", strerror(errno));
-
-	__xn_tscinfo.kinfo.counter =
-		((volatile unsigned *)
-		 ((char *) addr + (phys_addr & (page_size - 1))));
-
-	__STD(close(fd));
 }
 
 int cobalt_fp_detect(void)
diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index dbfcd4d76d..377582cf37 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -29,7 +29,6 @@
 #include <cobalt/uapi/time.h>
 #include <cobalt/ticks.h>
 #include <asm/xenomai/syscall.h>
-#include <asm/xenomai/tsc.h>
 #include "umm.h"
 #include "internal.h"
 
@@ -115,45 +114,6 @@ COBALT_IMPL(int, clock_getres, (clockid_t clock_id, struct timespec *tp))
 	return 0;
 }
 
-static int __do_clock_host_realtime(struct timespec *ts)
-{
-	uint64_t now, base, mask, cycle_delta, nsec;
-	struct xnvdso_hostrt_data *hostrt_data;
-	uint32_t mult, shift;
-	unsigned long rem;
-	urwstate_t tmp;
-
-	if (!xnvdso_test_feature(cobalt_vdso, XNVDSO_FEAT_HOST_REALTIME))
-		return -1;
-
-	hostrt_data = &cobalt_vdso->hostrt_data;
-
-	if (!hostrt_data->live)
-		return -1;
-
-	/*
-	 * The following is essentially a verbatim copy of the
-	 * mechanism in the kernel.
-	 */
-	unsynced_read_block(&tmp, &hostrt_data->lock) {
-		now = cobalt_read_legacy_tsc();
-		base = hostrt_data->cycle_last;
-		mask = hostrt_data->mask;
-		mult = hostrt_data->mult;
-		shift = hostrt_data->shift;
-		ts->tv_sec = hostrt_data->wall_sec;
-		nsec = hostrt_data->wall_nsec;
-	}
-
-	cycle_delta = (now - base) & mask;
-	nsec += (cycle_delta * mult) >> shift;
-
-	ts->tv_sec += cobalt_divrem_billion(nsec, &rem);
-	ts->tv_nsec = rem;
-
-	return 0;
-}
-
 static int __do_clock_gettime(clockid_t clock_id, struct timespec *tp)
 {
 #ifdef __USE_TIME_BITS64
@@ -163,65 +123,6 @@ static int __do_clock_gettime(clockid_t clock_id, struct timespec *tp)
 #endif
 }
 
-static int gettime_via_tsc(clockid_t clock_id, struct timespec *tp)
-{
-	unsigned long rem;
-	xnticks_t ns;
-	int ret;
-
-	switch (clock_id) {
-	case CLOCK_HOST_REALTIME:
-		ret = __do_clock_host_realtime(tp);
-		break;
-	case CLOCK_MONOTONIC:
-	case CLOCK_MONOTONIC_RAW:
-		ns = cobalt_ticks_to_ns(cobalt_read_legacy_tsc());
-		tp->tv_sec = cobalt_divrem_billion(ns, &rem);
-		tp->tv_nsec = rem;
-		return 0;
-	case CLOCK_REALTIME:
-		ns = cobalt_ticks_to_ns(cobalt_read_legacy_tsc());
-		ns += cobalt_vdso->wallclock_offset;
-		tp->tv_sec = cobalt_divrem_billion(ns, &rem);
-		tp->tv_nsec = rem;
-		return 0;
-	default:
-		ret = __do_clock_gettime(clock_id, tp);
-	}
-
-	if (ret) {
-		errno = ret;
-		return -1;
-	}
-
-	return 0;
-}
-
-static int gettime_via_vdso(clockid_t clock_id, struct timespec *tp)
-{
-	int ret;
-
-	switch (clock_id) {
-	case CLOCK_REALTIME:
-	case CLOCK_HOST_REALTIME:
-		ret = __cobalt_vdso_gettime(CLOCK_REALTIME, tp);
-		break;
-	case CLOCK_MONOTONIC:
-	case CLOCK_MONOTONIC_RAW:
-		ret = __cobalt_vdso_gettime(clock_id, tp);
-		break;
-	default:
-		ret = __do_clock_gettime(clock_id, tp);
-	}
-
-	if (ret) {
-		errno = ret;
-		return -1;
-	}
-
-	return 0;
-}
-
 /**
  * Read the specified clock.
  *
@@ -253,10 +154,27 @@ static int gettime_via_vdso(clockid_t clock_id, struct timespec *tp)
  */
 COBALT_IMPL(int, clock_gettime, (clockid_t clock_id, struct timespec *tp))
 {
-	if (cobalt_use_legacy_tsc())
-		return gettime_via_tsc(clock_id, tp);
+	int ret;
 
-	return gettime_via_vdso(clock_id, tp);
+	switch (clock_id) {
+	case CLOCK_REALTIME:
+	case CLOCK_HOST_REALTIME:
+		ret = __cobalt_vdso_gettime(CLOCK_REALTIME, tp);
+		break;
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+		ret = __cobalt_vdso_gettime(clock_id, tp);
+		break;
+	default:
+		ret = __do_clock_gettime(clock_id, tp);
+	}
+
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+
+	return 0;
 }
 
 /**
@@ -287,7 +205,7 @@ COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct timespec *tp))
 {
 	int ret;
 
-	if (clock_id == CLOCK_REALTIME && !cobalt_use_legacy_tsc())
+	if (clock_id == CLOCK_REALTIME)
 		return __STD(clock_settime(CLOCK_REALTIME, tp));
 
 #ifdef __USE_TIME_BITS64
diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index dcd63cad8e..58051a2f26 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -177,7 +177,7 @@ static void low_init(void)
 		early_panic("mlockall: %s", strerror(errno));
 
 	trace_me("memory locked");
-	cobalt_ticks_init(f->clock_freq);
+	cobalt_ticks_init();
 	cobalt_features_init(f);
 	cobalt_init_umm(f->vdso_offset);
 	trace_me("memory heaps mapped");
diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index bf1e940b71..74b5bd8350 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -31,7 +31,6 @@
 #include <stdarg.h>
 #include <pthread.h>
 #include <asm/xenomai/syscall.h>
-#include <asm/xenomai/tsc.h>
 #include <cobalt/ticks.h>
 #include <cobalt/sys/cobalt.h>
 #include "internal.h"
@@ -581,9 +580,6 @@ unsigned long long cobalt_read_tsc(void)
 {
 	struct timespec ts;
 
-	if (cobalt_use_legacy_tsc())
-		return cobalt_read_legacy_tsc();
-
 	__cobalt_vdso_gettime(CLOCK_MONOTONIC, &ts);
 
 	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index 00f51fa23d..049ab3fc4d 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -82,7 +82,7 @@ void cobalt_print_init(void);
 
 void cobalt_print_init_atfork(void);
 
-void cobalt_ticks_init(unsigned long long freq);
+void cobalt_ticks_init(void);
 
 void cobalt_mutex_init(void);
 
diff --git a/lib/cobalt/ticks.c b/lib/cobalt/ticks.c
index 94e0c1b0d3..a6792389c8 100644
--- a/lib/cobalt/ticks.c
+++ b/lib/cobalt/ticks.c
@@ -17,12 +17,9 @@
  */
 #include <cobalt/arith.h>
 #include <cobalt/ticks.h>
-#include <asm/xenomai/tsc.h>
 #include <asm/xenomai/time.h>
 #include "internal.h"
 
-unsigned long long __cobalt_tsc_clockfreq;
-
 /*
  * If we have no fast path via the vDSO for reading timestamps, ask
  * the Cobalt core.
@@ -35,13 +32,8 @@ static int gettime_fallback(clockid_t clk_id, struct timespec *tp)
 int (*__cobalt_vdso_gettime)(clockid_t clk_id,
 			struct timespec *tp) = gettime_fallback;
 
-#ifdef XNARCH_HAVE_LLMULSHFT
-
-static unsigned int tsc_scale, tsc_shift;
-
 #ifdef XNARCH_HAVE_NODIV_LLIMD
 
-static struct xnarch_u32frac tsc_frac;
 static struct xnarch_u32frac bln_frac;
 
 unsigned long long cobalt_divrem_billion(unsigned long long value,
@@ -60,50 +52,8 @@ unsigned long long cobalt_divrem_billion(unsigned long long value,
 	return q;
 }
 
-xnsticks_t __cobalt_ns_to_tsc(xnsticks_t ns)
-{
-	return xnarch_nodiv_llimd(ns, tsc_frac.frac, tsc_frac.integ);
-}
-
 #else /* !XNARCH_HAVE_NODIV_LLIMD */
 
-xnsticks_t __cobalt_ns_to_tsc(xnsticks_t ns)
-{
-	return xnarch_llimd(ns, 1 << tsc_shift, tsc_scale);
-}
-
-#endif /* !XNARCH_HAVE_NODIV_LLIMD */
-
-xnsticks_t __cobalt_tsc_to_ns(xnsticks_t ticks)
-{
-	return xnarch_llmulshft(ticks, tsc_scale, tsc_shift);
-}
-
-xnsticks_t __cobalt_tsc_to_ns_rounded(xnsticks_t ticks)
-{
-	unsigned int shift = tsc_shift - 1;
-	return (xnarch_llmulshft(ticks, tsc_scale, shift) + 1) / 2;
-}
-
-#else  /* !XNARCH_HAVE_LLMULSHFT */
-
-xnsticks_t __cobalt_tsc_to_ns(xnsticks_t ticks)
-{
-	return xnarch_llimd(ticks, 1000000000, __cobalt_tsc_clockfreq);
-}
-
-xnsticks_t __cobalt_tsc_to_ns_rounded(xnsticks_t ticks)
-{
-	return (xnarch_llimd(ticks, 1000000000, __cobalt_tsc_clockfreq/2) + 1) / 2;
-}
-
-xnsticks_t __cobalt_ns_to_tsc(xnsticks_t ns)
-{
-	return xnarch_llimd(ns, __cobalt_tsc_clockfreq, 1000000000);
-}
-#endif /* !XNARCH_HAVE_LLMULSHFT */
-
-#ifndef XNARCH_HAVE_NODIV_LLIMD
 unsigned long long cobalt_divrem_billion(unsigned long long value,
 					 unsigned long *rem)
 {
@@ -112,22 +62,12 @@ unsigned long long cobalt_divrem_billion(unsigned long long value,
 }
 #endif /* !XNARCH_HAVE_NODIV_LLIMD */
 
-void cobalt_ticks_init(unsigned long long freq)
+void cobalt_ticks_init(void)
 {
-	__cobalt_tsc_clockfreq = freq;
-	if (freq) {
-#ifdef XNARCH_HAVE_LLMULSHFT
-		xnarch_init_llmulshft(1000000000, freq, &tsc_scale, &tsc_shift);
-#ifdef XNARCH_HAVE_NODIV_LLIMD
-		xnarch_init_u32frac(&tsc_frac, 1 << tsc_shift, tsc_scale);
-#endif
-#endif
-	} else {
-		void *vcall = cobalt_lookup_vdso(COBALT_VDSO_VERSION,
-						 COBALT_VDSO_GETTIME);
-		if (vcall)
-			__cobalt_vdso_gettime = vcall;
-	}
+	void *vcall = cobalt_lookup_vdso(COBALT_VDSO_VERSION,
+					 COBALT_VDSO_GETTIME);
+	if (vcall)
+		__cobalt_vdso_gettime = vcall;
 #ifdef XNARCH_HAVE_NODIV_LLIMD
 	xnarch_init_u32frac(&bln_frac, 1, 1000000000);
 #endif
-- 
2.35.3

