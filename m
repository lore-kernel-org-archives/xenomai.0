MIME-Version: 1.0
In-Reply-To: <49E67198.3080801@domain.hid>
References: <d6c8ef150904101628r60c02baal3568b2ece287ce1f@domain.hid>
	<49E0F949.5040900@domain.hid>
	<d6c8ef150904151613j39f43928xd1a25f37184ad30b@domain.hid>
	<d6c8ef150904151626r5c36df10yb9f8e93ea59640df@domain.hid>
	<49E67198.3080801@domain.hid>
Date: Thu, 16 Apr 2009 01:55:56 +0200
Message-ID: <d6c8ef150904151655o5ca29fbei998c57fdc096a3c3@domain.hid>
From: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Intel EP80579 support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

There is no such entry in /proc/interrupts

On 4/16/09, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Bosko Radivojevic wrote:
>> Maybe this may help:
>>
>> # cd /proc/xenomai
>> # cat affinity
>> 00000001
>> # cat apc
>> APC          CPU0
>>   0:            0    (pipe_wakeup)
>>   1:            0    (lostage_handler)
>>   2:            0    (registry_export)
>>   3:            0    (pse51_lostage_handler)
>> # cat faults
>> TRAP         CPU0
>>   0:            0    (Divide error)
>>   1:            0    (Debug)
>>   3:            0    (Int3)
>>   4:            0    (Overflow)
>>   5:            0    (Bounds)
>>   6:            0    (Invalid opcode)
>>   7:            0    (FPU not available)
>>   8:            0    (Double fault)
>>   9:            0    (FPU segment overrun)
>>  10:            0    (Invalid TSS)
>>  11:            0    (Segment not present)
>>  12:            0    (Stack segment)
>>  13:            0    (General protection)
>>  14:            0    (Page fault)
>>  15:            0    (Spurious interrupt)
>>  16:            0    (FPU error)
>>  17:            0    (Alignment check)
>>  18:            0    (Machine check)
>>  19:            0    (SIMD error)
>> # cat hal
>> 2.2-06
>> # cat heap
>> size=129536:used=64:pagesz=512  (main heap)
>> size=32256:used=0:pagesz=512  (stack pool)
>> # cat irq
>> IRQ         CPU0
>> 297:       14807         [timer]
>> 322:           0         [virtual]
>> # cat latency
>> 1000
>> # cat stat
>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>   0  0      0          0          0     00500080  100.0  ROOT
>>   0  0      0          16645      0     00000000    0.0  IRQ297: [timer]
>> # cat sched
>> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
>>   0  0       -1      0          0          master    R          ROOT
>> # cat timebases
>> NAME       RESOLUTION     JIFFIES   STATUS
>> master              1         n/a   enabled,set
>> # cat timer
>> status=on:setup=0:clock=107197728116:timerdev=lapic:clockdev=tsc
>> # cat version
>> 2.4.7
>> # cat timerstat/master
>> CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
>> 0    40456       40455       3337906    4000000    NULL
>> [host-timer]
>
> Could you cat or grep 38 /proc/interrupts ?
>
> --
> 					    Gilles.
>

-- 
Sent from Gmail for mobile | mobile.google.com

