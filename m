Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9A3D79
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:08 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230903150459e98d2848ed5e23eafc
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1V0lQJEHPPmImLxIcSKw70TaH1bQZn0Q8QZ9w/qbt8o=;
 b=KA0aSwMfymM4ay64shFoUPM6IxOqvVTFMHsZLx8BmJUIfEkIui/5P7dtIdhP76Ix6ilmEK
 EEAXKGobs2sCl7tAKPC9Yu6sxJpRWjr0/bp5tJVWhSslAKWEDob4PNU3D47JLdTgV2/KeIKn
 gTbIlCHsVywylWVzWAEuDfQC5F+/4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 05/20] testsuite/clocktest: Drop obsolete CLOCK_HOST_REALTIME and wallclock offset bits
Date: Sun,  3 Sep 2023 17:04:42 +0200
Message-Id: <e3a3a3025b148fdc0f81adecd549ba7b8fabea37.1693753497.git.jan.kiszka@siemens.com>
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

This clock was retired with the removal of I-pipe support. Along with
it, wallclock offset support became obsolete.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/clocktest/clocktest.c | 64 ++-------------------------------
 1 file changed, 2 insertions(+), 62 deletions(-)

diff --git a/testsuite/clocktest/clocktest.c b/testsuite/clocktest/clocktest.c
index c524f42fb7..c2b9ee5f43 100644
--- a/testsuite/clocktest/clocktest.c
+++ b/testsuite/clocktest/clocktest.c
@@ -31,11 +31,8 @@
 #include <sys/time.h>
 #include <boilerplate/ancillaries.h>
 #include <boilerplate/atomic.h>
-#include <cobalt/uapi/kernel/vdso.h>
 #include <xeno_config.h>
 
-extern struct xnvdso *cobalt_vdso;
-
 /*
  * We can't really trust POSIX headers to check for features, since
  * some archs may not implement all of the declared uClibc POSIX
@@ -67,44 +64,6 @@ struct per_cpu_data {
 	pthread_t thread;
 } *per_cpu_data;
 
-static void show_hostrt_diagnostics(void)
-{
-	if (!xnvdso_test_feature(cobalt_vdso, XNVDSO_FEAT_HOST_REALTIME)) {
-		printf("XNVDSO_FEAT_HOST_REALTIME not available\n");
-		return;
-	}
-
-	if (cobalt_vdso->hostrt_data.live)
-		printf("hostrt data area is live\n");
-	else {
-		printf("hostrt data area is not live\n");
-		return;
-	}
-
-	printf("sequence counter : %u\n",
-	       cobalt_vdso->hostrt_data.lock.sequence);
-	printf("wall_time_sec    : %lld\n",
-	       (unsigned long long)cobalt_vdso->hostrt_data.wall_sec);
-	printf("wall_time_nsec   : %u\n", cobalt_vdso->hostrt_data.wall_nsec);
-	printf("wall_to_monotonic_sec    : %lld\n",
-	       (unsigned long long)cobalt_vdso->hostrt_data.wtom_sec);
-	printf("wall_to_monotonic_nsec   : %u\n", cobalt_vdso->hostrt_data.wtom_nsec);
-	printf("cycle_last       : %Lu\n", (long long)cobalt_vdso->hostrt_data.cycle_last);
-	printf("mask             : 0x%Lx\n", (long long)cobalt_vdso->hostrt_data.mask);
-	printf("mult             : %u\n", cobalt_vdso->hostrt_data.mult);
-	printf("shift            : %u\n\n", cobalt_vdso->hostrt_data.shift);
-}
-
-static void show_realtime_offset(void)
-{
-	if (!xnvdso_test_feature(cobalt_vdso, XNVDSO_FEAT_HOST_REALTIME)) {
-		printf("XNVDSO_FEAT_WALLCLOCK_OFFSET not available\n");
-		return;
-	}
-
-	printf("Wallclock offset : %llu\n", (long long)cobalt_vdso->wallclock_offset);
-}
-
 static inline uint64_t read_clock(clockid_t clock_id)
 {
 	struct timespec ts;
@@ -114,11 +73,6 @@ static inline uint64_t read_clock(clockid_t clock_id)
 	if (res != 0) {
 		fprintf(stderr, "clock_gettime failed for clock id %d\n",
 			clock_id);
-		if (clock_id == CLOCK_HOST_REALTIME)
-			show_hostrt_diagnostics();
-		else if (clock_id == CLOCK_REALTIME)
-			show_realtime_offset();
-
 		exit(-1);
 	}
 	return ts.tv_nsec + ts.tv_sec * 1000000000ULL;
@@ -249,9 +203,6 @@ static clockid_t resolve_clock_name(const char *name,
 			case CLOCK_MONOTONIC_RAW:
 				*real_name = "CLOCK_MONOTONIC_RAW";
 				break;
-			case CLOCK_HOST_REALTIME:
-				*real_name = "CLOCK_HOST_REALTIME";
-				break;
 			default:
 				error(1, EINVAL, "bad built-in clock id '%d'",
 				      clock_id);
@@ -264,8 +215,6 @@ static clockid_t resolve_clock_name(const char *name,
 			return CLOCK_MONOTONIC;
 		if (strcmp(name, "CLOCK_MONOTONIC_RAW") == 0)
 			return CLOCK_MONOTONIC_RAW;
-		if (strcmp(name, "CLOCK_HOST_REALTIME") == 0)
-			return CLOCK_HOST_REALTIME;
 		if (strcmp(name, "coreclk") == 0) {
 			/* Read the core clock as CLOCK_MONOTONIC_RAW */
 			*real_name = "CLOCK_MONOTONIC_RAW";
@@ -303,10 +252,9 @@ int main(int argc, char *argv[])
 	int max_cpu, cpus;
 	int i;
 	int c;
-	int d = 0;
 	int ext = 0;
 
-	while ((c = getopt(argc, argv, "C:ET:D")) != EOF)
+	while ((c = getopt(argc, argv, "C:ET:")) != EOF)
 		switch (c) {
 		case 'C':
 			clock_name = optarg;
@@ -320,16 +268,11 @@ int main(int argc, char *argv[])
 			alarm(atoi(optarg));
 			break;
 
-		case 'D':
-			d = 1;
-			break;
-
 		default:
 			fprintf(stderr, "usage: clocktest [options]\n"
 				"  [-C <clock_id|clock_name>]   # tested clock, defaults to CLOCK_REALTIME\n"
 				"  [-E]                         # -C specifies extension clock\n"
-				"  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
-				"  [-D]                         # print extra diagnostics for CLOCK_HOST_REALTIME\n");
+				"  [-T <test_duration_seconds>] # default=0, so ^C to end\n");
 			exit(2);
 		}
 
@@ -340,9 +283,6 @@ int main(int argc, char *argv[])
 
 	init_lock(&lock);
 
-	if (d && clock_id == CLOCK_HOST_REALTIME)
-		show_hostrt_diagnostics();
-
 	if (get_realtime_cpu_set(&cpu_realtime_set) != 0)
 		error(1, ENOSYS, "get_realtime_cpu_set");
 
-- 
2.35.3

