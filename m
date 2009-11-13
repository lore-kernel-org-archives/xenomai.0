Message-ID: <4AFD6922.2040408@domain.hid>
Date: Fri, 13 Nov 2009 15:11:46 +0100
From: Alexandre Coffignal <alexandre.coffignal@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020301040904080803050209"
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
To: xenomai@xenomai.org
Cc: 'Fabrice Gasnier' <fabrice.gasnier@domain.hid>

This is a multi-part message in MIME format.
--------------020301040904080803050209
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

Please find attached a new patch that should take into account your 
latest remarks.
This patch has been created using 'git diff -p' command and applies on 
2.4.10 revision.
I'm not sure I fully understand your remark on missing critical section. 
Indeed, this code is similar to __t_delete routine that doesn't seem to 
have critical section enforcement?
Should a critical section be added to it as well ?
Anyway, I tried to replicate __t_ident mechanism as you mentioned.

Please let me know your feeling about this.

Fabrice

> -------- Message original --------
> Sujet: 	Re: [Xenomai-help] How to fix t_delete call in psos skin?
> Date: 	Fri, 06 Nov 2009 12:28:33 +0100
> De: 	Philippe Gerum <rpm@xenomai.org>
> Organisation: 	Xenomai
> Pour :: 	Alexandre Coffignal <alexandre.coffignal@domain.hid>
> Copie à :: 	xenomai@xenomai.org
> Références: 	<4AF1474C.7000701@domain.hid>
> <1257331856.2210.85.camel@domain.hid>
> <4AF2AEF9.2050207@domain.hid>
>
>
>
> On Thu, 2009-11-05 at 11:54 +0100, Alexandre Coffignal wrote:
>
>   
>> Does this fix seem more suitable to you?
>> Do you see someting else missing?
>>
>>     
>
> The logic is fine, but the implementation should get closer to what is
> being done in the -head branch.
>
> Preliminary remarks:
>
> - Please follow the kernel CodingStyle guidelines for anything that is
> Xenomai-related, including userland code. Keeping a single code style
> throughout our code makes things easier for reviewing, and keeps visual
> pollution to the lowest possible level.
>
> - Please rebase your work on 2.4.10 for pushing those changes to Xenomai
> mainline. There is no point for us to consider changes to legacy
> releases which are not being actively maintained anymore; you can always
> backport those changes to 2.4.7 locally if you really fancy dealing with
> bugs solved between 2.4.7 and 2.4.10...
>
> - Please tell your CVS/SVN diff tool to use -p, when formatting patches.
>  
>   
>> Please advice.
>>     
>
>   
>> plain text document attachment (patch_psos_t_delete)
>> Index: xenomai-2.4.7_bugless/include/psos+/syscall.h
>> ===================================================================
>> --- xenomai-2.4.7_bugless.orig/include/psos+/syscall.h	2009-11-05 09:12:29.000000000 +0100
>> +++ xenomai-2.4.7_bugless/include/psos+/syscall.h	2009-11-05 09:13:14.000000000 +0100
>> @@ -73,6 +73,7 @@
>>  #define __psos_as_send      45
>>  /* Xenomai extension: get raw count of jiffies */
>>  #define __psos_tm_getc      46
>> +#define __psos_t_get_pthread		47	/* get hidden pthread_t identifier. */
>>     
>
> psos_t_getpth is enough. To be really, really pSOS-conformant when
> introducing a routine, we should either use:
>
> 1) a preposterously long argument list
>
> or, at the very least:
>  
> 2) an absolutely unpronounceable C identifier
>
> __psos_t_getpth happily qualifies for #2.
>
>   
>>  
>>  #ifdef __KERNEL__
>>  
>> Index: xenomai-2.4.7_bugless/ksrc/skins/psos+/syscall.c
>> ===================================================================
>> --- xenomai-2.4.7_bugless.orig/ksrc/skins/psos+/syscall.c	2009-11-05 09:16:48.000000000 +0100
>> +++ xenomai-2.4.7_bugless/ksrc/skins/psos+/syscall.c	2009-11-05 09:16:57.000000000 +0100
>> @@ -67,29 +67,37 @@
>>  	xncompletion_t __user *u_completion;
>>  	u_long prio, flags, tid, err;
>>  	char name[XNOBJECT_NAME_LEN];
>> +	struct arg_bulk5 bulk;
>>     
>
> Please have a look at what is being done in the -head branch, for the
> very same routine (in the absence of -p passed to diff, seems to be
> __t_create). An arg bulk has been introduced there, so you just need to
> backport this.
>
>   
>>  	psostask_t *task;
>>  
>> -	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs), 4))
>> +	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(bulk)))
>> +		return -EFAULT;
>> +
>> +	__xn_copy_from_user(curr, &bulk, (void __user *)__xn_reg_arg1(regs),
>> +			    sizeof(bulk));
>> +
>> +	if (!__xn_access_ok(curr, VERIFY_READ, bulk.a1, sizeof(name))) {
>>  		return -EFAULT;
>> +	}
>>  
>>  	/* Get task name. */
>> -	__xn_strncpy_from_user(curr, name, (const char __user *)__xn_reg_arg1(regs),
>> +	__xn_strncpy_from_user(curr, name, (const char __user *)bulk.a1,
>>  			       sizeof(name) - 1);
>>  	name[sizeof(name) - 1] = '\0';
>>  	strncpy(curr->comm, name, sizeof(curr->comm));
>>  	curr->comm[sizeof(curr->comm) - 1] = '\0';
>>  
>>  	if (!__xn_access_ok
>> -	    (curr, VERIFY_WRITE, __xn_reg_arg4(regs), sizeof(tid)))
>> +		(curr, VERIFY_WRITE, bulk.a4, sizeof(tid)))
>>  		return -EFAULT;
>>  
>>  	/* Task priority. */
>> -	prio = __xn_reg_arg2(regs);
>> +	prio = bulk.a2;
>>  	/* Task flags. Force FPU support in user-space. This will lead
>>  	   to a no-op if the platform does not support it. */
>> -	flags = __xn_reg_arg3(regs) | T_SHADOW | T_FPU;
>> +	flags = bulk.a3 | T_SHADOW | T_FPU;
>>  	/* Completion descriptor our parent thread is pending on. */
>> -	u_completion = (xncompletion_t __user *)__xn_reg_arg5(regs);
>> +	u_completion = (xncompletion_t __user *)__xn_reg_arg2(regs);
>>  
>>  	err = t_create(name, prio, 0, 0, flags, &tid);
>>  
>> @@ -99,7 +107,8 @@
>>  		 * about the new thread id, so we can manipulate its
>>  		 * TCB pointer freely. */
>>  		tid = xnthread_handle(&task->threadbase);
>> -		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg4(regs), &tid,
>> +		task->opaque2 = bulk.a5; /* hidden pthread_t identifier. */
>> +		__xn_copy_to_user(curr, (void __user *) bulk.a4, &tid,
>>  				  sizeof(tid));
>>  		err = xnshadow_map(&task->threadbase, u_completion); /* May be NULL */
>>  	} else {
>> @@ -1443,6 +1452,36 @@
>>  	return as_send((u_long)task, signals);
>>  }
>>  
>> +
>> +/*
>> + * int __t_get_pthread(u_long tid, u_long *pthread)
>> + */
>> +static int __t_get_pthread(struct task_struct *curr, struct pt_regs *regs)
>> +{
>> +	xnhandle_t handle;
>> +	psostask_t *task;
>> +	u_long pthread;
>> +
>> +	handle = __xn_reg_arg1(regs);
>> +
>> +	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg2(regs), sizeof(u_long)))
>> +		return -EFAULT;
>> +
>> +	if (handle)
>> +		task = (psostask_t *)xnregistry_fetch(handle);
>> +	else
>> +		task = __psos_task_current(curr);
>> +
>> +	if (!task)
>> +		return ERR_OBJID;
>>     
>
> Critical section enforcement is missing. What if the caller gets
> preempted after the handle is fetched, and the non-current tid gets
> killed by a concurrent thread right after? See t_ident for an
> illustration.
>
> If the deletion happens after the critical section, well, we would just
> have to hope that pthread_cancel() does a good job at validating its
> handle, but at least we would not have referred to stale memory on our
> end.
>
>   
>> +
>> +	pthread = task->opaque2; /* hidden pthread_t identifier. */
>> +
>> +	__xn_copy_to_user(curr, (void __user *) __xn_reg_arg2(regs), &pthread, sizeof(u_long));
>> +
>> +	return SUCCESS;
>> +}
>> +
>>  static void *psos_shadow_eventcb(int event, void *data)
>>  {
>>  	struct psos_resource_holder *rh;
>> @@ -1524,6 +1563,7 @@
>>  	[__psos_tm_signal] = {&__tm_signal, __xn_exec_primary},
>>  	[__psos_as_send] = {&__as_send, __xn_exec_conforming},
>>  	[__psos_tm_getc] = {&__tm_getc, __xn_exec_any},
>> +	[__psos_t_get_pthread] = {&__t_get_pthread, __xn_exec_any},
>>  };
>>  
>>  extern xntbase_t *psos_tbase;
>> Index: xenomai-2.4.7_bugless/src/skins/psos+/task.c
>> ===================================================================
>> --- xenomai-2.4.7_bugless.orig/src/skins/psos+/task.c	2009-11-05 09:17:31.000000000 +0100
>> +++ xenomai-2.4.7_bugless/src/skins/psos+/task.c	2009-11-05 09:17:56.000000000 +0100
>> @@ -26,6 +26,15 @@
>>  #include <memory.h>
>>  #include <psos+/psos.h>
>>  
>> +struct arg_bulk5{
>> +
>> +    u_long a1;
>> +    u_long a2;
>> +    u_long a3;
>> +    u_long a4;
>> +    u_long a5;
>> +};
>>     
>
> Rather use psos_arg_bulk like in -head tree.
>
>   
>> +
>>  extern int __psos_muxid;
>>  
>>  struct psos_task_iargs {
>> @@ -73,6 +82,7 @@
>>  	struct sched_param param;
>>  	int policy;
>>  	long err;
>> +	struct arg_bulk5 bulk;
>>  
>>  	policy = psos_task_set_posix_priority(iargs->prio, &param);
>>  	pthread_setschedparam(pthread_self(), policy, &param);
>> @@ -81,10 +91,14 @@
>>  
>>  	old_sigharden_handler = signal(SIGHARDEN, &psos_task_sigharden);
>>  
>> -	err = XENOMAI_SKINCALL5(__psos_muxid,
>> -				__psos_t_create,
>> -				iargs->name, iargs->prio, iargs->flags,
>> -				iargs->tid_r, iargs->completionp);
>> +	bulk.a1 = (u_long)iargs->name;
>> +	bulk.a2 = (u_long)iargs->prio;
>> +	bulk.a3 = (u_long)iargs->flags;
>> +	bulk.a4 = (u_long)iargs->tid_r;
>> +	bulk.a5 = (u_long)pthread_self();
>> +
>> +	err = XENOMAI_SKINCALL2(__psos_muxid, __psos_t_create, &bulk, iargs->completionp);
>> +
>>  	if (err)
>>  		goto fail;
>>  
>> @@ -172,14 +186,19 @@
>>  		u_long flags,
>>  		u_long *tid_r)
>>  {
>> +	struct arg_bulk5 bulk;
>> +
>>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>>  
>>  	old_sigharden_handler = signal(SIGHARDEN, &psos_task_sigharden);
>>  
>> -	return XENOMAI_SKINCALL5(__psos_muxid,
>> -				 __psos_t_create,
>> -				 name, prio, flags,
>> -				 tid_r, NULL);
>> +	bulk.a1 = (u_long)name;
>> +	bulk.a2 = (u_long)prio;
>> +	bulk.a3 = (u_long)flags;
>> +	bulk.a4 = (u_long)tid_r;
>> +	bulk.a5 = (u_long)pthread_self();
>> +
>> +	return XENOMAI_SKINCALL2(__psos_muxid, __psos_t_create, &bulk, NULL);
>>  }
>>  
>>  u_long t_start(u_long tid,
>> @@ -196,6 +215,18 @@
>>  
>>  u_long t_delete(u_long tid)
>>  {
>> +	long err;
>> +	u_long pthread;
>> +
>> +	if(tid)
>> +	{
>> +		err = XENOMAI_SKINCALL2(__psos_muxid, __psos_t_get_pthread, tid, &pthread);
>> +		if (err)
>> +			return err;
>> +		err = pthread_cancel((pthread_t)pthread);
>> +		if (err)
>> +			return err;
>> +	}
>>     
>
> We should handle the self-deletion case specifically:
>
> +	else {
> +		/* Silently migrate to avoid raising SIGXCPU. */
> +		XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
> +		pthread_exit(NULL);
> +	}
>
> Actually, we should also test for the case when a non-zero tid ends up
> pointing at the current thread as well, e.g.
>
> 		if (tid == 0)
> 			goto self_delete;
>
> 		err = XENOMAI_SKINCALL2(__psos_muxid, __psos_t_getpth, tid, &ptid);
> 		if (err)
> 			return err;
>
> 		if ((pthread_t)ptid == pthread_self())
> 			goto self_delete;
>
> 		err = pthread_cancel((pthread_t)ptid);
> 		if (err)
> 			return -err; /* differentiate from pSOS codes */
>
> 		return XENOMAI_SKINCALL1(__psos_muxid, __psos_t_delete, tid);
> self_delete:
> 		 /* Silently migrate to avoid raising SIGXCPU. */ 
> 		XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
> 		pthread_exit(NULL);
>
> 		return SUCCESS; /* not reached */
>
>   
>>  	return XENOMAI_SKINCALL1(__psos_muxid, __psos_t_delete, tid);
>>  }
>>  
>> Index: xenomai-2.4.7_bugless/include/psos+/task.h
>> ===================================================================
>> --- xenomai-2.4.7_bugless.orig/include/psos+/task.h	2009-11-05 09:19:49.000000000 +0100
>> +++ xenomai-2.4.7_bugless/include/psos+/task.h	2009-11-05 09:19:58.000000000 +0100
>> @@ -26,6 +26,16 @@
>>  
>>  #define PSOS_TASK_MAGIC 0x81810101
>>  
>> +struct arg_bulk5{
>> +
>> +    u_long a1;
>> +    u_long a2;
>> +    u_long a3;
>> +    u_long a4;
>> +    u_long a5;
>> +};
>> +
>> +
>>  typedef struct psostask {
>>  
>>      unsigned magic;   /* Magic code - must be first */
>> @@ -64,6 +74,8 @@
>>  
>>      } waitargs;
>>  
>> +    u_long opaque2; /* hidden pthread_t identifier. */
>>     
>
> No need to make this more opaque than required to the reviewer; besides,
> we only need this field when user-space support is compiled in.
>
> -	u_long opaque2; /* hidden pthread_t identifier. */
>
> +	#ifdef CONFIG_XENO_OPT_PERVASIVE
> +		u_long pthread;
> +	#endif
>
>   
>> +
>>  } psostask_t;
>>  
>>  static inline psostask_t *thread2psostask (xnthread_t *t)
>>     
>
>
>   



--------------020301040904080803050209
Content-Type: text/plain;
 name="patch_psos_t_delete"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch_psos_t_delete"

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvcHNvcysvc3lzY2FsbC5oIGIvaW5jbHVkZS9wc29zKy9z
eXNjYWxsLmgKaW5kZXggNTVlZThhMC4uMjVjMGEyZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9w
c29zKy9zeXNjYWxsLmgKKysrIGIvaW5jbHVkZS9wc29zKy9zeXNjYWxsLmgKQEAgLTczLDYg
KzczLDE2IEBACiAjZGVmaW5lIF9fcHNvc19hc19zZW5kICAgICAgNDUKIC8qIFhlbm9tYWkg
ZXh0ZW5zaW9uOiBnZXQgcmF3IGNvdW50IG9mIGppZmZpZXMgKi8KICNkZWZpbmUgX19wc29z
X3RtX2dldGMgICAgICA0NgorI2RlZmluZSBfX3Bzb3NfdF9nZXRwdGgJCTQ3CS8qIGdldCBo
aWRkZW4gcHRocmVhZF90IGlkZW50aWZpZXIuICovCisKK3N0cnVjdCBwc29zX2FyZ19idWxr
eworCisgICAgdV9sb25nIGExOworICAgIHVfbG9uZyBhMjsKKyAgICB1X2xvbmcgYTM7Cisg
ICAgdV9sb25nIGE0OworICAgIHVfbG9uZyBhNTsKK307CiAKICNpZmRlZiBfX0tFUk5FTF9f
CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvcHNvcysvdGFzay5oIGIvaW5jbHVkZS9wc29zKy90
YXNrLmgKaW5kZXggY2EwMTU3My4uNzI5NGYwYSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9wc29z
Ky90YXNrLmgKKysrIGIvaW5jbHVkZS9wc29zKy90YXNrLmgKQEAgLTY0LDYgKzY0LDEwIEBA
IHR5cGVkZWYgc3RydWN0IHBzb3N0YXNrIHsKIAogICAgIH0gd2FpdGFyZ3M7CiAKKwkjaWZk
ZWYgQ09ORklHX1hFTk9fT1BUX1BFUlZBU0lWRQorICAgIHVfbG9uZyBwdGhyZWFkOyAvKiBo
aWRkZW4gcHRocmVhZF90IGlkZW50aWZpZXIuICovCisJI2VuZGlmCisKIH0gcHNvc3Rhc2tf
dDsKIAogc3RhdGljIGlubGluZSBwc29zdGFza190ICp0aHJlYWQycHNvc3Rhc2sgKHhudGhy
ZWFkX3QgKnQpCmRpZmYgLS1naXQgYS9rc3JjL3NraW5zL3Bzb3MrL3N5c2NhbGwuYyBiL2tz
cmMvc2tpbnMvcHNvcysvc3lzY2FsbC5jCmluZGV4IDE3NTM5MDEuLmExNmNlYzUgMTAwNjQ0
Ci0tLSBhL2tzcmMvc2tpbnMvcHNvcysvc3lzY2FsbC5jCisrKyBiL2tzcmMvc2tpbnMvcHNv
cysvc3lzY2FsbC5jCkBAIC02NywyOSArNjcsMzcgQEAgc3RhdGljIGludCBfX3RfY3JlYXRl
KHN0cnVjdCB0YXNrX3N0cnVjdCAqY3Vyciwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCiAJeG5j
b21wbGV0aW9uX3QgX191c2VyICp1X2NvbXBsZXRpb247CiAJdV9sb25nIHByaW8sIGZsYWdz
LCB0aWQsIGVycjsKIAljaGFyIG5hbWVbWE5PQkpFQ1RfTkFNRV9MRU5dOworCXN0cnVjdCBw
c29zX2FyZ19idWxrIGJ1bGs7CiAJcHNvc3Rhc2tfdCAqdGFzazsKIAotCWlmICghX194bl9h
Y2Nlc3Nfb2soY3VyciwgVkVSSUZZX1JFQUQsIF9feG5fcmVnX2FyZzEocmVncyksIDQpKQor
CWlmICghX194bl9hY2Nlc3Nfb2soY3VyciwgVkVSSUZZX1JFQUQsIF9feG5fcmVnX2FyZzEo
cmVncyksIHNpemVvZihidWxrKSkpCiAJCXJldHVybiAtRUZBVUxUOwogCisJX194bl9jb3B5
X2Zyb21fdXNlcihjdXJyLCAmYnVsaywgKHZvaWQgX191c2VyICopX194bl9yZWdfYXJnMShy
ZWdzKSwKKwkJCSAgICBzaXplb2YoYnVsaykpOworCisJaWYgKCFfX3huX2FjY2Vzc19vayhj
dXJyLCBWRVJJRllfUkVBRCwgYnVsay5hMSwgc2l6ZW9mKG5hbWUpKSkgeworCQlyZXR1cm4g
LUVGQVVMVDsKKwl9CisKIAkvKiBHZXQgdGFzayBuYW1lLiAqLwotCV9feG5fc3RybmNweV9m
cm9tX3VzZXIoY3VyciwgbmFtZSwgKGNvbnN0IGNoYXIgX191c2VyICopX194bl9yZWdfYXJn
MShyZWdzKSwKKwlfX3huX3N0cm5jcHlfZnJvbV91c2VyKGN1cnIsIG5hbWUsIChjb25zdCBj
aGFyIF9fdXNlciAqKWJ1bGsuYTEsCiAJCQkgICAgICAgc2l6ZW9mKG5hbWUpIC0gMSk7CiAJ
bmFtZVtzaXplb2YobmFtZSkgLSAxXSA9ICdcMCc7CiAJc3RybmNweShjdXJyLT5jb21tLCBu
YW1lLCBzaXplb2YoY3Vyci0+Y29tbSkpOwogCWN1cnItPmNvbW1bc2l6ZW9mKGN1cnItPmNv
bW0pIC0gMV0gPSAnXDAnOwogCiAJaWYgKCFfX3huX2FjY2Vzc19vawotCSAgICAoY3Vyciwg
VkVSSUZZX1dSSVRFLCBfX3huX3JlZ19hcmc0KHJlZ3MpLCBzaXplb2YodGlkKSkpCisJCShj
dXJyLCBWRVJJRllfV1JJVEUsIGJ1bGsuYTQsIHNpemVvZih0aWQpKSkKIAkJcmV0dXJuIC1F
RkFVTFQ7CiAKIAkvKiBUYXNrIHByaW9yaXR5LiAqLwotCXByaW8gPSBfX3huX3JlZ19hcmcy
KHJlZ3MpOworCXByaW8gPSBidWxrLmEyOwogCS8qIFRhc2sgZmxhZ3MuIEZvcmNlIEZQVSBz
dXBwb3J0IGluIHVzZXItc3BhY2UuIFRoaXMgd2lsbCBsZWFkCiAJICAgdG8gYSBuby1vcCBp
ZiB0aGUgcGxhdGZvcm0gZG9lcyBub3Qgc3VwcG9ydCBpdC4gKi8KLQlmbGFncyA9IF9feG5f
cmVnX2FyZzMocmVncykgfCBUX1NIQURPVyB8IFRfRlBVOworCWZsYWdzID0gYnVsay5hMyB8
IFRfU0hBRE9XIHwgVF9GUFU7CiAJLyogQ29tcGxldGlvbiBkZXNjcmlwdG9yIG91ciBwYXJl
bnQgdGhyZWFkIGlzIHBlbmRpbmcgb24uICovCi0JdV9jb21wbGV0aW9uID0gKHhuY29tcGxl
dGlvbl90IF9fdXNlciAqKV9feG5fcmVnX2FyZzUocmVncyk7CisJdV9jb21wbGV0aW9uID0g
KHhuY29tcGxldGlvbl90IF9fdXNlciAqKV9feG5fcmVnX2FyZzIocmVncyk7CiAKIAllcnIg
PSB0X2NyZWF0ZShuYW1lLCBwcmlvLCAwLCAwLCBmbGFncywgJnRpZCk7CiAKQEAgLTk5LDcg
KzEwNywxMCBAQCBzdGF0aWMgaW50IF9fdF9jcmVhdGUoc3RydWN0IHRhc2tfc3RydWN0ICpj
dXJyLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIAkJICogYWJvdXQgdGhlIG5ldyB0aHJlYWQg
aWQsIHNvIHdlIGNhbiBtYW5pcHVsYXRlIGl0cwogCQkgKiBUQ0IgcG9pbnRlciBmcmVlbHku
ICovCiAJCXRpZCA9IHhudGhyZWFkX2hhbmRsZSgmdGFzay0+dGhyZWFkYmFzZSk7Ci0JCV9f
eG5fY29weV90b191c2VyKGN1cnIsICh2b2lkIF9fdXNlciAqKV9feG5fcmVnX2FyZzQocmVn
cyksICZ0aWQsCisJCSNpZmRlZiBDT05GSUdfWEVOT19PUFRfUEVSVkFTSVZFCisJCXRhc2st
PnB0aHJlYWQgPSBidWxrLmE1OyAvKiBoaWRkZW4gcHRocmVhZF90IGlkZW50aWZpZXIuICov
CisJCSNlbmRpZgorCQlfX3huX2NvcHlfdG9fdXNlcihjdXJyLCAodm9pZCBfX3VzZXIgKikg
YnVsay5hNCwgJnRpZCwKIAkJCQkgIHNpemVvZih0aWQpKTsKIAkJZXJyID0geG5zaGFkb3df
bWFwKCZ0YXNrLT50aHJlYWRiYXNlLCB1X2NvbXBsZXRpb24pOyAvKiBNYXkgYmUgTlVMTCAq
LwogCX0gZWxzZSB7CkBAIC0xNDQzLDYgKzE0NTQsNDcgQEAgc3RhdGljIGludCBfX2FzX3Nl
bmQoc3RydWN0IHRhc2tfc3RydWN0ICpjdXJyLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIAly
ZXR1cm4gYXNfc2VuZCgodV9sb25nKXRhc2ssIHNpZ25hbHMpOwogfQogCisKKy8qCisgKiBp
bnQgX190X2dldHB0aCh1X2xvbmcgdGlkLCB1X2xvbmcgKnB0aHJlYWQpCisgKi8KK3N0YXRp
YyBpbnQgX190X2dldHB0aChzdHJ1Y3QgdGFza19zdHJ1Y3QgKmN1cnIsIHN0cnVjdCBwdF9y
ZWdzICpyZWdzKQoreworCXhuaGFuZGxlX3QgaGFuZGxlOworCXBzb3N0YXNrX3QgKnRhc2s7
CisJc3BsX3QgczsKKwl1X2xvbmcgZXJyID0gU1VDQ0VTUzsKKwl1X2xvbmcgcHRocmVhZDsK
KworCWhhbmRsZSA9IF9feG5fcmVnX2FyZzEocmVncyk7CisKKwlpZiAoIV9feG5fYWNjZXNz
X29rKGN1cnIsIFZFUklGWV9SRUFELCBfX3huX3JlZ19hcmcyKHJlZ3MpLCBzaXplb2YodV9s
b25nKSkpCisJCXJldHVybiAtRUZBVUxUOworCisJeG5sb2NrX2dldF9pcnFzYXZlKCZua2xv
Y2ssIHMpOworCisJaWYgKGhhbmRsZSkKKwkJdGFzayA9IChwc29zdGFza190ICopeG5yZWdp
c3RyeV9mZXRjaChoYW5kbGUpOworCWVsc2UKKwkJdGFzayA9IF9fcHNvc190YXNrX2N1cnJl
bnQoY3Vycik7CisKKwlpZiAoIXRhc2spCisJCWVyciA9IEVSUl9PQkpJRDsKKwllbHNlCisJ
eworCQkjaWZkZWYgQ09ORklHX1hFTk9fT1BUX1BFUlZBU0lWRQorCQlwdGhyZWFkID0gdGFz
ay0+cHRocmVhZDsgLyogaGlkZGVuIHB0aHJlYWRfdCBpZGVudGlmaWVyLiAqLworCQkjZW5k
aWYKKwl9CisKKwl4bmxvY2tfcHV0X2lycXJlc3RvcmUoJm5rbG9jaywgcyk7CisKKwlpZihl
cnIgPT0gU1VDQ0VTUykKKwkJX194bl9jb3B5X3RvX3VzZXIoY3VyciwgKHZvaWQgX191c2Vy
ICopIF9feG5fcmVnX2FyZzIocmVncyksICZwdGhyZWFkLCBzaXplb2YodV9sb25nKSk7CisK
KwlyZXR1cm4gZXJyOworfQorCiBzdGF0aWMgdm9pZCAqcHNvc19zaGFkb3dfZXZlbnRjYihp
bnQgZXZlbnQsIHZvaWQgKmRhdGEpCiB7CiAJc3RydWN0IHBzb3NfcmVzb3VyY2VfaG9sZGVy
ICpyaDsKQEAgLTE1MjQsNiArMTU3Niw3IEBAIHN0YXRpYyB4bnN5c2VudF90IF9fc3lzdGFi
W10gPSB7CiAJW19fcHNvc190bV9zaWduYWxdID0geyZfX3RtX3NpZ25hbCwgX194bl9leGVj
X3ByaW1hcnl9LAogCVtfX3Bzb3NfYXNfc2VuZF0gPSB7Jl9fYXNfc2VuZCwgX194bl9leGVj
X2NvbmZvcm1pbmd9LAogCVtfX3Bzb3NfdG1fZ2V0Y10gPSB7Jl9fdG1fZ2V0YywgX194bl9l
eGVjX2FueX0sCisJW19fcHNvc190X2dldHB0aF0gPSB7Jl9fdF9nZXRwdGgsIF9feG5fZXhl
Y19hbnl9LAogfTsKIAogZXh0ZXJuIHhudGJhc2VfdCAqcHNvc190YmFzZTsKZGlmZiAtLWdp
dCBhL3NyYy9za2lucy9wc29zKy90YXNrLmMgYi9zcmMvc2tpbnMvcHNvcysvdGFzay5jCmlu
ZGV4IDkzNThlYTguLjYyZTI0MTkgMTAwNjQ0Ci0tLSBhL3NyYy9za2lucy9wc29zKy90YXNr
LmMKKysrIGIvc3JjL3NraW5zL3Bzb3MrL3Rhc2suYwpAQCAtNzMsNiArNzMsNyBAQCBzdGF0
aWMgdm9pZCAqcHNvc190YXNrX3RyYW1wb2xpbmUodm9pZCAqY29va2llKQogCXN0cnVjdCBz
Y2hlZF9wYXJhbSBwYXJhbTsKIAlpbnQgcG9saWN5OwogCWxvbmcgZXJyOworCXN0cnVjdCBw
c29zX2FyZ19idWxrIGJ1bGs7CiAKIAlwb2xpY3kgPSBwc29zX3Rhc2tfc2V0X3Bvc2l4X3By
aW9yaXR5KGlhcmdzLT5wcmlvLCAmcGFyYW0pOwogCXB0aHJlYWRfc2V0c2NoZWRwYXJhbShw
dGhyZWFkX3NlbGYoKSwgcG9saWN5LCAmcGFyYW0pOwpAQCAtODEsMTAgKzgyLDE0IEBAIHN0
YXRpYyB2b2lkICpwc29zX3Rhc2tfdHJhbXBvbGluZSh2b2lkICpjb29raWUpCiAKIAlvbGRf
c2lnaGFyZGVuX2hhbmRsZXIgPSBzaWduYWwoU0lHSEFSREVOLCAmcHNvc190YXNrX3NpZ2hh
cmRlbik7CiAKLQllcnIgPSBYRU5PTUFJX1NLSU5DQUxMNShfX3Bzb3NfbXV4aWQsCi0JCQkJ
X19wc29zX3RfY3JlYXRlLAotCQkJCWlhcmdzLT5uYW1lLCBpYXJncy0+cHJpbywgaWFyZ3Mt
PmZsYWdzLAotCQkJCWlhcmdzLT50aWRfciwgaWFyZ3MtPmNvbXBsZXRpb25wKTsKKwlidWxr
LmExID0gKHVfbG9uZylpYXJncy0+bmFtZTsKKwlidWxrLmEyID0gKHVfbG9uZylpYXJncy0+
cHJpbzsKKwlidWxrLmEzID0gKHVfbG9uZylpYXJncy0+ZmxhZ3M7CisJYnVsay5hNCA9ICh1
X2xvbmcpaWFyZ3MtPnRpZF9yOworCWJ1bGsuYTUgPSAodV9sb25nKXB0aHJlYWRfc2VsZigp
OworCisJZXJyID0gWEVOT01BSV9TS0lOQ0FMTDIoX19wc29zX211eGlkLCBfX3Bzb3NfdF9j
cmVhdGUsICZidWxrLCBpYXJncy0+Y29tcGxldGlvbnApOworCiAJaWYgKGVycikKIAkJZ290
byBmYWlsOwogCkBAIC0xNzIsMTQgKzE3NywxOSBAQCB1X2xvbmcgdF9zaGFkb3coY29uc3Qg
Y2hhciAqbmFtZSwgLyogWGVub21haSBleHRlbnNpb24uICovCiAJCXVfbG9uZyBmbGFncywK
IAkJdV9sb25nICp0aWRfcikKIHsKKwlzdHJ1Y3QgcHNvc19hcmdfYnVsayBidWxrOworCiAJ
cHRocmVhZF9zZXRjYW5jZWx0eXBlKFBUSFJFQURfQ0FOQ0VMX0FTWU5DSFJPTk9VUywgTlVM
TCk7CiAKIAlvbGRfc2lnaGFyZGVuX2hhbmRsZXIgPSBzaWduYWwoU0lHSEFSREVOLCAmcHNv
c190YXNrX3NpZ2hhcmRlbik7CiAKLQlyZXR1cm4gWEVOT01BSV9TS0lOQ0FMTDUoX19wc29z
X211eGlkLAotCQkJCSBfX3Bzb3NfdF9jcmVhdGUsCi0JCQkJIG5hbWUsIHByaW8sIGZsYWdz
LAotCQkJCSB0aWRfciwgTlVMTCk7CisJYnVsay5hMSA9ICh1X2xvbmcpbmFtZTsKKwlidWxr
LmEyID0gKHVfbG9uZylwcmlvOworCWJ1bGsuYTMgPSAodV9sb25nKWZsYWdzOworCWJ1bGsu
YTQgPSAodV9sb25nKXRpZF9yOworCWJ1bGsuYTUgPSAodV9sb25nKXB0aHJlYWRfc2VsZigp
OworCisJcmV0dXJuIFhFTk9NQUlfU0tJTkNBTEwyKF9fcHNvc19tdXhpZCwgX19wc29zX3Rf
Y3JlYXRlLCAmYnVsaywgTlVMTCk7CiB9CiAKIHVfbG9uZyB0X3N0YXJ0KHVfbG9uZyB0aWQs
CkBAIC0xOTYsNyArMjA2LDMyIEBAIHVfbG9uZyB0X3N0YXJ0KHVfbG9uZyB0aWQsCiAKIHVf
bG9uZyB0X2RlbGV0ZSh1X2xvbmcgdGlkKQogeworCWxvbmcgZXJyOworCXVfbG9uZyBwdGlk
OworCisJaWYgKHRpZCA9PSAwKQorCQlnb3RvIHNlbGZfZGVsZXRlOworCisJZXJyID0gWEVO
T01BSV9TS0lOQ0FMTDIoX19wc29zX211eGlkLCBfX3Bzb3NfdF9nZXRwdGgsIHRpZCwgJnB0
aWQpOworCWlmIChlcnIpCisJCXJldHVybiBlcnI7CisKKwlpZiAoKHB0aHJlYWRfdClwdGlk
ID09IHB0aHJlYWRfc2VsZigpKQorCQlnb3RvIHNlbGZfZGVsZXRlOworCisJZXJyID0gcHRo
cmVhZF9jYW5jZWwoKHB0aHJlYWRfdClwdGlkKTsKKwlpZiAoZXJyKQorCQlyZXR1cm4gLWVy
cjsgLyogZGlmZmVyZW50aWF0ZSBmcm9tIHBTT1MgY29kZXMgKi8KKwogCXJldHVybiBYRU5P
TUFJX1NLSU5DQUxMMShfX3Bzb3NfbXV4aWQsIF9fcHNvc190X2RlbGV0ZSwgdGlkKTsKKwor
c2VsZl9kZWxldGU6CisKKwkgLyogU2lsZW50bHkgbWlncmF0ZSB0byBhdm9pZCByYWlzaW5n
IFNJR1hDUFUuICovCisJWEVOT01BSV9TWVNDQUxMMShfX3huX3N5c19taWdyYXRlLCBYRU5P
TUFJX0xJTlVYX0RPTUFJTik7CisJcHRocmVhZF9leGl0KE5VTEwpOworCisJcmV0dXJuIFNV
Q0NFU1M7IC8qIG5vdCByZWFjaGVkICovCiB9CiAKIHVfbG9uZyB0X3N1c3BlbmQodV9sb25n
IHRpZCkK
--------------020301040904080803050209--

