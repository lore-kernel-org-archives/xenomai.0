From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/clocktest: Account for unsupported CPUs
Message-ID: <361867b3-8556-ceb2-54ed-c678d3d4c95f@siemens.com>
Date: Mon, 5 Jul 2021 12:31:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Scheduling a thread on a CPU that is not supported by Xenomai will only
fail and flood the screen with error messages.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/clocktest/clocktest.c | 44 +++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/testsuite/clocktest/clocktest.c b/testsuite/clocktest/clocktest.c
index a40fcaca9d..8f200f46ab 100644
--- a/testsuite/clocktest/clocktest.c
+++ b/testsuite/clocktest/clocktest.c
@@ -29,6 +29,7 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/time.h>
+#include <boilerplate/ancillaries.h>
 #include <boilerplate/atomic.h>
 #include <cobalt/uapi/kernel/vdso.h>
 #include <xeno_config.h>
@@ -52,8 +53,9 @@ pthread_mutex_t lock;
 #define release_lock(lock)			pthread_mutex_unlock(lock)
 #endif
 
-uint64_t last_common = 0;
-clockid_t clock_id = CLOCK_REALTIME;
+static uint64_t last_common = 0;
+static clockid_t clock_id = CLOCK_REALTIME;
+static cpu_set_t cpu_realtime_set;
 
 struct per_cpu_data {
 	uint64_t first_tod, first_clock;
@@ -298,7 +300,7 @@ static clockid_t resolve_clock_name(const char *name,
 int main(int argc, char *argv[])
 {
 	const char *clock_name = NULL, *real_clock_name = "CLOCK_REALTIME";
-	int cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	int max_cpu, cpus;
 	int i;
 	int c;
 	int d = 0;
@@ -341,13 +343,28 @@ int main(int argc, char *argv[])
 	if (d && clock_id == CLOCK_HOST_REALTIME)
 		show_hostrt_diagnostics();
 
-	per_cpu_data = malloc(sizeof(*per_cpu_data) * cpus);
+	if (get_realtime_cpu_set(&cpu_realtime_set) != 0)
+		error(1, ENOSYS, "get_realtime_cpu_set");
+
+	max_cpu = 0;
+	cpus = 0;
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &cpu_realtime_set))
+			continue;
+		cpus++;
+		if (i > max_cpu)
+			max_cpu = i;
+	}
+
+	per_cpu_data = malloc(sizeof(*per_cpu_data) * (max_cpu + 1));
 	if (per_cpu_data == NULL)
 		error(1, ENOMEM, "malloc");
 
-	memset(per_cpu_data, 0, sizeof(*per_cpu_data) * cpus);
+	memset(per_cpu_data, 0, sizeof(*per_cpu_data) * (max_cpu + 1));
 
-	for (i = 0; i < cpus; i++) {
+	for (i = 0; i <= max_cpu; i++) {
+		if (!CPU_ISSET(i, &cpu_realtime_set))
+			continue;
 		per_cpu_data[i].first_round = 1;
 		pthread_create(&per_cpu_data[i].thread, NULL, cpu_thread,
 			       (void *)(long)i);
@@ -359,13 +376,14 @@ int main(int argc, char *argv[])
 	       "--- -------------------- ---------------- ---------- --------------\n");
 
 	while (1) {
-		for (i = 0; i < cpus; i++)
-			printf("%3d %20.1f %16.3f %10lu %14.1f\n",
-			       i,
-			       per_cpu_data[i].offset/1000.0,
-			       per_cpu_data[i].drift * 1000000.0,
-			       per_cpu_data[i].warps,
-			       per_cpu_data[i].max_warp/1000.0);
+		for (i = 0; i <= max_cpu; i++)
+			if (CPU_ISSET(i, &cpu_realtime_set))
+				printf("%3d %20.1f %16.3f %10lu %14.1f\n",
+				       i,
+				       per_cpu_data[i].offset/1000.0,
+				       per_cpu_data[i].drift * 1000000.0,
+				       per_cpu_data[i].warps,
+				       per_cpu_data[i].max_warp/1000.0);
 		usleep(250000);
 		printf("\033[%dA", cpus);
 	}
-- 
2.26.2

