Message-ID: <53BC20E5.6090607@xenomai.org>
Date: Tue, 08 Jul 2014 18:48:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKc2Hpb0S50P=9iWvw3z9NexHmyZEjuAU=7SGyT77EPpub_D2A@mail.gmail.com>	<53B57361.1000603@xenomai.org>
 <CAKc2HpZROnFhxVZo3PWQzAoTYZHvvRCydFqxokKS_bQT2LHYVg@mail.gmail.com>
In-Reply-To: <CAKc2HpZROnFhxVZo3PWQzAoTYZHvvRCydFqxokKS_bQT2LHYVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge: Deadlock in finalize_thread()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/07/2014 09:58 AM, Kim De Mey wrote:
> 2014-07-03 17:14 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:
>> On 07/03/2014 10:11 AM, Kim De Mey wrote:
>>
>>> What I think that goes wrong is that the lock which is taken in
>>> threadobj_notify_entry() is not released before threadobj_start()
>>> continues at wait_on_barrier(thobj, __THREAD_S_ACTIVE).
>>
>>
>> Until threadobj_notify_entry() releases that lock, there is no way
>> wait_on_barrier() can exit, since it competes for the same lock.
>> pthread_cond_wait() will grab this lock before returning.
>>
>
> Yes, you are right, the wait_on_barrier() can not exit until the
> unlock. I misunderstood this part.
>
>>
>> As there is a
>>>
>>> t_delete() done right after t_start() returns in my test case, this
>>> could mean that the thread gets in finalize_thread() after the
>>> pthread_cancel() and blocks there on the threadobj_lock() as the
>>> threadobj_unlock() from threadobj_notify_entry() was possibly not yet
>>> called.
>>
>>
>> called? do you mean exited instead?
>>
>> Until wait_on_barrier() unwinds for the child task, theadobj_start() cannot
>> complete for its parent, so the latter cannot delete the child it has just
>> spawned, until the latter has dropped the lock from
>> threadobj_notify_entry(). So I'm unsure the explanation stands - unless I
>> missed your point entirely.
>
> No, you got my point, the explanation does not stand indeed.
>
>>
>> This said, there must be something fishy as the backtrace clearly shows a
>> child thread hanging in the finalizer, waiting for access to its own tcb.
>>
>> If you have a simple standalone test case illustrating this bug, please send
>> it along, this would save me some precious time trying to reproduce the
>> issue accurately. Otherwise I'll write one.
>
> I have a very simple test case:
>
> static void worker(u_long a,u_long b,u_long c,u_long d)
> {
>    while(1)
>      tm_wkafter(100);
> }
>
> static void create_delete(u_long a,u_long b,u_long c,u_long d)
> {
>    u_long tid, args[4] = {0,0,0,0};
>    int j;
>
>    for(j =0; j < 1000; j++)
>    {
>      if(t_create("TEST",50,0,0,0,&tid))
>        printf("t_create failed!\n");
>      if(t_start(tid,0, worker, args))
>        printf("t_start failed!\n");
>      if(t_delete(tid))
>        printf("t_delete failed!\n");
>    }
>
>    while (1) tm_wkafter(1000);
> }
>
> int main(int argc, char * const argv[])
> {
>    u_long tid,args[4] = {0,0,0,0};
>    copperplate_init(&argc,&argv);
>
>    t_create("CRDE",50,0,0,0,&tid);
>    t_start(tid,0,create_delete, args);
>
>    while (1) tm_wkafter(1000);
>    return 0;
> }
>
> In my case, running 1000 loops has about 4 to 10 "TEST" threads that hang.
>

I can't reproduce the issue with this test case, it's likely 
timing-dependent anyway. Please post the output of <test-program> 
--dump-config, so that I can match your build options.

TIA,

-- 
Philippe.

