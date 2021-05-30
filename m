References: <PR3PR02MB6202889054902C3CC902EF15D1229@PR3PR02MB6202.eurprd02.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai - VxWorks Emulator - Implementation of taskWait()
In-reply-to: <PR3PR02MB6202889054902C3CC902EF15D1229@PR3PR02MB6202.eurprd02.prod.outlook.com>
Date: Sun, 30 May 2021 10:00:58 +0200
Message-ID: <87fsy4k5vp.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: xenomai@xenomai.org


MONTET Julien via Xenomai <xenomai@xenomai.org> writes:

> Hi the developers,
>
> I already succeeded to use Xenomai with API/libraires such as Alchemy and Posix.
> My goal is now to use the VxWorks API.
> I don't have any issue to include path/librairies but I am trying to use the function "taskWait" (used by VxWorks) that is not present in Xenomai-VxWorks.
> https://docs.windriver.com/fr-FR/bundle/vxworks_7_application_core_os_sr0630-enus/page/CORE/taskLib.html#taskWait
> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/include_2vxworks_2taskLib_8h_source.html
>
> I don't really know if this function is obvious or if a similar code could run on Xenomai.

taskWait() is roughly equivalent to pthread_join() with WAIT_FOREVER as
a timeout. Dealing with a valid timeout would be tricky though, since
POSIX does not provide support for this, neither does libcobalt for this
reason.

[Cobalt core]     <- kernel, implements syscalls from libcobalt.so
    ^
[libcobalt]       <- POSIX API (lib/cobalt)
    ^
[libcopperplate]  <- building blocks for non-POSIX APIs (common RTOS API patterns)
    ^
[VxWorks]         <- VxWorks emulation

There is no provision for join-with-timeout in either libcopperplate or
libcobalt at the moment. If your *libc is recent enough, you could
implement pthread_tryjoin() in libcobalt (lib/cobalt/thread.c) as a
variation of the existing pthread_join(), which would use the native
pthread_tryjoin(3) instead of pthread_join(3) to have the caller wait
for the thread to exit, finalizing the operation by a call to
cobalt_thread_join().

> Could you advise a way to implement something that looks like taskWait ?
> Could rt_task_wait_period<https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__task.html#ga1645d3a072ef3cefeed3bcbb27dcf108> from Alchemy (task.h) be an interesting solution ?
>

No, this is not related. rt_task_wait_period() waits for the next wakeup
in a periodic timeline started by rt_task_set_periodic().

-- 
Philippe.

