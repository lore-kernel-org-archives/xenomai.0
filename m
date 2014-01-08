Message-ID: <52CD2290.8010107@xenomai.org>
Date: Wed, 08 Jan 2014 11:04:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKc2Hpb3myvq5SmRuRGa6pmoDDA9NnuA+doijhBARHkHt+PnOg@mail.gmail.com>
In-Reply-To: <CAKc2Hpb3myvq5SmRuRGa6pmoDDA9NnuA+doijhBARHkHt+PnOg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge pSOS app hangs on t_suspend + t_delete
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>, xenomai@xenomai.org

On 01/08/2014 10:25 AM, Kim De Mey wrote:
> Hi,
>
> I have an issue with a pSOS application that hangs after doing t_delete.
> We are using Xenomai-forge with Mercury core.
> The issue still occurs with the latest update.
>
> I can reproduce the issue with a very simple test application.
> The test application has a pSOS task that creates and starts another task.
> Then it suspends and deletes this task.
> The t_suspend() and t_delete() functions are called right after each other.
> This is the crucial part for the issue to happen.
>
> Example code:
>
> static void idle_task(u_long a,u_long b,u_long c,u_long d)
> {
>    while (1) tm_wkafter(100);
> }
>
> static void test(u_long a,u_long b,u_long c,u_long d)
> {
>    u_long tid,args[4] = {0,0,0,0};
>
>    t_create("IDLE",10,0,0,0,&tid);
>    t_start(tid,0,idle_task, args);
>
>    tm_wkafter(1000);
>
>    t_suspend(tid);
>    t_delete(tid);
>    printf("After t_delete of suspended task\n");
>
>    while (1) tm_wkafter(1000);
> }
>
> What I notice is that the cancel_sync() call in threadobj.c remains stuck
> at the sem_wait() call.
> The sem_post in finalize_thread() does not happen.
> It even looks like the finalize_thread() is never called.
> So it seems that for some reason the thread does not get cancelled (?).
>
> The issue does not always occur in my simple test.
> If I run it on more than 1 core it does not happen.
> So it looks like something racy.
> I notice the following difference in call order:
> The issue occurs when notifier_callback(), the suspend callback,
> happens after the sem_wait() (and thus after pthread_cancel()).
> The issue does not occur when the callback is started before that the
> sem_wait() call (or pthread_cancel()) occurs.
> I am not sure if that has anything to do with it.
>
> Can somebody have a look at this or give me some pointers because
> I had a look at the code and do not understand what could be causing this.
>

When your test hangs, could you attach gdb to the process, then dump the 
backtraces for all threads which are still present?

Also, the exact invocation command line of the build configuration 
script as available from config.log, would help.

TIA,

-- 
Philippe.

