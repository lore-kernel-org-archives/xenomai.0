From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Fri,  2 Jul 2010 13:49:13 +0200
Message-Id: <1278071353-13836-8-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 7/7] posix: Add some example code for
	CLOCK_HOST_REALTIME
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

... and for reading the contents of the hostrt data.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
---
 examples/posix/Makefile      |    3 +-
 examples/posix/show_hrtime.c |   82 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletions(-)
 create mode 100644 examples/posix/show_hrtime.c

diff --git a/examples/posix/Makefile b/examples/posix/Makefile
index 1bf46a4..c5ec8cb 100644
--- a/examples/posix/Makefile
+++ b/examples/posix/Makefile
@@ -1,7 +1,7 @@
 ###### CONFIGURATION ######
 
 ### List of applications to be build
-APPLICATIONS = satch
+APPLICATIONS = satch show_hrtime
 
 ### Note: to override the search path for the xeno-config script, use "make XENO=..."
 
@@ -14,6 +14,7 @@ MODULES = satch
 all::
 
 satch: satch.c
+show_hrtime: show_hrtime.c
 
 
 ###### USER SPACE BUILD (no change required normally) ######
diff --git a/examples/posix/show_hrtime.c b/examples/posix/show_hrtime.c
new file mode 100644
index 0000000..932c9f8
--- /dev/null
+++ b/examples/posix/show_hrtime.c
@@ -0,0 +1,82 @@
+/*
+ * Dump CLOCK_HOST_REALTIME data in the vdso page
+ * Written by Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+#include <nucleus/vdso.h>
+#include <nucleus/types.h>
+#include <nucleus/seqlock_user.h>
+#include <native/task.h>
+
+extern unsigned long xeno_sem_heap[2];
+static unsigned modeswitches = 0;
+
+void count_modeswitches(int sig __attribute__((unused)))
+{
+	modeswitches++;
+}
+
+int main(int argc, char **argv)
+{
+	int res;
+	struct timespec ts1, ts2;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	if (!xeno_sem_heap[1]) {
+		fprintf(stderr, "Could not determine position of the "
+			"global semaphore heap\n");
+		return 1;
+	}
+
+	if (!xnvdso_test_feature(XNVDSO_FEAT_HOST_REALTIME)) {
+		printf("XNVDSO_FEAT_HOST_REALTIME not available\n");
+		return 1;
+	}
+
+	if (nkvdso->hostrt_data.live)
+		printf("hostrt data area is live\n");
+	else {
+		printf("hostrt data area is not live\n");
+		return 2;
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
+
+	res = clock_gettime(CLOCK_REALTIME, &ts1);
+	if (res)
+		printf("clock_gettime(CLOCK_REALTIME) failed!\n");
+
+	signal(SIGXCPU, count_modeswitches);
+	rt_task_set_mode(0, T_WARNSW, NULL);
+	modeswitches = 0;
+	res = clock_gettime(CLOCK_HOST_REALTIME, &ts2);
+	if (res)
+		printf("clock_gettime(CLOCK_HOST_REALTIME) failed!\n");
+
+	if (modeswitches == 1) {
+		printf("CLOCK_HOST_REALTIME caused a mode switch.\n");
+		return 3;
+	}
+
+	rt_task_set_mode(T_PRIMARY, 0, NULL);
+	printf("CLOCK_REALTIME     : tv_sec = %jd, tv_nsec = %ld\n",
+	       ts1.tv_sec, ts1.tv_nsec);
+	printf("CLOCK_HOST_REALTIME: tv_sec = %jd, tv_nsec = %ld\n",
+	       ts2.tv_sec, ts2.tv_nsec);
+	return 0;
+}
-- 
1.6.4


