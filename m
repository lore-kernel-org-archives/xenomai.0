Message-ID: <4B28AE06.5070503@domain.hid>
Date: Wed, 16 Dec 2009 10:53:10 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
References: <4B1CCE12.4080106@domain.hid>
	<1260896063.2216.172.camel@domain.hid>
In-Reply-To: <1260896063.2216.172.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------030708060809000304020606"
Subject: Re: [Xenomai-core] [Fwd: Re: [Xenomai-help] How to fix t_delete
 call in psos skin?]
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030708060809000304020606
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
Please find attached a new patch that should take your latest remarks 
into account.
Regards,

Fabrice.

> On Mon, 2009-12-07 at 10:42 +0100, Fabrice Gasnier wrote:
>   
>> Hello,
>>
>> I come back to you to submit a slightly different patch.
>> I observed that __psos_t_delete sometimes returns ERR_OBJID after 
>> pthread_cancel has been issued, due to thread isn't found on kernel side.
>> The attached patch uses the same mechanism as in native API 
>> (rt_task_delete) where equivalent error is being filtered.
>>
>>     
>
> Correct.
>
>   
>> Please find attached this patch (formated with git format-patch origin).
>>
>> If it's looks like ok on your side, do you think this patch can be 
>> integrated in xenomai project?
>>
>>     
>
> Yes, this patch makes sense. Time for nitpicking now:
>
>
> +	#ifdef CONFIG_XENO_OPT_PERVASIVE
> +    u_long pthread; /* hidden pthread_t identifier. */
> +	#endif
> +
>
> Preprocessor statements should start at column 1.
>
> +	if (!__xn_access_ok(curr, VERIFY_READ, bulk.a1, sizeof(name))) {
> +		return -EFAULT;
> +	}
>
> Single executable statement in conditional needs no braces.
>
> @@ -99,7 +107,10 @@ static int __t_create(struct task_struct *curr,
> struct pt_regs *regs)
>  		 * about the new thread id, so we can manipulate its
>  		 * TCB pointer freely. */
>  		tid = xnthread_handle(&task->threadbase);
> -		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg4(regs), &tid,
> +		#ifdef CONFIG_XENO_OPT_PERVASIVE
> +		task->pthread = bulk.a5; /* hidden pthread_t identifier. */
> +		#endif
>
> Same as above regarding the indentation, but most importantly, testing
> CONFIG_OPT_XENO_PERVASIVE is redundant, since this file is only compiled
> when in pervasive mode.
>
> +		#ifdef CONFIG_XENO_OPT_PERVASIVE
> +		pthread = task->pthread; /* hidden pthread_t identifier. */
> +		#endif
>
> Same as above.
>
> Additionally, please make sure to prefix the commit message with the
> sub-system impacted, i.e. psos in this case, and be more descriptive
> regarding to the fix involved.
>
> E.g.
> git commit -a -m "psos: send pthread_cancel() upon t_delete"
>
>
>   

--------------030708060809000304020606
Content-Type: text/x-patch;
 name="0001-psos-send-pthread_cancel-upon-t_delete.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-psos-send-pthread_cancel-upon-t_delete.patch"

>From 62bbafb29e348bb371d435693d46dbf10f3c59d0 Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Date: Wed, 16 Dec 2009 10:21:54 +0100
Subject: [PATCH] psos: send pthread_cancel() upon t_delete

Fix t_delete call from user space in psos skin. pthread reference is kept
until pthread_cancel() has been issued. Add pthread field to psostask_t,
psos_arg_bulk structure and __t_getpth SKINCALL.
---
 include/psos+/syscall.h    |   10 +++++++
 include/psos+/task.h       |    4 +++
 ksrc/skins/psos+/syscall.c |   60 ++++++++++++++++++++++++++++++++++++++-----
 src/skins/psos+/task.c     |   57 +++++++++++++++++++++++++++++++++++------
 4 files changed, 115 insertions(+), 16 deletions(-)

diff --git a/include/psos+/syscall.h b/include/psos+/syscall.h
index 55ee8a0..25c0a2d 100644
--- a/include/psos+/syscall.h
+++ b/include/psos+/syscall.h
@@ -73,6 +73,16 @@
 #define __psos_as_send      45
 /* Xenomai extension: get raw count of jiffies */
 #define __psos_tm_getc      46
+#define __psos_t_getpth		47	/* get hidden pthread_t identifier. */
+
+struct psos_arg_bulk{
+
+    u_long a1;
+    u_long a2;
+    u_long a3;
+    u_long a4;
+    u_long a5;
+};
 
 #ifdef __KERNEL__
 
diff --git a/include/psos+/task.h b/include/psos+/task.h
index ca01573..d57967c 100644
--- a/include/psos+/task.h
+++ b/include/psos+/task.h
@@ -64,6 +64,10 @@ typedef struct psostask {
 
     } waitargs;
 
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+    u_long pthread; /* hidden pthread_t identifier. */
+#endif
+
 } psostask_t;
 
 static inline psostask_t *thread2psostask (xnthread_t *t)
diff --git a/ksrc/skins/psos+/syscall.c b/ksrc/skins/psos+/syscall.c
index 1753901..dea3ee2 100644
--- a/ksrc/skins/psos+/syscall.c
+++ b/ksrc/skins/psos+/syscall.c
@@ -67,29 +67,36 @@ static int __t_create(struct task_struct *curr, struct pt_regs *regs)
 	xncompletion_t __user *u_completion;
 	u_long prio, flags, tid, err;
 	char name[XNOBJECT_NAME_LEN];
+	struct psos_arg_bulk bulk;
 	psostask_t *task;
 
-	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs), 4))
+	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(bulk)))
+		return -EFAULT;
+
+	__xn_copy_from_user(curr, &bulk, (void __user *)__xn_reg_arg1(regs),
+			    sizeof(bulk));
+
+	if (!__xn_access_ok(curr, VERIFY_READ, bulk.a1, sizeof(name)))
 		return -EFAULT;
 
 	/* Get task name. */
-	__xn_strncpy_from_user(curr, name, (const char __user *)__xn_reg_arg1(regs),
+	__xn_strncpy_from_user(curr, name, (const char __user *)bulk.a1,
 			       sizeof(name) - 1);
 	name[sizeof(name) - 1] = '\0';
 	strncpy(curr->comm, name, sizeof(curr->comm));
 	curr->comm[sizeof(curr->comm) - 1] = '\0';
 
 	if (!__xn_access_ok
-	    (curr, VERIFY_WRITE, __xn_reg_arg4(regs), sizeof(tid)))
+		(curr, VERIFY_WRITE, bulk.a4, sizeof(tid)))
 		return -EFAULT;
 
 	/* Task priority. */
-	prio = __xn_reg_arg2(regs);
+	prio = bulk.a2;
 	/* Task flags. Force FPU support in user-space. This will lead
 	   to a no-op if the platform does not support it. */
-	flags = __xn_reg_arg3(regs) | T_SHADOW | T_FPU;
+	flags = bulk.a3 | T_SHADOW | T_FPU;
 	/* Completion descriptor our parent thread is pending on. */
-	u_completion = (xncompletion_t __user *)__xn_reg_arg5(regs);
+	u_completion = (xncompletion_t __user *)__xn_reg_arg2(regs);
 
 	err = t_create(name, prio, 0, 0, flags, &tid);
 
@@ -99,7 +106,8 @@ static int __t_create(struct task_struct *curr, struct pt_regs *regs)
 		 * about the new thread id, so we can manipulate its
 		 * TCB pointer freely. */
 		tid = xnthread_handle(&task->threadbase);
-		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg4(regs), &tid,
+		task->pthread = bulk.a5; /* hidden pthread_t identifier. */
+		__xn_copy_to_user(curr, (void __user *) bulk.a4, &tid,
 				  sizeof(tid));
 		err = xnshadow_map(&task->threadbase, u_completion); /* May be NULL */
 	} else {
@@ -1443,6 +1451,43 @@ static int __as_send(struct task_struct *curr, struct pt_regs *regs)
 	return as_send((u_long)task, signals);
 }
 
+
+/*
+ * int __t_getpth(u_long tid, u_long *pthread)
+ */
+static int __t_getpth(struct task_struct *curr, struct pt_regs *regs)
+{
+	xnhandle_t handle;
+	psostask_t *task;
+	spl_t s;
+	u_long err = SUCCESS;
+	u_long pthread;
+
+	handle = __xn_reg_arg1(regs);
+
+	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg2(regs), sizeof(u_long)))
+		return -EFAULT;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (handle)
+		task = (psostask_t *)xnregistry_fetch(handle);
+	else
+		task = __psos_task_current(curr);
+
+	if (!task)
+		err = ERR_OBJID;
+	else
+		pthread = task->pthread; /* hidden pthread_t identifier. */
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	if(err == SUCCESS)
+		__xn_copy_to_user(curr, (void __user *) __xn_reg_arg2(regs), &pthread, sizeof(u_long));
+
+	return err;
+}
+
 static void *psos_shadow_eventcb(int event, void *data)
 {
 	struct psos_resource_holder *rh;
@@ -1524,6 +1569,7 @@ static xnsysent_t __systab[] = {
 	[__psos_tm_signal] = {&__tm_signal, __xn_exec_primary},
 	[__psos_as_send] = {&__as_send, __xn_exec_conforming},
 	[__psos_tm_getc] = {&__tm_getc, __xn_exec_any},
+	[__psos_t_getpth] = {&__t_getpth, __xn_exec_any},
 };
 
 extern xntbase_t *psos_tbase;
diff --git a/src/skins/psos+/task.c b/src/skins/psos+/task.c
index 9358ea8..7121a52 100644
--- a/src/skins/psos+/task.c
+++ b/src/skins/psos+/task.c
@@ -73,6 +73,7 @@ static void *psos_task_trampoline(void *cookie)
 	struct sched_param param;
 	int policy;
 	long err;
+	struct psos_arg_bulk bulk;
 
 	policy = psos_task_set_posix_priority(iargs->prio, &param);
 	pthread_setschedparam(pthread_self(), policy, &param);
@@ -81,10 +82,14 @@ static void *psos_task_trampoline(void *cookie)
 
 	old_sigharden_handler = signal(SIGHARDEN, &psos_task_sigharden);
 
-	err = XENOMAI_SKINCALL5(__psos_muxid,
-				__psos_t_create,
-				iargs->name, iargs->prio, iargs->flags,
-				iargs->tid_r, iargs->completionp);
+	bulk.a1 = (u_long)iargs->name;
+	bulk.a2 = (u_long)iargs->prio;
+	bulk.a3 = (u_long)iargs->flags;
+	bulk.a4 = (u_long)iargs->tid_r;
+	bulk.a5 = (u_long)pthread_self();
+
+	err = XENOMAI_SKINCALL2(__psos_muxid, __psos_t_create, &bulk, iargs->completionp);
+
 	if (err)
 		goto fail;
 
@@ -172,14 +177,19 @@ u_long t_shadow(const char *name, /* Xenomai extension. */
 		u_long flags,
 		u_long *tid_r)
 {
+	struct psos_arg_bulk bulk;
+
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
 	old_sigharden_handler = signal(SIGHARDEN, &psos_task_sigharden);
 
-	return XENOMAI_SKINCALL5(__psos_muxid,
-				 __psos_t_create,
-				 name, prio, flags,
-				 tid_r, NULL);
+	bulk.a1 = (u_long)name;
+	bulk.a2 = (u_long)prio;
+	bulk.a3 = (u_long)flags;
+	bulk.a4 = (u_long)tid_r;
+	bulk.a5 = (u_long)pthread_self();
+
+	return XENOMAI_SKINCALL2(__psos_muxid, __psos_t_create, &bulk, NULL);
 }
 
 u_long t_start(u_long tid,
@@ -196,7 +206,36 @@ u_long t_start(u_long tid,
 
 u_long t_delete(u_long tid)
 {
-	return XENOMAI_SKINCALL1(__psos_muxid, __psos_t_delete, tid);
+	long err;
+	u_long ptid;
+
+	if (tid == 0)
+		goto self_delete;
+
+	err = XENOMAI_SKINCALL2(__psos_muxid, __psos_t_getpth, tid, &ptid);
+	if (err)
+		return err;
+
+	if ((pthread_t)ptid == pthread_self())
+		goto self_delete;
+
+	err = pthread_cancel((pthread_t)ptid);
+	if (err)
+		return -err; /* differentiate from pSOS codes */
+
+	err = XENOMAI_SKINCALL1(__psos_muxid, __psos_t_delete, tid);
+	if (err == ERR_OBJID)
+		return SUCCESS;
+
+	return err;
+
+self_delete:
+
+	 /* Silently migrate to avoid raising SIGXCPU. */
+	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
+	pthread_exit(NULL);
+
+	return SUCCESS; /* not reached */
 }
 
 u_long t_suspend(u_long tid)
-- 
1.6.0.4


--------------030708060809000304020606--

