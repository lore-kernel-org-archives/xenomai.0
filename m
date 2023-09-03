Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8503D9C
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:08 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202309031505010b04f3b5ec0cd208db
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=0Q1nisjs7ilUX6epMtYFYc1jRDcXWKGzFfpRxvMyuhg=;
 b=V2NZevwJdk3ijacrSeQ036Go1UB+sYJBSXuglvmk0jvCKEE5AOcCnhcVffrHGsnOofkBIM
 /9xgIhzmIwRNEHIJvtIhsXyY1xBLZSjWefjQRuE9GIukCMMm2ZjqBuVqkRbRBrJI+MKNcASH
 c0SfTVV6KWiAA8Z3EqsdJpfWOAQHo=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 13/20] kernel/cobalt: Remove VDSO support
Date: Sun,  3 Sep 2023 17:04:50 +0200
Message-Id: <c5b2aaa8f83279a059745502f38df0686a1a2151.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

No longer used, and userspace no longer expects it with the latest ABI
revision.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/Makefile.am          |   1 -
 include/cobalt/kernel/vdso.h               |  49 ---------
 include/cobalt/sys/cobalt.h                |   1 -
 include/cobalt/uapi/asm-generic/features.h |   4 +-
 include/cobalt/uapi/kernel/Makefile.am     |   4 +-
 include/cobalt/uapi/kernel/urw.h           | 113 ---------------------
 include/cobalt/uapi/kernel/vdso.h          |  66 ------------
 kernel/cobalt/clock.c                      |   2 -
 kernel/cobalt/dovetail/kevents.c           |   1 -
 kernel/cobalt/init.c                       |   1 -
 kernel/cobalt/posix/memory.c               |  21 ----
 kernel/cobalt/posix/process.c              |   1 -
 kernel/cobalt/posix/syscall.c              |   3 -
 13 files changed, 3 insertions(+), 264 deletions(-)
 delete mode 100644 include/cobalt/kernel/vdso.h
 delete mode 100644 include/cobalt/uapi/kernel/urw.h
 delete mode 100644 include/cobalt/uapi/kernel/vdso.h

diff --git a/include/cobalt/kernel/Makefile.am b/include/cobalt/kernel/Makefile.am
index 6413481f8b..aa6d1de8a5 100644
--- a/include/cobalt/kernel/Makefile.am
+++ b/include/cobalt/kernel/Makefile.am
@@ -31,7 +31,6 @@ noinst_HEADERS =	\
 	timer.h		\
 	trace.h		\
 	tree.h		\
-	vdso.h		\
 	vfile.h
 
 SUBDIRS = rtdm
diff --git a/include/cobalt/kernel/vdso.h b/include/cobalt/kernel/vdso.h
deleted file mode 100644
index 7da88a7309..0000000000
--- a/include/cobalt/kernel/vdso.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * Copyright (C) 2009 Wolfgang Mauerer <wolfgang.mauerer@siemens.com>.
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
-#ifndef _COBALT_KERNEL_VDSO_H
-#define _COBALT_KERNEL_VDSO_H
-
-#include <linux/time.h>
-#include <asm/barrier.h>
-#include <asm/atomic.h>
-#include <asm/processor.h>
-#include <cobalt/uapi/kernel/vdso.h>
-
-extern struct xnvdso *nkvdso;
-
-/*
- * Define the available feature set here. We have a single feature
- * defined for now, only in the I-pipe case.
- */
-#ifdef CONFIG_IPIPE_HAVE_HOSTRT
-
-#define XNVDSO_FEATURES XNVDSO_FEAT_HOST_REALTIME
-
-static inline struct xnvdso_hostrt_data *get_hostrt_data(void)
-{
-	return &nkvdso->hostrt_data;
-}
-
-#else
-
-#define XNVDSO_FEATURES 0
-
-#endif
-
-#endif /* _COBALT_KERNEL_VDSO_H */
diff --git a/include/cobalt/sys/cobalt.h b/include/cobalt/sys/cobalt.h
index 46096e8801..39c9a8493a 100644
--- a/include/cobalt/sys/cobalt.h
+++ b/include/cobalt/sys/cobalt.h
@@ -29,7 +29,6 @@
 #include <boilerplate/atomic.h>
 #include <boilerplate/list.h>
 #include <cobalt/uapi/kernel/synch.h>
-#include <cobalt/uapi/kernel/vdso.h>
 #include <cobalt/uapi/corectl.h>
 #include <cobalt/uapi/mutex.h>
 #include <cobalt/uapi/event.h>
diff --git a/include/cobalt/uapi/asm-generic/features.h b/include/cobalt/uapi/asm-generic/features.h
index 4f069b1ceb..4b0635d0c7 100644
--- a/include/cobalt/uapi/asm-generic/features.h
+++ b/include/cobalt/uapi/asm-generic/features.h
@@ -25,8 +25,8 @@
 struct cobalt_featinfo {
 	/* Used to be real-time clock frequency. */
 	__u64 __reserved1;
-	/** Offset of nkvdso in the sem heap. */
-	__u32 vdso_offset;
+	/* Used to be vdso_offset. */
+	__u32 __reserved2;
 	/** ABI revision level. */
 	__u32 feat_abirev;
 	/** Available feature set. */
diff --git a/include/cobalt/uapi/kernel/Makefile.am b/include/cobalt/uapi/kernel/Makefile.am
index 12e1b37285..093d917bdb 100644
--- a/include/cobalt/uapi/kernel/Makefile.am
+++ b/include/cobalt/uapi/kernel/Makefile.am
@@ -7,6 +7,4 @@ includesub_HEADERS =	\
 	synch.h		\
 	thread.h	\
 	trace.h		\
-	types.h		\
-	urw.h		\
-	vdso.h
+	types.h
diff --git a/include/cobalt/uapi/kernel/urw.h b/include/cobalt/uapi/kernel/urw.h
deleted file mode 100644
index fcfde21a02..0000000000
--- a/include/cobalt/uapi/kernel/urw.h
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * Copyright (C) 2013 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _COBALT_UAPI_KERNEL_URW_H
-#define _COBALT_UAPI_KERNEL_URW_H
-
-#include <linux/types.h>
-
-/*
- * A restricted version of the kernel seqlocks with a slightly
- * different interface, allowing for unsynced reads with concurrent
- * write detection, without serializing writers.  Caller should
- * provide for proper locking to deal with concurrent updates.
- *
- * urw_t lock = URW_INITIALIZER;
- * urwstate_t tmp;
- *
- * unsynced_read_block(&tmp, &lock) {
- *          (will redo until clean read)...
- * }
- *
- * unsynced_write_block(&tmp, &lock) {
- *          ...
- * }
- *
- * This code was inspired by Wolfgang Mauerer's linux/seqlock.h
- * adaptation for Xenomai 2.6 to support the VDSO feature.
- */
-
-typedef struct {
-	__u32 sequence;
-} urw_t;
-
-typedef struct {
-	__u32 token;
-	__u32 dirty;
-} urwstate_t;
-
-#define URW_INITIALIZER     { 0 }
-#define DEFINE_URW(__name)  urw_t __name = URW_INITIALIZER
-
-#ifndef READ_ONCE
-#define READ_ONCE ACCESS_ONCE
-#endif
-
-static inline void __try_read_start(const urw_t *urw, urwstate_t *tmp)
-{
-	__u32 token;
-repeat:
-	token = READ_ONCE(urw->sequence);
-	smp_rmb();
-	if (token & 1) {
-		cpu_relax();
-		goto repeat;
-	}
-
-	tmp->token = token;
-	tmp->dirty = 1;
-}
-
-static inline void __try_read_end(const urw_t *urw, urwstate_t *tmp)
-{
-	smp_rmb();
-	if (urw->sequence != tmp->token) {
-		__try_read_start(urw, tmp);
-		return;
-	}
-
-	tmp->dirty = 0;
-}
-
-static inline void __do_write_start(urw_t *urw, urwstate_t *tmp)
-{
-	urw->sequence++;
-	tmp->dirty = 1;
-	smp_wmb();
-}
-
-static inline void __do_write_end(urw_t *urw, urwstate_t *tmp)
-{
-	smp_wmb();
-	tmp->dirty = 0;
-	urw->sequence++;
-}
-
-static inline void unsynced_rw_init(urw_t *urw)
-{
-	urw->sequence = 0;
-}
-
-#define unsynced_read_block(__tmp, __urw)		\
-	for (__try_read_start(__urw, __tmp);		\
-	     (__tmp)->dirty; __try_read_end(__urw, __tmp))
-
-#define unsynced_write_block(__tmp, __urw)		\
-	for (__do_write_start(__urw, __tmp);		\
-	     (__tmp)->dirty; __do_write_end(__urw, __tmp))
-
-#endif /* !_COBALT_UAPI_KERNEL_URW_H */
diff --git a/include/cobalt/uapi/kernel/vdso.h b/include/cobalt/uapi/kernel/vdso.h
deleted file mode 100644
index 5b9b1b66b2..0000000000
--- a/include/cobalt/uapi/kernel/vdso.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * Copyright (C) 2009 Wolfgang Mauerer <wolfgang.mauerer@siemens.com>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _COBALT_UAPI_KERNEL_VDSO_H
-#define _COBALT_UAPI_KERNEL_VDSO_H
-
-#include <cobalt/uapi/kernel/urw.h>
-
-/*
- * I-pipe only. Dovetail enables the common vDSO for getting
- * CLOCK_REALTIME timestamps from the out-of-band stage
- * (XNVDSO_FEAT_HOST_REALTIME is cleared in this case).
- */
-struct xnvdso_hostrt_data {
-	__u64 wall_sec;
-	__u64 wtom_sec;
-	__u64 cycle_last;
-	__u64 mask;
-	__u32 wall_nsec;
-	__u32 wtom_nsec;
-	__u32 mult;
-	__u32 shift;
-	__u32 live;
-	urw_t lock;
-};
-
-/*
- * Data shared between the Cobalt kernel and applications, which lives
- * in the shared memory heap (COBALT_MEMDEV_SHARED).
- * xnvdso_hostrt_data.features tells which data is present. Notice
- * that struct xnvdso may only grow, but never shrink.
- */
-struct xnvdso {
-	__u64 features;
-	/* XNVDSO_FEAT_HOST_REALTIME */
-	struct xnvdso_hostrt_data hostrt_data;
-	/* XNVDSO_FEAT_WALLCLOCK_OFFSET */
-	__u64 wallclock_offset;
-};
-
-/* For each shared feature, add a flag below. */
-
-#define XNVDSO_FEAT_HOST_REALTIME	0x0000000000000001ULL
-#define XNVDSO_FEAT_WALLCLOCK_OFFSET	0x0000000000000002ULL
-
-static inline int xnvdso_test_feature(struct xnvdso *vdso,
-				      __u64 feature)
-{
-	return (vdso->features & feature) != 0;
-}
-
-#endif /* !_COBALT_UAPI_KERNEL_VDSO_H */
diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index 2b9efad4e7..fbb7ddbe95 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -22,7 +22,6 @@
 #include <cobalt/kernel/timer.h>
 #include <cobalt/kernel/clock.h>
 #include <cobalt/kernel/arith.h>
-#include <cobalt/kernel/vdso.h>
 #include <cobalt/uapi/time.h>
 #include <asm/xenomai/calibration.h>
 #include <trace/events/cobalt-core.h>
@@ -292,7 +291,6 @@ void xnclock_set_wallclock(xnticks_t epoch_ns)
 	old_offset_ns = nkclock.wallclock_offset;
 	offset_ns = (xnsticks_t)(epoch_ns - xnclock_core_read_monotonic());
 	nkclock.wallclock_offset = offset_ns;
-	nkvdso->wallclock_offset = offset_ns;
 	xnclock_apply_offset(&nkclock, offset_ns - old_offset_ns);
 	xnlock_put_irqrestore(&nklock, s);
 }
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 4da4f51b7a..817aa954dc 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -14,7 +14,6 @@
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/thread.h>
 #include <cobalt/kernel/clock.h>
-#include <cobalt/kernel/vdso.h>
 #include <cobalt/kernel/init.h>
 #include <rtdm/driver.h>
 #include <trace/events/cobalt-core.h>
diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index 5168b56035..509ba3fc4c 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -28,7 +28,6 @@
 #include <cobalt/kernel/ppd.h>
 #include <cobalt/kernel/pipe.h>
 #include <cobalt/kernel/select.h>
-#include <cobalt/kernel/vdso.h>
 #include <rtdm/fd.h>
 #include "rtdm/internal.h"
 #include "posix/internal.h"
diff --git a/kernel/cobalt/posix/memory.c b/kernel/cobalt/posix/memory.c
index 25cc784ea9..79db01cebd 100644
--- a/kernel/cobalt/posix/memory.c
+++ b/kernel/cobalt/posix/memory.c
@@ -23,7 +23,6 @@
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
 #include <rtdm/driver.h>
-#include <cobalt/kernel/vdso.h>
 #include "process.h"
 #include "memory.h"
 
@@ -31,9 +30,6 @@
 #define UMM_SHARED   1	/* Shared user-mapped memory heap */
 #define SYS_GLOBAL   2	/* System heap (not mmapped) */
 
-struct xnvdso *nkvdso;
-EXPORT_SYMBOL_GPL(nkvdso);
-
 static void umm_vmopen(struct vm_area_struct *vma)
 {
 	struct cobalt_umm *umm = vma->vm_private_data;
@@ -252,12 +248,6 @@ static struct rtdm_device sysmem_device = {
 	.label = COBALT_MEMDEV_SYS,
 };
 
-static inline void init_vdso(void)
-{
-	nkvdso->features = XNVDSO_FEATURES;
-	nkvdso->wallclock_offset = nkclock.wallclock_offset;
-}
-
 int cobalt_memdev_init(void)
 {
 	int ret;
@@ -269,14 +259,6 @@ int cobalt_memdev_init(void)
 
 	cobalt_umm_set_name(&cobalt_kernel_ppd.umm, "shared heap");
 
-	nkvdso = cobalt_umm_alloc(&cobalt_kernel_ppd.umm, sizeof(*nkvdso));
-	if (nkvdso == NULL) {
-		ret = -ENOMEM;
-		goto fail_vdso;
-	}
-
-	init_vdso();
-
 	ret = rtdm_dev_register(umm_devices + UMM_PRIVATE);
 	if (ret)
 		goto fail_private;
@@ -296,8 +278,6 @@ fail_sysmem:
 fail_shared:
 	rtdm_dev_unregister(umm_devices + UMM_PRIVATE);
 fail_private:
-	cobalt_umm_free(&cobalt_kernel_ppd.umm, nkvdso);
-fail_vdso:
 	cobalt_umm_destroy(&cobalt_kernel_ppd.umm);
 
 	return ret;
@@ -308,7 +288,6 @@ void cobalt_memdev_cleanup(void)
 	rtdm_dev_unregister(&sysmem_device);
 	rtdm_dev_unregister(umm_devices + UMM_SHARED);
 	rtdm_dev_unregister(umm_devices + UMM_PRIVATE);
-	cobalt_umm_free(&cobalt_kernel_ppd.umm, nkvdso);
 	cobalt_umm_destroy(&cobalt_kernel_ppd.umm);
 }
 
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 1abc86f37b..23ed913bb2 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -44,7 +44,6 @@
 #include <cobalt/kernel/trace.h>
 #include <cobalt/kernel/stat.h>
 #include <cobalt/kernel/ppd.h>
-#include <cobalt/kernel/vdso.h>
 #include <cobalt/kernel/thread.h>
 #include <cobalt/uapi/signal.h>
 #include <cobalt/uapi/syscall.h>
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 59c45d0499..66dd1aec85 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -23,7 +23,6 @@
 #include <linux/unistd.h>
 #include <cobalt/uapi/corectl.h>
 #include <cobalt/kernel/tree.h>
-#include <cobalt/kernel/vdso.h>
 #include <cobalt/kernel/init.h>
 #include <pipeline/kevents.h>
 #include <pipeline/vdso_fallback.h>
@@ -331,8 +330,6 @@ static COBALT_SYSCALL(bind, lostage,
 	f->feat_abirev = XENOMAI_ABI_REV;
 	collect_arch_features(f);
 
-	f->vdso_offset = cobalt_umm_offset(&cobalt_ppd_get(1)->umm, nkvdso);
-
 	if (cobalt_copy_to_user(u_breq, &breq, sizeof(breq)))
 		return -EFAULT;
 
-- 
2.35.3

