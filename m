From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/posix/syscall: Handle clock_gettime[64] coming from
 vDSO in primary
Message-ID: <d8af8049-cafd-0097-b563-5cf9cf70aafe@siemens.com>
Date: Fri, 18 Jun 2021 18:47:04 +0200
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

This is needed when there is not userspace-readable clocksource
available. This can happen under Dovetail where Linux selects the
suitable clocksource and may see problems with, e.g., the TSC under x86.
When it then switches to a clocksource that require a syscall, we so
far migrate to Linux on every access.

This handler resolves that problem. It's not needed under I-pipe where
clock_gettime is not routed through the vDSO and the clocksource is
separate. Therefore, we simply never match on the related syscall
numbers under I-pipe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Modeled after EVL. Should mitigate the clocksource switching issue with 
5.10+ and Dovetail.

 .../kernel/dovetail/pipeline/vdso_fallback.h  | 73 +++++++++++++++++++
 .../kernel/ipipe/pipeline/vdso_fallback.h     | 16 ++++
 kernel/cobalt/posix/syscall.c                 |  4 +
 3 files changed, 93 insertions(+)
 create mode 100644 include/cobalt/kernel/dovetail/pipeline/vdso_fallback.h
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/vdso_fallback.h

diff --git a/include/cobalt/kernel/dovetail/pipeline/vdso_fallback.h b/include/cobalt/kernel/dovetail/pipeline/vdso_fallback.h
new file mode 100644
index 0000000000..07de643e43
--- /dev/null
+++ b/include/cobalt/kernel/dovetail/pipeline/vdso_fallback.h
@@ -0,0 +1,73 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
+ * Copyright (c) Siemens AG, 2021
+ */
+
+#ifndef _COBALT_KERNEL_PIPELINE_VDSO_FALLBACK_H
+#define _COBALT_KERNEL_PIPELINE_VDSO_FALLBACK_H
+
+#include <cobalt/kernel/clock.h>
+#include <cobalt/kernel/timer.h>
+#include <xenomai/posix/clock.h>
+
+#define is_clock_gettime(__nr)		((__nr) == __NR_clock_gettime)
+
+#ifndef __NR_clock_gettime64
+#define is_clock_gettime64(__nr)	0
+#else
+#define is_clock_gettime64(__nr)	((__nr) == __NR_clock_gettime64)
+#endif
+
+static __always_inline bool 
+pipeline_handle_vdso_fallback(int nr, struct pt_regs *regs)
+{
+	struct __kernel_old_timespec __user *u_old_ts;
+	struct __kernel_timespec uts, __user *u_uts;
+	struct __kernel_old_timespec old_ts;
+	struct timespec64 ts64;
+	int clock_id, ret = 0;
+	unsigned long args[6];
+
+	if (!is_clock_gettime(nr) && !is_clock_gettime64(nr))
+		return false;
+
+	/*
+	 * We need to fetch the args again because not all archs use the same
+	 * calling convention for Linux and Xenomai syscalls.
+	 */
+	syscall_get_arguments(current, regs, args);
+
+	clock_id = (int)args[0];
+	switch (clock_id) {
+	case CLOCK_MONOTONIC:
+		ns2ts(&ts64, xnclock_read_monotonic(&nkclock));
+		break;
+	case CLOCK_REALTIME:
+		ns2ts(&ts64, xnclock_read_realtime(&nkclock));
+		break;
+	default:
+		return false;
+	}
+
+	if (is_clock_gettime(nr)) {
+		old_ts.tv_sec = (__kernel_old_time_t)ts64.tv_sec;
+		old_ts.tv_nsec = ts64.tv_nsec;
+		u_old_ts = (struct __kernel_old_timespec __user *)args[1];
+		if (raw_copy_to_user(u_old_ts, &old_ts, sizeof(old_ts)))
+			ret = -EFAULT;
+	} else if (is_clock_gettime64(nr)) {
+		uts.tv_sec = ts64.tv_sec;
+		uts.tv_nsec = ts64.tv_nsec;
+		u_uts = (struct __kernel_timespec __user *)args[1];
+		if (raw_copy_to_user(u_uts, &uts, sizeof(uts)))
+			ret = -EFAULT;
+	}
+
+	__xn_status_return(regs, ret);
+
+	return true;
+}
+
+#endif /* !_COBALT_KERNEL_PIPELINE_VDSO_FALLBACK_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/vdso_fallback.h b/include/cobalt/kernel/ipipe/pipeline/vdso_fallback.h
new file mode 100644
index 0000000000..f9ea3886ba
--- /dev/null
+++ b/include/cobalt/kernel/ipipe/pipeline/vdso_fallback.h
@@ -0,0 +1,16 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) Siemens AG, 2021
+ */
+
+#ifndef _COBALT_KERNEL_PIPELINE_VDSO_FALLBACK_H
+#define _COBALT_KERNEL_PIPELINE_VDSO_FALLBACK_H
+
+static __always_inline bool 
+pipeline_handle_vdso_fallback(int nr, struct pt_regs *regs)
+{
+	return false;
+}
+
+#endif /* !_COBALT_KERNEL_PIPELINE_VDSO_FALLBACK_H */
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index b7177042e7..cd72b22d14 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -26,6 +26,7 @@
 #include <cobalt/kernel/vdso.h>
 #include <cobalt/kernel/init.h>
 #include <pipeline/kevents.h>
+#include <pipeline/vdso_fallback.h>
 #include <asm/syscall.h>
 #include "internal.h"
 #include "thread.h"
@@ -656,6 +657,9 @@ linux_syscall:
 	if (!__xn_rootcall_p(regs, &code))
 		goto bad_syscall;
 
+	if (pipeline_handle_vdso_fallback(code, regs))
+		return KEVENT_STOP;
+
 	/*
 	 * We know this is a Cobalt thread since it runs over the head
 	 * domain, however the current syscall should be handled by
-- 
2.26.2

