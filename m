From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AF2AEF9.2050207@domain.hid>
References: <4AF1474C.7000701@domain.hid>
	<1257331856.2210.85.camel@domain.hid>
	<4AF2AEF9.2050207@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 Nov 2009 12:28:33 +0100
Message-ID: <1257506913.2210.311.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] How to fix t_delete call in psos
	skin?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexandre Coffignal <alexandre.coffignal@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2009-11-05 at 11:54 +0100, Alexandre Coffignal wrote:

> Does this fix seem more suitable to you?
> Do you see someting else missing?
> 

The logic is fine, but the implementation should get closer to what is
being done in the -head branch.

Preliminary remarks:

- Please follow the kernel CodingStyle guidelines for anything that is
Xenomai-related, including userland code. Keeping a single code style
throughout our code makes things easier for reviewing, and keeps visual
pollution to the lowest possible level.

- Please rebase your work on 2.4.10 for pushing those changes to Xenomai
mainline. There is no point for us to consider changes to legacy
releases which are not being actively maintained anymore; you can always
backport those changes to 2.4.7 locally if you really fancy dealing with
bugs solved between 2.4.7 and 2.4.10...

- Please tell your CVS/SVN diff tool to use -p, when formatting patches.
 
> Please advice.

> 
> plain text document attachment (patch_psos_t_delete)
> Index: xenomai-2.4.7_bugless/include/psos+/syscall.h
> ===================================================================
> --- xenomai-2.4.7_bugless.orig/include/psos+/syscall.h	2009-11-05 09:12:29.000000000 +0100
> +++ xenomai-2.4.7_bugless/include/psos+/syscall.h	2009-11-05 09:13:14.000000000 +0100
> @@ -73,6 +73,7 @@
>  #define __psos_as_send      45
>  /* Xenomai extension: get raw count of jiffies */
>  #define __psos_tm_getc      46
> +#define __psos_t_get_pthread		47	/* get hidden pthread_t identifier. */

psos_t_getpth is enough. To be really, really pSOS-conformant when
introducing a routine, we should either use:

1) a preposterously long argument list

or, at the very least:
 
2) an absolutely unpronounceable C identifier

__psos_t_getpth happily qualifies for #2.

>  
>  #ifdef __KERNEL__
>  
> Index: xenomai-2.4.7_bugless/ksrc/skins/psos+/syscall.c
> ===================================================================
> --- xenomai-2.4.7_bugless.orig/ksrc/skins/psos+/syscall.c	2009-11-05 09:16:48.000000000 +0100
> +++ xenomai-2.4.7_bugless/ksrc/skins/psos+/syscall.c	2009-11-05 09:16:57.000000000 +0100
> @@ -67,29 +67,37 @@
>  	xncompletion_t __user *u_completion;
>  	u_long prio, flags, tid, err;
>  	char name[XNOBJECT_NAME_LEN];
> +	struct arg_bulk5 bulk;

Please have a look at what is being done in the -head branch, for the
very same routine (in the absence of -p passed to diff, seems to be
__t_create). An arg bulk has been introduced there, so you just need to
backport this.

>  	psostask_t *task;
>  
> -	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs), 4))
> +	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(bulk)))
> +		return -EFAULT;
> +
> +	__xn_copy_from_user(curr, &bulk, (void __user *)__xn_reg_arg1(regs),
> +			    sizeof(bulk));
> +
> +	if (!__xn_access_ok(curr, VERIFY_READ, bulk.a1, sizeof(name))) {
>  		return -EFAULT;
> +	}
>  
>  	/* Get task name. */
> -	__xn_strncpy_from_user(curr, name, (const char __user *)__xn_reg_arg1(regs),
> +	__xn_strncpy_from_user(curr, name, (const char __user *)bulk.a1,
>  			       sizeof(name) - 1);
>  	name[sizeof(name) - 1] = '\0';
>  	strncpy(curr->comm, name, sizeof(curr->comm));
>  	curr->comm[sizeof(curr->comm) - 1] = '\0';
>  
>  	if (!__xn_access_ok
> -	    (curr, VERIFY_WRITE, __xn_reg_arg4(regs), sizeof(tid)))
> +		(curr, VERIFY_WRITE, bulk.a4, sizeof(tid)))
>  		return -EFAULT;
>  
>  	/* Task priority. */
> -	prio = __xn_reg_arg2(regs);
> +	prio = bulk.a2;
>  	/* Task flags. Force FPU support in user-space. This will lead
>  	   to a no-op if the platform does not support it. */
> -	flags = __xn_reg_arg3(regs) | T_SHADOW | T_FPU;
> +	flags = bulk.a3 | T_SHADOW | T_FPU;
>  	/* Completion descriptor our parent thread is pending on. */
> -	u_completion = (xncompletion_t __user *)__xn_reg_arg5(regs);
> +	u_completion = (xncompletion_t __user *)__xn_reg_arg2(regs);
>  
>  	err = t_create(name, prio, 0, 0, flags, &tid);
>  
> @@ -99,7 +107,8 @@
>  		 * about the new thread id, so we can manipulate its
>  		 * TCB pointer freely. */
>  		tid = xnthread_handle(&task->threadbase);
> -		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg4(regs), &tid,
> +		task->opaque2 = bulk.a5; /* hidden pthread_t identifier. */
> +		__xn_copy_to_user(curr, (void __user *) bulk.a4, &tid,
>  				  sizeof(tid));
>  		err = xnshadow_map(&task->threadbase, u_completion); /* May be NULL */
>  	} else {
> @@ -1443,6 +1452,36 @@
>  	return as_send((u_long)task, signals);
>  }
>  
> +
> +/*
> + * int __t_get_pthread(u_long tid, u_long *pthread)
> + */
> +static int __t_get_pthread(struct task_struct *curr, struct pt_regs *regs)
> +{
> +	xnhandle_t handle;
> +	psostask_t *task;
> +	u_long pthread;
> +
> +	handle = __xn_reg_arg1(regs);
> +
> +	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg2(regs), sizeof(u_long)))
> +		return -EFAULT;
> +
> +	if (handle)
> +		task = (psostask_t *)xnregistry_fetch(handle);
> +	else
> +		task = __psos_task_current(curr);
> +
> +	if (!task)
> +		return ERR_OBJID;

Critical section enforcement is missing. What if the caller gets
preempted after the handle is fetched, and the non-current tid gets
killed by a concurrent thread right after? See t_ident for an
illustration.

If the deletion happens after the critical section, well, we would just
have to hope that pthread_cancel() does a good job at validating its
handle, but at least we would not have referred to stale memory on our
end.

> +
> +	pthread = task->opaque2; /* hidden pthread_t identifier. */
> +
> +	__xn_copy_to_user(curr, (void __user *) __xn_reg_arg2(regs), &pthread, sizeof(u_long));
> +
> +	return SUCCESS;
> +}
> +
>  static void *psos_shadow_eventcb(int event, void *data)
>  {
>  	struct psos_resource_holder *rh;
> @@ -1524,6 +1563,7 @@
>  	[__psos_tm_signal] = {&__tm_signal, __xn_exec_primary},
>  	[__psos_as_send] = {&__as_send, __xn_exec_conforming},
>  	[__psos_tm_getc] = {&__tm_getc, __xn_exec_any},
> +	[__psos_t_get_pthread] = {&__t_get_pthread, __xn_exec_any},
>  };
>  
>  extern xntbase_t *psos_tbase;
> Index: xenomai-2.4.7_bugless/src/skins/psos+/task.c
> ===================================================================
> --- xenomai-2.4.7_bugless.orig/src/skins/psos+/task.c	2009-11-05 09:17:31.000000000 +0100
> +++ xenomai-2.4.7_bugless/src/skins/psos+/task.c	2009-11-05 09:17:56.000000000 +0100
> @@ -26,6 +26,15 @@
>  #include <memory.h>
>  #include <psos+/psos.h>
>  
> +struct arg_bulk5{
> +
> +    u_long a1;
> +    u_long a2;
> +    u_long a3;
> +    u_long a4;
> +    u_long a5;
> +};

Rather use psos_arg_bulk like in -head tree.

> +
>  extern int __psos_muxid;
>  
>  struct psos_task_iargs {
> @@ -73,6 +82,7 @@
>  	struct sched_param param;
>  	int policy;
>  	long err;
> +	struct arg_bulk5 bulk;
>  
>  	policy = psos_task_set_posix_priority(iargs->prio, &param);
>  	pthread_setschedparam(pthread_self(), policy, &param);
> @@ -81,10 +91,14 @@
>  
>  	old_sigharden_handler = signal(SIGHARDEN, &psos_task_sigharden);
>  
> -	err = XENOMAI_SKINCALL5(__psos_muxid,
> -				__psos_t_create,
> -				iargs->name, iargs->prio, iargs->flags,
> -				iargs->tid_r, iargs->completionp);
> +	bulk.a1 = (u_long)iargs->name;
> +	bulk.a2 = (u_long)iargs->prio;
> +	bulk.a3 = (u_long)iargs->flags;
> +	bulk.a4 = (u_long)iargs->tid_r;
> +	bulk.a5 = (u_long)pthread_self();
> +
> +	err = XENOMAI_SKINCALL2(__psos_muxid, __psos_t_create, &bulk, iargs->completionp);
> +
>  	if (err)
>  		goto fail;
>  
> @@ -172,14 +186,19 @@
>  		u_long flags,
>  		u_long *tid_r)
>  {
> +	struct arg_bulk5 bulk;
> +
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>  
>  	old_sigharden_handler = signal(SIGHARDEN, &psos_task_sigharden);
>  
> -	return XENOMAI_SKINCALL5(__psos_muxid,
> -				 __psos_t_create,
> -				 name, prio, flags,
> -				 tid_r, NULL);
> +	bulk.a1 = (u_long)name;
> +	bulk.a2 = (u_long)prio;
> +	bulk.a3 = (u_long)flags;
> +	bulk.a4 = (u_long)tid_r;
> +	bulk.a5 = (u_long)pthread_self();
> +
> +	return XENOMAI_SKINCALL2(__psos_muxid, __psos_t_create, &bulk, NULL);
>  }
>  
>  u_long t_start(u_long tid,
> @@ -196,6 +215,18 @@
>  
>  u_long t_delete(u_long tid)
>  {
> +	long err;
> +	u_long pthread;
> +
> +	if(tid)
> +	{
> +		err = XENOMAI_SKINCALL2(__psos_muxid, __psos_t_get_pthread, tid, &pthread);
> +		if (err)
> +			return err;
> +		err = pthread_cancel((pthread_t)pthread);
> +		if (err)
> +			return err;
> +	}

We should handle the self-deletion case specifically:

+	else {
+		/* Silently migrate to avoid raising SIGXCPU. */
+		XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
+		pthread_exit(NULL);
+	}

Actually, we should also test for the case when a non-zero tid ends up
pointing at the current thread as well, e.g.

		if (tid == 0)
			goto self_delete;

		err = XENOMAI_SKINCALL2(__psos_muxid, __psos_t_getpth, tid, &ptid);
		if (err)
			return err;

		if ((pthread_t)ptid == pthread_self())
			goto self_delete;

		err = pthread_cancel((pthread_t)ptid);
		if (err)
			return -err; /* differentiate from pSOS codes */

		return XENOMAI_SKINCALL1(__psos_muxid, __psos_t_delete, tid);
self_delete:
		 /* Silently migrate to avoid raising SIGXCPU. */ 
		XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
		pthread_exit(NULL);

		return SUCCESS; /* not reached */

> 
> 
>  	return XENOMAI_SKINCALL1(__psos_muxid, __psos_t_delete, tid);
>  }
>  
> Index: xenomai-2.4.7_bugless/include/psos+/task.h
> ===================================================================
> --- xenomai-2.4.7_bugless.orig/include/psos+/task.h	2009-11-05 09:19:49.000000000 +0100
> +++ xenomai-2.4.7_bugless/include/psos+/task.h	2009-11-05 09:19:58.000000000 +0100
> @@ -26,6 +26,16 @@
>  
>  #define PSOS_TASK_MAGIC 0x81810101
>  
> +struct arg_bulk5{
> +
> +    u_long a1;
> +    u_long a2;
> +    u_long a3;
> +    u_long a4;
> +    u_long a5;
> +};
> +
> +
>  typedef struct psostask {
>  
>      unsigned magic;   /* Magic code - must be first */
> @@ -64,6 +74,8 @@
>  
>      } waitargs;
>  
> +    u_long opaque2; /* hidden pthread_t identifier. */

No need to make this more opaque than required to the reviewer; besides,
we only need this field when user-space support is compiled in.

-	u_long opaque2; /* hidden pthread_t identifier. */

+	#ifdef CONFIG_XENO_OPT_PERVASIVE
+		u_long pthread;
+	#endif

> +
>  } psostask_t;
>  
>  static inline psostask_t *thread2psostask (xnthread_t *t)


-- 
Philippe.



