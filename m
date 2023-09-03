Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09C3D7B
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:08 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230903150501257aa97a439785006c
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=oTOSSQwJmT/rL9C46UaxAtwEmfj3N4ZoXOShga1kb4I=;
 b=GHQ4YEB1BxkGRvdazzYy5SIzbS5JdztGK9eM+lIWaQh40/eboLelswtDYojAN9H5I9Do5v
 jijg2IpSQZA8TE3VQidKSoIll8e13RtU5cUSself5bI6qM1Ovg6jJZn0PB+0/NQ0GvLvPcqK
 RKHWTIQ23QJyuFRGHC2lNJvgGneyk=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 15/20] lib/cobalt: Refactor cobalt_read_tsc API to cobalt_read_ns
Date: Sun,  3 Sep 2023 17:04:52 +0200
Message-Id: <271a0c3d8fc11baacc934ef526fc1a809ed3404c.1693753497.git.jan.kiszka@siemens.com>
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

As we are now only reading nanoseconds via cobalt_read_tsc, change the
API to make this clear, obsoleting cobalt_ticks_to_ns,
cobalt_ticks_to_ns_rounded and cobalt_ns_to_ticks at the same time.

Existing users are adjusted accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/sys/cobalt.h    |  2 +-
 include/cobalt/ticks.h         | 18 -----------------
 include/copperplate/clockobj.h | 30 +++++++++------------------
 lib/cobalt/internal.c          |  2 +-
 lib/copperplate/clockobj.c     |  4 ++--
 testsuite/smokey/tsc/tsc.c     | 37 +++++++---------------------------
 6 files changed, 21 insertions(+), 72 deletions(-)

diff --git a/include/cobalt/sys/cobalt.h b/include/cobalt/sys/cobalt.h
index 39c9a8493a..ba629cbeba 100644
--- a/include/cobalt/sys/cobalt.h
+++ b/include/cobalt/sys/cobalt.h
@@ -133,7 +133,7 @@ void cobalt_register_tsd_hook(struct cobalt_tsd_hook *th);
 
 void cobalt_assert_nrt(void);
 
-unsigned long long cobalt_read_tsc(void);
+unsigned long long cobalt_read_ns(void);
 
 extern int __cobalt_control_bind;
 
diff --git a/include/cobalt/ticks.h b/include/cobalt/ticks.h
index fe5a6ac21a..d9cde6323d 100644
--- a/include/cobalt/ticks.h
+++ b/include/cobalt/ticks.h
@@ -25,24 +25,6 @@
 extern "C" {
 #endif
 
-static inline
-xnsticks_t cobalt_ns_to_ticks(xnsticks_t ns)
-{
-	return ns;
-}
-
-static inline
-xnsticks_t cobalt_ticks_to_ns(xnsticks_t ticks)
-{
-	return ticks;
-}
-
-static inline
-xnsticks_t cobalt_ticks_to_ns_rounded(xnsticks_t ticks)
-{
-	return ticks;
-}
-
 unsigned long long cobalt_divrem_billion(unsigned long long value,
 					 unsigned long *rem);
 #ifdef __cplusplus
diff --git a/include/copperplate/clockobj.h b/include/copperplate/clockobj.h
index dde18bda87..b29c58bdb7 100644
--- a/include/copperplate/clockobj.h
+++ b/include/copperplate/clockobj.h
@@ -124,17 +124,7 @@ void __clockobj_ticks_to_timespec(struct clockobj *clkobj,
 static inline ticks_t clockobj_get_tsc(void)
 {
 	/* Guaranteed to be the source of CLOCK_COPPERPLATE. */
-	return cobalt_read_tsc();
-}
-
-static inline sticks_t clockobj_ns_to_tsc(sticks_t ns)
-{
-	return cobalt_ns_to_ticks(ns);
-}
-
-static inline sticks_t clockobj_tsc_to_ns(sticks_t tsc)
-{
-	return cobalt_ticks_to_ns(tsc);
+	return cobalt_read_ns();
 }
 
 static inline
@@ -150,6 +140,15 @@ void clockobj_ns_to_timespec(ticks_t ns, struct timespec *ts)
 
 ticks_t clockobj_get_tsc(void);
 
+static inline
+void clockobj_ns_to_timespec(ticks_t ns, struct timespec *ts)
+{
+	ts->tv_sec = ns / 1000000000ULL;
+	ts->tv_nsec = ns - (ts->tv_sec * 1000000000ULL);
+}
+
+#endif /* CONFIG_XENO_MERCURY */
+
 static inline sticks_t clockobj_ns_to_tsc(sticks_t ns)
 {
 	return ns;
@@ -160,15 +159,6 @@ static inline sticks_t clockobj_tsc_to_ns(sticks_t tsc)
 	return tsc;
 }
 
-static inline
-void clockobj_ns_to_timespec(ticks_t ns, struct timespec *ts)
-{
-	ts->tv_sec = ns / 1000000000ULL;
-	ts->tv_nsec = ns - (ts->tv_sec * 1000000000ULL);
-}
-
-#endif /* CONFIG_XENO_MERCURY */
-
 #ifdef CONFIG_XENO_LORES_CLOCK_DISABLED
 
 static inline
diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index 74b5bd8350..b9f518ed16 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -576,7 +576,7 @@ void cobalt_assert_nrt(void)
 		pthread_kill(pthread_self(), SIGDEBUG);
 }
 
-unsigned long long cobalt_read_tsc(void)
+unsigned long long cobalt_read_ns(void)
 {
 	struct timespec ts;
 
diff --git a/lib/copperplate/clockobj.c b/lib/copperplate/clockobj.c
index b57bb46e7a..a9a8f8a25a 100644
--- a/lib/copperplate/clockobj.c
+++ b/lib/copperplate/clockobj.c
@@ -237,7 +237,7 @@ int clockobj_set_resolution(struct clockobj *clkobj, unsigned int resolution_ns)
 
 ticks_t clockobj_get_time(struct clockobj *clkobj)
 {
-	ticks_t ns = cobalt_ticks_to_ns_rounded(cobalt_read_tsc());
+	ticks_t ns = cobalt_read_ns();
 	return clockobj_ns_to_ticks(clkobj, ns);
 }
 
@@ -257,7 +257,7 @@ void clockobj_get_date(struct clockobj *clkobj, ticks_t *pticks)
 
 	read_lock_nocancel(&clkobj->lock);
 
-	ns = cobalt_ticks_to_ns(clockobj_get_tsc());
+	ns = clockobj_get_tsc();
 	/* Add offset to epoch. */
 	ns += (ticks_t)clkobj->offset.tv_sec * 1000000000ULL;
 	ns += clkobj->offset.tv_nsec;
diff --git a/testsuite/smokey/tsc/tsc.c b/testsuite/smokey/tsc/tsc.c
index f9ae82fec3..5cc6749761 100644
--- a/testsuite/smokey/tsc/tsc.c
+++ b/testsuite/smokey/tsc/tsc.c
@@ -49,30 +49,9 @@ smokey_test_plugin(tsc,
 		"Check that emulated tsc is monotonic"
 );
 
-
-static inline unsigned long long timer_get_tsc(void)
-{
-	/*
-	 * The additional function call clockobj_get_tsc() makes a big
-	 * difference on low end
-	 */
-	return cobalt_read_tsc();
-}
-
-static inline unsigned long long timer_tsc2ns(unsigned long long tsc)
-{
-	return clockobj_tsc_to_ns(tsc);
-}
-
-static inline unsigned long long timer_ns2tsc(unsigned long long ns)
-{
-	return clockobj_ns_to_tsc(ns);
-}
-
 static int run_tsc(struct smokey_test *t, int argc, char *const argv[])
 {
 	unsigned long long runtime, start, jump, tsc1, tsc2;
-	unsigned long long one_sec_tsc;
 	unsigned long long sum, g_sum;
 	unsigned long long loops, g_loops;
 	unsigned dt, min, max, g_min, g_max;
@@ -102,10 +81,8 @@ static int run_tsc(struct smokey_test *t, int argc, char *const argv[])
 
 	smokey_parse_args(t, argc, argv);
 
-	one_sec_tsc = timer_ns2tsc(ONE_BILLION);
-
-	runtime = timer_get_tsc();
-	margin = timer_tsc2ns(2000);
+	runtime = cobalt_read_ns();
+	margin = 2000;
 	if (margin < 80)
 		margin = 80;
 
@@ -123,15 +100,15 @@ static int run_tsc(struct smokey_test *t, int argc, char *const argv[])
 		max = 0;
 		sum = 0;
 		loops = 0;
-		tsc2 = start = timer_get_tsc();
+		tsc2 = start = cobalt_read_ns();
 		do {
-			tsc1 = timer_get_tsc();
+			tsc1 = cobalt_read_ns();
 			if (tsc1 < tsc2) {
 				fprintf(stderr, "%016Lx -> %016Lx\n",
 					tsc2, tsc1);
 				goto err1;
 			}
-			tsc2 = timer_get_tsc();
+			tsc2 = cobalt_read_ns();
 			if (tsc2 < tsc1) {
 				fprintf(stderr, "%016Lx -> %016Lx\n",
 					tsc1, tsc2);
@@ -149,7 +126,7 @@ static int run_tsc(struct smokey_test *t, int argc, char *const argv[])
 				max = dt;
 			sum += dt;
 			++loops;
-		} while (tsc2 - start < one_sec_tsc);
+		} while (tsc2 - start < ONE_BILLION);
 
 		smokey_trace("min: %u, max: %u, avg: %g",
 			min, max, (double)sum / loops);
@@ -164,7 +141,7 @@ static int run_tsc(struct smokey_test *t, int argc, char *const argv[])
 
 	smokey_trace("min: %u, max: %u, avg: %g -> %g us",
 		g_min, g_max, (double)g_sum / g_loops,
-		(double)timer_tsc2ns(g_sum) / (1000 * g_loops));
+		(double)g_sum / (1000 * g_loops));
 
 	return EXIT_SUCCESS;
 
-- 
2.35.3

