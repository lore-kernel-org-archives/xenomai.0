From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/sched: Save one cpumask stack variable in
 affinity_vfile_store
Message-ID: <c4f5a2e7-3749-956f-4ec7-d1a40a75f94c@siemens.com>
Date: Tue, 12 Oct 2021 18:57:07 +0200
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

This brings us below default CONFIG_FRAME_WARN with CONFIG_MAXSMP=y on
x86, avoiding the related compile-time warning.

Reported-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

The first idea was to make the vars static, but the handler is actually 
not running under any lock, thus this would have been ugly - at best.

 kernel/cobalt/sched.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 222d0dd408..88c4951ed8 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -1381,7 +1381,7 @@ static int affinity_vfile_show(struct xnvfile_regular_iterator *it,
 
 static ssize_t affinity_vfile_store(struct xnvfile_input *input)
 {
-	cpumask_t affinity, set;
+	cpumask_t affinity;
 	ssize_t ret;
 	long val;
 	int cpu;
@@ -1396,21 +1396,21 @@ static ssize_t affinity_vfile_store(struct xnvfile_input *input)
 	else {
 		cpumask_clear(&affinity);
 		for (cpu = 0; cpu < BITS_PER_LONG; cpu++, val >>= 1) {
-			if (val & 1)
+			if (val & 1) {
+				/*
+				 * The new dynamic affinity must be a strict
+				 * subset of the static set of supported CPUs.
+				 */
+				if (!cpumask_test_cpu(cpu,
+						      &xnsched_realtime_cpus))
+					return -EINVAL;
 				cpumask_set_cpu(cpu, &affinity);
+			}
 		}
 	}
 
-	cpumask_and(&set, &affinity, cpu_online_mask);
-	if (cpumask_empty(&set))
-		return -EINVAL;
-
-	/*
-	 * The new dynamic affinity must be a strict subset of the
-	 * static set of supported CPUs.
-	 */
-	cpumask_or(&set, &affinity, &xnsched_realtime_cpus);
-	if (!cpumask_equal(&set, &xnsched_realtime_cpus))
+	cpumask_and(&affinity, &affinity, cpu_online_mask);
+	if (cpumask_empty(&affinity))
 		return -EINVAL;
 
 	xnlock_get_irqsave(&nklock, s);
-- 
2.31.1

