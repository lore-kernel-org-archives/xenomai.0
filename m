Message-ID: <45DBF120.2040202@domain.hid>
Date: Wed, 21 Feb 2007 08:13:36 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] latency results for ppc and x86
References: <192764.8911.qm@domain.hid>
In-Reply-To: <192764.8911.qm@domain.hid>
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

Hello,

poornima r wrote:
> Hello,
> 
> These were the scheduling latency and interrupt
> latency test results on ppc and x86 with IPIPE tracer
> option disabled.
> 
> 1.Please comment on these results (whether valid) and 

Your results are OK. These are actually the figures I remember from my 
own tests in the past.

> 2.Is there any method to optimize these results.

No that I know of. There are a few ideas how to reduce latencies further 
like cache locking or TLB pinning.

> 1)PPC:-
> (MPC-860 at 48 MHz, 4 kB I-Cache and 4 kB D-Cache) 
> 
> User mode:-
> root@domain.hid# ./latency -t0
> == Sampling period: 1000000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 1000000 us
> period, priority 99)
> RTH|-----lat min|-----lat
> avg|-----latmax|-overrun|----lat best|---lat worst
> RTD|     167.000|     167.000|     167.000|       0|  
>    167.000|     167.000
> RTD|     176.000|     176.000|     176.000|       0|  
>    167.000|     176.000
> RTD|     168.000|     168.000|     168.000|       0|  
>     167.000|    176.000
> RTD|     171.000|     171.000|     171.000|       0|  
>     167.000|    176.000
> 
> Kernel mode:-
> root@domain.hid# ./latency -t1
> == Sampling period: 1000000 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> warming up...
> RTT|  00:00:00  (in-kernel periodic task, 1000000 us
> period, priority 99)
> RTH|-----lat min|-----lat
> avg|-----latmax|-overrun|----lat best|---lat worst
> RTD|     123.000|     123.000|     123.000|       0|  
>     123.000|     123.000
> RTD|     125.000|     125.000|     125.000|       0|  
>     123.000|     125.000
> RTD|     128.333|     128.333|     128.333|       0|  
>     123.000|     128.333
> RTD|     127.000|     127.000|     127.000|       0|  
>     123.000|     128.333
> 
> Interrupt mode:-
> root@domain.hid# ./latency -t2
> == Sampling period: 1000000 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel timer handler, 1000000 us
> period, priority 99)
> RTH|-----lat min|-----lat
> avg|-----latmax|-overrun|----lat best|---lat worst
> RTD|      45.334|      45.334|       45.334|       0| 
>          45.334|      45.334
> RTD|      45.000|      45.000|       45.000|       0| 
>          45.000|      45.334
> RTD|      46.000|      46.000|       46.000|       0| 
>          45.000|      46.000
> RTD|      47.334|      47.334|       47.334|       0| 
>          45.000|      47.334
> RTD|      46.334|      46.334|       46.334|       0| 
>          45.000|      47.334

On the MPC860, the latencies are mainly due code execution time as this 
processor is very slow.

> 2)X86:-
> (Pentium4, 3.06GHz, 1024 KB cache size)
> User mode:-
> Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> warming up...
> 
> RTT|  00:00:01  (periodic user-mode task, 100 us
> period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat
> max|-overrun|----lat best|---lat worst
> RTD|       3.807|      12.825|      21.565|       0|  
>     3.807|      21.565
> RTD|       3.796|      12.792|      21.483|       0|  
>     3.796|      21.565
> RTD|       3.770|      12.799|      21.501|       0|  
>     3.770|      21.565
> RTD|       3.578|      12.806|      20.890|       0|  
>     3.578|      21.565
> RTD|       3.755|      12.809|      21.486|       0|  
>     3.578|
> 
> kernel mode:-
> Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> warming up...
> 
> RTT|  00:00:01  (in-kernel periodic task, 100 us
> period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat
> max|-overrun|----lat best|---lat worst
> RTD|       2.381|       3.451|      19.620|       0|  
>     2.381|      19.620
> RTD|       2.332|       3.480|      19.930|       0|  
>     2.332|      19.930
> RTD|       2.382|       3.649|      19.609|       0|  
>     2.332|      19.930
> RTD|       2.323|       2.786|      14.351|       0|  
>     2.323|      19.930
> RTD|       2.375|       2.532|       5.519|       0|  
>     2.323|      19.930
> RTD|       2.332|       3.971|      19.617|       0|  
>     2.323|      19.930
> 
> Interrupt mode:-
> Sampling period: 100 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> warming up...
> 
> RTT|  00:00:01  (in-kernel timer handler, 100 us
> period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat
> max|-overrun|----lat best|---lat worst
> RTD|      -1.563|       7.553|      15.736|       0|  
>    -1.563|      15.736
> RTD|      -1.579|       7.558|      15.804|       0|  
>    -1.579|      15.804
> RTD|      -1.584|       7.529|      16.167|       0|  
>    -1.584|      16.167
> RTD|      -1.548|       7.553|      16.186|       0|  
>    -1.584|      16.186
> RTD|      -1.585|       7.556|      16.275|       0|  
>    -1.585|      16.275

Latencies are mainly due to cache refills on the P4. Have you already 
put load onto your system? If not, worst case latencies will be even longer.

Wolfgang.

> Thanks,
> Poornima
> 
> 
> --- Wolfgang Grandegger <wg@domain.hid> wrote:
> 
>> Hello,
>>
>> poornima r wrote:
>>> Hello,
>>>
>>> Srry for not replying all these days...
>>> (Was not in in station, may be too personal!!!!!)
>>>
>>> About software emulation error:
>>>
>>> 4)Output of /proc/xenomai/faults after the illegal
>>>>> instruction:-
>>>>> root@domain.hid# cat
>>>>> /proc/xenomai/faults
>>>>> TRAP         CPU0
>>>>>   0:            0    (Data or instruction
>> access)
>>>>>   1:            0    (Alignment)
>>>>>   2:            0    (Altivec unavailable)
>>>>>   3:            0    (Program check exception)
>>>>>   4:            0    (Machine check exception)
>>>>>   5:            0    (Unknown)
>>>>>   6:            0    (Instruction breakpoint)
>>>>>   7:            0    (Run mode exception)
>>>>>   8:            0    (Single-step exception)
>>>>>   9:            0    (Non-recoverable exception)
>>>>>  10:            1    (Software emulation)
>>>>>  11:            0    (Debug)
>>>>>  12:            0    (SPE)
>>>>>  13:            0    (Altivec assist)
>>>> Hm, I see a software emulation exception which is
>>>> also the reason for 
>>>> the illegal instructions. What toolchain do you
>> use?
>>>> The toolchain 
>>>> should support software FP emulation.
>>> 1)I am using open source too chain with software
>>> floating point emulation support.
>>> (#ppc_8xx-gcc --v
>>>
> /lib/gcc/powerpc/3.4.3/../../../../target_powerpc/usr/include/c++/3.4.3
>>> --with-numa-policy=no --with-float=soft)
>>>
>>> 2)And the kernel is included with code to emulate
>> a
>>> floating-point                                    
>>    
>>>          unit, which will allow programs that 
>>> use floating-point                                
>>    
>>>                           instructions to run
>>>
>>> Kernel configuration 
>>> ----CONFIG_MATH_EMULATION:y
>> If you build with "--with-float=soft" there is no
>> need for math 
>> emulation in the kernel. Likely, there is something
>> wrong with your 
>> tool-chain. Could you please try a known-to-work
>> tool-chain like the 
>> ELDK v4.x from http://www.denx.de.
>>
>> Wolfgang.
>>
>>> Thanks,
>>> Poornima
>>>
>>> --- Wolfgang Grandegger <wg@domain.hid> wrote:
>>>
>>>> poornima r wrote:
>>>>> Hi,
>>>>>
>>>>> 1)I am using open source kernel from Kernel.org,
>>>>> but what is meant by vanilla kernel from
>>>> Kernel.org?
>>>>
>>>> It's the kernel from kernel.org. This means that
>> the
>>>> Linux kernel 2.6.18 
>>>> is running fine on your MPC860 platform as is?
>>>> Thanks for the info.
>>>>
>>>>> 2)With sampling period of 500usec the system
>>>> simply
>>>>> hangs without printing any results (./latenct
>>>> -p500)
>>>>
>>>> OK.
>>>>
>>>>> 3)cyclictest with -t1 option (without
>>>> IPIPE-tracer)
>>>>> root@domain.hid#
>> ./cyclictest
>>>> -t1
>>>>> 2.04 0.50 0.17 8/27 174
>>>>>
>>>>> T: 0 (    0) P:99 I:    1000 C:       0 Min:
>>>> 1000000
>>>>> Act:       0 Avg:       0 Max:-1000000
>>>>> Illegal instruction
>>>>>
>>>>> 4)Output of /proc/xenomai/faults after the
>> illegal
>>>>> instruction:-
>>>>> root@domain.hid# cat
>>>>> /proc/xenomai/faults
>>>>> TRAP         CPU0
>>>>>   0:            0    (Data or instruction
>> access)
>>>>>   1:            0    (Alignment)
>>>>>   2:            0    (Altivec unavailable)
>>>>>   3:            0    (Program check exception)
>>>>>   4:            0    (Machine check exception)
>>>>>   5:            0    (Unknown)
>>>>>   6:            0    (Instruction breakpoint)
>>>>>   7:            0    (Run mode exception)
>>>>>   8:            0    (Single-step exception)
>>>>>   9:            0    (Non-recoverable exception)
>>>>>  10:            1    (Software emulation)
>>>>>  11:            0    (Debug)
>>>>>  12:            0    (SPE)
>>>>>  13:            0    (Altivec assist)
>>>> Hm, I see a software emulation exception which is
>>>> also the reason for 
>>>> the illegal instructions. What toolchain do you
>> use?
>>>> The toolchain 
>>>> should support software FP emulation.
>>>>
>>>>> 5)Running switchtest:-
>>>>> root@domain.hid#
>> ./switchtest
>>>> -n
>>>>> --The system hangs wihtout printing any results
>>>>>
>>>>> Thanks,
>>>>> Poornima
>>>>>
>>>>>
>>>>> --- Wolfgang Grandegger <wg@domain.hid>
>> wrote:
>>>>>> poornima r wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Thanks for the reply.
>>>>>>>
>>>>>>> Linux version:linux-2.6.18
>>>>>>> Xenomai: xenomai-2.3.0 (Stable version)
>>>>>>> adeos patch:
>> adeos-ipipe-2.6.18-ppc-1.5-01.patch
>>>>>> OK, I'm curious, did you use the vanilla kernel
>>>> from
>>>>>> kernel.org?
>>>>>> More comments below.
>>>>>>
>>>>>>> The tests were run as follows:
>>>>>>> 1)The sampling period in the code for latency
>>>> and
>>>>>>> switchbench was changed to 1000000000ns(to
>>>> remove
>>>>>>> overrun error) 
>>>>>>> 2)switchtest was run with -n5 option
>>>>>>> 3)cyclictest was run with  -t5 option(5
>> threads 
>>>>>>> were created.)
>>>>>>> 4)cyclictest was terminated with Illegal
>>>>>> instruction
>>>>>>> (after creating 5 threads) with IPIPE tracer
>>>>>> enabled.
>>>>>>
>>>>>>> These were the results without I-PIPE Tracer
>>>>>> option:
>>>>>>> (All the tests were run without any load)
>>>>>>> 1)LATENCY TEST:-
>>>>>>> User mode:-
>>>>>>> /mnt/out_xen/bin# ./latency -t0
>>>>>>> == Sampling period: 1000000 us
>>>>>>> == Test mode: periodic user-mode task
>>>>>>> == All results in microseconds
>>>>>>> warming up...
>>>>>>> RTT|  00:00:01  (periodic user-mode task,
>>>> 1000000
>>>>>> us
>>>>>>> period, priority 99)
>>>>>>> RTH|-----lat min|-----lat avg|-----lat
>>>>>>> max|-overrun|----lat best|---lat worst
>>>>>>> RTD|     167.000|     167.000|     167.000|   
>>  
>>>>>> 0|  
>>>>>>>   167.000|     167.000
>>>>>>> RTD|     176.000|     176.000|     176.000|   
>>  
>>>>>> 0|  
>>>>>>>   167.000|     176.000
>>>>>>> RTD|     168.000|     168.000|     168.000|   
>>  
>>>>>> 0|  
>>>>>>>   167.000|     176.000
> === message truncated ===
> 
> 
> 
>  
> ____________________________________________________________________________________
> Get your own web address.  
> Have a HUGE year through Yahoo! Small Business.
> http://smallbusiness.yahoo.com/domains/?p=BESTDEAL
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
> 
> 


