Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D073FFA
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:09 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202309031505017ef2769e27205d871b
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zg5E8Mje0AjlX1OJpO7j7+gJQcPJ3wEZb/bedaUfCFg=;
 b=RvXhiGWJrhlMOl1vjXtaFKf7YQ4tD6mCtFsYuJt/z5+SGCQuehnkaQoxN4ZSO13rFxRMd/
 BUaPV0bRMN10B9q8sznFgjCLMd9bErKe+QY0aRndmSP6ogISksN8hcnJTo4Z05LYXs2oLTOj
 tHfCyjR4QNc20KiDBX3PmD03opRjo=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 16/20] lib/copperplate: Refactor clockobj_get_tsc API to clockobj_get_ns
Date: Sun,  3 Sep 2023 17:04:53 +0200
Message-Id: <5b83978ba61d186058832f7b8ddddd614d5f990d.1693753497.git.jan.kiszka@siemens.com>
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

As we are now only reading nanoseconds via clockobj_get_tsc, change the
API to make this clear, obsoleting clockobj_tsc_to_ns and
clockobj_ns_to_tsc at the same time.

Existing users are adjusted accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/copperplate/clockobj.h           | 23 ++++--------
 lib/copperplate/clockobj.c               |  6 ++--
 lib/copperplate/threadobj.c              |  4 +--
 lib/psos/tm.c                            |  2 +-
 testsuite/smokey/arith/arith.c           |  6 ++--
 testsuite/smokey/posix-cond/posix-cond.c | 46 ++++++++++--------------
 6 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/include/copperplate/clockobj.h b/include/copperplate/clockobj.h
index b29c58bdb7..c06737e115 100644
--- a/include/copperplate/clockobj.h
+++ b/include/copperplate/clockobj.h
@@ -114,14 +114,13 @@ void __clockobj_ticks_to_timespec(struct clockobj *clkobj,
 
 /*
  * The Cobalt core exclusively deals with aperiodic timings, so a
- * Cobalt _tick_ is actually a _TSC_ unit. In contrast, Copperplate
- * deals with _TSC_ units and periodic _ticks_ which duration depend
- * on the clock resolution. Therefore, Cobalt ticks are strictly
- * equivalent to Copperplate TSC units, and Copperplate ticks are
- * periods of the reference clockobj which Cobalt does not know about.
+ * Cobalt _tick_ is actually a nanosecond unit. In contrast, Copperplate
+ * deals with both nanosecond units and periodic _ticks_ which duration
+ * depend on the clock resolution. Copperplate ticks are periods of the
+ * reference clockobj which Cobalt does not know about.
  */
 
-static inline ticks_t clockobj_get_tsc(void)
+static inline ticks_t clockobj_get_ns(void)
 {
 	/* Guaranteed to be the source of CLOCK_COPPERPLATE. */
 	return cobalt_read_ns();
@@ -138,7 +137,7 @@ void clockobj_ns_to_timespec(ticks_t ns, struct timespec *ts)
 
 #else /* CONFIG_XENO_MERCURY */
 
-ticks_t clockobj_get_tsc(void);
+ticks_t clockobj_get_ns(void);
 
 static inline
 void clockobj_ns_to_timespec(ticks_t ns, struct timespec *ts)
@@ -149,16 +148,6 @@ void clockobj_ns_to_timespec(ticks_t ns, struct timespec *ts)
 
 #endif /* CONFIG_XENO_MERCURY */
 
-static inline sticks_t clockobj_ns_to_tsc(sticks_t ns)
-{
-	return ns;
-}
-
-static inline sticks_t clockobj_tsc_to_ns(sticks_t tsc)
-{
-	return tsc;
-}
-
 #ifdef CONFIG_XENO_LORES_CLOCK_DISABLED
 
 static inline
diff --git a/lib/copperplate/clockobj.c b/lib/copperplate/clockobj.c
index a9a8f8a25a..3a771e474b 100644
--- a/lib/copperplate/clockobj.c
+++ b/lib/copperplate/clockobj.c
@@ -257,7 +257,7 @@ void clockobj_get_date(struct clockobj *clkobj, ticks_t *pticks)
 
 	read_lock_nocancel(&clkobj->lock);
 
-	ns = clockobj_get_tsc();
+	ns = clockobj_get_ns();
 	/* Add offset to epoch. */
 	ns += (ticks_t)clkobj->offset.tv_sec * 1000000000ULL;
 	ns += clkobj->offset.tv_nsec;
@@ -270,7 +270,7 @@ void clockobj_get_date(struct clockobj *clkobj, ticks_t *pticks)
 
 #else /* CONFIG_XENO_MERCURY */
 
-ticks_t clockobj_get_tsc(void)
+ticks_t clockobj_get_ns(void)
 {
 	struct timespec now;
 	clock_gettime(CLOCK_COPPERPLATE, &now);
@@ -279,7 +279,7 @@ ticks_t clockobj_get_tsc(void)
 
 ticks_t clockobj_get_time(struct clockobj *clkobj)
 {
-	ticks_t ns = clockobj_get_tsc();
+	ticks_t ns = clockobj_get_ns();
 
 	if (clockobj_get_resolution(clkobj) > 1)
 		return ns / clockobj_get_resolution(clkobj);
diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index db18f4ffa3..b97807c8a7 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1693,8 +1693,8 @@ void threadobj_spin(ticks_t ns)
 {
 	ticks_t end;
 
-	end = clockobj_get_tsc() + clockobj_ns_to_tsc(ns);
-	while (clockobj_get_tsc() < end)
+	end = clockobj_get_ns() + ns;
+	while (clockobj_get_ns() < end)
 		cpu_relax();
 }
 
diff --git a/lib/psos/tm.c b/lib/psos/tm.c
index c315335236..de7d56d1ed 100644
--- a/lib/psos/tm.c
+++ b/lib/psos/tm.c
@@ -347,6 +347,6 @@ u_long tm_get(u_long *date_r, u_long *time_r, u_long *ticks_r)
 
 u_long tm_getm(unsigned long long *ns_r)
 {
-	*ns_r = clockobj_tsc_to_ns(clockobj_get_tsc());
+	*ns_r = clockobj_get_ns();
 	return SUCCESS;
 }
diff --git a/testsuite/smokey/arith/arith.c b/testsuite/smokey/arith/arith.c
index c927d1d122..edb87229a0 100644
--- a/testsuite/smokey/arith/arith.c
+++ b/testsuite/smokey/arith/arith.c
@@ -20,9 +20,9 @@ static volatile long long arg = 0x3ffffffffffffffULL;
 		  	ticks_t start, end;				\
 			unsigned long delta;				\
 									\
-			start = clockobj_get_tsc();			\
+			start = clockobj_get_ns();			\
 			result = (f);					\
-			end = clockobj_get_tsc();			\
+			end = clockobj_get_ns();			\
 			delta = end - start;				\
 									\
 			if (i == 0 || delta < (avg / i) * 4) {		\
@@ -32,7 +32,7 @@ static volatile long long arg = 0x3ffffffffffffffULL;
 		}							\
 		if (rejected < 10000) {					\
 			avg = xnarch_llimd(avg, 10000, 10000 - rejected); \
-			avg = clockobj_tsc_to_ns(avg) - calib;		\
+			avg -= calib;		\
 			smokey_trace("%s: 0x%016llx: %lld.%03llu ns,"	\
 				    " rejected %d/10000",		\
 				    display, result, avg / 10000,	\
diff --git a/testsuite/smokey/posix-cond/posix-cond.c b/testsuite/smokey/posix-cond/posix-cond.c
index e49c44727e..a664aab1bb 100644
--- a/testsuite/smokey/posix-cond/posix-cond.c
+++ b/testsuite/smokey/posix-cond/posix-cond.c
@@ -33,16 +33,6 @@ static unsigned long long timer_read(void)
 	return (unsigned long long)ts.tv_sec * NS_PER_S + ts.tv_nsec;
 }
 
-static inline unsigned long long timer_get_tsc(void)
-{
-	return clockobj_get_tsc();
-}
-
-static inline unsigned long long timer_tsc2ns(unsigned long long tsc)
-{
-	return clockobj_tsc_to_ns(tsc);
-}
-
 static void check_inner(const char *file, int line, const char *fn, const char *msg, int status, int expected)
 {
 	if (status == expected)
@@ -64,7 +54,7 @@ static void check_inner(const char *file, int line, const char *fn, const char *
 static void check_sleep_inner(const char *fn,
 		       const char *prefix, unsigned long long start)
 {
-	unsigned long long diff = timer_tsc2ns(timer_get_tsc() - start);
+	unsigned long long diff = clockobj_get_ns() - start;
 
 	if (diff < 10 * NS_PER_MS) {
 		fprintf(stderr, "%s waited %Ld.%03u us\n",
@@ -212,7 +202,7 @@ static void *cond_signaler(void *cookie)
 	unsigned long long start;
 	struct cond_mutex *cm = cookie;
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("mutex_lock", mutex_lock(cm->mutex), 0);
 	check_sleep("mutex_lock", start);
 	thread_msleep(10);
@@ -256,7 +246,7 @@ static void autoinit_simple_condwait(void)
 	      thread_spawn(&cond_signaler_tid, 2, cond_signaler, &cm), 0);
 	thread_msleep(11);
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("cond_wait", cond_wait(&cond, &mutex, 0), 0);
 	check_sleep("cond_wait", start);
 	thread_msleep(10);
@@ -287,7 +277,7 @@ static void simple_condwait(void)
 	      thread_spawn(&cond_signaler_tid, 2, cond_signaler, &cm), 0);
 	thread_msleep(11);
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("cond_wait", cond_wait(&cond, &mutex, 0), 0);
 	check_sleep("cond_wait", start);
 	thread_msleep(10);
@@ -310,7 +300,7 @@ static void relative_condwait(void)
 	check("cond_init", cond_init(&cond, 0), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("cond_wait",
 	      cond_wait(&cond, &mutex, 10 * NS_PER_MS), -ETIMEDOUT);
 	check_sleep("cond_wait", start);
@@ -333,7 +323,7 @@ static void autoinit_absolute_condwait(void)
 				       PTHREAD_PRIO_NONE), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("cond_wait",
 	      cond_wait_until(&cond, &mutex, timer_read() + 10 * NS_PER_MS),
 	      -ETIMEDOUT);
@@ -357,7 +347,7 @@ static void absolute_condwait(void)
 	check("cond_init", cond_init(&cond, 1), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("cond_wait",
 	      cond_wait_until(&cond, &mutex, timer_read() + 10 * NS_PER_MS),
 	      -ETIMEDOUT);
@@ -373,7 +363,7 @@ static void *cond_killer(void *cookie)
 	unsigned long long start;
 	struct cond_mutex *cm = cookie;
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("mutex_lock", mutex_lock(cm->mutex), 0);
 	check_sleep("mutex_lock", start);
 	thread_msleep(10);
@@ -418,7 +408,7 @@ static void sig_norestart_condwait(void)
 	      thread_spawn(&cond_killer_tid, 2, cond_killer, &cm), 0);
 	thread_msleep(11);
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	sig_seen = 0;
 	check("cond_wait", cond_wait(&cond, &mutex, 0), 0);
 	check_sleep("cond_wait", start);
@@ -457,7 +447,7 @@ static void sig_restart_condwait(void)
 	      thread_spawn(&cond_killer_tid, 2, cond_killer, &cm), 0);
 	thread_msleep(11);
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	sig_seen = 0;
 	check("cond_wait", cond_wait(&cond, &mutex, 0), 0);
 	check_sleep("cond_wait", start);
@@ -473,7 +463,7 @@ static void *mutex_killer(void *cookie)
 	unsigned long long start;
 	struct cond_mutex *cm = cookie;
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("mutex_lock", mutex_lock(cm->mutex), 0);
 	check_sleep("mutex_lock", start);
 	check("cond_signal", cond_signal(cm->cond), 0);
@@ -513,7 +503,7 @@ static void sig_norestart_condwait_mutex(void)
 	thread_msleep(11);
 
 	sig_seen = 0;
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("cond_wait", cond_wait(&cond, &mutex, 0), 0);
 	check_sleep("cond_wait", start);
 	check("sig_seen", sig_seen, 1);
@@ -554,7 +544,7 @@ static void sig_restart_condwait_mutex(void)
 	thread_msleep(11);
 
 	sig_seen = 0;
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 
 	check("cond_wait", cond_wait(&cond, &mutex, 0), 0);
 	check_sleep("cond_wait", start);
@@ -571,7 +561,7 @@ static void *double_killer(void *cookie)
 	unsigned long long start;
 	struct cond_mutex *cm = cookie;
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("mutex_lock", mutex_lock(cm->mutex), 0);
 	check_sleep("mutex_lock", start);
 	check("thread_kill 1", thread_kill(cm->tid, SIGRTMIN), 0);
@@ -611,7 +601,7 @@ static void sig_norestart_double(void)
 	thread_msleep(11);
 
 	sig_seen = 0;
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("cond_wait", cond_wait(&cond, &mutex, 0), 0);
 	check_sleep("cond_wait", start);
 	check("sig_seen", sig_seen, 2);
@@ -652,7 +642,7 @@ static void sig_restart_double(void)
 	thread_msleep(11);
 
 	sig_seen = 0;
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 
 	check("cond_wait", cond_wait(&cond, &mutex, 0), 0);
 	check_sleep("cond_wait", start);
@@ -670,7 +660,7 @@ static void *cond_destroyer(void *cookie)
 	unsigned long long start;
 	struct cond_mutex *cm = cookie;
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 	check("mutex_lock", mutex_lock(cm->mutex), 0);
 	check_sleep("mutex_lock", start);
 	thread_msleep(10);
@@ -708,7 +698,7 @@ static void cond_destroy_whilewait(void)
 	      thread_spawn(&cond_destroyer_tid, 2, cond_destroyer, &cm), 0);
 	thread_msleep(11);
 
-	start = timer_get_tsc();
+	start = clockobj_get_ns();
 
 	check("cond_wait", cond_wait(&cond, &mutex, 10 * NS_PER_MS), -ETIMEDOUT);
 	check_sleep("cond_wait", start);
-- 
2.35.3

