MIME-Version: 1.0
In-Reply-To: <50486572.5060305@xenomai.org>
References: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>
	<50460BCE.8010505@xenomai.org>
	<CANKLDmtmnbAb7PM4URTjxYtaH5WnvGjVcEPOpSNr2A6gPwLLaA@mail.gmail.com>
	<50464969.2000902@xenomai.org> <5046549C.7030008@xenomai.org>
	<CANKLDmufv25Bngqb3CapS6ybHG9DH76DUq1q6dinzJ5ai7TowA@mail.gmail.com>
	<5046FF0A.9000208@xenomai.org>
	<CANKLDmverDgL3c2BEtXAwkGhq7KLRopGnM3q9Z_TQiAAeMponw@mail.gmail.com>
	<50470D2D.8020004@xenomai.org>
	<CANKLDmudbBw5gyWVe_nPSLkQTopaH0ajs3FXgJottn84Cm6anQ@mail.gmail.com>
	<5047318D.8060106@xenomai.org> <504735A6.5040800@xenomai.org>
	<CANKLDmtbOPWG_bc3=pcbSpgbEvSj=5ZsiXm3CWgBCwBx=yQ8Pw@mail.gmail.com>
	<5047449C.2040308@xenomai.org> <5047A68D.3020001@xenomai.org>
	<5047B83D.5030403@xenomai.org>
	<CANKLDmtj=+OUzgL8Kc5LtOiE0U8R4mZWS=x1PXH=f2THyUG7bw@mail.gmail.com>
	<50486572.5060305@xenomai.org>
Date: Thu, 6 Sep 2012 16:33:13 +0200
Message-ID: <CANKLDmtAkFtFawHbW9CyxaBgM=Uqp5K5P3LRZ_Ydnwjp7fa1Qw@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] kernel NULL pointer dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Sep 6, 2012 at 10:57 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/06/2012 10:40 AM, Henri Roosen wrote:
>> On Wed, Sep 5, 2012 at 10:38 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On 09/05/2012 09:22 PM, Gilles Chanteperdrix wrote:
>>>
>>>> On 09/05/2012 02:25 PM, Gilles Chanteperdrix wrote:
>>>>
>>>>> On 09/05/2012 02:10 PM, Henri Roosen wrote:
>>>>>> I will find out why the application is doing a sys_exit. However I'm
>>>>>> not sure how this is related to the thread affinity; when not setting
>>>>>> the affinity, the problem is not reproducable.
>>>>>
>>>>> Thanks for the trace. When we find the bug we will say, of course, that
>>>>> is the reason! Anyway, at first sight, the bug does not seem related to
>>>>> multi-processor, I would say the difference with affinity is a
>>>>> difference in how the cleanup happens in your application (namely the
>>>>> case where a mutex holder is destroyed while another thread which is
>>>>> waiting for the mutex is still alive).
>>>>
>>>>
>>>> Indeed, the bug is reproducible on any UP board with the following
>>>> test case. With RPI enabled, the NULL user_task pointer is a problem in
>>>> RPI handling functions, but with RPI disabled, I get the same backtrace
>>>> as you.
>>>
>>>
>>> The real test code, which really triggers the bug
>>>
>>> #include <stdio.h>
>>> #include <string.h>
>>>
>>> #include <unistd.h>
>>> #include <sys/mman.h>
>>> #include <pthread.h>
>>> #include <semaphore.h>
>>>
>>> pthread_mutex_t mutex;
>>> sem_t ready;
>>>
>>> void locker(void)
>>> {
>>>         pthread_set_name_np(pthread_self(), "locker");
>>>         pthread_mutex_lock(&mutex);
>>>         sem_post(&ready);
>>> }
>>>
>>> void waiter(void)
>>> {
>>>         pthread_set_name_np(pthread_self(), "waiter");
>>>         sem_wait(&ready);
>>>         pthread_mutex_lock(&mutex);
>>> }
>>>
>>> void *thread(void *cookie)
>>> {
>>>         locker();
>>>         sleep(1);
>>>         return cookie;
>>> }
>>>
>>> int main(void)
>>> {
>>>         pthread_mutexattr_t mattr;
>>>         struct sched_param sp;
>>>         pthread_t tid;
>>>         int rc;
>>>
>>>         mlockall(MCL_CURRENT | MCL_FUTURE);
>>>
>>>         pthread_mutexattr_init(&mattr);
>>>         pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
>>>
>>>         rc = pthread_mutex_init(&mutex, &mattr);
>>>         pthread_mutexattr_destroy(&mattr);
>>>         if (rc) {
>>>                 fprintf(stderr, "pthread_mutex_init: %s\n", strerror(rc));
>>>                 return 1;
>>>         }
>>>
>>>         rc = sem_init(&ready, 0, 0);
>>>         if (rc) {
>>>                 perror("sem_init");
>>>                 return 1;
>>>         }
>>>
>>>         rc = pthread_create(&tid, NULL, thread, NULL);
>>>         if (rc) {
>>>                 fprintf(stderr, "pthread_create: %s\n", strerror(rc));
>>>                 return 1;
>>>         }
>>>
>>>         sp.sched_priority = 99;
>>>         pthread_setschedparam(pthread_self(), SCHED_FIFO, &sp);
>>>
>>>         waiter();
>>>
>>>         return 0;
>>> }
>>>
>>
>> Thanks for the patch and test application!!
>>
>> I tried the patch (with the two previous applied patches still applied
>> too) and cannot reproduce the kernel NULL pointer dereference anymore
>> in the QEMU environment. I did a quick test on the hardware and it
>> seems also there this problem doesn't occur anymore. However, our
>> application does not run yet; the thread that caused the problem when
>> moved to another core now dies when moved. That is probably the
>> sys_exit call.. however, when keeping all threads on the same core,
>> this thread just starts without a problem. I will try and find out
>> what is going on there and will get back with more detailed info.
>
> So, you are calling sched_setaffinity while holding a PI mutex and under
> priority boost? That is a priority inversion, if you have
> CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX, you probably die because you receive
> a SIGDEBUG and do not have a handler installed. See
> examples/native/sigdebug.c.
>

Found out our application has some mechanism in place that suspends
certain threads, which was causing Xenomai functions to return -EINTR
and that we handle as fatal exception and stop the thread... I
disabled that mechanism for now and the application starts and seems
to run normal.

So the latter is an issue in our application.
Thanks Gilles for your excellent support!

> --
>                                             Gilles.

