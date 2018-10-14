From: Philippe Gerum <rpm@xenomai.org>
Date: Sun, 14 Oct 2018 10:54:05 +0200
Message-Id: <20181014085405.9326-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH] boilerplate/setup: cobalt: do not advertise
 non-RT CPUs to applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

The CPU affinity mask in __base_setup_data.cpu_affinity - which may be
set by --cpu-affinity - is conventionally checked by applications for
determining which CPUs are usable for real-time duties.

Over Cobalt, we need to make sure that such mask reflects the set of
CPUs available for running real-time threads as defined by the core
(i.e. /proc/xenomai/affinity), in absence of --cpu-affinity
setting.

Otherwise, some applications like switchest looking at an empty
affinity mask may wrongly assume that all CPUs are available for
running RT threads, leading to a failure when manually pinning such
thread to an invalid (non-RT) CPU.

With current Cobalt core and I-pipe releases not fixed for gracefully
handling invalid domain migration requests over a non-RT CPU, such a
failure may trigger a kernel panic.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 lib/boilerplate/setup.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 8b363efee..3214d7f04 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -173,6 +173,8 @@ static int collect_cpu_affinity(const char *cpu_list)
 		return ret;
 	}
 
+	CPU_ZERO(&__base_setup_data.cpu_affinity);
+
 	s = n = strdup(cpu_list);
 	while ((range = strtok_r(n, ",", &range_p)) != NULL) {
 		if (*range == '\0')
@@ -232,6 +234,33 @@ fail:
 	return -EINVAL;
 }
 
+static void retrieve_default_cpu_affinity(void)
+{
+	CPU_ZERO(&__base_setup_data.cpu_affinity);
+
+#ifdef CONFIG_XENO_COBALT
+	/*
+	 * If the Cobalt core has restricted the CPU set, update our
+	 * mask accordingly.
+	 */
+	unsigned long cpumask;
+	FILE *fp;
+	int cpu;
+
+	fp = fopen("/proc/xenomai/affinity", "r");
+	if (fp == NULL)
+		return;	/* uhh? */
+
+	if (fscanf(fp, "%lx", &cpumask) == 1) {
+		for (cpu = 0; cpumask; cpumask >>= 1, cpu++)
+			if (cpumask & 1)
+				CPU_SET(cpu, &__base_setup_data.cpu_affinity);
+	}
+
+	fclose(fp);
+#endif
+}
+
 static inline char **prep_args(int argc, char *const argv[])
 {
 	char **uargv;
@@ -528,8 +557,8 @@ static void __xenomai_init(int *argcp, char *const **argvp, const char *me)
 	/* No ifs, no buts: we must be called over the main thread. */
 	assert(getpid() == __node_id);
 
-	/* Define default CPU affinity, i.e. no particular affinity. */
-	CPU_ZERO(&__base_setup_data.cpu_affinity);
+	/* Retrieve the default CPU affinity. */
+	retrieve_default_cpu_affinity();
 
 	/*
 	 * Parse the base options first, to bootstrap the core with
-- 
2.14.4


