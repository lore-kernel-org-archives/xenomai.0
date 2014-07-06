Message-ID: <53B98012.3020500@xenomai.org>
Date: Sun, 06 Jul 2014 18:57:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B964DC.1020004@xenomai.org>
 <1404662453.79446.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53B974A3.5010004@xenomai.org>
 <1404664284.37181.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <1404664634.35911.YahooMailNeo@web171602.mail.ir2.yahoo.com>
 <53B97CE2.5080700@xenomai.org>
 <1404665771.3492.YahooMailNeo@web171605.mail.ir2.yahoo.com>
In-Reply-To: <1404665771.3492.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] issue with cobalt/timer: avoid periodic timer drift
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/06/2014 06:56 PM, Matthias Schneider wrote:
> 
> 
> 
> 
> ----- Original Message -----
>> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc: 
>> Sent: Sunday, July 6, 2014 6:44 PM
>> Subject: Re: [Xenomai] issue with cobalt/timer: avoid periodic timer drift
>>
>> On 07/06/2014 06:37 PM, Matthias Schneider wrote:
>>>  ----- Original Message -----
>>>
>>>>  From: Matthias Schneider <ma30002000@yahoo.de>
>>>>  To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>; 
>> "xenomai@xenomai.org" <xenomai@xenomai.org>
>>>>  Cc: 
>>>>  Sent: Sunday, July 6, 2014 6:31 PM
>>>>  Subject: Re: [Xenomai] issue with cobalt/timer: avoid periodic timer 
>> drift
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>  ----- Original Message -----
>>>>>   From: Gilles Chanteperdrix 
>> <gilles.chanteperdrix@xenomai.org>
>>>>>   To: Matthias Schneider <ma30002000@yahoo.de>; 
>>>>  "xenomai@xenomai.org" <xenomai@xenomai.org>
>>>>>   Cc: 
>>>>>   Sent: Sunday, July 6, 2014 6:09 PM
>>>>>   Subject: Re: [Xenomai] issue with cobalt/timer: avoid periodic 
>> timer drift
>>>>>
>>>>>   On 07/06/2014 06:00 PM, Matthias Schneider wrote:
>>>>>>>    You seem to have created a periodic timer with a null 
>> period. 
>>>>  Could you
>>>>>>>    post a sample code allowing to reproduce this issue?
>>>>>>>     
>>>>>>
>>>>>>
>>>>>>    This happens in most of my freertos apps (e.g. demo, etc.). 
>> However, 
>>>>>>    I have not put any effort in narrowing the problem down, in 
>> the hope
>>>>>>    the problem would be deductible from the kernel state. Maybe 
>> you could
>>>>>>    give a few hints where a periodic timer could come into play? 
>> In the
>>>>>>    freertos skin there are only tasks, queues and semaphores, so 
>> I
>>>>>>    am not creating any periodic timer explicitly. Are there 
>> occasiosn
>>>>>>    when periodic timers are being created implicitly using the 
>> three
>>>>>>    primitives mentioned above? Or can I configure an intelligent
>>>>>>    breakpoint to catch the creation of a periodic timer?
>>>>>
>>>>>   Maybe you could put a breakpoint to see where xntimer_start is 
>> called?
>>>>
>>>>
>>>>  I have already had the idea, unfortunately it seems to be called all
>>>>  the time:
>>>>
>>>>  #0  xntimer_start (timer=0xc06b7628 <nksched+24>, value=405804, 
>>>>  interval=interval@entry=0, mode=mode@entry=XN_RELATIVE) at 
>>>>  kernel/xenomai/timer.c:104
>>>>  #1  0xc00ca504 in program_htick_shot (delay=<optimized out>, 
>>>>  cdev=<optimized out>) at kernel/xenomai/timer.c:572
>>>>  #2  0xc007407c in clockevents_program_event (dev=0xc06a65c0 
>>>>  <clockevent_gpt>, expires=..., force=force@entry=false) at 
>>>>  kernel/time/clockevents.c:269
>>>>  #3  0xc0074a54 in tick_program_event (expires=..., force=force@entry=0) 
>> at 
>>>>  kernel/time/tick-oneshot.c:31
>>>>  #4  0xc0050974 in hrtimer_interrupt (dev=<optimized out>) at 
>>>>  kernel/hrtimer.c:1360
>>>>
>>>>  Any other idea?
>>>
>>>
>>>  By the way, how can I deduce it was a periodic timer?
>>>
>>>  status seems to be 0x1 (XNTIMER_DEQUEUED), but not 0x4(XNTIMER_PERIODIC)
>>>  Also, all the other timer values seem to indicate that
>>>
>>>   if (interval != XN_INFINITE) {
>>>    timer->interval_ns = interval;
>>>    timer->interval = xnclock_ns_to_ticks(clock, interval);
>>>    timer->periodic_ticks = 0;
>>>    timer->start_date = date;
>>>    timer->pexpect_ticks = 0;
>>>    timer->status |= XNTIMER_PERIODIC;
>>>   }
>>>
>>>  was never being used for that timer...
>>
>> You mean for the timer where you hit the breakpoint, or for the timer
>> which has the bug?
> 
> 
> I assumed that if I would have create a periodic timer, status would at least
> have been or'ed with 0x4. However, as can be seen in my initial post, the 
> status value of the timer causing the problem was 1. Thats why I asked how 
> you deduced that it was a periodic timer with a period of 0.

Because normally the loop is made for periodic timers. Are you running
inside gdb?


-- 
                                                                Gilles.

