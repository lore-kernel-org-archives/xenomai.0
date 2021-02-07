From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 04/18] cobalt/clock: dovetail: add placeholders for clock
 services
Date: Sun,  7 Feb 2021 17:04:20 +0100
Message-Id: <20210207160434.2869121-4-rpm@xenomai.org>
In-Reply-To: <20210207160434.2869121-1-rpm@xenomai.org>
References: <20210207160434.2869121-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../cobalt/kernel/dovetail/pipeline/clock.h   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/clock.h

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
new file mode 100644
index 000000000..933e100ba
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -0,0 +1,80 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_DOVETAIL_CLOCK_H
+#define _COBALT_KERNEL_DOVETAIL_CLOCK_H
+
+#include <cobalt/uapi/kernel/types.h>
+#include <cobalt/kernel/assert.h>
+
+struct timespec;
+
+static inline u64 pipeline_read_cycle_counter(void)
+{
+	/* Read the raw cycle counter of the core clock. */
+	TODO();
+
+	return 0;
+}
+
+static inline void pipeline_set_timer_shot(unsigned long cycles)
+{
+	/*
+	 * N/A. Revisit: xnclock_core_local_shot() should go to the
+	 * I-pipe section, we do things differently on Dovetail via
+	 * the proxy tick device. As a consequence,
+	 * pipeline_set_timer_shot() should not be part of the
+	 * pipeline interface.
+	 */
+	TODO();
+}
+
+static inline const char *pipeline_timer_name(void)
+{
+	/*
+	 * Return the name of the current clock event chip, which is
+	 * the real device controlled by the proxy tick device.
+	 */
+	TODO();
+
+	return "?";
+}
+
+static inline const char *pipeline_clock_name(void)
+{
+	/* Return the name of the current clock source. */
+	TODO();
+
+	return "?";
+}
+
+static inline int pipeline_get_host_time(struct timespec *tp)
+{
+	/* Convert ktime_get_real_fast_ns() to timespec. */
+	TODO();
+
+	return 0;
+}
+
+static inline void pipeline_init_clock(void)
+{
+	/* N/A */
+}
+
+static inline xnsticks_t xnclock_core_ticks_to_ns(xnsticks_t ticks)
+{
+	return ticks;
+}
+
+static inline xnsticks_t xnclock_core_ticks_to_ns_rounded(xnsticks_t ticks)
+{
+	return ticks;
+}
+
+static inline xnsticks_t xnclock_core_ns_to_ticks(xnsticks_t ns)
+{
+	return ns;
+}
+
+#endif /* !_COBALT_KERNEL_DOVETAIL_CLOCK_H */
-- 
2.26.2


