Message-ID: <47CBE07D.6010307@domain.hid>
Date: Mon, 03 Mar 2008 12:26:53 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <47C838A9.8040200@domain.hid>	<2ff1a98a0802290958k3457d577j8e2ad01079612320@domain.hid>
	<47CBD35A.6030305@domain.hid> <47CBDA5B.70603@domain.hid>
	<47CBDC28.1020907@domain.hid> <47CBDF7E.9050704@domain.hid>
In-Reply-To: <47CBDF7E.9050704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_cond_wait doesn't timeout (xenomai 2.4.1)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: philippe.gerum@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
> Anders Blomdell wrote:
>> Philippe Gerum wrote:
>>> Anders Blomdell wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> On Fri, Feb 29, 2008 at 5:54 PM, Anders Blomdell
>>>>> <anders.blomdell@domain.hid> wrote:
>>>>>> Hi,
>>>>>>
>>>>>>  with xenomai 2.4.1 my call to:
>>>>>>
>>>>>>   rt_cond_wait(&cond, &mutex, 1000);
>>>>>>
>>>>>>  doesn't timeout (signalling works OK). Kernel version is 2.6.23.12, can it be
>>>>>>  due to CONFIG_NO_HZ=y, or have I misunderstood something?
>>>>> What is your system timer setting ? Are you running in periodic or
>>>>> aperiodic mode ? If aperiodic, 1000 ticks means 1000 ns, that is 1us,
>>>>> so rt_cond_wait should return instantaneously.
>>>> OK, here comes a simplified program that just outputs A, and then hangs.
>>>>
>>> I can't reproduce this issue with your test code here, but this might be
>>> the sign of some timer race depending on how fast is the hw.
>>>
>>> By hanging, I assume the box is still ok, right?
>>> If so, could you please send the output of /proc/xenomai/stat,
>>> /proc/xenomai/sched, /proc/xenomai/timer and /proc/xenomai/timerstat/master?
>>>
>>> TIA,
>>>
>>> cat /proc/xenomai/stat
>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>   0  0      0          108606586  0     00500080  100.0  ROOT/0
>>   0  0      0          54113426   0     00000082    0.0  rtnet-stack
>>   0  0      0          1          0     00000082    0.0  rtnet-rtpc
>>   0  22291  2          3          0     00300186    0.0  main
>>   0  0      0          107816863  0     00000000    0.0  IRQ22: rt_eepro100
>>   0  0      0          617309219  0     00000000    0.0  IRQ233: [timer]
>>
>>> cat /proc/xenomai/sched
>> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
>>   0  0       -1      0          0          master    R          ROOT/0
>>   0  0       98      0          0          master    W          rtnet-stack
>>   0  0        0      0          0          master    W          rtnet-rtpc
>>   0  22291    1      0          0          master    w          main
>>
>>> cat /proc/xenomai/timer
>> status=on+watchdog:setup=0:clock=8061167744254256:timerdev=lapic:clockdev=tsc
>>
>>> cat /proc/xenomai/timerstat/master
>> CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
>> 0    1049107334  506070537   324149     -          NULL         [host-timer/0]
>> 0    3358790     3358789     662553305  1000000000  xnpod_watch  [watchdog]
>> 0    1           1           -          -          xnthread_ti  main
>>
>>
> 
> Thanks. It looks like the timer did tick but the wakeup event was
> missed. The thread is still waiting for it (stat xxxxxxx6 means
> delayed+pending, which is the mode rt_cond_wait() sets for the thread).
> We do have a problem, it seems.
> 
OK, what can I do to be of assistance?

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

