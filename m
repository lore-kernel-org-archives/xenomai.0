Message-ID: <4735DC17.1070003@domain.hid>
Date: Sat, 10 Nov 2007 17:28:07 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <473391B0.5040809@domain.hid> <4733A2B8.8070100@domain.hid>
	<47344759.4020505@domain.hid> <473484C6.6050101@domain.hid>
	<473492EF.6090309@domain.hid> <4734995E.7090105@domain.hid>
In-Reply-To: <4734995E.7090105@domain.hid>
Content-Type: multipart/mixed; boundary="------------040402090302000306040406"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] User space drivers on PPC440
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040402090302000306040406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Steven A. Falco wrote:
> Solved.  As you pointed out, Xenomai inverts the returned value from
> request_region.  So, that was a bug in my application.
> 
> However, turns out that instead of request_region, I have to use
> request_mem_region.  This is because the I/O region only goes up to
> 2^32, but the mem region goes up to 2^64.
> 
> So, attached is a patch to add two new syscalls: rt_misc_get_mem_region
> and rt_misc_put_mem_region.
> 

Thanks. At this chance, I've reworked the I/O region support to
introduce descriptors, so that this API conforms to the
one-descriptor-per-object rule commonly followed by other services from
the native skin. I've merged your MMIO support on top of this. The added
bonus is that auto-cleanup upon process exit becomes available with I/O
regions too, since we now have the proper descriptor to hold the cleanup
data.

The calls supporting this scheme are named rt_io_get_region, and
rt_io_put_region, taking a RT_IOREGION object descriptor to hold the
internal resource information. The rt_misc_io_get/put_region API is now
deprecated starting with 2.4-rc6, albeit still available to allow for
smooth transition; one will only get a warning as a reminder to upgrade
to the new calls when using the old ones. e.g.

RT_IOREGION iorn;

rt_io_get_region(&iorn, label, start, len, IORN_IOPORT)
is equivalent to calling:
rt_misc_get_io_region(start, len, label)

the same way,

rt_io_get_region(&iorn, label, start, len, IORN_MEMORY)
is equivalent to calling:
rt_misc_get_mem_region(start, len, label)

Conversely,

rt_io_put_region(&iorn)
is equivalent to calling:
rt_misc_put_io/mem_region(start, len)

-- 
Philippe.

--------------040402090302000306040406
Content-Type: text/x-patch;
 name="introduce-io-region-descriptors.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="introduce-io-region-descriptors.patch"

Index: include/native/misc.h
===================================================================
--- include/native/misc.h	(revision 3166)
+++ include/native/misc.h	(working copy)
@@ -24,21 +24,109 @@
 
 #include <native/types.h>
 
-#if !defined(__KERNEL__) && !defined(__XENO_SIM__)
+#define IORN_IOPORT	0x1
+#define IORN_MEMORY	0x2
 
+typedef struct rt_ioregion_placeholder {
+	xnhandle_t opaque;
+	/*
+	 * We keep the region start and length in the userland
+	 * placeholder to support deprecated rt_misc_io_*() calls.
+	 */
+	uint64_t start;
+	uint64_t len;
+} RT_IOREGION_PLACEHOLDER;
+
+#if defined(__KERNEL__) || defined(__XENO_SIM__)
+
+#include <native/ppd.h>
+
+#define XENO_IOREGION_MAGIC 0x55550b0b
+
+typedef struct rt_ioregion {
+
+	unsigned magic;		/* !< Magic code - must be first */
+
+	xnhandle_t handle;	/* !< Handle in registry -- must be registered. */
+
+	uint64_t start;		/* !< Start of I/O region. */
+
+	uint64_t len;		/* !< Length of I/O region. */
+
+	char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
+
+	int flags;		/* !< Operation flags. */
+
+	pid_t cpid;		/* !< Creator's pid. */
+
+	xnholder_t rlink;	/* !< Link in resource queue. */
+
+#define rlink2ioregion(ln)	container_of(ln, RT_IOREGION, rlink)
+
+	xnqueue_t *rqueue;     /* !< Backpointer to resource queue. */
+
+} RT_IOREGION;
+
+int rt_ioregion_delete(RT_IOREGION *iorn);
+
+static inline void __native_ioregion_flush_rq(xnqueue_t *rq)
+{
+	xeno_flush_rq(RT_IOREGION, rq, ioregion);
+}
+
+static inline int __native_misc_pkg_init(void)
+{
+	return 0;
+}
+
+static inline void __native_misc_pkg_cleanup(void)
+{
+	__native_ioregion_flush_rq(&__native_global_rholder.ioregionq);
+}
+
+#else /* !(__KERNEL__ && __XENO_SIM__) */
+
+typedef RT_IOREGION_PLACEHOLDER RT_IOREGION;
+
 #ifdef __cplusplus
 extern "C" {
 #endif
 
 /* Public interface. */
 
-int rt_misc_get_io_region(uint64_t start,
-			  unsigned long len,
-			  const char *label);
+int rt_io_get_region(RT_IOREGION *iorn,
+		     const char *name,
+		     uint64_t start,
+		     uint64_t len,
+		     int flags);
 
-void rt_misc_put_io_region(uint64_t start,
-			   unsigned long len);
+int rt_io_put_region(RT_IOREGION *iorn);
 
+__deprecated_call__
+static inline int  rt_misc_get_io_region(unsigned long start,
+					 unsigned long len,
+					 const char *label)
+{
+	RT_IOREGION iorn;
+
+	return rt_io_get_region(&iorn, label, (uint64_t)start,
+				(uint64_t)len, IORN_IOPORT);
+}
+
+__deprecated_call__
+static inline int rt_misc_put_io_region(unsigned long start,
+					unsigned long len)
+{
+	RT_IOREGION iorn;
+
+	iorn.opaque = XN_NO_HANDLE;
+	iorn.start = (uint64_t)start;
+	iorn.len = (uint64_t)len;
+	rt_io_put_region(&iorn);
+
+	return 0;
+}
+
 #ifdef __cplusplus
 }
 #endif
Index: include/native/syscall.h
===================================================================
--- include/native/syscall.h	(revision 3166)
+++ include/native/syscall.h	(working copy)
@@ -113,8 +113,8 @@
 #define __native_pipe_write         87
 #define __native_pipe_stream        88
 #define __native_unimp_89           89
-#define __native_misc_get_io_region 90
-#define __native_misc_put_io_region 91
+#define __native_io_get_region      90
+#define __native_io_put_region      91
 #define __native_timer_ns2tsc       92
 #define __native_timer_tsc2ns       93
 #define __native_queue_write        94
Index: include/native/ppd.h
===================================================================
--- include/native/ppd.h	(revision 3166)
+++ include/native/ppd.h	(working copy)
@@ -41,6 +41,7 @@
 	xnqueue_t pipeq;
 	xnqueue_t queueq;
 	xnqueue_t semq;
+	xnqueue_t ioregionq;
 
 } xeno_rholder_t;
 
Index: src/skins/native/misc.c
===================================================================
--- src/skins/native/misc.c	(revision 3166)
+++ src/skins/native/misc.c	(working copy)
@@ -16,22 +16,21 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <stdio.h>
 #include <native/syscall.h>
-#include <native/intr.h>
+#include <native/misc.h>
 
 extern int __native_muxid;
 
-int rt_misc_get_io_region(uint64_t start,
-			  unsigned long len, const char *label)
+int rt_io_get_region(RT_IOREGION *iorn, const char *name,
+		     uint64_t start, uint64_t len, int flags)
 {
-	return XENOMAI_SKINCALL3(__native_muxid,
-				 __native_misc_get_io_region, &start, len,
-				 label);
+	return XENOMAI_SKINCALL5(__native_muxid,
+				 __native_io_get_region, iorn, name,
+				 &start, &len, flags);
 }
 
-void rt_misc_put_io_region(uint64_t start, unsigned long len)
+int rt_io_put_region(RT_IOREGION *iorn)
 {
-	XENOMAI_SKINCALL2(__native_muxid,
-			  __native_misc_put_io_region, &start, len);
+	return XENOMAI_SKINCALL1(__native_muxid,
+				 __native_io_put_region, iorn);
 }
Index: ksrc/skins/native/syscall.c
===================================================================
--- ksrc/skins/native/syscall.c	(revision 3166)
+++ ksrc/skins/native/syscall.c	(working copy)
@@ -36,6 +36,7 @@
 #include <native/alarm.h>
 #include <native/intr.h>
 #include <native/pipe.h>
+#include <native/misc.h>
 
 /* This file implements the Xenomai syscall wrappers;
  *
@@ -3656,60 +3657,178 @@
 #endif /* CONFIG_XENO_OPT_NATIVE_PIPE */
 
 /*
- * int __rt_misc_get_io_region(uint64_t *start,
- *                             unsigned long len,
- *                             const char *label)
+ * int __rt_io_get_region(RT_IOREGION_PLACEHOLDER *ph,
+ *                        const char *name,
+ *                        uint64_t *startp,
+ *                        uint64_t *lenp,
+ *                        int flags)
  */
 
-static int __rt_misc_get_io_region(struct task_struct *curr,
-				   struct pt_regs *regs)
+static int __rt_io_get_region(struct task_struct *curr,
+			      struct pt_regs *regs)
 {
-	unsigned long len;
-	uint64_t start;
-	char label[64];
+	RT_IOREGION_PLACEHOLDER ph;
+	uint64_t start, len;
+	RT_IOREGION *iorn;
+	int err, flags;
+	spl_t s;
 
 	if (!__xn_access_ok
-	    (curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(start)))
+	    (curr, VERIFY_WRITE, __xn_reg_arg1(regs), sizeof(ph)))
 		return -EFAULT;
 
 	if (!__xn_access_ok
-	    (curr, VERIFY_READ, __xn_reg_arg3(regs), sizeof(label)))
+	    (curr, VERIFY_READ, __xn_reg_arg2(regs), sizeof(iorn->name)))
 		return -EFAULT;
 
-	__xn_copy_from_user(curr, &start, (void __user *)__xn_reg_arg1(regs),
+	if (!__xn_access_ok
+	    (curr, VERIFY_READ, __xn_reg_arg3(regs), sizeof(start)))
+		return -EFAULT;
+
+	if (!__xn_access_ok
+	    (curr, VERIFY_READ, __xn_reg_arg4(regs), sizeof(len)))
+		return -EFAULT;
+
+	iorn = (RT_IOREGION *)xnmalloc(sizeof(*iorn));
+
+	if (!iorn)
+		return -ENOMEM;
+
+	__xn_strncpy_from_user(curr, iorn->name,
+			       (const char __user *)__xn_reg_arg2(regs),
+			       sizeof(iorn->name) - 1);
+	iorn->name[sizeof(iorn->name) - 1] = '\0';
+
+	err = xnregistry_enter(iorn->name, iorn, &iorn->handle, NULL);
+
+	if (err)
+		goto fail;
+
+	__xn_copy_from_user(curr, &start, (void __user *)__xn_reg_arg3(regs),
 			    sizeof(start));
 
-	__xn_strncpy_from_user(curr, label,
-			       (const char __user *)__xn_reg_arg3(regs),
-			       sizeof(label) - 1);
-	label[sizeof(label) - 1] = '\0';
+	__xn_copy_from_user(curr, &len, (void __user *)__xn_reg_arg4(regs),
+			    sizeof(len));
 
-	len = __xn_reg_arg2(regs);
+	flags = __xn_reg_arg5(regs);
 
-	return request_region(start, len, label) ? 0 : -EBUSY;
+	if (flags & IORN_IOPORT)
+		err = request_region(start, len, iorn->name) ? 0 : -EBUSY;
+	else if (flags & IORN_MEMORY)
+		err = request_mem_region(start, len, iorn->name) ? 0 : -EBUSY;
+	else
+		err = -EINVAL;
+
+	if (unlikely(err != 0))
+		goto fail;
+
+	iorn->magic = XENO_IOREGION_MAGIC;
+	iorn->start = start;
+	iorn->len = len;
+	iorn->flags = flags;
+	inith(&iorn->rlink);
+	iorn->rqueue = &xeno_get_rholder()->ioregionq;
+	xnlock_get_irqsave(&nklock, s);
+	appendq(iorn->rqueue, &iorn->rlink);
+	xnlock_put_irqrestore(&nklock, s);
+	iorn->cpid = curr->pid;
+	/* Copy back the registry handle to the ph struct. */
+	ph.opaque = iorn->handle;
+	ph.start = start;
+	ph.len = len;
+	__xn_copy_to_user(curr, (void __user *)__xn_reg_arg1(regs), &ph, sizeof(ph));
+
+	return 0;
+
+fail:
+	xnfree(iorn);
+
+	return err;
 }
 
+/* Provided for auto-cleanup support. */
+int rt_ioregion_delete(RT_IOREGION *iorn)
+{
+	uint64_t start, len;
+	int flags;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	flags = iorn->flags;
+	start = iorn->start;
+	len = iorn->len;
+	removeq(iorn->rqueue, &iorn->rlink);
+	xnregistry_remove(iorn->handle);
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	if (flags & IORN_IOPORT)
+		release_region(start, len);
+	else if (flags & IORN_MEMORY)
+		release_mem_region(start, len);
+
+	return 0;
+}
+
 /*
- * int __rt_misc_put_io_region(uint64_t *start,
- *                             unsigned long len)
+ * int __rt_io_put_region(RT_IOREGION_PLACEHOLDER *ph)
  */
 
-static int __rt_misc_put_io_region(struct task_struct *curr,
-				   struct pt_regs *regs)
+static int __rt_io_put_region(struct task_struct *curr,
+			      struct pt_regs *regs)
 {
-	unsigned long len;
-	uint64_t start;
+	RT_IOREGION_PLACEHOLDER ph;
+	uint64_t start, len;
+	RT_IOREGION *iorn;
+	int flags;
+	spl_t s;
 
 	if (!__xn_access_ok
-	    (curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(start)))
+	    (curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(ph)))
 		return -EFAULT;
 
-	__xn_copy_from_user(curr, &start, (void __user *)__xn_reg_arg1(regs),
-			    sizeof(start));
+	__xn_copy_from_user(curr, &ph, (void __user *)__xn_reg_arg1(regs),
+			    sizeof(ph));
 
-	len = __xn_reg_arg2(regs);
-	release_region(start, len);
+	xnlock_get_irqsave(&nklock, s);
 
+	if (unlikely(ph.opaque == XN_NO_HANDLE)) { /* Legacy compat. */
+		xnqueue_t *rq = &xeno_get_rholder()->ioregionq;
+		RT_IOREGION *_iorn;
+		xnholder_t *holder;
+
+		for (holder = getheadq(rq), iorn = NULL;
+		     holder; holder = nextq(rq, holder)) {
+			_iorn = rlink2ioregion(holder);
+			if (_iorn->start == ph.start && _iorn->len == ph.len) {
+				iorn = _iorn;
+				break;
+			}
+		}
+	} else
+		iorn = (RT_IOREGION *)xnregistry_fetch(ph.opaque);
+
+	if (iorn == NULL) {
+		xnlock_put_irqrestore(&nklock, s);
+		return -ESRCH;
+	}
+
+	flags = iorn->flags;
+	start = iorn->start;
+	len = iorn->len;
+	removeq(iorn->rqueue, &iorn->rlink);
+	xnregistry_remove(iorn->handle);
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	xnfree(iorn);
+
+	if (flags & IORN_IOPORT)
+		release_region(start, len);
+	else if (flags & IORN_MEMORY)
+		release_mem_region(start, len);
+
 	return 0;
 }
 
@@ -3746,6 +3865,7 @@
 		initq(&rh->pipeq);
 		initq(&rh->queueq);
 		initq(&rh->semq);
+		initq(&rh->ioregionq);
 
 		return &rh->ppd;
 
@@ -3761,6 +3881,7 @@
 		__native_pipe_flush_rq(&rh->pipeq);
 		__native_queue_flush_rq(&rh->queueq);
 		__native_sem_flush_rq(&rh->semq);
+		__native_ioregion_flush_rq(&rh->ioregionq);
 
 		xnarch_free_host_mem(rh, sizeof(*rh));
 
@@ -3867,10 +3988,10 @@
 	[__native_pipe_write] = {&__rt_pipe_write, __xn_exec_any},
 	[__native_pipe_stream] = {&__rt_pipe_stream, __xn_exec_any},
 	[__native_unimp_89] = {&__rt_call_not_available, __xn_exec_any},
-	[__native_misc_get_io_region] =
-	    {&__rt_misc_get_io_region, __xn_exec_lostage},
-	[__native_misc_put_io_region] =
-	    {&__rt_misc_put_io_region, __xn_exec_lostage},
+	[__native_io_get_region] =
+	    {&__rt_io_get_region, __xn_exec_lostage},
+	[__native_io_put_region] =
+	    {&__rt_io_put_region, __xn_exec_lostage},
 	[__native_timer_ns2tsc] = {&__rt_timer_ns2tsc, __xn_exec_any},
 	[__native_timer_tsc2ns] = {&__rt_timer_tsc2ns, __xn_exec_any},
 };
Index: ksrc/skins/native/module.c
===================================================================
--- ksrc/skins/native/module.c	(revision 3166)
+++ ksrc/skins/native/module.c	(working copy)
@@ -45,6 +45,7 @@
 #include <native/heap.h>
 #include <native/alarm.h>
 #include <native/intr.h>
+#include <native/misc.h>
 
 MODULE_DESCRIPTION("Native skin");
 MODULE_AUTHOR("rpm@xenomai.org");
@@ -80,6 +81,7 @@
 	initq(&__native_global_rholder.pipeq);
 	initq(&__native_global_rholder.queueq);
 	initq(&__native_global_rholder.semq);
+	initq(&__native_global_rholder.ioregionq);
 
 	err = xnpod_init();
 
@@ -93,11 +95,16 @@
 
 	xntbase_start(__native_tbase);
 
-	err = __native_task_pkg_init();
+	err = __native_misc_pkg_init();
 
 	if (err)
 		goto cleanup_pod;
 
+	err = __native_task_pkg_init();
+
+	if (err)
+		goto cleanup_misc;
+
 	err = __native_sem_pkg_init();
 
 	if (err)
@@ -192,6 +199,10 @@
 
 	__native_task_pkg_cleanup();
 
+      cleanup_misc:
+
+	__native_misc_pkg_cleanup();
+
       cleanup_pod:
 
 	xntbase_free(__native_tbase);
@@ -219,6 +230,7 @@
 	__native_event_pkg_cleanup();
 	__native_sem_pkg_cleanup();
 	__native_task_pkg_cleanup();
+	__native_misc_pkg_cleanup();
 	__native_syscall_cleanup();
 
 	xntbase_free(__native_tbase);

--------------040402090302000306040406--

