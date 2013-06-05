Message-ID: <51AFA49A.3070604@xenomai.org>
Date: Wed, 05 Jun 2013 22:50:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAONLcG3gGo=vPGe+x_XBhs2ovXF9nzSkq+jvGP8zZR4daa0_4g@mail.gmail.com>
	<51AEF0A5.6010402@xenomai.org>
	<CAMJ=MEe-gaqb-wUeVPnx-9O+bL+LyCBsndrBucji5c9vqwiJDQ@mail.gmail.com>
	<51AEF87A.8060506@xenomai.org>
	<CAONLcG0x0GWn0PQN3_5S6LfUbf8fMXzRVR82Udt9=C4yHZEJhg@mail.gmail.com>
	<51AF0C0D.5060307@xenomai.org>
	<CAMJ=MEcJN=Sbtz_kw9JUKR_ckQwzMprAdYgcinZvR7SrjmetmQ@mail.gmail.com>
	<51AF120C.6070603@xenomai.org>
In-Reply-To: <51AF120C.6070603@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai-forge] psos: crash while stressing event
	timers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 06/05/2013 12:25 PM, Philippe Gerum wrote:
> On 06/05/2013 12:11 PM, Ronny Meeus wrote:
>>
>>
>> On Wed, Jun 5, 2013 at 11:59 AM, Philippe Gerum <rpm@xenomai.org
>> <mailto:rpm@xenomai.org>> wrote:
>>
>>     On 06/05/2013 11:51 AM, Tom Philips wrote:
>>
>>         Philippe,
>>
>>         I tried the asserts you suggested and here's the output:
>>
>>         +++
>>         xenomai: timerobj.c:308: timerobj_start: Assertion
>>         `timer_getoverrun(tmobj->__timer) >= 0' failed.
>>         Aborted (core dumped)
>>         +++
>>
>>
>>         So this means the call to timer_getoverrun() fails.
>>         Then I did some further investigation.
>>         I changed the code in timerobj_start() to this:
>>
>>
>>         +++
>>             if (__RT(timer_settime(tmobj->__timer, TIMER_ABSTIME, it,
>>         NULL))) {
>>               int error = errno;
>>               errno = 0;
>>               if (timer_getoverrun(tmobj->__timer) < 0) {
>>                 __bt(-errno);           => @ line 311
>>               }
>>         /*  assert(timer_getoverrun(tmobj-__>timer) >= 0); */
>>               assert(it->it_value.tv_sec >= 0 && it->it_value.tv_nsec <
>>         1000000000);
>>               assert(it->it_interval.tv_sec >= 0 &&
>>         it->it_interval.tv_nsec <
>>         1000000000);
>>               return __bt(-error);      => @ line 316
>>             }
>>         +++
>>
>>
>>         This gives following (strange) result:
>>         (The 'tm_evafter(x,y) returned' traces are from my test app)
>>
>>
>>         +++
>>
>> ------------------------------__------------------------------__------------------
>>
>>         [ ERROR BACKTRACE: thread 0.0 ]
>>
>>              #0  EINVAL in timerobj_start(), timerobj.c:316
>>         => #1  EINVAL in timerobj_start(), timerobj.c:311
>>
>> ------------------------------__------------------------------__------------------
>>
>>         tm_evafter(0,0) returned 75 (errno 22): tmid=3066037456
>>
>> ------------------------------__------------------------------__------------------
>>
>>         [ ERROR BACKTRACE: thread 4.0 ]
>>
>>         => #0  EINVAL in timerobj_start(), timerobj.c:316
>>
>> ------------------------------__------------------------------__------------------
>>
>>         tm_evafter(4,0) returned 75 (errno 0): tmid=67192088
>>
>> ------------------------------__------------------------------__------------------
>>
>>         [ ERROR BACKTRACE: thread 4.0 ]
>>
>>              #0  EINVAL in timerobj_start(), timerobj.c:316
>>         => #1  EINVAL in timerobj_start(), timerobj.c:311
>>
>> ------------------------------__------------------------------__------------------
>>
>>         tm_evafter(4,0) returned 75 (errno 22): tmid=67191880
>>         +++
>>
>>
>>         So timer_getoverrun() fails and sets errno to EINVAL (22)
>>         This can only mean that the given timerid is (or has become)
>>         invalid.
>>
>>         But timer_getoverrun() does not always fail when timer_settime()
>>         fails.
>>         My rough estimate is that 1 out of 20 times timer_getoverrun()
>>         does not fail when timer_settime() fails.
>>
>>         Might it be that there is a race condition between the above code
>>         and the code excuted at timer elapse (i.e. were the timer is
>>         destroyed)?
>>
>>
>>
>>     Yes, I think there is some race in the Xenomai code, and running SMP
>>     makes it more likely. I just got the backtrace below:
>>
>>     #0  __timer_settime_new (timerid=0x0, flags=1, value=0x7f78b2102d60,
>>          ovalue=0x0) at
>> ../nptl/sysdeps/unix/sysv/__linux/timer_settime.c:58
>>     #1  0x00007f78b229c2e0 in timerobj_start (tmobj=0x7f78440008f8,
>>          handler=0x7f78b24ca9c1 <post_event_once>, it=0x7f78b2102d60)
>>          at /home/rpm/git/xenomai-forge/__lib/copperplate/timerobj.c:309
>>     #2  0x00007f78b24cabf6 in start_evtimer (events=2, it=0x7f78b2102d60,
>>          tmid_r=0x7f78b2102db0) at
>>     /home/rpm/git/xenomai-forge/__lib/psos/tm.c:133
>>     #3  0x00007f78b24cac86 in tm_evafter (ticks=1, events=2,
>>          tmid_r=0x7f78b2102db0) at
>>     /home/rpm/git/xenomai-forge/__lib/psos/tm.c:153
>>     #4  0x0000000000400c64 in thread_timer (bidx=24, tidx=0) at
>> settime.c:73
>>     #5  0x000000000040101c in thread_receive (bidx=24, tidx=0) at
>>     settime.c:117
>>     #6  0x00000000004013a6 in thread_entry (a1=24, a2=0, a3=0, a4=0)
>>          at settime.c:149
>>     #7  0x00007f78b24c9835 in task_trampoline (arg=0x67efc80)
>>          at /home/rpm/git/xenomai-forge/__lib/psos/task.c:200
>>     #8  0x0000003d71c07d15 in start_thread (arg=0x7f78b2103700)
>>          at pthread_create.c:308
>>     #9  0x0000003d714f248d in clone ()
>>          at ../sysdeps/unix/sysv/linux/__x86_64/clone.S:114
>>
>>     The timerid is definitely broken in some cases.
>>
>>     --
>>     Philippe.
>>
>>
>>     _________________________________________________
>>     Xenomai mailing list
>>     Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>
>>     http://www.xenomai.org/__mailman/listinfo/xenomai
>>     <http://www.xenomai.org/mailman/listinfo/xenomai>
>>
>>
>> Hello
>>
>> if I understand the code of the timerserver correctly, it processes all
>> timers that have an expiry in the past.
>> So the linux timer will wake-up the timeserver thread and it simply
>> starts to process all timers for which the timeout is in the past.
>>
>> Suppose now that a timer is enqueued and right after that the task that
>> enqueues the timer is scheduled out and does only return after the timer
>> is expired. If there is another timer expired in the meantime, also the
>> timer of the process scheduled out is already processed and cleaned-up.
>>
>> In this way you have a race condition that will typically be seen under
>> heavy load and with short timeouts.
>
> I'm not sure to understand the scenario you describe. Low-resolution
> timers in userland are all processed over a single carrier thread,
> independently from the actual timer owner. When a timer elapses, it gets
> removed out of the outstanding queue on behalf of the carrier thread
> with no risk of duplicate handling and/or cleanup.
>
> However, I suspect a race between that carrier thread and the thread
> re-arming a just elapsed timer, causing the former to cleanup this timer
> unexpectedly. The code supposed to prevent looks fragile. But maybe this
> is the same scenario you just described, using another wording.
>

Please pull the last 6 commits from the "next" branch, referring to the 
pSOS emulator and copperplate libraries. These fixes make the test case 
you sent me stable, including on a 8-way machine running 50 batches. 
Feedback welcome.

Thanks for the heads up on this issue, and for the test case as well.

-- 
Philippe.

