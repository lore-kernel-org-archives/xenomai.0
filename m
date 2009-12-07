Message-ID: <4B1CCE12.4080106@domain.hid>
Date: Mon, 07 Dec 2009 10:42:42 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080403020302040409070905"
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
--------------080403020302040409070905
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hello,

I come back to you to submit a slightly different patch.
I observed that __psos_t_delete sometimes returns ERR_OBJID after=20
pthread_cancel has been issued, due to thread isn't found on kernel side.
The attached patch uses the same mechanism as in native API=20
(rt_task_delete) where equivalent error is being filtered.

Please find attached this patch (formated with git format-patch origin).

If it's looks like ok on your side, do you think this patch can be=20
integrated in xenomai project?

Best regards,

Fabrice

Philippe Gerum a =E9crit :
> On Fri, 2009-11-13 at 15:11 +0100, Alexandre Coffignal wrote:
> =20
>> Hello,
>>
>> Please find attached a new patch that should take into account your=20
>> latest remarks.
>> This patch has been created using 'git diff -p' command and applies=20
>> on 2.4.10 revision.
>> I'm not sure I fully understand your remark on missing critical=20
>> section. Indeed, this code is similar to __t_delete routine that=20
>> doesn't seem to have critical section enforcement?
>> Should a critical section be added to it as well ?
>>    =20
>
> No, __t_delete() is safe because it does not directly dereference the
> task pointer fetched from the registry, but simply passes it to the
> actual t_delete() syscall, which will revalidate that pointer before
> doing anything silly with it.
>
> __t_get_pthread() on the other hand, does dereference the task pointer
> to fetch the opaque handle, which is unsafe unless this is done within a
> critical section.
>
> =20
>> Anyway, I tried to replicate __t_ident mechanism as you mentioned.
>>
>> Please let me know your feeling about this.
>>
>> Fabrice
>>   =20
>>>
>>>
>>> On Thu, 2009-11-05 at 11:54 +0100, Alexandre Coffignal wrote:
>>>
>>>       =20
>>>> Does this fix seem more suitable to you?
>>>> Do you see someting else missing?
>>>>
>>>>            =20
>>> The logic is fine, but the implementation should get closer to what is
>>> being done in the -head branch.
>>>
>>> Preliminary remarks:
>>>
>>> - Please follow the kernel CodingStyle guidelines for anything that is
>>> Xenomai-related, including userland code. Keeping a single code style
>>> throughout our code makes things easier for reviewing, and keeps visual
>>> pollution to the lowest possible level.
>>>
>>> - Please rebase your work on 2.4.10 for pushing those changes to=20
>>> Xenomai
>>> mainline. There is no point for us to consider changes to legacy
>>> releases which are not being actively maintained anymore; you can=20
>>> always
>>> backport those changes to 2.4.7 locally if you really fancy dealing=20
>>> with
>>> bugs solved between 2.4.7 and 2.4.10...
>>>
>>> - Please tell your CVS/SVN diff tool to use -p, when formatting=20
>>> patches.
>>> =20
>>>       =20
>>>> Please advice.
>>>>            =20
>>>       =20
>>>> plain text document attachment (patch_psos_t_delete)
>>>> Index: xenomai-2.4.7_bugless/include/psos+/syscall.h
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- xenomai-2.4.7_bugless.orig/include/psos+/syscall.h   =20
>>>> 2009-11-05 09:12:29.000000000 +0100
>>>> +++ xenomai-2.4.7_bugless/include/psos+/syscall.h    2009-11-05=20
>>>> 09:13:14.000000000 +0100
>>>> @@ -73,6 +73,7 @@
>>>>  #define __psos_as_send      45
>>>>  /* Xenomai extension: get raw count of jiffies */
>>>>  #define __psos_tm_getc      46
>>>> +#define __psos_t_get_pthread        47    /* get hidden pthread_t=20
>>>> identifier. */
>>>>            =20
>>> psos_t_getpth is enough. To be really, really pSOS-conformant when
>>> introducing a routine, we should either use:
>>>
>>> 1) a preposterously long argument list
>>>
>>> or, at the very least:
>>> =20
>>> 2) an absolutely unpronounceable C identifier
>>>
>>> __psos_t_getpth happily qualifies for #2.
>>>
>>>       =20
>>>> =20
>>>>  #ifdef __KERNEL__
>>>> =20
>>>> Index: xenomai-2.4.7_bugless/ksrc/skins/psos+/syscall.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- xenomai-2.4.7_bugless.orig/ksrc/skins/psos+/syscall.c   =20
>>>> 2009-11-05 09:16:48.000000000 +0100
>>>> +++ xenomai-2.4.7_bugless/ksrc/skins/psos+/syscall.c    2009-11-05=20
>>>> 09:16:57.000000000 +0100
>>>> @@ -67,29 +67,37 @@
>>>>      xncompletion_t __user *u_completion;
>>>>      u_long prio, flags, tid, err;
>>>>      char name[XNOBJECT_NAME_LEN];
>>>> +    struct arg_bulk5 bulk;
>>>>            =20
>>> Please have a look at what is being done in the -head branch, for the
>>> very same routine (in the absence of -p passed to diff, seems to be
>>> __t_create). An arg bulk has been introduced there, so you just need to
>>> backport this.
>>>
>>>       =20
>>>>      psostask_t *task;
>>>> =20
>>>> -    if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs), 4))
>>>> +    if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs),=20
>>>> sizeof(bulk)))
>>>> +        return -EFAULT;
>>>> +
>>>> +    __xn_copy_from_user(curr, &bulk, (void __user=20
>>>> *)__xn_reg_arg1(regs),
>>>> +                sizeof(bulk));
>>>> +
>>>> +    if (!__xn_access_ok(curr, VERIFY_READ, bulk.a1, sizeof(name))) {
>>>>          return -EFAULT;
>>>> +    }
>>>> =20
>>>>      /* Get task name. */
>>>> -    __xn_strncpy_from_user(curr, name, (const char __user=20
>>>> *)__xn_reg_arg1(regs),
>>>> +    __xn_strncpy_from_user(curr, name, (const char __user *)bulk.a1,
>>>>                     sizeof(name) - 1);
>>>>      name[sizeof(name) - 1] =3D '\0';
>>>>      strncpy(curr->comm, name, sizeof(curr->comm));
>>>>      curr->comm[sizeof(curr->comm) - 1] =3D '\0';
>>>> =20
>>>>      if (!__xn_access_ok
>>>> -        (curr, VERIFY_WRITE, __xn_reg_arg4(regs), sizeof(tid)))
>>>> +        (curr, VERIFY_WRITE, bulk.a4, sizeof(tid)))
>>>>          return -EFAULT;
>>>> =20
>>>>      /* Task priority. */
>>>> -    prio =3D __xn_reg_arg2(regs);
>>>> +    prio =3D bulk.a2;
>>>>      /* Task flags. Force FPU support in user-space. This will lead
>>>>         to a no-op if the platform does not support it. */
>>>> -    flags =3D __xn_reg_arg3(regs) | T_SHADOW | T_FPU;
>>>> +    flags =3D bulk.a3 | T_SHADOW | T_FPU;
>>>>      /* Completion descriptor our parent thread is pending on. */
>>>> -    u_completion =3D (xncompletion_t __user *)__xn_reg_arg5(regs);
>>>> +    u_completion =3D (xncompletion_t __user *)__xn_reg_arg2(regs);
>>>> =20
>>>>      err =3D t_create(name, prio, 0, 0, flags, &tid);
>>>> =20
>>>> @@ -99,7 +107,8 @@
>>>>           * about the new thread id, so we can manipulate its
>>>>           * TCB pointer freely. */
>>>>          tid =3D xnthread_handle(&task->threadbase);
>>>> -        __xn_copy_to_user(curr, (void __user=20
>>>> *)__xn_reg_arg4(regs), &tid,
>>>> +        task->opaque2 =3D bulk.a5; /* hidden pthread_t identifier. */
>>>> +        __xn_copy_to_user(curr, (void __user *) bulk.a4, &tid,
>>>>                    sizeof(tid));
>>>>          err =3D xnshadow_map(&task->threadbase, u_completion); /*=20
>>>> May be NULL */
>>>>      } else {
>>>> @@ -1443,6 +1452,36 @@
>>>>      return as_send((u_long)task, signals);
>>>>  }
>>>> =20
>>>> +
>>>> +/*
>>>> + * int __t_get_pthread(u_long tid, u_long *pthread)
>>>> + */
>>>> +static int __t_get_pthread(struct task_struct *curr, struct=20
>>>> pt_regs *regs)
>>>> +{
>>>> +    xnhandle_t handle;
>>>> +    psostask_t *task;
>>>> +    u_long pthread;
>>>> +
>>>> +    handle =3D __xn_reg_arg1(regs);
>>>> +
>>>> +    if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg2(regs),=20
>>>> sizeof(u_long)))
>>>> +        return -EFAULT;
>>>> +
>>>> +    if (handle)
>>>> +        task =3D (psostask_t *)xnregistry_fetch(handle);
>>>> +    else
>>>> +        task =3D __psos_task_current(curr);
>>>> +
>>>> +    if (!task)
>>>> +        return ERR_OBJID;
>>>>            =20
>>> Critical section enforcement is missing. What if the caller gets
>>> preempted after the handle is fetched, and the non-current tid gets
>>> killed by a concurrent thread right after? See t_ident for an
>>> illustration.
>>>
>>> If the deletion happens after the critical section, well, we would just
>>> have to hope that pthread_cancel() does a good job at validating its
>>> handle, but at least we would not have referred to stale memory on our
>>> end.
>>>
>>>       =20
>>>> +
>>>> +    pthread =3D task->opaque2; /* hidden pthread_t identifier. */
>>>> +
>>>> +    __xn_copy_to_user(curr, (void __user *) __xn_reg_arg2(regs),=20
>>>> &pthread, sizeof(u_long));
>>>> +
>>>> +    return SUCCESS;
>>>> +}
>>>> +
>>>>  static void *psos_shadow_eventcb(int event, void *data)
>>>>  {
>>>>      struct psos_resource_holder *rh;
>>>> @@ -1524,6 +1563,7 @@
>>>>      [__psos_tm_signal] =3D {&__tm_signal, __xn_exec_primary},
>>>>      [__psos_as_send] =3D {&__as_send, __xn_exec_conforming},
>>>>      [__psos_tm_getc] =3D {&__tm_getc, __xn_exec_any},
>>>> +    [__psos_t_get_pthread] =3D {&__t_get_pthread, __xn_exec_any},
>>>>  };
>>>> =20
>>>>  extern xntbase_t *psos_tbase;
>>>> Index: xenomai-2.4.7_bugless/src/skins/psos+/task.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- xenomai-2.4.7_bugless.orig/src/skins/psos+/task.c    2009-11-05=20
>>>> 09:17:31.000000000 +0100
>>>> +++ xenomai-2.4.7_bugless/src/skins/psos+/task.c    2009-11-05=20
>>>> 09:17:56.000000000 +0100
>>>> @@ -26,6 +26,15 @@
>>>>  #include <memory.h>
>>>>  #include <psos+/psos.h>
>>>> =20
>>>> +struct arg_bulk5{
>>>> +
>>>> +    u_long a1;
>>>> +    u_long a2;
>>>> +    u_long a3;
>>>> +    u_long a4;
>>>> +    u_long a5;
>>>> +};
>>>>            =20
>>> Rather use psos_arg_bulk like in -head tree.
>>>
>>>       =20
>>>> +
>>>>  extern int __psos_muxid;
>>>> =20
>>>>  struct psos_task_iargs {
>>>> @@ -73,6 +82,7 @@
>>>>      struct sched_param param;
>>>>      int policy;
>>>>      long err;
>>>> +    struct arg_bulk5 bulk;
>>>> =20
>>>>      policy =3D psos_task_set_posix_priority(iargs->prio, &param);
>>>>      pthread_setschedparam(pthread_self(), policy, &param);
>>>> @@ -81,10 +91,14 @@
>>>> =20
>>>>      old_sigharden_handler =3D signal(SIGHARDEN, &psos_task_sigharden);
>>>> =20
>>>> -    err =3D XENOMAI_SKINCALL5(__psos_muxid,
>>>> -                __psos_t_create,
>>>> -                iargs->name, iargs->prio, iargs->flags,
>>>> -                iargs->tid_r, iargs->completionp);
>>>> +    bulk.a1 =3D (u_long)iargs->name;
>>>> +    bulk.a2 =3D (u_long)iargs->prio;
>>>> +    bulk.a3 =3D (u_long)iargs->flags;
>>>> +    bulk.a4 =3D (u_long)iargs->tid_r;
>>>> +    bulk.a5 =3D (u_long)pthread_self();
>>>> +
>>>> +    err =3D XENOMAI_SKINCALL2(__psos_muxid, __psos_t_create, &bulk,=20
>>>> iargs->completionp);
>>>> +
>>>>      if (err)
>>>>          goto fail;
>>>> =20
>>>> @@ -172,14 +186,19 @@
>>>>          u_long flags,
>>>>          u_long *tid_r)
>>>>  {
>>>> +    struct arg_bulk5 bulk;
>>>> +
>>>>      pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>>>> =20
>>>>      old_sigharden_handler =3D signal(SIGHARDEN, &psos_task_sigharden);
>>>> =20
>>>> -    return XENOMAI_SKINCALL5(__psos_muxid,
>>>> -                 __psos_t_create,
>>>> -                 name, prio, flags,
>>>> -                 tid_r, NULL);
>>>> +    bulk.a1 =3D (u_long)name;
>>>> +    bulk.a2 =3D (u_long)prio;
>>>> +    bulk.a3 =3D (u_long)flags;
>>>> +    bulk.a4 =3D (u_long)tid_r;
>>>> +    bulk.a5 =3D (u_long)pthread_self();
>>>> +
>>>> +    return XENOMAI_SKINCALL2(__psos_muxid, __psos_t_create, &bulk,=20
>>>> NULL);
>>>>  }
>>>> =20
>>>>  u_long t_start(u_long tid,
>>>> @@ -196,6 +215,18 @@
>>>> =20
>>>>  u_long t_delete(u_long tid)
>>>>  {
>>>> +    long err;
>>>> +    u_long pthread;
>>>> +
>>>> +    if(tid)
>>>> +    {
>>>> +        err =3D XENOMAI_SKINCALL2(__psos_muxid,=20
>>>> __psos_t_get_pthread, tid, &pthread);
>>>> +        if (err)
>>>> +            return err;
>>>> +        err =3D pthread_cancel((pthread_t)pthread);
>>>> +        if (err)
>>>> +            return err;
>>>> +    }
>>>>            =20
>>> We should handle the self-deletion case specifically:
>>>
>>> +    else {
>>> +        /* Silently migrate to avoid raising SIGXCPU. */
>>> +        XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
>>> +        pthread_exit(NULL);
>>> +    }
>>>
>>> Actually, we should also test for the case when a non-zero tid ends up
>>> pointing at the current thread as well, e.g.
>>>
>>>         if (tid =3D=3D 0)
>>>             goto self_delete;
>>>
>>>         err =3D XENOMAI_SKINCALL2(__psos_muxid, __psos_t_getpth, tid,=20
>>> &ptid);
>>>         if (err)
>>>             return err;
>>>
>>>         if ((pthread_t)ptid =3D=3D pthread_self())
>>>             goto self_delete;
>>>
>>>         err =3D pthread_cancel((pthread_t)ptid);
>>>         if (err)
>>>             return -err; /* differentiate from pSOS codes */
>>>
>>>         return XENOMAI_SKINCALL1(__psos_muxid, __psos_t_delete, tid);
>>> self_delete:
>>>          /* Silently migrate to avoid raising SIGXCPU. */        =20
>>> XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
>>>         pthread_exit(NULL);
>>>
>>>         return SUCCESS; /* not reached */
>>>
>>>       =20
>>>>      return XENOMAI_SKINCALL1(__psos_muxid, __psos_t_delete, tid);
>>>>  }
>>>> =20
>>>> Index: xenomai-2.4.7_bugless/include/psos+/task.h
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- xenomai-2.4.7_bugless.orig/include/psos+/task.h    2009-11-05=20
>>>> 09:19:49.000000000 +0100
>>>> +++ xenomai-2.4.7_bugless/include/psos+/task.h    2009-11-05=20
>>>> 09:19:58.000000000 +0100
>>>> @@ -26,6 +26,16 @@
>>>> =20
>>>>  #define PSOS_TASK_MAGIC 0x81810101
>>>> =20
>>>> +struct arg_bulk5{
>>>> +
>>>> +    u_long a1;
>>>> +    u_long a2;
>>>> +    u_long a3;
>>>> +    u_long a4;
>>>> +    u_long a5;
>>>> +};
>>>> +
>>>> +
>>>>  typedef struct psostask {
>>>> =20
>>>>      unsigned magic;   /* Magic code - must be first */
>>>> @@ -64,6 +74,8 @@
>>>> =20
>>>>      } waitargs;
>>>> =20
>>>> +    u_long opaque2; /* hidden pthread_t identifier. */
>>>>            =20
>>> No need to make this more opaque than required to the reviewer;=20
>>> besides,
>>> we only need this field when user-space support is compiled in.
>>>
>>> -    u_long opaque2; /* hidden pthread_t identifier. */
>>>
>>> +    #ifdef CONFIG_XENO_OPT_PERVASIVE
>>> +        u_long pthread;
>>> +    #endif
>>>
>>>       =20
>>>> +
>>>>  } psostask_t;
>>>> =20
>>>>  static inline psostask_t *thread2psostask (xnthread_t *t)
>>>>            =20
>>>        =20
>> plain text document attachment (patch_psos_t_delete)
>> diff --git a/include/psos+/syscall.h b/include/psos+/syscall.h
>> index 55ee8a0..25c0a2d 100644
>> --- a/include/psos+/syscall.h
>> +++ b/include/psos+/syscall.h
>> @@ -73,6 +73,16 @@
>>  #define __psos_as_send      45
>>  /* Xenomai extension: get raw count of jiffies */
>>  #define __psos_tm_getc      46
>> +#define __psos_t_getpth        47    /* get hidden pthread_t=20
>> identifier. */
>> +
>> +struct psos_arg_bulk{
>> +
>> +    u_long a1;
>> +    u_long a2;
>> +    u_long a3;
>> +    u_long a4;
>> +    u_long a5;
>> +};
>> =20
>>  #ifdef __KERNEL__
>> =20
>> diff --git a/include/psos+/task.h b/include/psos+/task.h
>> index ca01573..7294f0a 100644
>> --- a/include/psos+/task.h
>> +++ b/include/psos+/task.h
>> @@ -64,6 +64,10 @@ typedef struct psostask {
>> =20
>>      } waitargs;
>> =20
>> +    #ifdef CONFIG_XENO_OPT_PERVASIVE
>> +    u_long pthread; /* hidden pthread_t identifier. */
>> +    #endif
>> +
>>  } psostask_t;
>> =20
>>  static inline psostask_t *thread2psostask (xnthread_t *t)
>> diff --git a/ksrc/skins/psos+/syscall.c b/ksrc/skins/psos+/syscall.c
>> index 1753901..a16cec5 100644
>> --- a/ksrc/skins/psos+/syscall.c
>> +++ b/ksrc/skins/psos+/syscall.c
>> @@ -67,29 +67,37 @@ static int __t_create(struct task_struct *curr,=20
>> struct pt_regs *regs)
>>      xncompletion_t __user *u_completion;
>>      u_long prio, flags, tid, err;
>>      char name[XNOBJECT_NAME_LEN];
>> +    struct psos_arg_bulk bulk;
>>      psostask_t *task;
>> =20
>> -    if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs), 4))
>> +    if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs),=20
>> sizeof(bulk)))
>>          return -EFAULT;
>> =20
>> +    __xn_copy_from_user(curr, &bulk, (void __user=20
>> *)__xn_reg_arg1(regs),
>> +                sizeof(bulk));
>> +
>> +    if (!__xn_access_ok(curr, VERIFY_READ, bulk.a1, sizeof(name))) {
>> +        return -EFAULT;
>> +    }
>> +
>>      /* Get task name. */
>> -    __xn_strncpy_from_user(curr, name, (const char __user=20
>> *)__xn_reg_arg1(regs),
>> +    __xn_strncpy_from_user(curr, name, (const char __user *)bulk.a1,
>>                     sizeof(name) - 1);
>>      name[sizeof(name) - 1] =3D '\0';
>>      strncpy(curr->comm, name, sizeof(curr->comm));
>>      curr->comm[sizeof(curr->comm) - 1] =3D '\0';
>> =20
>>      if (!__xn_access_ok
>> -        (curr, VERIFY_WRITE, __xn_reg_arg4(regs), sizeof(tid)))
>> +        (curr, VERIFY_WRITE, bulk.a4, sizeof(tid)))
>>          return -EFAULT;
>> =20
>>      /* Task priority. */
>> -    prio =3D __xn_reg_arg2(regs);
>> +    prio =3D bulk.a2;
>>      /* Task flags. Force FPU support in user-space. This will lead
>>         to a no-op if the platform does not support it. */
>> -    flags =3D __xn_reg_arg3(regs) | T_SHADOW | T_FPU;
>> +    flags =3D bulk.a3 | T_SHADOW | T_FPU;
>>      /* Completion descriptor our parent thread is pending on. */
>> -    u_completion =3D (xncompletion_t __user *)__xn_reg_arg5(regs);
>> +    u_completion =3D (xncompletion_t __user *)__xn_reg_arg2(regs);
>> =20
>>      err =3D t_create(name, prio, 0, 0, flags, &tid);
>> =20
>> @@ -99,7 +107,10 @@ static int __t_create(struct task_struct *curr,=20
>> struct pt_regs *regs)
>>           * about the new thread id, so we can manipulate its
>>           * TCB pointer freely. */
>>          tid =3D xnthread_handle(&task->threadbase);
>> -        __xn_copy_to_user(curr, (void __user *)__xn_reg_arg4(regs),=20
>> &tid,
>> +        #ifdef CONFIG_XENO_OPT_PERVASIVE
>> +        task->pthread =3D bulk.a5; /* hidden pthread_t identifier. */
>> +        #endif
>> +        __xn_copy_to_user(curr, (void __user *) bulk.a4, &tid,
>>                    sizeof(tid));
>>          err =3D xnshadow_map(&task->threadbase, u_completion); /* May=20
>> be NULL */
>>      } else {
>> @@ -1443,6 +1454,47 @@ static int __as_send(struct task_struct *curr,=20
>> struct pt_regs *regs)
>>      return as_send((u_long)task, signals);
>>  }
>> =20
>> +
>> +/*
>> + * int __t_getpth(u_long tid, u_long *pthread)
>> + */
>> +static int __t_getpth(struct task_struct *curr, struct pt_regs *regs)
>> +{
>> +    xnhandle_t handle;
>> +    psostask_t *task;
>> +    spl_t s;
>> +    u_long err =3D SUCCESS;
>> +    u_long pthread;
>> +
>> +    handle =3D __xn_reg_arg1(regs);
>> +
>> +    if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg2(regs),=20
>> sizeof(u_long)))
>> +        return -EFAULT;
>> +
>> +    xnlock_get_irqsave(&nklock, s);
>> +
>> +    if (handle)
>> +        task =3D (psostask_t *)xnregistry_fetch(handle);
>> +    else
>> +        task =3D __psos_task_current(curr);
>> +
>> +    if (!task)
>> +        err =3D ERR_OBJID;
>> +    else
>> +    {
>> +        #ifdef CONFIG_XENO_OPT_PERVASIVE
>> +        pthread =3D task->pthread; /* hidden pthread_t identifier. */
>> +        #endif
>> +    }
>> +
>> +    xnlock_put_irqrestore(&nklock, s);
>> +
>> +    if(err =3D=3D SUCCESS)
>> +        __xn_copy_to_user(curr, (void __user *) __xn_reg_arg2(regs),=20
>> &pthread, sizeof(u_long));
>> +
>> +    return err;
>> +}
>> +
>>  static void *psos_shadow_eventcb(int event, void *data)
>>  {
>>      struct psos_resource_holder *rh;
>> @@ -1524,6 +1576,7 @@ static xnsysent_t __systab[] =3D {
>>      [__psos_tm_signal] =3D {&__tm_signal, __xn_exec_primary},
>>      [__psos_as_send] =3D {&__as_send, __xn_exec_conforming},
>>      [__psos_tm_getc] =3D {&__tm_getc, __xn_exec_any},
>> +    [__psos_t_getpth] =3D {&__t_getpth, __xn_exec_any},
>>  };
>> =20
>>  extern xntbase_t *psos_tbase;
>> diff --git a/src/skins/psos+/task.c b/src/skins/psos+/task.c
>> index 9358ea8..62e2419 100644
>> --- a/src/skins/psos+/task.c
>> +++ b/src/skins/psos+/task.c
>> @@ -73,6 +73,7 @@ static void *psos_task_trampoline(void *cookie)
>>      struct sched_param param;
>>      int policy;
>>      long err;
>> +    struct psos_arg_bulk bulk;
>> =20
>>      policy =3D psos_task_set_posix_priority(iargs->prio, &param);
>>      pthread_setschedparam(pthread_self(), policy, &param);
>> @@ -81,10 +82,14 @@ static void *psos_task_trampoline(void *cookie)
>> =20
>>      old_sigharden_handler =3D signal(SIGHARDEN, &psos_task_sigharden);
>> =20
>> -    err =3D XENOMAI_SKINCALL5(__psos_muxid,
>> -                __psos_t_create,
>> -                iargs->name, iargs->prio, iargs->flags,
>> -                iargs->tid_r, iargs->completionp);
>> +    bulk.a1 =3D (u_long)iargs->name;
>> +    bulk.a2 =3D (u_long)iargs->prio;
>> +    bulk.a3 =3D (u_long)iargs->flags;
>> +    bulk.a4 =3D (u_long)iargs->tid_r;
>> +    bulk.a5 =3D (u_long)pthread_self();
>> +
>> +    err =3D XENOMAI_SKINCALL2(__psos_muxid, __psos_t_create, &bulk,=20
>> iargs->completionp);
>> +
>>      if (err)
>>          goto fail;
>> =20
>> @@ -172,14 +177,19 @@ u_long t_shadow(const char *name, /* Xenomai=20
>> extension. */
>>          u_long flags,
>>          u_long *tid_r)
>>  {
>> +    struct psos_arg_bulk bulk;
>> +
>>      pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>> =20
>>      old_sigharden_handler =3D signal(SIGHARDEN, &psos_task_sigharden);
>> =20
>> -    return XENOMAI_SKINCALL5(__psos_muxid,
>> -                 __psos_t_create,
>> -                 name, prio, flags,
>> -                 tid_r, NULL);
>> +    bulk.a1 =3D (u_long)name;
>> +    bulk.a2 =3D (u_long)prio;
>> +    bulk.a3 =3D (u_long)flags;
>> +    bulk.a4 =3D (u_long)tid_r;
>> +    bulk.a5 =3D (u_long)pthread_self();
>> +
>> +    return XENOMAI_SKINCALL2(__psos_muxid, __psos_t_create, &bulk,=20
>> NULL);
>>  }
>> =20
>>  u_long t_start(u_long tid,
>> @@ -196,7 +206,32 @@ u_long t_start(u_long tid,
>> =20
>>  u_long t_delete(u_long tid)
>>  {
>> +    long err;
>> +    u_long ptid;
>> +
>> +    if (tid =3D=3D 0)
>> +        goto self_delete;
>> +
>> +    err =3D XENOMAI_SKINCALL2(__psos_muxid, __psos_t_getpth, tid, &ptid=
);
>> +    if (err)
>> +        return err;
>> +
>> +    if ((pthread_t)ptid =3D=3D pthread_self())
>> +        goto self_delete;
>> +
>> +    err =3D pthread_cancel((pthread_t)ptid);
>> +    if (err)
>> +        return -err; /* differentiate from pSOS codes */
>> +
>>      return XENOMAI_SKINCALL1(__psos_muxid, __psos_t_delete, tid);
>> +
>> +self_delete:
>> +
>> +     /* Silently migrate to avoid raising SIGXCPU. */
>> +    XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
>> +    pthread_exit(NULL);
>> +
>> +    return SUCCESS; /* not reached */
>>  }
>> =20
>>  u_long t_suspend(u_long tid)
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
>>    =20
>
>
>  =20


--------------080403020302040409070905
Content-Type: text/x-patch;
 name="0001-Fix-t_delete-call-in-psos-skin-from-user-land.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Fix-t_delete-call-in-psos-skin-from-user-land.patch"

>From 9235829ceaf327c53929c9138eb1b783d1b83b1c Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Date: Mon, 7 Dec 2009 09:42:19 +0100
Subject: [PATCH] Fix t_delete call in psos skin from user land

---
 include/psos+/syscall.h    |   10 ++++++
 include/psos+/task.h       |    4 ++
 ksrc/skins/psos+/syscall.c |   67 +++++++++++++++++++++++++++++++++++++++----
 src/skins/psos+/task.c     |   57 +++++++++++++++++++++++++++++++------
 4 files changed, 122 insertions(+), 16 deletions(-)

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
index ca01573..7294f0a 100644
--- a/include/psos+/task.h
+++ b/include/psos+/task.h
@@ -64,6 +64,10 @@ typedef struct psostask {
 
     } waitargs;
 
+	#ifdef CONFIG_XENO_OPT_PERVASIVE
+    u_long pthread; /* hidden pthread_t identifier. */
+	#endif
+
 } psostask_t;
 
 static inline psostask_t *thread2psostask (xnthread_t *t)
diff --git a/ksrc/skins/psos+/syscall.c b/ksrc/skins/psos+/syscall.c
index 1753901..a16cec5 100644
--- a/ksrc/skins/psos+/syscall.c
+++ b/ksrc/skins/psos+/syscall.c
@@ -67,29 +67,37 @@ static int __t_create(struct task_struct *curr, struct pt_regs *regs)
 	xncompletion_t __user *u_completion;
 	u_long prio, flags, tid, err;
 	char name[XNOBJECT_NAME_LEN];
+	struct psos_arg_bulk bulk;
 	psostask_t *task;
 
-	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs), 4))
+	if (!__xn_access_ok(curr, VERIFY_READ, __xn_reg_arg1(regs), sizeof(bulk)))
 		return -EFAULT;
 
+	__xn_copy_from_user(curr, &bulk, (void __user *)__xn_reg_arg1(regs),
+			    sizeof(bulk));
+
+	if (!__xn_access_ok(curr, VERIFY_READ, bulk.a1, sizeof(name))) {
+		return -EFAULT;
+	}
+
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
 
@@ -99,7 +107,10 @@ static int __t_create(struct task_struct *curr, struct pt_regs *regs)
 		 * about the new thread id, so we can manipulate its
 		 * TCB pointer freely. */
 		tid = xnthread_handle(&task->threadbase);
-		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg4(regs), &tid,
+		#ifdef CONFIG_XENO_OPT_PERVASIVE
+		task->pthread = bulk.a5; /* hidden pthread_t identifier. */
+		#endif
+		__xn_copy_to_user(curr, (void __user *) bulk.a4, &tid,
 				  sizeof(tid));
 		err = xnshadow_map(&task->threadbase, u_completion); /* May be NULL */
 	} else {
@@ -1443,6 +1454,47 @@ static int __as_send(struct task_struct *curr, struct pt_regs *regs)
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
+	{
+		#ifdef CONFIG_XENO_OPT_PERVASIVE
+		pthread = task->pthread; /* hidden pthread_t identifier. */
+		#endif
+	}
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
@@ -1524,6 +1576,7 @@ static xnsysent_t __systab[] = {
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


--------------080403020302040409070905--

