Message-ID: <482C4560.3070200@domain.hid>
Date: Thu, 15 May 2008 16:14:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <2ff1a98a0805150612x62f8a1a9te843a27911244e72@domain.hid>
	<955c7c82b3624040fbf69ee97e7177dc@domain.hid>
In-Reply-To: <955c7c82b3624040fbf69ee97e7177dc@domain.hid>
Content-Type: multipart/mixed; boundary="------------040204060307000407020508"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] VxWorks skin problem concerning WIND_TCBstructure
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040204060307000407020508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Matthieu wrote:
> 
> On Thu, 15 May 2008 15:12:32 +0200, "Gilles Chanteperdrix"
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On Thu, May 15, 2008 at 11:28 AM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On Thu, May 15, 2008 at 8:10 AM, Matthieu
>>> <matthieu.connaulte_xenomai@domain.hid> wrote:
>>>  I think
>>>> that VxWorks Task Control Block ,implemeted by  WIND RIVER, is keeping
>> the
>>>> context in hard real-time. That's why I would like to know if there are
>>>> other possibilities ?
>>> Yes, there are possibilities: fix your code not to use such internal
>>> data as the WIND_TCB members.
>> Even VxWorks documentation considers accessing WIND_TCB directly as a
>> bad practice. See the doc of taskInfoGet at:
>>
>>
> http://spacegrant.colorado.edu/~dixonc/vxworks/docs/vxworks/ref/taskShow.html
>> So, what I would agree we can do is implement taskInfoGet.
>>
>> --
>>  Gilles
> 
> Well, what a great issue for me...
> 

The attached patch provides taskInfoGet(). Whether it does provide everything
you need from the task information block is another issue, but at least, you
would have the proper infrastructure to add the missing bits to.

-- 
Philippe.

--------------040204060307000407020508
Content-Type: text/x-diff;
 name="vxworks-taskinfoget.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vxworks-taskinfoget.patch"

Index: include/asm-ia64/system.h
===================================================================
--- include/asm-ia64/system.h	(revision 3786)
+++ include/asm-ia64/system.h	(working copy)
@@ -32,6 +32,8 @@
 #define XNARCH_THREAD_STACKSZ  KERNEL_STACK_SIZE
 
 #define xnarch_stack_size(tcb)  ((tcb)->stacksize)
+#define xnarch_stack_base(tcb)	((tcb)->stackbase)
+#define xnarch_stack_end(tcb)	((caddr_t)(tcb)->stackbase - (tcb)->stacksize)
 #define xnarch_user_task(tcb)   ((tcb)->user_task)
 #define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
 
Index: include/vxworks/syscall.h
===================================================================
--- include/vxworks/syscall.h	(revision 3786)
+++ include/vxworks/syscall.h	(working copy)
@@ -69,12 +69,14 @@
 #define __vxworks_wd_cancel        43
 #define __vxworks_wd_wait          44
 #define __vxworks_int_context      45
+#define __vxworks_taskinfo_get     46
 
 struct wind_arg_bulk {
 
     u_long a1;
     u_long a2;
     u_long a3;
+    u_long a4;
 };
 
 #ifdef __KERNEL__
Index: include/vxworks/vxworks.h
===================================================================
--- include/vxworks/vxworks.h	(revision 3786)
+++ include/vxworks/vxworks.h	(working copy)
@@ -127,6 +127,32 @@
     TASK_ID handle;
 } WIND_TCB_PLACEHOLDER;
 
+#define WIND_READY	0x0
+#define WIND_SUSPEND	0x1
+#define WIND_PEND	0x2
+#define WIND_DELAY	0x4
+#define WIND_DEAD	0x8
+#define WIND_STOP	0x10	/* Never reported. */
+
+typedef struct _TASK_DESC {
+
+	TASK_ID tid;
+	char    name[XNOBJECT_NAME_LEN];
+	int	priority;
+	int	status;
+	int	flags;
+	FUNCPTR	entry;
+	int	stacksize;
+	char	*pStackBase;
+	char	*pStackEnd;
+	char	*pExcStackBase;
+	char	*pExcStackEnd;
+	int	errorStatus;
+
+	unsigned long opaque;
+	
+} TASK_DESC;
+
 typedef void (*wind_timer_t)(long);
     
 typedef struct wind_wd_utarget {
@@ -156,6 +182,9 @@
     int status;
     int prio;
     FUNCPTR entry;
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+    unsigned long ptid;
+#endif
 
     /* Xenomai specific: used by taskLib */
 
@@ -345,6 +374,9 @@
 
 BOOL taskIsSuspended (TASK_ID task_id);
          
+STATUS taskInfoGet(TASK_ID task_id,
+		   TASK_DESC *desc);
+
 STATUS semGive(SEM_ID sem_id);
 
 STATUS semTake(SEM_ID sem_id,
Index: include/asm-blackfin/system.h
===================================================================
--- include/asm-blackfin/system.h	(revision 3786)
+++ include/asm-blackfin/system.h	(working copy)
@@ -30,6 +30,8 @@
 #define XNARCH_THREAD_STACKSZ   8192
 
 #define xnarch_stack_size(tcb)  ((tcb)->stacksize)
+#define xnarch_stack_base(tcb)	((tcb)->stackbase)
+#define xnarch_stack_end(tcb)	((caddr_t)(tcb)->stackbase - (tcb)->stacksize)
 #define xnarch_user_task(tcb)   ((tcb)->user_task)
 #define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
 
Index: include/asm-powerpc/system.h
===================================================================
--- include/asm-powerpc/system.h	(revision 3786)
+++ include/asm-powerpc/system.h	(working copy)
@@ -35,6 +35,8 @@
 #endif
 
 #define xnarch_stack_size(tcb)  ((tcb)->stacksize)
+#define xnarch_stack_base(tcb)	((tcb)->stackbase)
+#define xnarch_stack_end(tcb)	((caddr_t)(tcb)->stackbase - (tcb)->stacksize)
 #define xnarch_user_task(tcb)   ((tcb)->user_task)
 #define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
 
Index: include/asm-arm/system.h
===================================================================
--- include/asm-arm/system.h	(revision 3786)
+++ include/asm-arm/system.h	(working copy)
@@ -32,6 +32,8 @@
 #define XNARCH_THREAD_STACKSZ   4096
 
 #define xnarch_stack_size(tcb)  ((tcb)->stacksize)
+#define xnarch_stack_base(tcb)	((tcb)->stackbase)
+#define xnarch_stack_end(tcb)	((caddr_t)(tcb)->stackbase - (tcb)->stacksize)
 #define xnarch_user_task(tcb)   ((tcb)->user_task)
 #define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
 
Index: include/asm-x86/system_64.h
===================================================================
--- include/asm-x86/system_64.h	(revision 3786)
+++ include/asm-x86/system_64.h	(working copy)
@@ -31,6 +31,8 @@
 #define XNARCH_THREAD_STACKSZ	4096
 
 #define xnarch_stack_size(tcb)  ((tcb)->stacksize)
+#define xnarch_stack_base(tcb)	((tcb)->stackbase)
+#define xnarch_stack_end(tcb)	((caddr_t)(tcb)->stackbase - (tcb)->stacksize)
 #define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
 #define xnarch_user_task(tcb)   ((tcb)->user_task)
 #define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
Index: include/asm-x86/system_32.h
===================================================================
--- include/asm-x86/system_32.h	(revision 3786)
+++ include/asm-x86/system_32.h	(working copy)
@@ -31,6 +31,8 @@
 #define XNARCH_THREAD_STACKSZ 4096
 
 #define xnarch_stack_size(tcb)  ((tcb)->stacksize)
+#define xnarch_stack_base(tcb)	((tcb)->stackbase)
+#define xnarch_stack_end(tcb)	((caddr_t)(tcb)->stackbase - (tcb)->stacksize)
 #define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
 #define xnarch_user_task(tcb)   ((tcb)->user_task)
 #define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
Index: include/asm-sim/system.h
===================================================================
--- include/asm-sim/system.h	(revision 3786)
+++ include/asm-sim/system.h	(working copy)
@@ -186,8 +186,10 @@
 }
 
 #define xnarch_stack_size(tcb)    0
-#define xnarch_fpu_ptr(tcb)       (NULL)
-#define xnarch_user_task(tcb)     (NULL)
+#define xnarch_stack_base(tcb)	  NULL
+#define xnarch_stack_end(tcb)	  NULL
+#define xnarch_fpu_ptr(tcb)       NULL
+#define xnarch_user_task(tcb)     NULL
 #define xnarch_user_pid(tcb)      0
 
 /* Under the MVM, preemption only occurs at the C-source line level,
Index: include/nucleus/thread.h
===================================================================
--- include/nucleus/thread.h	(revision 3786)
+++ include/nucleus/thread.h	(working copy)
@@ -277,6 +277,8 @@
 #define xnthread_pending_signals(thread)  ((thread)->signals)
 #define xnthread_timeout(thread)           xntimer_get_timeout(&(thread)->rtimer)
 #define xnthread_stack_size(thread)        xnarch_stack_size(xnthread_archtcb(thread))
+#define xnthread_stack_base(thread)        xnarch_stack_base(xnthread_archtcb(thread))
+#define xnthread_stack_end(thread)         xnarch_stack_end(xnthread_archtcb(thread))
 #define xnthread_handle(thread)            ((thread)->registry.handle)
 #ifdef CONFIG_XENO_OPT_TIMING_PERIODIC
 #define xnthread_time_base(thread)         ((thread)->rtimer.base)
Index: src/skins/vxworks/taskInfo.c
===================================================================
--- src/skins/vxworks/taskInfo.c	(revision 3786)
+++ src/skins/vxworks/taskInfo.c	(working copy)
@@ -18,6 +18,7 @@
 
 #include <stdlib.h>
 #include <errno.h>
+#include <pthread.h>
 #include <nucleus/thread.h>	/* For status bits. */
 #include <vxworks/vxworks.h>
 
@@ -72,3 +73,40 @@
 
 	return !!(status & XNSUSP);
 }
+
+STATUS taskInfoGet(TASK_ID task_id, TASK_DESC *desc)
+{
+	pthread_attr_t attr;
+	int probe1, probe2;
+	size_t stacksize;
+	void *stackbase;
+	int err;
+
+	err = XENOMAI_SKINCALL2(__vxworks_muxid,
+				__vxworks_taskinfo_get, task_id, desc);
+	if (err) {
+		errno = abs(err);
+		return ERROR;
+	}
+
+	if (pthread_getattr_np((pthread_t)desc->opaque, &attr)) {
+		errno = S_objLib_OBJ_ID_ERROR;
+		return ERROR;
+	}
+
+	pthread_attr_getstack(&attr, &stackbase, &stacksize);
+	desc->stacksize = stacksize;
+	desc->pStackBase = stackbase;
+
+	if (&probe1 < &probe2)
+		/* Stack grows upward. */
+		desc->pStackEnd = (caddr_t)stackbase + stacksize;
+	else
+		/* Stack grows downward. */
+		desc->pStackEnd = (caddr_t)stackbase - stacksize;
+
+	desc->pExcStackBase = desc->pStackBase;
+	desc->pExcStackEnd = desc->pStackEnd;
+
+	return OK;
+}
Index: src/skins/vxworks/taskLib.c
===================================================================
--- src/skins/vxworks/taskLib.c	(revision 3786)
+++ src/skins/vxworks/taskLib.c	(working copy)
@@ -108,6 +108,7 @@
 	bulk.a1 = (u_long)iargs->name;
 	bulk.a2 = (u_long)iargs->prio;
 	bulk.a3 = (u_long)iargs->flags;
+	bulk.a4 = (u_long)pthread_self();
 
 	err = XENOMAI_SKINCALL3(__vxworks_muxid,
 				__vxworks_task_init,
Index: ksrc/skins/vxworks/syscall.c
===================================================================
--- ksrc/skins/vxworks/syscall.c	(revision 3786)
+++ ksrc/skins/vxworks/syscall.c	(working copy)
@@ -60,6 +60,7 @@
  * a1: const char *name;
  * a2: int prio;
  * a3: int flags;
+ * a4: pthread_self();
  * }
  */
 
@@ -120,6 +121,7 @@
 		     0, 0, 0, 0, 0, 0, 0, 0, 0, 0) == OK) {
 		/* Let the skin discard the TCB memory upon exit. */
 		task->auto_delete = 1;
+		task->ptid = bulk.a4;
 		/* Copy back the registry handle to the ph struct. */
 		ph.handle = xnthread_handle(&task->threadbase);
 		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg2(regs), &ph,
@@ -693,6 +695,34 @@
 }
 
 /*
+ * int __wind_taskinfo_get(TASK_ID task_id, TASK_DESC *desc)
+ */
+static int __wind_taskinfo_get(struct task_struct *curr, struct pt_regs *regs)
+{
+	xnhandle_t handle = __xn_reg_arg1(regs);
+	TASK_DESC desc;
+	WIND_TCB *pTcb;
+	int err;
+
+	if (!__xn_access_ok
+	    (curr, VERIFY_WRITE, __xn_reg_arg2(regs), sizeof(desc)))
+		return -EFAULT;
+
+	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+
+	if (!pTcb)
+		return S_objLib_OBJ_ID_ERROR;
+
+	err = taskInfoGet((TASK_ID)pTcb, &desc);
+
+	if (!err)
+		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg2(regs), &desc,
+				  sizeof(desc));
+
+	return err;
+}
+
+/*
  * int __wind_errno_taskset(TASK_ID task_id, int errcode)
  */
 
@@ -1305,6 +1335,7 @@
 	[__vxworks_taskinfo_name] = {&__wind_taskinfo_name, __xn_exec_any},
 	[__vxworks_taskinfo_iddfl] = {&__wind_taskinfo_iddfl, __xn_exec_any},
 	[__vxworks_taskinfo_status] = {&__wind_taskinfo_status, __xn_exec_any},
+	[__vxworks_taskinfo_get] = {&__wind_taskinfo_get, __xn_exec_any},
 	[__vxworks_errno_taskset] = {&__wind_errno_taskset, __xn_exec_primary},
 	[__vxworks_errno_taskget] = {&__wind_errno_taskget, __xn_exec_primary},
 	[__vxworks_kernel_timeslice] =
Index: ksrc/skins/vxworks/taskInfo.c
===================================================================
--- ksrc/skins/vxworks/taskInfo.c	(revision 3786)
+++ ksrc/skins/vxworks/taskInfo.c	(working copy)
@@ -70,3 +70,63 @@
 
 	return testbits(xnthread_state_flags(&task->threadbase), XNSUSP);
 }
+
+STATUS taskInfoGet(TASK_ID task_id, TASK_DESC *desc)
+{
+	wind_task_t *task;
+	xnflags_t status;
+	spl_t s;
+
+	memset(desc, 0, sizeof(*desc));
+
+	xnlock_get_irqsave(&nklock, s);
+
+	check_OBJ_ID_ERROR(task_id, wind_task_t, task, WIND_TASK_MAGIC,
+			   goto error);
+
+	desc->tid = task_id;
+	xnobject_copy_name(desc->name, task->name);
+	desc->priority = wind_denormalized_prio(xnthread_current_priority
+						(&task->threadbase));
+
+	status = xnthread_state_flags(&task->threadbase);
+
+	if (xnpod_current_thread() == &task->threadbase || (status & XNREADY))
+		desc->status |= WIND_READY;
+	else if (status & XNDORMANT)
+		desc->status |= WIND_DEAD;
+	else {
+		if (status & XNSUSP)
+			desc->status |= WIND_SUSPEND;
+		if (status & XNPEND)
+			desc->status |= WIND_PEND;
+		if (status & XNDELAY)
+			desc->status |= WIND_DELAY;
+	}
+
+	desc->flags = task->flags;
+	desc->entry = task->entry;
+	desc->errorStatus = errnoOfTaskGet(task_id);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	if (status & XNSHADOW)
+		desc->opaque = task->ptid;
+		/* Userland should fill in the stack information. */
+	else
+#endif
+	{
+		desc->stacksize = xnthread_stack_size(&task->threadbase);
+		desc->pStackBase = (char *)xnthread_stack_base(&task->threadbase);
+		desc->pStackEnd = (char *)xnthread_stack_end(&task->threadbase);
+		desc->pExcStackBase = desc->pStackBase;
+		desc->pExcStackEnd = desc->pStackEnd;
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return OK;
+
+      error:
+	xnlock_put_irqrestore(&nklock, s);
+	return ERROR;
+}
Index: ksrc/skins/vxworks/module.c
===================================================================
--- ksrc/skins/vxworks/module.c	(revision 3786)
+++ ksrc/skins/vxworks/module.c	(working copy)
@@ -180,3 +180,4 @@
 EXPORT_SYMBOL(tickSet);
 EXPORT_SYMBOL(kernelTimeSlice);
 EXPORT_SYMBOL(kernelVersion);
+EXPORT_SYMBOL(taskInfoGet);
Index: ksrc/skins/vxworks/taskLib.c
===================================================================
--- ksrc/skins/vxworks/taskLib.c	(revision 3786)
+++ ksrc/skins/vxworks/taskLib.c	(working copy)
@@ -104,6 +104,8 @@
 	   neither. */
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
+ 	/* Caller should fill in this field whenever applicable. */
+ 	pTcb->ptid = 0;
 	if (flags & VX_SHADOW)
 		bflags |= XNSHADOW;
 #else /* !CONFIG_XENO_OPT_PERVASIVE */

--------------040204060307000407020508--

