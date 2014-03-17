MIME-Version: 1.0
In-Reply-To: <1395004042.86948.YahooMailNeo@web171605.mail.ir2.yahoo.com>
References: <1394996997.10478.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <532605BE.3060101@xenomai.org>
 <1395004042.86948.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Mon, 17 Mar 2014 10:50:37 +0100
Message-ID: <CAKc2HpZ66-9PiC1Rju59CyZHdWRJW=_MeJ8BDurdgr_snz5pbg@mail.gmail.com>
From: Kim De Mey <kim.demey@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Issue suspending threads on mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

2014-03-16 22:07 GMT+01:00 Matthias Schneider <ma30002000@yahoo.de>:
>> On Sunday, March 16, 2014 9:12 PM, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
>> > On 03/16/2014 08:09 PM, Matthias Schneider wrote:
>>
>>>  Hi all,
>>>
>>>  I am experiencing a problem with xenomai-forge (recent "next"
>> checkout) on Mercury (on top of a 3.12.9+CONFIG_PREEMPT_RT on x86) when suspending
>>>  tasks/threads.
>>>
>>>  As far  as I understand, the mercury implementation sends a signal to the thread
>>>  to be suspended, with that threads signal handler setting the suspended state,
>>>  i.e. the setting of __THREAD_S_SUSPENDED happens in notifier_callback, which
>>>  seems to be different from the cobalt implementation.
>>>
>>>  The problem I am experiencing is that sometimes the signal handler never seems
>>>  to get called in a thread that should be suspended,  i.e. that thread suspension
>>>  sometimes simply does not work.
>>>  The following example code (for the vxworks skin) reproduces the issue (it gets
>>>  stuck in the loop waiting for the WIND_SUSPEND flag):
>>>
>>>  http://www.pastebin.ca/2667435
>>>
>>>  Any hints on how I can continue investigating this issue?
>>
>> Have you tried checking taskSpawn and taskSuspend return values? To see
>> if the calls are successful?
>>
>>
>> --
>>                                                                 Gilles.
>>
>
> Hi Gilles,
>
> yes, the calls seem to return with "OK". I have put updated sample code at
>
> http://www.pastebin.ca/2667459
>
>
> The problem seems to happen quite often when attached with gdb (mostly during
> the first execution of the do .. while loop.

Not sure if this is anyhow related but I have seen problems with the
signal handler when gdb is attached before. I noticed this when
debugging this issue:
http://www.xenomai.org/pipermail/xenomai/2014-February/030117.html

It looked like the notifier_sighandler() often ran on the wrong thread
when gdb was attached, causing it to fail at owner check and thus
never doing the notifier callback. I only noticed this with gdb
attached though.

>
> The thread not suspended stack looks like this:
> #0  0xffffe424 in __kernel_vsyscall ()
> #1  0xb7e8e8ee in clock_nanosleep (clock_id=-1208270244, flags=1, req=0xb69ff1f0, rem=0x0) at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:47
> #2  0xb7fa02cb in threadobj_sleep (ts=0xb69ff1f0) at threadobj.c:1096
> #3  0xb7fcdf00 in taskDelay (ticks=1000) at taskLib.c:851
> #4  0x0804878f in windTask (...) at task-1.c:15
> [...]
>
> while all the other suspended stacks look like
>
> #0  0xffffe424 in __kernel_vsyscall ()
> #1  0xb7f5272b in read () at ../sysdeps/unix/syscall-template.S:81
> #2  0xb7fa679f in notifier_wait (nf=0x804a418) at notifier.c:279
> #3  0xb7f9cf36 in notifier_callback (nf=0x804a418) at threadobj.c:430
> #4  0xb7fa524d in notifier_sighandler (sig=42, siginfo=0xb7d89e0c, uc=0xb7d89e8c) at notifier.c:91
> #5  <signal handler called>
> #6  0xffffe424 in __kernel_vsyscall ()
> #7  0xb7e8e8ee in clock_nanosleep (...) at clock_nanosleep.c:47
> #8  0xb7fa02cb in threadobj_sleep (ts=0xb7d8a1f0) at threadobj.c:1096
> #9  0xb7fcdf00 in taskDelay (ticks=1000) at taskLib.c:851
> #10 0x0804878f in windTask (...) at task-1.c:15
>
> , which is probably what I would suspect...
>
> Matthias
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

