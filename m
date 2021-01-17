From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail v2 5/5] cobalt/apc: drop obsolete APC mechanism
Date: Sun, 17 Jan 2021 16:08:03 +0100
Message-Id: <20210117150803.477767-6-rpm@xenomai.org>
In-Reply-To: <20210117150803.477767-1-rpm@xenomai.org>
References: <20210117150803.477767-1-rpm@xenomai.org>
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

No more in-tree users.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/Makefile.am             |   1 -
 include/cobalt/kernel/apc.h                   |  32 ---
 .../cobalt/kernel/ipipe/pipeline/machine.h    |   2 -
 include/cobalt/kernel/rtdm/driver.h           |   1 -
 kernel/cobalt/ipipe/Makefile                  |   2 +-
 kernel/cobalt/ipipe/apc.c                     | 202 ------------------
 kernel/cobalt/ipipe/init.c                    |  19 --
 kernel/cobalt/procfs.c                        |  42 ----
 kernel/cobalt/rtdm/core.c                     |   1 -
 9 files changed, 1 insertion(+), 301 deletions(-)
 delete mode 100644 include/cobalt/kernel/apc.h
 delete mode 100644 kernel/cobalt/ipipe/apc.c

diff --git a/include/cobalt/kernel/Makefile.am b/include/cobalt/kernel/Makefile.am
index 4d9570241..6413481f8 100644
--- a/include/cobalt/kernel/Makefile.am
+++ b/include/cobalt/kernel/Makefile.am
@@ -1,7 +1,6 @@
 
 noinst_HEADERS =	\
 	ancillaries.h	\
-	apc.h		\
 	arith.h		\
 	assert.h	\
 	bufd.h		\
diff --git a/include/cobalt/kernel/apc.h b/include/cobalt/kernel/apc.h
deleted file mode 100644
index 45d70b146..000000000
--- a/include/cobalt/kernel/apc.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Copyright (C) 2012 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_KERNEL_APC_H
-#define _COBALT_KERNEL_APC_H
-
-int xnapc_alloc(const char *name,
-		void (*handler)(void *cookie),
-		void *cookie);
-
-void xnapc_free(int apc);
-
-void __xnapc_schedule(int apc);
-
-void xnapc_schedule(int apc);
-
-#endif /* !_COBALT_KERNEL_APC_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/machine.h b/include/cobalt/kernel/ipipe/pipeline/machine.h
index c7d2d68b4..32d5cd2a2 100644
--- a/include/cobalt/kernel/ipipe/pipeline/machine.h
+++ b/include/cobalt/kernel/ipipe/pipeline/machine.h
@@ -40,8 +40,6 @@ struct cobalt_pipeline {
 	struct ipipe_domain domain;
 	unsigned long timer_freq;
 	unsigned long clock_freq;
-	unsigned int apc_virq;
-	unsigned long apc_map;
 	unsigned int escalate_virq;
 #ifdef CONFIG_SMP
 	cpumask_t supported_cpus;
diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 581e7a5c0..0d3b5a5d0 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -40,7 +40,6 @@
 #include <cobalt/kernel/synch.h>
 #include <cobalt/kernel/select.h>
 #include <cobalt/kernel/clock.h>
-#include <cobalt/kernel/apc.h>
 #include <cobalt/kernel/init.h>
 #include <cobalt/kernel/ancillaries.h>
 #include <cobalt/kernel/tree.h>
diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
index 573b17947..1daa84440 100644
--- a/kernel/cobalt/ipipe/Makefile
+++ b/kernel/cobalt/ipipe/Makefile
@@ -2,4 +2,4 @@ ccflags-y += -I$(srctree)/kernel
 
 obj-y +=	pipeline.o
 
-pipeline-y :=	init.o intr.o kevents.o apc.o tick.o syscall.o
+pipeline-y :=	init.o intr.o kevents.o tick.o syscall.o
diff --git a/kernel/cobalt/ipipe/apc.c b/kernel/cobalt/ipipe/apc.c
deleted file mode 100644
index 715997727..000000000
--- a/kernel/cobalt/ipipe/apc.c
+++ /dev/null
@@ -1,202 +0,0 @@
-/*
- * Copyright (C) 2007,2012 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#include <linux/spinlock.h>
-#include <linux/ipipe.h>
-#include <asm/xenomai/machine.h>
-#include <cobalt/kernel/apc.h>
-
-/**
- * @ingroup cobalt_core
- * @defgroup cobalt_core_apc Asynchronous Procedure Calls
- *
- * Services for scheduling function calls in the Linux domain
- *
- * APC is the acronym for Asynchronous Procedure Call, a mean by which
- * activities from the Xenomai domain can schedule deferred
- * invocations of handlers to be run into the Linux domain, as soon as
- * possible when the Linux kernel gets back in control.
- *
- * Up to BITS_PER_LONG APC slots can be active at any point in time.
- *
- * APC support is built upon the interrupt pipeline's virtual
- * interrupt support.
- *
- * @{
- */
-static IPIPE_DEFINE_SPINLOCK(apc_lock);
-
-void apc_dispatch(unsigned int virq, void *arg)
-{
-	void (*handler)(void *), *cookie;
-	unsigned long *p;
-	int apc;
-
-	/*
-	 * CAUTION: The APC dispatch loop is not protected against a
-	 * handler becoming unavailable while processing the pending
-	 * queue; the software must make sure to uninstall all APCs
-	 * before eventually unloading any module that may contain APC
-	 * handlers. We keep the handler affinity with the poster's
-	 * CPU, so that the handler is invoked on the same CPU than
-	 * the code which called xnapc_schedule().
-	 */
-	raw_spin_lock(&apc_lock);
-
-	/* This is atomic linux context (non-threaded IRQ). */
-	p = &raw_cpu_ptr(&cobalt_machine_cpudata)->apc_pending;
-	while (*p) {
-		apc = ffnz(*p);
-		clear_bit(apc, p);
-		handler = cobalt_pipeline.apc_table[apc].handler;
-		cookie = cobalt_pipeline.apc_table[apc].cookie;
-		raw_cpu_ptr(&cobalt_machine_cpudata)->apc_shots[apc]++;
-		raw_spin_unlock(&apc_lock);
-		handler(cookie);
-		raw_spin_lock(&apc_lock);
-	}
-
-	raw_spin_unlock(&apc_lock);
-}
-
-/**
- * @fn int xnapc_alloc(const char *name,void (*handler)(void *cookie),void *cookie)
- *
- * @brief Allocate an APC slot.
- *
- * APC is the acronym for Asynchronous Procedure Call, a mean by which
- * activities from the Xenomai domain can schedule deferred
- * invocations of handlers to be run into the Linux domain, as soon as
- * possible when the Linux kernel gets back in control. Up to
- * BITS_PER_LONG APC slots can be active at any point in time. APC
- * support is built upon the interrupt pipeline's virtual interrupt
- * support.
- *
- * Any Linux kernel service which is callable from a regular Linux
- * interrupt handler is in essence available to APC handlers.
- *
- * @param name is a symbolic name identifying the APC which will get
- * reported through the /proc/xenomai/apc interface. Passing NULL to
- * create an anonymous APC is allowed.
- *
- * @param handler The address of the fault handler to call upon
- * exception condition. The handle will be passed the @a cookie value
- * unmodified.
- *
- * @param cookie A user-defined opaque pointer the APC handler
- * receives as its sole argument.
- *
- * @return a valid APC identifier is returned upon success, or a
- * negative error code otherwise:
- *
- * - -EINVAL is returned if @a handler is invalid.
- *
- * - -EBUSY is returned if no more APC slots are available.
- *
- * @coretags{unrestricted}
- */
-int xnapc_alloc(const char *name,
-		void (*handler)(void *cookie), void *cookie)
-{
-	unsigned long flags;
-	int apc;
-
-	if (handler == NULL)
-		return -EINVAL;
-
-	raw_spin_lock_irqsave(&apc_lock, flags);
-
-	if (cobalt_pipeline.apc_map == ~0) {
-		apc = -EBUSY;
-		goto out;
-	}
-
-	apc = ffz(cobalt_pipeline.apc_map);
-	__set_bit(apc, &cobalt_pipeline.apc_map);
-	cobalt_pipeline.apc_table[apc].handler = handler;
-	cobalt_pipeline.apc_table[apc].cookie = cookie;
-	cobalt_pipeline.apc_table[apc].name = name;
-out:
-	raw_spin_unlock_irqrestore(&apc_lock, flags);
-
-	return apc;
-}
-EXPORT_SYMBOL_GPL(xnapc_alloc);
-
-/**
- * @fn int xnapc_free(int apc)
- *
- * @brief Releases an APC slot.
- *
- * This service deallocates an APC slot obtained by xnapc_alloc().
- *
- * @param apc The APC id. to release, as returned by a successful call
- * to the xnapc_alloc() service.
- *
- * @coretags{unrestricted}
- */
-void xnapc_free(int apc)
-{
-	BUG_ON(apc < 0 || apc >= BITS_PER_LONG);
-	clear_bit(apc, &cobalt_pipeline.apc_map);
-	smp_mb__after_atomic();
-}
-EXPORT_SYMBOL_GPL(xnapc_free);
-
-void __xnapc_schedule(int apc)
-{
-	unsigned long *p = &raw_cpu_ptr(&cobalt_machine_cpudata)->apc_pending;
-
-	if (!__test_and_set_bit(apc, p))
-		ipipe_post_irq_root(cobalt_pipeline.apc_virq);
-}
-EXPORT_SYMBOL_GPL(__xnapc_schedule);
-
-/**
- * @fn static inline int xnapc_schedule(int apc)
- *
- * @brief Schedule an APC invocation.
- *
- * This service marks the APC as pending for the Linux domain, so that
- * its handler will be called as soon as possible, when the Linux
- * domain gets back in control.
- *
- * When posted from the Linux domain, the APC handler is fired as soon
- * as the interrupt mask is explicitly cleared by some kernel
- * code. When posted from the Xenomai domain, the APC handler is
- * fired as soon as the Linux domain is resumed, i.e. after Xenomai has
- * completed all its pending duties.
- *
- * @param apc The APC id. to schedule.
- *
- * This service can be called from:
- *
- * - Any domain context, albeit the usual calling place is from the
- * Xenomai domain.
- */
-void xnapc_schedule(int apc)
-{
-	unsigned long flags;
-
-	flags = ipipe_test_and_stall_head() & 1;
-	__xnapc_schedule(apc);
-	ipipe_restore_head(flags);
-}
-EXPORT_SYMBOL_GPL(xnapc_schedule);
-
-/** @} */
diff --git a/kernel/cobalt/ipipe/init.c b/kernel/cobalt/ipipe/init.c
index d901c417f..d61d150d7 100644
--- a/kernel/cobalt/ipipe/init.c
+++ b/kernel/cobalt/ipipe/init.c
@@ -10,7 +10,6 @@
 #include <linux/ipipe_tickdev.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/clock.h>
-#include <cobalt/kernel/apc.h>
 
 static unsigned long timerfreq_arg;
 module_param_named(timerfreq, timerfreq_arg, ulong, 0444);
@@ -18,8 +17,6 @@ module_param_named(timerfreq, timerfreq_arg, ulong, 0444);
 static unsigned long clockfreq_arg;
 module_param_named(clockfreq, clockfreq_arg, ulong, 0444);
 
-void apc_dispatch(unsigned int virq, void *arg);
-
 int __init pipeline_init(void)
 {
 	struct ipipe_sysinfo sysinfo;
@@ -53,18 +50,6 @@ int __init pipeline_init(void)
 
 	ipipe_register_head(&xnsched_realtime_domain, "Xenomai");
 
-	ret = -EBUSY;
-	virq = ipipe_alloc_virq();
-	if (virq == 0)
-		goto fail_apc;
-
-	cobalt_pipeline.apc_virq = virq;
-
-	ipipe_request_irq(ipipe_root_domain,
-			  cobalt_pipeline.apc_virq,
-			  apc_dispatch,
-			  NULL, NULL);
-
 	virq = ipipe_alloc_virq();
 	if (virq == 0)
 		goto fail_escalate;
@@ -87,10 +72,6 @@ fail_clock:
 		       cobalt_pipeline.escalate_virq);
 	ipipe_free_virq(cobalt_pipeline.escalate_virq);
 fail_escalate:
-	ipipe_free_irq(ipipe_root_domain,
-		       cobalt_pipeline.apc_virq);
-	ipipe_free_virq(cobalt_pipeline.apc_virq);
-fail_apc:
 	ipipe_unregister_head(&xnsched_realtime_domain);
 
 	if (cobalt_machine.cleanup)
diff --git a/kernel/cobalt/procfs.c b/kernel/cobalt/procfs.c
index c453ee370..0aaf691dd 100644
--- a/kernel/cobalt/procfs.c
+++ b/kernel/cobalt/procfs.c
@@ -18,7 +18,6 @@
  */
 #include <cobalt/kernel/lock.h>
 #include <cobalt/kernel/clock.h>
-#include <cobalt/kernel/apc.h>
 #include <cobalt/kernel/vfile.h>
 #include <cobalt/kernel/intr.h>
 #include <cobalt/kernel/heap.h>
@@ -174,45 +173,6 @@ static struct xnvfile_regular faults_vfile = {
 	.ops = &faults_vfile_ops,
 };
 
-static int apc_vfile_show(struct xnvfile_regular_iterator *it, void *data)
-{
-	int cpu, apc;
-
-	/* We assume the entire output fits in a single page. */
-
-	xnvfile_puts(it, "APC  ");
-
-	for_each_realtime_cpu(cpu)
-		xnvfile_printf(it, "        CPU%d", cpu);
-
-	for (apc = 0; apc < BITS_PER_LONG; apc++) {
-		if (!test_bit(apc, &cobalt_pipeline.apc_map))
-			continue; /* Not hooked. */
-
-		xnvfile_printf(it, "\n%3d: ", apc);
-
-		for_each_realtime_cpu(cpu)
-			xnvfile_printf(it, "%12lu",
-				       per_cpu(cobalt_machine_cpudata, cpu).apc_shots[apc]);
-
-		if (cobalt_pipeline.apc_table[apc].name)
-			xnvfile_printf(it, "    (%s)",
-				       cobalt_pipeline.apc_table[apc].name);
-	}
-
-	xnvfile_putc(it, '\n');
-
-	return 0;
-}
-
-static struct xnvfile_regular_ops apc_vfile_ops = {
-	.show = apc_vfile_show,
-};
-
-static struct xnvfile_regular apc_vfile = {
-	.ops = &apc_vfile_ops,
-};
-
 void xnprocfs_cleanup_tree(void)
 {
 #ifdef CONFIG_XENO_OPT_DEBUG
@@ -221,7 +181,6 @@ void xnprocfs_cleanup_tree(void)
 #endif
 	xnvfile_destroy_dir(&cobalt_debug_vfroot);
 #endif /* XENO_OPT_DEBUG */
-	xnvfile_destroy_regular(&apc_vfile);
 	xnvfile_destroy_regular(&faults_vfile);
 	xnvfile_destroy_regular(&version_vfile);
 	xnvfile_destroy_regular(&latency_vfile);
@@ -250,7 +209,6 @@ int __init xnprocfs_init_tree(void)
 	xnvfile_init_regular("latency", &latency_vfile, &cobalt_vfroot);
 	xnvfile_init_regular("version", &version_vfile, &cobalt_vfroot);
 	xnvfile_init_regular("faults", &faults_vfile, &cobalt_vfroot);
-	xnvfile_init_regular("apc", &apc_vfile, &cobalt_vfroot);
 #ifdef CONFIG_XENO_OPT_DEBUG
 	xnvfile_init_dir("debug", &cobalt_debug_vfroot, &cobalt_vfroot);
 #ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
index 843193a2b..2e5aeb44e 100644
--- a/kernel/cobalt/rtdm/core.c
+++ b/kernel/cobalt/rtdm/core.c
@@ -26,7 +26,6 @@
 #include <linux/anon_inodes.h>
 #include <cobalt/kernel/ppd.h>
 #include <cobalt/kernel/heap.h>
-#include <cobalt/kernel/apc.h>
 #include "rtdm/internal.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/cobalt-rtdm.h>
-- 
2.26.2


