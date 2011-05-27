Message-ID: <4DDFF74E.2000400@domain.hid>
Date: Fri, 27 May 2011 21:11:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DDE8DC9.2020905@domain.hid>
	<4DDF475A.5080504@domain.hid>	<4DDFB30F.8000003@domain.hid>
	<4DDFB780.4010009@domain.hid> <4DDFBDCD.4040809@domain.hid>
	<4DDFEDA2.40206@domain.hid>
In-Reply-To: <4DDFEDA2.40206@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Huge clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonas Witt <jonas.witt@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On 05/27/2011 08:29 PM, Jonas Witt wrote:
> Am 27.05.2011 17:05, schrieb Jan Kiszka:
>> On 2011-05-27 16:38, Gilles Chanteperdrix wrote:
>>> On 05/27/2011 04:19 PM, Jonas Witt wrote:
>>>> Am 27.05.2011 08:40, schrieb Gilles Chanteperdrix:
>>>>> On 05/26/2011 07:28 PM, Jonas Witt wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> i am having a problem concerning the clock drift under load:
>>>>>>
>>>>>> # /usr/xenomai/bin/clocktest
>>>>>> == Tested clock: 0 (CLOCK_REALTIME)
>>>>>> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
>>>>>> --- -------------------- ---------------- ---------- --------------
>>>>>>      0          775571614.0       166776.858          0            0.0
>>>>>>
>>>>>>
>>>>>> It remains in the hundreds of MILLIseconds, changing constantly. My
>>>>>> setup consists of an embedded Intel Atom board (1.6GHz Z530 processor)
>>>>>> with a 2.6.32.7 kernel and Xenomai 2.5.2.
>>>>> Hi Jonas,
>>>>>
>>>>> Could you try and see if 2.5.6 with latest I-pipe patches has the same
>>>>> behaviour?
>>>>>
>>>>>> Latencies under load are
>>>>>> reasonable. Mean latency<   10us. Maximum latency<   40us.
>>>>>>
>>>>>> Without load the ToD offset is approximately constant over time with a
>>>>>> ToD drift in the range of 10 microseconds (strangely after a while this
>>>>>> settles in a range of 2 microseconds). Does anyone have an idea how this
>>>>>> can be caused?
>>>>> First, I am not sure clocktest is meant to be use under load. Second,
>>>>> does your system uses ntp?
>>>>>
>>>>>> As a workaround I currently use rt_timer_read() in all
>>>>>> relevant programs (also the non-realtime ones), since I need consistent
>>>>>> timestamps between realtime and non-realtime tasks.
>>>>> In order to solve this particular issue, we have a solution, but not yet
>>>>> in stable released versions.
>>>>>
>>>>>> One other (maybe unrelated) strange behavior is occasional secondary
>>>>>> mode switches when calling rt_queue_read(...).
>>>>> For this error, we need more details, such as a simple test case
>>>>> allowing to reproduce the issue, and again, you need to be sure to
>>>>> reproduce the issue on latest stable release with latest I-pipe patches.
>>>>>
>>>>> Regards.
>>>> Hi Gilles,
>>>>
>>>> thanks for your input. I will try Xenomai 2.5.6 soon. In the meantime I
>>>> wrote a simple load simulator to reproduce the issue with my more
>>>> complex program. The clock drift only occurs with a load of more than
>>>> 30%. Below that the clock is fine. So you may have to adjust the
>>>> attached code (e.g. change the 2000 value in the for-loop to something
>>>> larger) to stress your system to that level where the processing time is
>>>> more than 2000 microseconds.
>>> My point was that maybe clocktest is not meant to be run under load. To
>>> this, we should ask Jan to answer, as he wrote this test and knows what
>>> is inside.
>> There are some simple measures in clocktest to check if the clock
>> read-outs were done without major preemptions. But even in extreme load,
>> this should only cause temporary offsets, no constant drift, no
>> persistent delta after taking away the load.
>>
>> What is the clocksourse Linux is using? See
>> /sys/devices/system/clocksource/clocksource0/current_clocksource.
>>
>> More important, you still didn't answer Gilles' question about ntp.
>>
>> Jan
>>
> Sorry, I missed the NTP-part. I am not using NTP. Just plain timer 
> queries on a single system.
> 
> My clock source is tsc which is the same for Xenomai I suppose.
> 
> I wonder how a Xenomai task, even if it occupies 50% or even 90% of a 4 
> milliseconds time slice can interfere with the tsc. The tsc is not 
> incremented via an interrupt, is it? But I do not know much about the 
> inner workings of these functions.

The problem is not the clocksource, the problem is the timer interrupt.
The kernel expects 1 timer tick every millisecond. When you run a
real-time task during 2 milliseconds and prevent the kernel from
receiving the timer interrupts, you certainly disrupt its timekeeping.
If you want to do this, switch the Linux kernel frequency (CONFIG_HZ) to
100.

> 
> Jonas
> 
> 


-- 
                                                                Gilles.

