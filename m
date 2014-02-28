MIME-Version: 1.0
In-Reply-To: <531096F9.8080503@xenomai.org>
References: <CAKc2HpZ+zHoF22BjPKj_x0V+oOX9ZcLpU-N1jNv1pjq6sQhsqQ@mail.gmail.com>
 <52F7B36C.5010905@xenomai.org>
 <CAKc2HpaFwremV-pUgYez_O5gAvg_f=NeMihnFMZ0vgf3GJWG8Q@mail.gmail.com>
 <CAKc2Hpaus4Vryt5LdDexzRTyYr16Ux-bbVz2c6WoWdgX6j7D5Q@mail.gmail.com>
 <53108F8C.20000@xenomai.org> <531096F9.8080503@xenomai.org>
Date: Fri, 28 Feb 2014 15:35:00 +0100
Message-ID: <CAKc2HpZEC7RD4ghGvZ16W0Qvt9rmMLneZJMOvXN2tyJURwj9sg@mail.gmail.com>
From: Kim De Mey <kim.demey@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai-forge pSOS t_start followed by t_suspend does
 not work
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

2014-02-28 15:02 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:
> On 02/28/2014 02:30 PM, Philippe Gerum wrote:
>> On 02/26/2014 09:54 AM, Kim De Mey wrote:
>>> 2014-02-10 12:23 GMT+01:00 Kim De Mey <kim.demey@gmail.com>:
>>>> 2014-02-09 17:57 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:
>>>>> On 02/06/2014 02:36 PM, Kim De Mey wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I believe there is a problem in Xenomai-forge when doing a pSOS
>>>>>> t_suspend() call right after a t_start() call.
>>>>>> It looks like the task does not get suspended in some cases. The
>>>>>> return value of t_suspend() is 0 however.
>>>>>>
>>>>>> I suspect that this happens when the threadobj_prologue() is not
>>>>>> finished yet at the moment that the notifier_sighandler() is called.
>>>>>> In this case it could be that the notifier_init() did not run yet. If
>>>>>> this is the case, then the notifier_sighandler() will not do any
>>>>>> notifier callback and thus the task will not be suspended. Additional
>>>>>> t_suspend() calls will not work as the "notified" flag has been set
>>>>>> already.
>>>>>> Is this possible?
>>>>>>
>>>>>
>>>>> Unfortunately, yes.
>>>>>
>>>>> This is a general issue in the current implementation, as any child
>>>>> thread
>>>>> created by the emulation sub-system might not have fully registered
>>>>> before
>>>>> the parent refers to it due to priority/wait state issues.
>>>>>
>>>>> We definitely need stronger handshaking there, could you please
>>>>> check again
>>>>> with this changes in?
>>>>> http://git.xenomai.org/xenomai-forge.git/commit/?h=next&id=a48b8f640cad510a1101e380cc54ef2bf29afcd6
>>>>>
>>>>>
>>>>> TIA,
>>>>>
>>>>
>>>> I tested the new revision and the problems no longer occur. So it
>>>> looks good!
>>>>
>>>> Many thanks for fixing this so quickly.
>>>>
>>>
>>> Hi Philippe,
>>>
>>> I'm afraid the new handshaking mechanism introduced to fix the
>>> problems I was having created an actually worse problem.
>>>
>>> If now a parent task with high priority creates a child task with low
>>> priority while there is another task with medium priority creating a
>>> high load on the CPU then the parent task gets stuck in the creation
>>> of the child. This while the parent task has a higher priority than
>>> the task creating the load.
>>>
>>> I believe it is due to the fact that the parent task now waits for a
>>> sem_post of the child, which in this case has a too low priority to
>>> get this done.
>>>
>>> Should the child priority be temporary increased to the one of the
>>> parent during the creation or would that be a bad idea?
>>>
>>
>> I don't see any other option for preventing this priority inversion
>> anyway, since the child prologue is logically part of the parent context
>> actually. IOW, the child has to fully inherit the scheduling parameters
>> of the parent until its prologue is over. Ok, will do this.
>>
>
> Does this patch helps with your test case?

Yes, this patch fixes the problem. Test case works and the original
suspend test case also still works.
I will run it over more tests but so far it looks good.

Thanks!

>
> diff --git a/lib/copperplate/internal.c b/lib/copperplate/internal.c
> index a7f86e7..86e69af 100644
> --- a/lib/copperplate/internal.c
> +++ b/lib/copperplate/internal.c
> @@ -68,10 +68,9 @@ int copperplate_probe_node(unsigned int id)
>  int copperplate_create_thread(struct corethread_attributes *cta,
>                               pthread_t *tid)
>  {
> -       struct sched_param_ex param_ex;
>         pthread_attr_ex_t attr_ex;
>         size_t stacksize;
> -       int policy, ret;
> +       int ret;
>
>         ret = thread_spawn_prologue(cta);
>         if (ret)
> @@ -81,12 +80,8 @@ int copperplate_create_thread(struct corethread_attributes *cta,
>         if (stacksize < PTHREAD_STACK_MIN * 4)
>                 stacksize = PTHREAD_STACK_MIN * 4;
>
> -       param_ex.sched_priority = cta->prio;
> -       policy = cta->prio ? SCHED_RT : SCHED_OTHER;
>         pthread_attr_init_ex(&attr_ex);
> -       pthread_attr_setinheritsched_ex(&attr_ex, PTHREAD_EXPLICIT_SCHED);
> -       pthread_attr_setschedpolicy_ex(&attr_ex, policy);
> -       pthread_attr_setschedparam_ex(&attr_ex, &param_ex);
> +       pthread_attr_setinheritsched_ex(&attr_ex, PTHREAD_INHERIT_SCHED);
>         pthread_attr_setstacksize_ex(&attr_ex, stacksize);
>         pthread_attr_setdetachstate_ex(&attr_ex, cta->detachstate);
>         ret = __bt(-pthread_create_ex(tid, &attr_ex, thread_trampoline, cta));
> @@ -120,6 +115,11 @@ static inline void prepare_wait_corespec(void)
>         cobalt_thread_harden();
>  }
>
> +static inline int finish_wait_corespec(struct corethread_attributes *cta)
> +{
> +       return __bt(copperplate_renice_thread(pthread_self(), cta->prio));
> +}
> +
>  #else /* CONFIG_XENO_MERCURY */
>
>  int copperplate_probe_node(unsigned int id)
> @@ -130,10 +130,9 @@ int copperplate_probe_node(unsigned int id)
>  int copperplate_create_thread(struct corethread_attributes *cta,
>                               pthread_t *tid)
>  {
> -       struct sched_param param;
>         pthread_attr_t attr;
>         size_t stacksize;
> -       int policy, ret;
> +       int ret;
>
>         ret = thread_spawn_prologue(cta);
>         if (ret)
> @@ -143,12 +142,8 @@ int copperplate_create_thread(struct corethread_attributes *cta,
>         if (stacksize < PTHREAD_STACK_MIN * 4)
>                 stacksize = PTHREAD_STACK_MIN * 4;
>
> -       param.sched_priority = cta->prio;
> -       policy = cta->prio ? SCHED_RT : SCHED_OTHER;
>         pthread_attr_init(&attr);
> -       pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
> -       pthread_attr_setschedpolicy(&attr, policy);
> -       pthread_attr_setschedparam(&attr, &param);
> +       pthread_attr_setinheritsched(&attr, PTHREAD_INHERIT_SCHED);
>         pthread_attr_setstacksize(&attr, stacksize);
>         pthread_attr_setdetachstate(&attr, cta->detachstate);
>         ret = __bt(-pthread_create(tid, &attr, thread_trampoline, cta));
> @@ -176,6 +171,11 @@ static inline void prepare_wait_corespec(void)
>         /* empty */
>  }
>
> +static inline int finish_wait_corespec(struct corethread_attributes *cta)
> +{
> +       return __bt(copperplate_renice_thread(pthread_self(), cta->prio));
> +}
> +
>  #endif  /* CONFIG_XENO_MERCURY */
>
>  static int thread_spawn_prologue(struct corethread_attributes *cta)
> @@ -208,19 +208,17 @@ static void thread_spawn_wait(sem_t *sem)
>
>  static void *thread_trampoline(void *arg)
>  {
> -       struct corethread_attributes *cta = arg;
> -       void *__arg, *(*__run)(void *arg);
> +       struct corethread_attributes *cta = arg, _cta;
>         sem_t released;
>         int ret;
>
>         /*
>          * cta may be on the parent's stack, so it may be dandling
> -        * soon after the parent is posted: copy what we need from
> -        * this area early on.
> +        * soon after the parent is posted: copy this argument
> +        * structure early on.
>          */
> -       __run = cta->run;
> -       __arg = cta->arg;
> -       ret = cta->prologue(__arg);
> +       _cta = *cta;
> +       ret = cta->prologue(cta->arg);
>         cta->__reserved.status = ret;
>
>         if (ret) {
> @@ -238,12 +236,13 @@ static void *thread_trampoline(void *arg)
>          */
>         prepare_wait_corespec();
>         __RT(sem_post(&cta->__reserved.warm));
> -
>         thread_spawn_wait(&released);
> -
>         __RT(sem_destroy(&released));
> +       ret = finish_wait_corespec(&_cta);
> +       if (ret)
> +               warning("core thread prologue failed, %s", symerror(ret));
>
> -       return __run(__arg);
> +       return _cta.run(_cta.arg);
>  }
>
>  static int thread_spawn_epilogue(struct corethread_attributes *cta)
>
>
> --
> Philippe.

