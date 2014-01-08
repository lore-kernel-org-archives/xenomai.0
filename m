MIME-Version: 1.0
In-Reply-To: <52CD2290.8010107@xenomai.org>
References: <CAKc2Hpb3myvq5SmRuRGa6pmoDDA9NnuA+doijhBARHkHt+PnOg@mail.gmail.com>
 <52CD2290.8010107@xenomai.org>
Date: Wed, 8 Jan 2014 13:23:56 +0100
Message-ID: <CAKc2HpZ50=BeBvDATODZJ=yBS9bd=-SCiFO20Vr1Zjg11Z+8cg@mail.gmail.com>
From: Kim De Mey <kim.demey@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai-forge pSOS app hangs on t_suspend + t_delete
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

2014/1/8 Philippe Gerum <rpm@xenomai.org>:
> On 01/08/2014 10:25 AM, Kim De Mey wrote:
>>
>> Hi,
>>
>> I have an issue with a pSOS application that hangs after doing t_delete.
>> We are using Xenomai-forge with Mercury core.
>> The issue still occurs with the latest update.
>>
>> I can reproduce the issue with a very simple test application.
>> The test application has a pSOS task that creates and starts another task.
>> Then it suspends and deletes this task.
>> The t_suspend() and t_delete() functions are called right after each
>> other.
>> This is the crucial part for the issue to happen.
>>
>> Example code:
>>
>> static void idle_task(u_long a,u_long b,u_long c,u_long d)
>> {
>>    while (1) tm_wkafter(100);
>> }
>>
>> static void test(u_long a,u_long b,u_long c,u_long d)
>> {
>>    u_long tid,args[4] = {0,0,0,0};
>>
>>    t_create("IDLE",10,0,0,0,&tid);
>>    t_start(tid,0,idle_task, args);
>>
>>    tm_wkafter(1000);
>>
>>    t_suspend(tid);
>>    t_delete(tid);
>>    printf("After t_delete of suspended task\n");
>>
>>    while (1) tm_wkafter(1000);
>> }
>>
>> What I notice is that the cancel_sync() call in threadobj.c remains stuck
>> at the sem_wait() call.
>> The sem_post in finalize_thread() does not happen.
>> It even looks like the finalize_thread() is never called.
>> So it seems that for some reason the thread does not get cancelled (?).
>>
>> The issue does not always occur in my simple test.
>> If I run it on more than 1 core it does not happen.
>> So it looks like something racy.
>> I notice the following difference in call order:
>> The issue occurs when notifier_callback(), the suspend callback,
>> happens after the sem_wait() (and thus after pthread_cancel()).
>> The issue does not occur when the callback is started before that the
>> sem_wait() call (or pthread_cancel()) occurs.
>> I am not sure if that has anything to do with it.
>>
>> Can somebody have a look at this or give me some pointers because
>> I had a look at the code and do not understand what could be causing this.
>>
>
> When your test hangs, could you attach gdb to the process, then dump the
> backtraces for all threads which are still present?
>
> Also, the exact invocation command line of the build configuration script as
> available from config.log, would help.
>
> TIA,
>
> --
> Philippe.


Here are the backtraces:

main thread:
(gdb) bt
#0  clock_nanosleep (clock_id=<optimized out>, flags=<optimized out>,
req=<optimized out>, rem=<optimized out>)
    at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:51
#1  0x00b45e10 in threadobj_sleep () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#2  0x00b2b618 in tm_wkafter () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
#3  0x10000b3c in main (argc=1, argv=0x104120e0) at suspend_delete_easy.c:42

first psos task:
(gdb) bt
#0  0x00b6b5c8 in __old_sem_wait (sem=<optimized out>) at
../nptl/sysdeps/unix/sysv/linux/sem_wait.c:105
#1  0x00b45c84 in threadobj_cancel () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#2  0x00b2ac44 in t_delete () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
#3  0x10000a70 in test (a=0, b=0, c=0, d=0) at suspend_delete_easy.c:22
#4  0x00b2a658 in task_trampoline () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
#5  0x00b63824 in start_thread (arg=<optimized out>) at pthread_create.c:299
#6  0x00c7df4c in __thread_start () from
output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6

second psos task:
(gdb) bt
#0  0x00b6cbbc in read () from
output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libpthread.so.0
#1  0x00b47bd8 in notifier_wait () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#2  0x00b460b0 in notifier_callback () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#3  0x00b47d30 in notifier_sighandler () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#4  <signal handler called>
#5  sigcancel_handler (sig=32, si=0x1e03aa8, ctx=0x1e03b28) at init.c:136
#6  <signal handler called>
#7  clock_nanosleep (clock_id=<optimized out>, flags=<optimized out>,
req=<optimized out>, rem=<optimized out>)
    at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:51
#8  0x00b45e10 in threadobj_sleep () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#9  0x00b2b618 in tm_wkafter () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
#10 0x100009bc in idle_task (a=0, b=0, c=0, d=0) at suspend_delete_easy.c:9
#11 0x00b2a658 in task_trampoline () from
/repo/kdemey/buildroot/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
#12 0x00b63824 in start_thread (arg=<optimized out>) at pthread_create.c:299
#13 0x00c7df4c in __thread_start () from
output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6


Invocation command line was

  $ ./configure --target=mips64-buildroot-linux-gnu
--host=mips64-buildroot-linux-gnu --build=x86_64-unknown-linux-gnu
--prefix=/usr --exec-prefix=/usr --sysconfdir=/etc --program-prefix=
--disable-gtk-doc --disable-doc --disable-docs --disable-documentation
--with-xmlto=no --with-fop=no --enable-ipv6 --enable-static
--enable-shared --with-core=mercury
--includedir=/usr/include/xenomai-forge --disable-doc-install
--enable-lores-clock


Is this what you were asking?


By the way, I forgot the mention the following test that I did:

When the application is blocked I've done an "echo 1 > /proc/pid/fd/xx",
where xx is the file descriptor that is being read from in the notifier_wait().
This kinda emulates a t_resume.

After doing this the t_delete gets finalized and the application unblocks.

