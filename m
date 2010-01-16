From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 16 Jan 2010 21:05:00 +0100
Message-Id: <1263672300-20868-3-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1263672300-20868-2-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <4B521B97.7010203@domain.hid>
	<1263672300-20868-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1263672300-20868-2-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] [PATCH 3/3] latency: account for and signal
	involuntary mode switches.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

---
 src/testsuite/latency/latency.c |  103 +++++++++++++++++++++++++++-----------
 1 files changed, 73 insertions(+), 30 deletions(-)

diff --git a/src/testsuite/latency/latency.c b/src/testsuite/latency/latency.c
index f82a072..9af785e 100644
--- a/src/testsuite/latency/latency.c
+++ b/src/testsuite/latency/latency.c
@@ -1,13 +1,16 @@
-#include <sys/mman.h>
-#include <sys/time.h>
-#include <unistd.h>
 #include <stdlib.h>
 #include <math.h>
 #include <stdio.h>
 #include <string.h>
 #include <signal.h>
-#include <getopt.h>
 #include <time.h>
+
+#include <sys/mman.h>
+#include <sys/time.h>
+#include <unistd.h>
+
+#include <execinfo.h>
+
 #include <native/task.h>
 #include <native/timer.h>
 #include <native/sem.h>
@@ -20,6 +23,7 @@ RT_SEM display_sem;
 #define ONE_BILLION  1000000000
 #define TEN_MILLION    10000000
 
+unsigned max_relaxed;
 long minjitter, maxjitter, avgjitter;
 long gminjitter = TEN_MILLION, gmaxjitter = -TEN_MILLION, goverrun = 0;
 long long gavgjitter = 0;
@@ -32,6 +36,8 @@ int benchdev_no = 0;
 int benchdev = -1;
 int freeze_max = 0;
 int priority = T_HIPRIO;
+int stop_upon_switch = 0;
+sig_atomic_t sampling_relaxed = 0;
 
 #define USER_TASK       0
 #define KERNEL_TASK     1
@@ -72,6 +78,7 @@ void latency(void *cookie)
 	int err, count, nsamples, warmup = 1;
 	RTIME expected_tsc, period_tsc, start_ticks;
 	RT_TIMER_INFO timer_info;
+	unsigned old_relaxed = 0;
 
 	err = rt_timer_inquire(&timer_info);
 
@@ -109,8 +116,13 @@ void latency(void *cookie)
 			err = rt_task_wait_period(&ov);
 
 			dt = (long)(rt_timer_tsc() - expected_tsc);
-			if (dt > maxj)
+			if (dt > maxj) {
+				if (sampling_relaxed != old_relaxed)
+					max_relaxed += 
+						sampling_relaxed - old_relaxed;
 				maxj = dt;
+			}
+			old_relaxed = sampling_relaxed;
 			if (dt < minj)
 				minj = dt;
 			sumj += dt;
@@ -274,17 +286,17 @@ void display(void *cookie)
 				     (dt / 60) % 60, dt % 60,
 				     test_mode_names[test_mode],
 				     period_ns / 1000, priority);
-				printf("RTH|%12s|%12s|%12s|%8s|%12s|%12s\n",
-				       "-----lat min", "-----lat avg",
-				       "-----lat max", "-overrun",
-				       "----lat best", "---lat worst");
+				printf("RTH|%11s|%11s|%11s|%8s|%6s|%11s|%11s\n",
+				       "----lat min", "----lat avg",
+				       "----lat max", "-overrun", "---msw",
+				       "---lat best", "--lat worst");
 			}
-
-			printf("RTD|%12.3f|%12.3f|%12.3f|%8ld|%12.3f|%12.3f\n",
+			printf("RTD|%11.3f|%11.3f|%11.3f|%8ld|%6u|%11.3f|%11.3f\n",
 			       (double)minj / 1000,
 			       (double)avgj / 1000,
 			       (double)maxj / 1000,
 			       goverrun,
+			       max_relaxed,
 			       (double)gminj / 1000, (double)gmaxj / 1000);
 		}
 	}
@@ -396,12 +408,16 @@ void cleanup(void)
 		test_duration = actual_duration;
 
 	printf
-	    ("---|------------|------------|------------|--------|-------------------------\n"
-	     "RTS|%12.3f|%12.3f|%12.3f|%8ld|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
+	    ("---|-----------|-----------|-----------|--------|------|-------------------------\n"
+	     "RTS|%11.3f|%11.3f|%11.3f|%8ld|%6u|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
 	     (double)gminj / 1000, (double)gavgj / 1000, (double)gmaxj / 1000,
-	     goverrun, actual_duration / 3600, (actual_duration / 60) % 60,
+	     goverrun, max_relaxed, actual_duration / 3600, (actual_duration / 60) % 60,
 	     actual_duration % 60, test_duration / 3600,
 	     (test_duration / 60) % 60, test_duration % 60);
+	if (max_relaxed > 0)
+		printf(
+"Warning! some latency maxima may have been due to involuntary mode switches.\n"
+"Please contact xenomai@xenomai.org");
 
 	if (histogram_avg)
 		free(histogram_avg);
@@ -425,13 +441,32 @@ void faulthand(int sig)
 	kill(getpid(), sig);
 }
 
+void mode_sw(int sig)
+{
+	const char buffer[] = "Mode switch, aborting. Backtrace:\n";
+	static void *bt[200];
+	unsigned n;
+
+	if (!stop_upon_switch) {
+		++sampling_relaxed;
+		return;
+	}
+
+	write(STDERR_FILENO, buffer, sizeof(buffer));
+	n = backtrace(bt, sizeof(bt)/sizeof(bt[0]));
+	backtrace_symbols_fd(bt, n, STDERR_FILENO);
+
+	signal(sig, SIG_DFL);
+	kill(getpid(), sig);
+}
+
 int main(int argc, char **argv)
 {
 	int c, err;
 	char task_name[16];
 	int cpu = 0;
 
-	while ((c = getopt(argc, argv, "hp:l:T:qH:B:sD:t:fc:P:")) != EOF)
+	while ((c = getopt(argc, argv, "hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
 		switch (c) {
 		case 'h':
 
@@ -497,22 +532,29 @@ int main(int argc, char **argv)
 			priority = atoi(optarg);
 			break;
 
+		case 'b':
+			stop_upon_switch = 1;
+			break;
+
 		default:
 
-			fprintf(stderr, "usage: latency [options]\n"
-				"  [-h]                         # print histograms of min, avg, max latencies\n"
-				"  [-s]                         # print statistics of min, avg, max latencies\n"
-				"  [-H <histogram-size>]        # default = 200, increase if your last bucket is full\n"
-				"  [-B <bucket-size>]           # default = 1000ns, decrease for more resolution\n"
-				"  [-p <period_us>]             # sampling period\n"
-				"  [-l <data-lines per header>] # default=21, 0 to supress headers\n"
-				"  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
-				"  [-q]                         # supresses RTD, RTH lines if -T is used\n"
-				"  [-D <testing_device_no>]     # number of testing device, default=0\n"
-				"  [-t <test_mode>]             # 0=user task (default), 1=kernel task, 2=timer IRQ\n"
-				"  [-f]                         # freeze trace for each new max latency\n"
-				"  [-c <cpu>]                   # pin measuring task down to given CPU\n"
-				"  [-P <priority>]              # task priority (test mode 0 and 1 only)\n");
+			fprintf(stderr, 
+"usage: latency [options]\n"
+"  [-h]                         # print histograms of min, avg, max latencies\n"
+"  [-s]                         # print statistics of min, avg, max latencies\n"
+"  [-H <histogram-size>]        # default = 200, increase if your last bucket is full\n"
+"  [-B <bucket-size>]           # default = 1000ns, decrease for more resolution\n"
+"  [-p <period_us>]             # sampling period\n"
+"  [-l <data-lines per header>] # default=21, 0 to supress headers\n"
+"  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
+"  [-q]                         # supresses RTD, RTH lines if -T is used\n"
+"  [-D <testing_device_no>]     # number of testing device, default=0\n"
+"  [-t <test_mode>]             # 0=user task (default), 1=kernel task, 2=timer IRQ\n"
+"  [-f]                         # freeze trace for each new max latency\n"
+"  [-c <cpu>]                   # pin measuring task down to given CPU\n"
+"  [-P <priority>]              # task priority (test mode 0 and 1 only)\n"
+"  [-b]                         # break upon mode switch\n"
+);
 			exit(2);
 		}
 
@@ -548,6 +590,7 @@ int main(int argc, char **argv)
 	signal(SIGTERM, sighand);
 	signal(SIGHUP, sighand);
 	signal(SIGALRM, sighand);
+	signal(SIGXCPU, mode_sw);
 
 	if (freeze_max) {
 		/* If something goes wrong, we want to freeze the current
@@ -605,7 +648,7 @@ int main(int argc, char **argv)
 		snprintf(task_name, sizeof(task_name), "sampling-%d", getpid());
 		err =
 		    rt_task_create(&latency_task, task_name, 0, priority,
-				   T_FPU | cpu);
+				   T_FPU | cpu | T_WARNSW);
 
 		if (err) {
 			fprintf(stderr,
-- 
1.5.6.5


