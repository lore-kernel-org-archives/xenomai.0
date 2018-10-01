From: Philippe Gerum <rpm@xenomai.org>
Date: Mon,  1 Oct 2018 15:56:17 +0200
Message-Id: <20181001135619.24883-5-rpm@xenomai.org>
In-Reply-To: <20181001135619.24883-1-rpm@xenomai.org>
References: <20181001135619.24883-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 4/6] cobalt/sched: fix mismatches between
 supported CPUs and affinity set
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

xnsched_realtime_cpus is a misnomer defining the set of CPUs which may
handle timer events.

cobalt_cpu_affinity is a subset of xnsched_realtime_cpus which defines
which CPU(s) may run Cobalt threads.
---
 include/cobalt/kernel/sched.h | 10 ++++++++++
 kernel/cobalt/posix/process.c |  2 +-
 kernel/cobalt/posix/sched.c   |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index eab80c340..d2b3d0c63 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -259,6 +259,11 @@ static inline int xnsched_supported_cpu(int cpu)
 	return cpumask_test_cpu(cpu, &xnsched_realtime_cpus);
 }
 
+static inline int xnsched_threading_cpu(int cpu)
+{
+	return cpumask_test_cpu(cpu, &cobalt_cpu_affinity);
+}
+
 #else /* !CONFIG_SMP */
 
 static inline void xnsched_set_resched(struct xnsched *sched)
@@ -273,6 +278,11 @@ static inline int xnsched_supported_cpu(int cpu)
 	return 1;
 }
 
+static inline int xnsched_threading_cpu(int cpu)
+{
+	return 1;
+}
+
 #endif /* !CONFIG_SMP */
 
 #define for_each_realtime_cpu(cpu)		\
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index a708833ef..d0f2f3725 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -897,7 +897,7 @@ static inline bool affinity_ok(struct task_struct *p) /* nklocked, IRQs off */
 	 * in secondary mode. If so, do the fixups to reflect the
 	 * change.
 	 */
-	if (!xnsched_supported_cpu(cpu)) {
+	if (!xnsched_threading_cpu(cpu)) {
 		/*
 		 * The thread is about to switch to primary mode on a
 		 * non-rt CPU, which is damn wrong and hopeless.
diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index eca16f764..103f85534 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -622,7 +622,7 @@ int __cobalt_sched_setconfig_np(int cpu, int policy,
 
 	trace_cobalt_sched_setconfig(cpu, policy, len);
 
-	if (cpu < 0 || cpu >= NR_CPUS || !xnsched_supported_cpu(cpu))
+	if (cpu < 0 || cpu >= NR_CPUS || !xnsched_threading_cpu(cpu))
 		return -EINVAL;
 
 	if (len == 0)
-- 
2.14.4


