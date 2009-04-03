Message-ID: <49D63AAB.2020708@domain.hid>
Date: Fri, 03 Apr 2009 18:34:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49D481EF.1010908@domain.hid> <49D4ED4E.40707@domain.hid>
	<49D61BB6.20002@domain.hid>
In-Reply-To: <49D61BB6.20002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fix rt_task_shadow error path without __thread.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Hi,
>>>
>>> it seems that rt_task_shadow currently leaves the self tsd assigned (and
>>> uninitialized) in case of error. So, here is an attempt to fix this
>>> situation:
>> Good point.
>>
>>> Index: src/skins/native/task.c
>>> ===================================================================
>>> --- src/skins/native/task.c     (revision 4727)
>>> +++ src/skins/native/task.c     (working copy)
>>> @@ -187,15 +187,8 @@
>>>
>>>  #ifdef HAVE___THREAD
>>>         self = &__native_self;
>>> -#else /* !HAVE___THREAD */
>>> -       self = pthread_getspecific(__native_tskey);
>>> +#endif /* HAVE___THREAD */
>>>
>>> -       if (!self)
>>> -               self = malloc(sizeof(*self));
>>> -
>>> -       pthread_setspecific(__native_tskey, self);
>>> -#endif /* !HAVE___THREAD */
>>> -
>>>         if (task == NULL)
>>>                 task = &task_desc; /* Discarded. */
>>>
>>> @@ -217,9 +210,13 @@
>>>                                 NULL);
>>>
>>>         if (!err) {
>>> -               if (self)
>>> -                       *self = *task;
>>> +#ifndef HAVE___THREAD
>>> +               self = malloc(sizeof(*self));
>> Hmm, this creates a potential relaxation point (and may raise SIGXCPU if
>> the warn flag is set). I would prefer to keep early allocation and
>> release the chunk properly on error (as well as reset the tsd).
>>
>>> +               pthread_setspecific(__native_tskey, self);
>>> +#endif /* !HAVE___THREAD */
>>> +               *self = *task;
>> And if self is NULL, ie. malloc failed for whatever obscure reasons? The
>> existing code skipped over this, maybe we should actually handle it and
>> return an error code.
> 
> Ok. Here is a new version which addresses the above critics. Note that 
> there is still a potential for SIGXCPU: if the task calling 
> rt_task_shadow has already been mapped by another skin, the 
> __native_task_create syscall will fail, and free will be called. 
> However, such use of rt_task_shadow may be considered a programming 
> error, and we may accept a SIGXCPU in such a case.

Agreed.

> 
> diff --git a/src/skins/native/task.c b/src/skins/native/task.c
> index 905d366..e448576 100644
> --- a/src/skins/native/task.c
> +++ b/src/skins/native/task.c
> @@ -188,10 +188,13 @@ int rt_task_shadow(RT_TASK *task, const char *name, int prio
>  #ifdef HAVE___THREAD
>         self = &__native_self;
>  #else /* !HAVE___THREAD */
> -       self = pthread_getspecific(__native_tskey);
> +       if (pthread_getspecific(__native_tskey))
> +               /* Current task is already a native taks. */
> +               return -EBUSY;
> 
> +       self = malloc(sizeof(*self));
>         if (!self)
> -               self = malloc(sizeof(*self));
> +               return -ENOMEM;
> 
>         pthread_setspecific(__native_tskey, self);
>  #endif /* !HAVE___THREAD */
> @@ -210,21 +213,30 @@ int rt_task_shadow(RT_TASK *task, const char *name, int prio
>         bulk.a5 = (u_long)pthread_self();
>         bulk.a6 = (u_long)xeno_init_current_mode();
> 
> -       if (!bulk.a6)
> -               return -ENOMEM;
> +       if (!bulk.a6) {
> +               err = -ENOMEM;
> +               goto fail;
> +       }
> 
>         err = XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk,
>                                 NULL);
> +       if (err)
> +               goto fail;
> 
> -       if (!err) {
> -               if (self)
> -                       *self = *task;
> +       *self = *task;
> 
> -               xeno_set_current();
> +       xeno_set_current();
> 
> -               if (mode & T_WARNSW)
> -                       xeno_sigxcpu_no_mlock = 0;
> -       }
> +       if (mode & T_WARNSW)
> +               xeno_sigxcpu_no_mlock = 0;
> +
> +       return 0;
> +
> +  fail:
> +#ifndef HAVE___THREAD
> +       pthread_setspecific(__native_tskey, NULL);
> +       free(self);
> +#endif  /* !HAVE___THREAD */
> 
>         return err;
>  }
> 

Looks good to me.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

