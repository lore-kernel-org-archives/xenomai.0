References: <55DF2471.6030006@cern.ch> <55DF2868.2070804@xenomai.org>
 <55DF32E3.1010706@cern.ch> <55E015FE.7000302@xenomai.org>
 <55E0560B.4040601@gmail.com> <55E05817.90601@xenomai.org>
 <55E0594C.2060704@gmail.com> <55E05B2E.60907@xenomai.org>
 <55E05E81.5040209@gmail.com> <55E0607D.3070701@xenomai.org>
From: Konstantinos Chalas <konchalas@gmail.com>
Message-ID: <55E3689D.7060105@gmail.com>
Date: Sun, 30 Aug 2015 22:33:33 +0200
MIME-Version: 1.0
In-Reply-To: <55E0607D.3070701@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cyclictest in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

It wasn't innocuous... The variable uint64_t diff was used to store the 
latency, which in turn took the value -1 because of the timer 
calibration issue , therefore when casted as unsigned produced 2^64-1. 
It works as it should after running autotune.

Thank you very much for the help,
Konstantinos

On 08/28/2015 03:22 PM, Philippe Gerum wrote:
> On 08/28/2015 03:13 PM, Konstantinos Chalas wrote:
>> No, besides a negative lat best value, like this:
>>
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
>> best|--lat worst
>> RTD|      1.080|      3.013|     40.080|            0| 0|
>> -1.275|     43.961
> Ok, that one is innocuous, this is only a timer calibration issue. The
> strange average value may be an issue in cyclictest since 2147483647 is
> 2^31-1, which is INT32_MAX. A bit like no sample had been recorded
> during such run.
>
>> On 08/28/2015 02:59 PM, Philippe Gerum wrote:
>>> On 08/28/2015 02:51 PM, Konstantinos Chalas wrote:
>>>> Hello,
>>>>
>>>> root@beaglebone:~# uname -a
>>>> Linux beaglebone 3.14.44+ #1 SMP PREEMPT Wed Aug 26 23:41:20 CEST 2015
>>>> armv7l GNU/Linux
>>>>
>>>> and ipipe-core-3.14.44-arm-12
>>>>
>>> Do you have any weird values appearing during a standard latency test?
>>> e.g.
>>>
>>> # latency [-t0]
>>>
>>>> Thanks
>>>>
>>>> On 08/28/2015 02:46 PM, Philippe Gerum wrote:
>>>>> On 08/28/2015 02:37 PM, Konstantinos Chalas wrote:
>>>>>> Great! Now, it is much better! Thanks for the interest.
>>>>>>
>>>>>> I have noticed something else, when using clock_nanosleep, there is
>>>>>> something wrong going on. Example output with clock_nanosleep:
>>>>>>
>>>>>> root@beaglebone:~# cyclictest    -p 99  -i 250 -n
>>>>>> # /dev/cpu_dma_latency set to 0us
>>>>>> policy: fifo: loadavg: 1.13 1.18 1.15 1/243 2385
>>>>>>
>>>>>> T: 0 ( 2384) P:99 I:250 C: 122168 Min:      0 Act:    9
>>>>>> *Avg:2147483647*
>>>>>> Max:      -1
>>>>>>
>>>>>> The Avg value jumps to this insane number.
>>>>>> I didn't find any differences between the vanilla cyclictest and the
>>>>>> xenomai-2.6 upstream cyclictest regarding the use of clock_nanosleep.
>>>>>> Any ideas of where this behaviour would come from?
>>>>> Which kernel and I-pipe release are you running?
>>>>>
>>
>


