MIME-Version: 1.0
In-Reply-To: <5137496C.4090908@xenomai.org>
References: <CAMJ=MEfo5EU2mnM4=JDNU4QXX00W=0aC2+m5LucPYiN39W5wcQ@mail.gmail.com>
	<512FB9B5.9040709@xenomai.org>
	<CAAXf6LXDSxU_eASbHOgQzw_2xSpZua2BaORAiJ59KoPitFNEcg@mail.gmail.com>
	<51306545.1010200@xenomai.org> <5130663F.7070209@xenomai.org>
	<51306710.5030201@xenomai.org> <5130673D.2090700@xenomai.org>
	<513069D5.1090508@xenomai.org>
	<CAMJ=MEdAfvwWhjc4SLPk5smh+vNbPDJP=kM3bBFdw6n3bJd_mg@mail.gmail.com>
	<5137496C.4090908@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Wed, 6 Mar 2013 15:32:21 +0100
Message-ID: <CAMJ=MEcMeQ2oj+g099xxOukwBvGaxyNwQ5dtYDCZfMOOgD8kng@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai-forge: thread using 100% cpu load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Mar 6, 2013 at 2:49 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 03/02/2013 12:13 PM, Ronny Meeus wrote:
>
>> An update on the investigation:
>> I was able to make this issue disappear by changing the timeout value
>> of the smallest timers we use.
>> We use a couple of timers with a timeout of 25ms. By enlarging these
>> to 25sec and the problem is gone.
>>
>> Yesterday I was also able to see (using the"strace" tool) the process
>> executing constantly "clone" system calls.
>> Note that the process we use is large (2Gb) and uses an mlockall call.
>>
>> In
>> http://stackoverflow.com/questions/4263958/some-information-on-timer-helper-thread-of-librt-so-1/4935895#4935895
>> I see that a new thread is created when the timer_create is called for
>> the first time. This thread stays alive until the program exits and is
>> used to process the timer expiries.
>
>
> Looking at the code, glibc 2.9 not only forks one helper thread once, but
> also creates a dedicated short-lived thread for running the user handler at
> each timer expiration. This implementation is still current with 2.15. Which
> makes quite too many clones out there for my taste.
>
> --
> Philippe.

It can be that there are too many clones, so performance wise this is
not good, but I would assume that the code should behave correctly in
any case.

Here is the last part of the strace information I collected:

11309      0.000069 futex(0x17ab6a4, 0x81, 0x1, 0, 0 <unfinished ...>
16541      0.000042 <... futex resumed> ) = 0
16541      0.000035 futex(0x17ab6a4, 0x81, 0x1, 0, 0x17ab6a4) = 0
16541      0.000064 rt_sigprocmask(SIG_SETMASK, [], NULL, 16) = 0
16541      0.000095 exit(0)             = ?
11309      0.000054 <... futex resumed> ) = 1
11309      0.000038 rt_sigtimedwait([RT_0],  <unfinished ...>
11308      0.000060 <... clock_gettime resumed> ) = 0
11308      0.000043 timer_create(0x1, 0x157ac68, 0x1050b654 <unfinished ...>
11309      0.000074 <... rt_sigtimedwait resumed> {si_signo=SIGRT_0,
si_code=SI_TIMER, si_pid=51, si_uid=0, si_value={int=273724880,
ptr=0x1050b5d0}}, NULL, 16) = 32
11309      0.000132 sched_get_priority_min(SCHED_FIFO) = 1
11309      0.000062 sched_get_priority_max(SCHED_FIFO) = 99
11309      0.000058 clone(child_stack=0x17ab020,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID
, parent_tidptr=0, tls=0x10, child_tidptr=0) = 16543
16543      0.000117 SYS_6272()          = 0
16543      0.000058 futex(0x17ab6a4, 0x80, 0x2, 0, 0x17ab6a4 <unfinished ...>
11309      0.000040 sched_setscheduler(16543, SCHED_FIFO, { 99 }) = 0
11309      0.000067 futex(0x17ab6a4, 0x81, 0x1, 0, 0 <unfinished ...>
16543      0.000043 <... futex resumed> ) = 0
16543      0.000035 futex(0x17ab6a4, 0x81, 0x1, 0, 0x17ab6a4) = 0
16543      0.000064 rt_sigprocmask(SIG_SETMASK, [], NULL, 16) = 0
16543      0.000095 exit(0)             = ?
11309      0.000054 <... futex resumed> ) = 1
11309      0.000038 rt_sigtimedwait([RT_0],  <unfinished ...>
11308      0.000059 <... timer_create resumed> ) = 0
11309      0.000058 <... rt_sigtimedwait resumed> {si_signo=SIGRT_0,
si_code=SI_TIMER, si_pid=51, si_uid=0, si_value={int=273724880,
ptr=0x1050b5d0}}, NULL, 16) = 32
11309     15.442127 +++ killed by SIGKILL +++

I'm not an expert in this, but to me it looks like the create_timer
call, executed in the context of the 11308 thread, gets interrupted
because a signal is received by thread 11309. This signal is generated
because of a timer expiry which creates a new thread and processes the
callback function.

Is it not possible to disable all signals of the process during the
creation of the timer in xenomai. In this way we can avoid the race
condition in the library. This might be not a clean solution but would
it work as a temporary one until you finish the timer handling you
talk about in one of your earlier mails. BTW can I have some
information about what you are planning to change?

Regards,
Ronny

