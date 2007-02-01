Message-ID: <45C1F0A3.8000602@domain.hid>
Date: Thu, 01 Feb 2007 14:52:35 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] switchbench tests with IPIPE tracer disabled
References: <936257.30688.qm@domain.hid>
In-Reply-To: <936257.30688.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: poornima r <rpoornar@domain.hid>
Cc: adeos-main@gna.org

poornima r wrote:
> Hi,
> 
> 1)I am using open source kernel from Kernel.org,
> but what is meant by vanilla kernel from Kernel.org?

It's the kernel from kernel.org. This means that the Linux kernel 2.6.18 
is running fine on your MPC860 platform as is? Thanks for the info.

> 2)With sampling period of 500usec the system simply
> hangs without printing any results (./latenct -p500)

OK.

> 3)cyclictest with -t1 option (without IPIPE-tracer)
> root@domain.hid# ./cyclictest -t1
> 2.04 0.50 0.17 8/27 174
> 
> T: 0 (    0) P:99 I:    1000 C:       0 Min: 1000000
> Act:       0 Avg:       0 Max:-1000000
> Illegal instruction
> 
> 4)Output of /proc/xenomai/faults after the illegal
> instruction:-
> root@domain.hid# cat
> /proc/xenomai/faults
> TRAP         CPU0
>   0:            0    (Data or instruction access)
>   1:            0    (Alignment)
>   2:            0    (Altivec unavailable)
>   3:            0    (Program check exception)
>   4:            0    (Machine check exception)
>   5:            0    (Unknown)
>   6:            0    (Instruction breakpoint)
>   7:            0    (Run mode exception)
>   8:            0    (Single-step exception)
>   9:            0    (Non-recoverable exception)
>  10:            1    (Software emulation)
>  11:            0    (Debug)
>  12:            0    (SPE)
>  13:            0    (Altivec assist)

Hm, I see a software emulation exception which is also the reason for 
the illegal instructions. What toolchain do you use? The toolchain 
should support software FP emulation.

> 5)Running switchtest:-
> root@domain.hid# ./switchtest -n
> --The system hangs wihtout printing any results
> 
> Thanks,
> Poornima
> 
> 
> --- Wolfgang Grandegger <wg@domain.hid> wrote:
> 
>> poornima r wrote:
>>> Hi,
>>>
>>> Thanks for the reply.
>>>
>>> Linux version:linux-2.6.18
>>> Xenomai: xenomai-2.3.0 (Stable version)
>>> adeos patch: adeos-ipipe-2.6.18-ppc-1.5-01.patch
>> OK, I'm curious, did you use the vanilla kernel from
>> kernel.org?
>> More comments below.
>>
>>> The tests were run as follows:
>>> 1)The sampling period in the code for latency and
>>> switchbench was changed to 1000000000ns(to remove
>>> overrun error) 
>>> 2)switchtest was run with -n5 option
>>> 3)cyclictest was run with  -t5 option(5 threads 
>>> were created.)
>>> 4)cyclictest was terminated with Illegal
>> instruction
>>> (after creating 5 threads) with IPIPE tracer
>> enabled.
>>
>>> These were the results without I-PIPE Tracer
>> option:
>>> (All the tests were run without any load)
>>> 1)LATENCY TEST:-
>>> User mode:-
>>> /mnt/out_xen/bin# ./latency -t0
>>> == Sampling period: 1000000 us
>>> == Test mode: periodic user-mode task
>>> == All results in microseconds
>>> warming up...
>>> RTT|  00:00:01  (periodic user-mode task, 1000000
>> us
>>> period, priority 99)
>>> RTH|-----lat min|-----lat avg|-----lat
>>> max|-overrun|----lat best|---lat worst
>>> RTD|     167.000|     167.000|     167.000|      
>> 0|  
>>>   167.000|     167.000
>>> RTD|     176.000|     176.000|     176.000|      
>> 0|  
>>>   167.000|     176.000
>>> RTD|     168.000|     168.000|     168.000|      
>> 0|  
>>>   167.000|     176.000
>>> RTD|     171.000|     171.000|     171.000|      
>> 0|  
>>>   167.000|     176.000
>>  >
>>> Kernel mode:-
>>> root@domain.hid# ./latency -t1
>>> == Sampling period: 1000000 us
>>> == Test mode: in-kernel periodic task
>>> == All results in microseconds
>>> warming up...
>>> RTT|  00:00:00  (in-kernel periodic task, 1000000
>> us
>>> period, priority 99)
>>> RTH|-----lat min|-----lat avg|-----lat
>>> max|-overrun|----lat best|---lat worst
>>> RTD|     123.000|     123.000|     123.000|      
>> 0|  
>>>   123.000|     123.000
>>> RTD|     125.000|     125.000|     125.000|      
>> 0|  
>>>   123.000|     125.000
>>> RTD|     128.333|     128.333|     128.333|      
>> 0|  
>>>   123.000|     128.333
>>> RTD|     127.000|     127.000|     127.000|      
>> 0|  
>>>   123.000|     128.333
>>>
>>> Interrupt mode:-
>>> root@domain.hid# ./latency -t2
>>> == Sampling period: 1000000 us
>>> == Test mode: in-kernel timer handler
>>> == All results in microseconds
>>> warming up...
>>> RTT|  00:00:01  (in-kernel timer handler, 1000000
>> us
>>> period, priority 99)
>>> RTH|-----lat min|-----lat avg|-----lat
>>> max|-overrun|----lat best|---lat worst
>>> RTD|      45.334|      45.334|      45.334|      
>> 0|  
>>>    45.334|      45.334
>>> RTD|      45.000|      45.000|      45.000|      
>> 0|  
>>>    45.000|      45.334
>>> RTD|      46.000|      46.000|      46.000|      
>> 0|  
>>>    45.000|      46.000
>>> RTD|      47.334|      47.334|      47.334|      
>> 0|  
>>>    45.000|      47.334
>>> RTD|      46.334|      46.334|      46.334|      
>> 0|  
>>>    45.000|      47.334
>> I remember similar figures from measurements under
>> 2.4. I guess you 
>> tested without load!? Nevertheless, most of the
>> latency is due to code 
>> execution time because the system is very slow and
>> the caches are small.
>> The sampling period is 1 second. I think "-p500"
>> should already work.
>>
>>> 2)CYCLICTEST RESULTS:-
>>> root@domain.hid# ./cyclictest
>> -t5
>>> 5.14 3.71 1.72 6/31 216
>>>
>>> T: 0 (    0) P:99 I:    1000 C:       0 Min:
>> 1000000
>>> Act:       0 Avg:       0 Max:-1000000
>>> T: 1 (    0) P:98 I:    1500 C:       0 Min:
>> 1000000
>>> Act:       0 Avg:       0 Max:-1000000
>>> T: 2 (  212) P:97 I:    2000 C:    8112 Min:    
>> 169
>>> Act:     189 Avg:     204 Max:     288
>>> T: 3 (    0) P:96 I:    2500 C:       0 Min:
>> 1000000
>>> Act:       0 Avg:       0 Max:-1000000
>>> T: 4 (  216) P:95 I:    3000 C:   21596 Min:    
>> 180
>>> Act:    1279 Avg:     702 Max:    1336
>> Hm, this looks bogus. What returns "./cyclictest"
>> without options (or -t1)?
>>
>>> 3)SWITCHBENCH TEST RESULTS:-
>>> root@domain.hid# ./switchbench
>> -n5
>>> == Sampling period: 1000000 us
>>> == Do not interrupt this program
>>> RTH|     lat min|     lat avg|     lat max|       
>>> lost
>>> RTD|     229.333|      45.666|     229.333|       
>>   
>>> 0
>>>
>>> Test results with IPIPE tracer enabled
>>> 1)LATENCY TEST RESULTS:-
>>> User mode:-
>>> root@domain.hid# ./latency -t0
>>> == Sampling period: 1000000 us
>>> == Test mode: periodic user-mode task
>>> == All results in microseconds
>>> warming up...
>>> RTT|  00:00:01  (periodic user-mode task, 1000000
>> us
>>> period, priority 99)
>>> RTH|-----lat min|-----lat avg|-----lat
>>> max|-overrun|----lat best|---lat worst
>>> RTD|     340.000|     340.000|     340.000|      
>> 0|  
>>>   340.000|     340.000
>>> RTD|     338.666|     338.666|     338.666|      
>> 0|  
>>>   338.666|     340.000
>>> RTD|     341.000|     341.000|     341.000|      
>> 0|  
>>>   338.666|     341.000
>>> RTD|     342.000|     342.000|     342.000|      
>> 0|  
>>>   338.666|     342.000
>>>
>>> 2)kernel mode:-
>>> root@domain.hid# ./latency -t1
>>> == Sampling period: 1000000 us
>>> == Test mode: in-kernel periodic task
>>> == All results in microseconds
>>> warming up...
>>> RTT|  00:00:00  (in-kernel periodic task, 1000000
>> us
>>> period, priority 99)
>>> RTH|-----lat min|-----lat avg|-----lat
>>> max|-overrun|----lat best|---lat worst
>>> RTD|     303.333|     303.333|     303.333|      
>> 0|  
>>>   303.333|     303.333
>>> RTD|     309.666|     309.666|     309.666|      
>> 0|  
>>>   303.333|     309.666
>>> RTD|     325.000|     325.000|     325.000|      
>> 0|  
>>>   303.333|     325.000
>>> RTD|     306.333|     306.333|     306.333|      
>> 0|  
>>>   303.333|     325.000
>>>
>>> Interrupt mode:-
>>> root@domain.hid# ./latency -t2
> === message truncated ===
> 
> 
> 
>  
> ____________________________________________________________________________________
> Be a PS3 game guru.
> Get your game face on with the latest PS3 news and previews at Yahoo! Games.
> http://videogames.yahoo.com/platform?platform=120121
> 
> 


