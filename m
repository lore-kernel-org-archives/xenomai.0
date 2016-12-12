From: Marco Baracchi <cormabara@yandex.com>
In-Reply-To: <68551481553062@web16j.yandex.ru>
References: <mailman.3.1481540401.18213.xenomai@xenomai.org>
 <68551481553062@web16j.yandex.ru>
MIME-Version: 1.0
Message-Id: <84831481553347@web16j.yandex.ru>
Date: Mon, 12 Dec 2016 15:35:47 +0100
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Long time system slow down on imx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sorry I hope this format is more readable

12.12.2016, 15:31, "Marco Baracchi" <cormabara@yandex.com>:
> Sorry I hope this is the correct way to add a mail to this thread inside mailing list:
>
> What you mean with "lost wakeup problem" ?
>
> What we are checking is a timer tick missing:
>
> root@deimo-staubli ~$ cat /proc/timer_list
>
> Timer List Version: v0.6
>
> HRTIMER_MAX_CLOCK_BASES: 3
>
> now at 158072087097365 nsecs
>
> cpu: 0
>
> clock 0:
>
>   .base:       80ba8380
>
>   .index:      0
>
>   .resolution: 1 nsecs
>
>   .get_time:   ktime_get
>
>   .offset:     0 nsecs
>
> active timers:
>
> #0: <80ba88a0>, tick_sched_timer, S:01
>
> # expires at 158034760000000-158034760000000 nsecs [in -37327097365 to -37327097365 nsecs]
>
> #1: <8fb57f40>, hrtimer_wakeup, S:01
>
> # expires at 158034782298842-158034782348842 nsecs [in -37304798523 to -37304748523 nsecs]
>
> #2: <8f201ad0>, hrtimer_wakeup, S:01
>
> # expires at 159434496114473-159434496164473 nsecs [in 1362409017108 to 1362409067108 nsecs]
>
> #3: <8f20bad0>, hrtimer_wakeup, S:01
>
> # expires at 159439053136473-159439057697464 nsecs [in 1366966039108 to 1366970600099 nsecs]
>
> clock 1:
>
>   .base:       80ba83b8
>
>   .index:      1
>
>   .resolution: 1 nsecs
>
>   .get_time:   ktime_get_real
>
>   .offset:     1481376344107425663 nsecs
>
> active timers:
>
> clock 2:
>
>   .base:       80ba83f0
>
>   .index:      2
>
>   .resolution: 1 nsecs
>
>   .get_time:   ktime_get_boottime
>
>   .offset:     0 nsecs
>
> active timers:
>
>   .expires_next   : 158034760000000 nsecs
>
>   .hres_active    : 1
>
>   .nr_events      : 22078740
>
>   .nr_retries     : 51929
>
>   .nr_hangs       : 0
>
>   .max_hang_time  : 0 nsecs
>
>   .nohz_mode      : 0
>
>   .idle_tick      : 0 nsecs
>
>   .tick_stopped   : 0
>
>   .idle_jiffies   : 0
>
>   .idle_calls     : 0
>
>   .idle_sleeps    : 0
>
>   .idle_entrytime : 0 nsecs
>
>   .idle_waketime  : 0 nsecs
>
>   .idle_exittime  : 0 nsecs
>
>   .idle_sleeptime : 0 nsecs
>
>   .iowait_sleeptime: 0 nsecs
>
>   .last_jiffies   : 0
>
>   .next_jiffies   : 0
>
>   .idle_expires   : 0 nsecs
>
> jiffies: 15773475
>
> Tick Device: mode:     1
>
> Per CPU device: 0
>
> Clock Event Device: mxc_timer1
>
> max_delta_ns:   4294967295
>
> min_delta_ns:   85000
>
> mult:           1
>
> shift:          0
>
> mode:           3
>
> next_event:     158034760000000 nsecs
>
> set_next_event: xnarch_next_htick_shot
>
> set_mode:       xnarch_switch_htick_mode
>
> event_handler:  hrtimer_interrupt
>
> retries:        0
>
> As you can see the next event is in the past, timer mxc_timer1 seems to have missed a tick.
>
> You mean your system is locked into a SELECT system call ?
>
> 1ms is the period of your periodic thread ?
>
> 12.12.2016, 12:00, "xenomai-request@xenomai.org" <xenomai-request@xenomai.org>:
>> Send Xenomai mailing list submissions to
>>         xenomai@xenomai.org
>>
>> To subscribe or unsubscribe via the World Wide Web, visit
>>         https://xenomai.org/mailman/listinfo/xenomai
>> or, via email, send a message with subject or body 'help' to
>>         xenomai-request@xenomai.org
>>
>> You can reach the person managing the list at
>>         xenomai-owner@xenomai.org
>>
>> When replying, please edit your Subject line so it is more specific
>> than "Re: Contents of Xenomai digest..."
>>
>> Today's Topics:
>>
>>    1. Re: Long time system slow down on imx6 (Johann Obermayr)
>>
>> ----------------------------------------------------------------------
>>
>> Message: 1
>> Date: Mon, 12 Dec 2016 11:16:33 +0100
>> From: Johann Obermayr <johann.obermayr@sigmatek.at>
>> To: Xenomai@xenomai.org
>> Subject: Re: [Xenomai] Long time system slow down on imx6
>> Message-ID: <f07822d2-e30a-d394-bae6-bdf776c0f03a@sigmatek.at>
>> Content-Type: text/plain; charset=utf-8; format=flowed
>>
>> Am 09.12.2016 um 23:42 schrieb Marco:
>>>      We are notice a very strange problem on a imx6 with kernel
>>>      Linux3.0.35-4.1.0 + xenomai_2.6.4. After machine runs for 8 - 10 hours
>>>      we found the system blocked in may different ways (user interface
>>>      tcp/ip interface ecc..)
>>>
>>>      ?
>>>
>>>      We check into /proc/timer_list and we found the next event was
>>>      scheduled in the past.
>>>
>>>      ?
>>>
>>>      We found some items about timer blocked but all the patches indicated
>>>      was already applied.
>>>
>>>      ?
>>>
>>>      Maybe someone have seen a similar problem ?
>>>  _______________________________________________
>>>  Xenomai mailing list
>>>  Xenomai@xenomai.org
>>>  https://xenomai.org/mailman/listinfo/xenomai
>>
>> Hello,
>>
>> i don't known if it is the same problem.
>> But we search a lost wakeup problem with "select" and a short timeout. (1ms)
>>
>> Regards
>>    Johann
>>
>> ------------------------------
>>
>> Subject: Digest Footer
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>>
>> ------------------------------
>>
>> End of Xenomai Digest, Vol 56, Issue 11
>> ***************************************

