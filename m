From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  8 Jul 2010 12:18:21 +0200
Message-Id: <1278584301-8064-8-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 7/7] Update clocktest for CLOCK_HOST_REALTIME
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: jan.kiszka@domain.hid, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 src/testsuite/clocktest/clocktest.c |   64 ++++++++++++++++++++++++++++++++---
 1 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/src/testsuite/clocktest/clocktest.c b/src/testsuite/clocktest/clocktest.c
index 7f29c23..bf4feb6 100644
--- a/src/testsuite/clocktest/clocktest.c
+++ b/src/testsuite/clocktest/clocktest.c
@@ -28,6 +28,7 @@
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <sys/time.h>
+#include <nucleus/vdso.h>
 
 #include <xeno_config.h>
 
@@ -75,11 +76,49 @@ struct per_cpu_data {
 	pthread_t thread;
 } *per_cpu_data;
 
+static void show_hostrt_diagnostics(void)
+{
+	if (!xnvdso_test_feature(XNVDSO_FEAT_HOST_REALTIME)) {
+		printf("XNVDSO_FEAT_HOST_REALTIME not available\n");
+		return;
+	}
+
+	if (nkvdso->hostrt_data.live)
+		printf("hostrt data area is live\n");
+	else {
+		printf("hostrt data area is not live\n");
+		return;
+	}
+
+	printf("Sequence counter : %u\n",
+	       nkvdso->hostrt_data.seqcount.sequence);
+	printf("wall_time_sec    : %ld\n", nkvdso->hostrt_data.wall_time_sec);
+	printf("wall_time_nsec   : %u\n", nkvdso->hostrt_data.wall_time_nsec);
+	printf("wall_to_monotonic\n");
+	printf("          tv_sec : %jd\n",
+	       (intmax_t)nkvdso->hostrt_data.wall_to_monotonic.tv_sec);
+	printf("         tv_nsec : %ld\n",
+	       nkvdso->hostrt_data.wall_to_monotonic.tv_nsec);
+	printf("cycle_last       : %lu\n", nkvdso->hostrt_data.cycle_last);
+	printf("mask             : 0x%lx\n", nkvdso->hostrt_data.mask);
+	printf("mult             : %u\n", nkvdso->hostrt_data.mult);
+	printf("shift            : %u\n\n", nkvdso->hostrt_data.shift);
+}
+
 static inline unsigned long long read_clock(clockid_t clock_id)
 {
 	struct timespec ts;
+	int res;
 
-	clock_gettime(clock_id, &ts);
+	res = clock_gettime(clock_id, &ts);
+	if (res != 0) {
+		fprintf(stderr, "clock_gettime failed for clock id %d\n",
+			clock_id);
+		if (clock_id == CLOCK_HOST_REALTIME)
+			show_hostrt_diagnostics();
+
+		exit(-1);
+	}
 	return ts.tv_nsec + ts.tv_sec * 1000000000ULL;
 }
 
@@ -87,8 +126,10 @@ static inline unsigned long long read_reference_clock(void)
 {
 	struct timeval tv;
 
-	/* Make sure we do not pick the vsyscall variant. It won't
-	   switch us into secondary mode and can easily deadlock. */
+	/*
+	 * Make sure we do not pick the vsyscall variant. It won't
+	 * switch us into secondary mode and can easily deadlock.
+	 */
 	syscall(SYS_gettimeofday, &tv, NULL);
 	return tv.tv_usec * 1000ULL + tv.tv_sec * 1000000000ULL;
 }
@@ -186,8 +227,9 @@ int main(int argc, char *argv[])
 	int cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	int i;
 	int c;
+	int d = 0;
 
-	while ((c = getopt(argc, argv, "C:T:")) != EOF)
+	while ((c = getopt(argc, argv, "C:T:D")) != EOF)
 		switch (c) {
 		case 'C':
 			clock_id = atoi(optarg);
@@ -197,10 +239,15 @@ int main(int argc, char *argv[])
 			alarm(atoi(optarg));
 			break;
 
+		case 'D':
+			d = 1;
+			break;
+
 		default:
 			fprintf(stderr, "usage: clocktest [options]\n"
 				"  [-C <clock_id>]              # tested clock, default=%d (CLOCK_REALTIME)\n"
-				"  [-T <test_duration_seconds>] # default=0, so ^C to end\n",
+				"  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
+				"  [-D]                         # print extra diagnostics for CLOCK_HOST_REALTIME\n",
 				CLOCK_REALTIME);
 			exit(2);
 		}
@@ -211,6 +258,9 @@ int main(int argc, char *argv[])
 
 	init_lock(&lock);
 
+	if (d && clock_id == CLOCK_HOST_REALTIME)
+		show_hostrt_diagnostics();
+
 	per_cpu_data = malloc(sizeof(*per_cpu_data) * cpus);
 	if (!per_cpu_data) {
 		fprintf(stderr, "%s\n", strerror(ENOMEM));
@@ -234,6 +284,10 @@ int main(int argc, char *argv[])
 		printf("CLOCK_MONOTONIC");
 		break;
 
+	case CLOCK_HOST_REALTIME:
+		printf("CLOCK_HOST_REALTIME");
+		break;
+
         default:
 		printf("<unknown>");
 		break;
-- 
1.6.4


