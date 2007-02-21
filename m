Date: Wed, 21 Feb 2007 01:33:11 -0800 (PST)
From: poornima r <rpoornar@domain.hid>
Subject: Re: [Adeos-main] latency results for ppc and x86
In-Reply-To: <45DBF120.2040202@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-149941850-1172050391=:56324"
Content-Transfer-Encoding: 8bit
Message-ID: <725115.56324.qm@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: adeos-main@gna.org

--0-149941850-1172050391=:56324
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hello, 

Thankx for the reply.
These tests were actually run without loading the system

Thanks,
Poornima
Wolfgang Grandegger <wg@domain.hid> wrote: Hello,

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
> --- Wolfgang Grandegger  wrote:
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
>>> --- Wolfgang Grandegger  wrote:
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
>>>>> --- Wolfgang Grandegger 
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



 
---------------------------------
Bored stiff? Loosen up...
Download and play hundreds of games for free on Yahoo! Games.
--0-149941850-1172050391=:56324
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br>Hello, <br><br>Thankx for the reply.<br>These tests were actually run without loading the system<br><br>Thanks,<br>Poornima<br><b><i>Wolfgang Grandegger &lt;wg@domain.hid&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hello,<br><br>poornima r wrote:<br>&gt; Hello,<br>&gt; <br>&gt; These were the scheduling latency and interrupt<br>&gt; latency test results on ppc and x86 with IPIPE tracer<br>&gt; option disabled.<br>&gt; <br>&gt; 1.Please comment on these results (whether valid) and <br><br>Your results are OK. These are actually the figures I remember from my <br>own tests in the past.<br><br>&gt; 2.Is there any method to optimize these results.<br><br>No that I know of. There are a few ideas how to reduce latencies further <br>like cache locking or TLB pinning.<br><br>&gt; 1)PPC:-<br>&gt; (MPC-860 at 48 MHz, 4 kB I-Cache and 4 kB D-Cache) <br>&gt; <br>&gt; User mode:-<br>&gt;
 root@domain.hid# ./latency -t0<br>&gt; == Sampling period: 1000000 us<br>&gt; == Test mode: periodic user-mode task<br>&gt; == All results in microseconds<br>&gt; warming up...<br>&gt; RTT|  00:00:01  (periodic user-mode task, 1000000 us<br>&gt; period, priority 99)<br>&gt; RTH|-----lat min|-----lat<br>&gt; avg|-----latmax|-overrun|----lat best|---lat worst<br>&gt; RTD|     167.000|     167.000|     167.000|       0|  <br>&gt;    167.000|     167.000<br>&gt; RTD|     176.000|     176.000|     176.000|       0|  <br>&gt;    167.000|     176.000<br>&gt; RTD|     168.000|     168.000|     168.000|       0|  <br>&gt;     167.000|    176.000<br>&gt; RTD|     171.000|     171.000|     171.000|       0|  <br>&gt;     167.000|    176.000<br>&gt; <br>&gt; Kernel mode:-<br>&gt; root@domain.hid# ./latency -t1<br>&gt; == Sampling period: 1000000 us<br>&gt; == Test mode: in-kernel periodic task<br>&gt; == All results in microseconds<br>&gt;
 warming up...<br>&gt; RTT|  00:00:00  (in-kernel periodic task, 1000000 us<br>&gt; period, priority 99)<br>&gt; RTH|-----lat min|-----lat<br>&gt; avg|-----latmax|-overrun|----lat best|---lat worst<br>&gt; RTD|     123.000|     123.000|     123.000|       0|  <br>&gt;     123.000|     123.000<br>&gt; RTD|     125.000|     125.000|     125.000|       0|  <br>&gt;     123.000|     125.000<br>&gt; RTD|     128.333|     128.333|     128.333|       0|  <br>&gt;     123.000|     128.333<br>&gt; RTD|     127.000|     127.000|     127.000|       0|  <br>&gt;     123.000|     128.333<br>&gt; <br>&gt; Interrupt mode:-<br>&gt; root@domain.hid# ./latency -t2<br>&gt; == Sampling period: 1000000 us<br>&gt; == Test mode: in-kernel timer handler<br>&gt; == All results in microseconds<br>&gt; warming up...<br>&gt; RTT|  00:00:01  (in-kernel timer handler, 1000000 us<br>&gt; period, priority 99)<br>&gt; RTH|-----lat min|-----lat<br>&gt; avg|-----latmax|-overrun|----lat
 best|---lat worst<br>&gt; RTD|      45.334|      45.334|       45.334|       0| <br>&gt;          45.334|      45.334<br>&gt; RTD|      45.000|      45.000|       45.000|       0| <br>&gt;          45.000|      45.334<br>&gt; RTD|      46.000|      46.000|       46.000|       0| <br>&gt;          45.000|      46.000<br>&gt; RTD|      47.334|      47.334|       47.334|       0| <br>&gt;          45.000|      47.334<br>&gt; RTD|      46.334|      46.334|       46.334|       0| <br>&gt;          45.000|      47.334<br><br>On the MPC860, the latencies are mainly due code execution time as this <br>processor is very slow.<br><br>&gt; 2)X86:-<br>&gt; (Pentium4, 3.06GHz, 1024 KB cache size)<br>&gt; User mode:-<br>&gt; Sampling period: 100 us<br>&gt; == Test mode: in-kernel periodic task<br>&gt; == All results in microseconds<br>&gt; warming up...<br>&gt; <br>&gt; RTT|  00:00:01  (periodic user-mode task, 100 us<br>&gt; period, priority 99)<br>&gt; RTH|-----lat min|-----lat
 avg|-----lat<br>&gt; max|-overrun|----lat best|---lat worst<br>&gt; RTD|       3.807|      12.825|      21.565|       0|  <br>&gt;     3.807|      21.565<br>&gt; RTD|       3.796|      12.792|      21.483|       0|  <br>&gt;     3.796|      21.565<br>&gt; RTD|       3.770|      12.799|      21.501|       0|  <br>&gt;     3.770|      21.565<br>&gt; RTD|       3.578|      12.806|      20.890|       0|  <br>&gt;     3.578|      21.565<br>&gt; RTD|       3.755|      12.809|      21.486|       0|  <br>&gt;     3.578|<br>&gt; <br>&gt; kernel mode:-<br>&gt; Sampling period: 100 us<br>&gt; == Test mode: in-kernel periodic task<br>&gt; == All results in microseconds<br>&gt; warming up...<br>&gt; <br>&gt; RTT|  00:00:01  (in-kernel periodic task, 100 us<br>&gt; period, priority 99)<br>&gt; RTH|-----lat min|-----lat avg|-----lat<br>&gt; max|-overrun|----lat best|---lat worst<br>&gt; RTD|       2.381|       3.451|      19.620|       0|  <br>&gt;     2.381|      19.620<br>&gt; RTD|    
   2.332|       3.480|      19.930|       0|  <br>&gt;     2.332|      19.930<br>&gt; RTD|       2.382|       3.649|      19.609|       0|  <br>&gt;     2.332|      19.930<br>&gt; RTD|       2.323|       2.786|      14.351|       0|  <br>&gt;     2.323|      19.930<br>&gt; RTD|       2.375|       2.532|       5.519|       0|  <br>&gt;     2.323|      19.930<br>&gt; RTD|       2.332|       3.971|      19.617|       0|  <br>&gt;     2.323|      19.930<br>&gt; <br>&gt; Interrupt mode:-<br>&gt; Sampling period: 100 us<br>&gt; == Test mode: in-kernel timer handler<br>&gt; == All results in microseconds<br>&gt; warming up...<br>&gt; <br>&gt; RTT|  00:00:01  (in-kernel timer handler, 100 us<br>&gt; period, priority 99)<br>&gt; RTH|-----lat min|-----lat avg|-----lat<br>&gt; max|-overrun|----lat best|---lat worst<br>&gt; RTD|      -1.563|       7.553|      15.736|       0|  <br>&gt;    -1.563|      15.736<br>&gt; RTD|      -1.579|       7.558|      15.804|       0|  <br>&gt;   
 -1.579|      15.804<br>&gt; RTD|      -1.584|       7.529|      16.167|       0|  <br>&gt;    -1.584|      16.167<br>&gt; RTD|      -1.548|       7.553|      16.186|       0|  <br>&gt;    -1.584|      16.186<br>&gt; RTD|      -1.585|       7.556|      16.275|       0|  <br>&gt;    -1.585|      16.275<br><br>Latencies are mainly due to cache refills on the P4. Have you already <br>put load onto your system? If not, worst case latencies will be even longer.<br><br>Wolfgang.<br><br>&gt; Thanks,<br>&gt; Poornima<br>&gt; <br>&gt; <br>&gt; --- Wolfgang Grandegger <wg@domain.hid> wrote:<br>&gt; <br>&gt;&gt; Hello,<br>&gt;&gt;<br>&gt;&gt; poornima r wrote:<br>&gt;&gt;&gt; Hello,<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Srry for not replying all these days...<br>&gt;&gt;&gt; (Was not in in station, may be too personal!!!!!)<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; About software emulation error:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; 4)Output of /proc/xenomai/faults after the
 illegal<br>&gt;&gt;&gt;&gt;&gt; instruction:-<br>&gt;&gt;&gt;&gt;&gt; root@domain.hid# cat<br>&gt;&gt;&gt;&gt;&gt; /proc/xenomai/faults<br>&gt;&gt;&gt;&gt;&gt; TRAP         CPU0<br>&gt;&gt;&gt;&gt;&gt;   0:            0    (Data or instruction<br>&gt;&gt; access)<br>&gt;&gt;&gt;&gt;&gt;   1:            0    (Alignment)<br>&gt;&gt;&gt;&gt;&gt;   2:            0    (Altivec unavailable)<br>&gt;&gt;&gt;&gt;&gt;   3:            0    (Program check exception)<br>&gt;&gt;&gt;&gt;&gt;   4:            0    (Machine check exception)<br>&gt;&gt;&gt;&gt;&gt;   5:            0    (Unknown)<br>&gt;&gt;&gt;&gt;&gt;   6:            0    (Instruction breakpoint)<br>&gt;&gt;&gt;&gt;&gt;   7:            0    (Run mode exception)<br>&gt;&gt;&gt;&gt;&gt;   8:            0    (Single-step exception)<br>&gt;&gt;&gt;&gt;&gt;   9:            0    (Non-recoverable exception)<br>&gt;&gt;&gt;&gt;&gt;  10:            1    (Software emulation)<br>&gt;&gt;&gt;&gt;&gt;  11:          
  0    (Debug)<br>&gt;&gt;&gt;&gt;&gt;  12:            0    (SPE)<br>&gt;&gt;&gt;&gt;&gt;  13:            0    (Altivec assist)<br>&gt;&gt;&gt;&gt; Hm, I see a software emulation exception which is<br>&gt;&gt;&gt;&gt; also the reason for <br>&gt;&gt;&gt;&gt; the illegal instructions. What toolchain do you<br>&gt;&gt; use?<br>&gt;&gt;&gt;&gt; The toolchain <br>&gt;&gt;&gt;&gt; should support software FP emulation.<br>&gt;&gt;&gt; 1)I am using open source too chain with software<br>&gt;&gt;&gt; floating point emulation support.<br>&gt;&gt;&gt; (#ppc_8xx-gcc --v<br>&gt;&gt;&gt;<br>&gt; /lib/gcc/powerpc/3.4.3/../../../../target_powerpc/usr/include/c++/3.4.3<br>&gt;&gt;&gt; --with-numa-policy=no --with-float=soft)<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; 2)And the kernel is included with code to emulate<br>&gt;&gt; a<br>&gt;&gt;&gt; floating-point                                    <br>&gt;&gt;    <br>&gt;&gt;&gt;          unit, which will allow programs that <br>&gt;&gt;&gt; use
 floating-point                                <br>&gt;&gt;    <br>&gt;&gt;&gt;                           instructions to run<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Kernel configuration <br>&gt;&gt;&gt; ----CONFIG_MATH_EMULATION:y<br>&gt;&gt; If you build with "--with-float=soft" there is no<br>&gt;&gt; need for math <br>&gt;&gt; emulation in the kernel. Likely, there is something<br>&gt;&gt; wrong with your <br>&gt;&gt; tool-chain. Could you please try a known-to-work<br>&gt;&gt; tool-chain like the <br>&gt;&gt; ELDK v4.x from http://www.denx.de.<br>&gt;&gt;<br>&gt;&gt; Wolfgang.<br>&gt;&gt;<br>&gt;&gt;&gt; Thanks,<br>&gt;&gt;&gt; Poornima<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; --- Wolfgang Grandegger <wg@domain.hid> wrote:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; poornima r wrote:<br>&gt;&gt;&gt;&gt;&gt; Hi,<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; 1)I am using open source kernel from Kernel.org,<br>&gt;&gt;&gt;&gt;&gt; but what is meant by vanilla kernel from<br>&gt;&gt;&gt;&gt;
 Kernel.org?<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; It's the kernel from kernel.org. This means that<br>&gt;&gt; the<br>&gt;&gt;&gt;&gt; Linux kernel 2.6.18 <br>&gt;&gt;&gt;&gt; is running fine on your MPC860 platform as is?<br>&gt;&gt;&gt;&gt; Thanks for the info.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; 2)With sampling period of 500usec the system<br>&gt;&gt;&gt;&gt; simply<br>&gt;&gt;&gt;&gt;&gt; hangs without printing any results (./latenct<br>&gt;&gt;&gt;&gt; -p500)<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; OK.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; 3)cyclictest with -t1 option (without<br>&gt;&gt;&gt;&gt; IPIPE-tracer)<br>&gt;&gt;&gt;&gt;&gt; root@domain.hid#<br>&gt;&gt; ./cyclictest<br>&gt;&gt;&gt;&gt; -t1<br>&gt;&gt;&gt;&gt;&gt; 2.04 0.50 0.17 8/27 174<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; T: 0 (    0) P:99 I:    1000 C:       0 Min:<br>&gt;&gt;&gt;&gt; 1000000<br>&gt;&gt;&gt;&gt;&gt; Act:       0 Avg:       0
 Max:-1000000<br>&gt;&gt;&gt;&gt;&gt; Illegal instruction<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; 4)Output of /proc/xenomai/faults after the<br>&gt;&gt; illegal<br>&gt;&gt;&gt;&gt;&gt; instruction:-<br>&gt;&gt;&gt;&gt;&gt; root@domain.hid# cat<br>&gt;&gt;&gt;&gt;&gt; /proc/xenomai/faults<br>&gt;&gt;&gt;&gt;&gt; TRAP         CPU0<br>&gt;&gt;&gt;&gt;&gt;   0:            0    (Data or instruction<br>&gt;&gt; access)<br>&gt;&gt;&gt;&gt;&gt;   1:            0    (Alignment)<br>&gt;&gt;&gt;&gt;&gt;   2:            0    (Altivec unavailable)<br>&gt;&gt;&gt;&gt;&gt;   3:            0    (Program check exception)<br>&gt;&gt;&gt;&gt;&gt;   4:            0    (Machine check exception)<br>&gt;&gt;&gt;&gt;&gt;   5:            0    (Unknown)<br>&gt;&gt;&gt;&gt;&gt;   6:            0    (Instruction breakpoint)<br>&gt;&gt;&gt;&gt;&gt;   7:            0    (Run mode exception)<br>&gt;&gt;&gt;&gt;&gt;   8:            0    (Single-step
 exception)<br>&gt;&gt;&gt;&gt;&gt;   9:            0    (Non-recoverable exception)<br>&gt;&gt;&gt;&gt;&gt;  10:            1    (Software emulation)<br>&gt;&gt;&gt;&gt;&gt;  11:            0    (Debug)<br>&gt;&gt;&gt;&gt;&gt;  12:            0    (SPE)<br>&gt;&gt;&gt;&gt;&gt;  13:            0    (Altivec assist)<br>&gt;&gt;&gt;&gt; Hm, I see a software emulation exception which is<br>&gt;&gt;&gt;&gt; also the reason for <br>&gt;&gt;&gt;&gt; the illegal instructions. What toolchain do you<br>&gt;&gt; use?<br>&gt;&gt;&gt;&gt; The toolchain <br>&gt;&gt;&gt;&gt; should support software FP emulation.<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; 5)Running switchtest:-<br>&gt;&gt;&gt;&gt;&gt; root@domain.hid#<br>&gt;&gt; ./switchtest<br>&gt;&gt;&gt;&gt; -n<br>&gt;&gt;&gt;&gt;&gt; --The system hangs wihtout printing any results<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; Thanks,<br>&gt;&gt;&gt;&gt;&gt;
 Poornima<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; --- Wolfgang Grandegger <wg@domain.hid><br>&gt;&gt; wrote:<br>&gt;&gt;&gt;&gt;&gt;&gt; poornima r wrote:<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks for the reply.<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Linux version:linux-2.6.18<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Xenomai: xenomai-2.3.0 (Stable version)<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; adeos patch:<br>&gt;&gt; adeos-ipipe-2.6.18-ppc-1.5-01.patch<br>&gt;&gt;&gt;&gt;&gt;&gt; OK, I'm curious, did you use the vanilla kernel<br>&gt;&gt;&gt;&gt; from<br>&gt;&gt;&gt;&gt;&gt;&gt; kernel.org?<br>&gt;&gt;&gt;&gt;&gt;&gt; More comments below.<br>&gt;&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; The tests were run as follows:<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 1)The sampling period in the code for latency<br>&gt;&gt;&gt;&gt; and<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt;
 switchbench was changed to 1000000000ns(to<br>&gt;&gt;&gt;&gt; remove<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; overrun error) <br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2)switchtest was run with -n5 option<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 3)cyclictest was run with  -t5 option(5<br>&gt;&gt; threads <br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; were created.)<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 4)cyclictest was terminated with Illegal<br>&gt;&gt;&gt;&gt;&gt;&gt; instruction<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; (after creating 5 threads) with IPIPE tracer<br>&gt;&gt;&gt;&gt;&gt;&gt; enabled.<br>&gt;&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; These were the results without I-PIPE Tracer<br>&gt;&gt;&gt;&gt;&gt;&gt; option:<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; (All the tests were run without any load)<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 1)LATENCY TEST:-<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; User mode:-<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; /mnt/out_xen/bin# ./latency -t0<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; == Sampling period: 1000000
 us<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; == Test mode: periodic user-mode task<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; == All results in microseconds<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; warming up...<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; RTT|  00:00:01  (periodic user-mode task,<br>&gt;&gt;&gt;&gt; 1000000<br>&gt;&gt;&gt;&gt;&gt;&gt; us<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; period, priority 99)<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; RTH|-----lat min|-----lat avg|-----lat<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; max|-overrun|----lat best|---lat worst<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; RTD|     167.000|     167.000|     167.000|   <br>&gt;&gt;  <br>&gt;&gt;&gt;&gt;&gt;&gt; 0|  <br>&gt;&gt;&gt;&gt;&gt;&gt;&gt;   167.000|     167.000<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; RTD|     176.000|     176.000|     176.000|   <br>&gt;&gt;  <br>&gt;&gt;&gt;&gt;&gt;&gt; 0|  <br>&gt;&gt;&gt;&gt;&gt;&gt;&gt;   167.000|     176.000<br>&gt;&gt;&gt;&gt;&gt;&gt;&gt; RTD|     168.000|     168.000|     168.000|   <br>&gt;&gt; 
 <br>&gt;&gt;&gt;&gt;&gt;&gt; 0|  <br>&gt;&gt;&gt;&gt;&gt;&gt;&gt;   167.000|     176.000<br>&gt; === message truncated ===<br>&gt; <br>&gt; <br>&gt; <br>&gt;  <br>&gt; ____________________________________________________________________________________<br>&gt; Get your own web address.  <br>&gt; Have a HUGE year through Yahoo! Small Business.<br>&gt; http://smallbusiness.yahoo.com/domains/?p=BESTDEAL<br>&gt; <br>&gt; _______________________________________________<br>&gt; Adeos-main mailing list<br>&gt; Adeos-main@domain.hid<br>&gt; https://mail.gna.org/listinfo/adeos-main<br>&gt; <br>&gt; <br><br></wg@domain.hid></wg@domain.hid></wg@domain.hid></blockquote><br><p>&#32;

<hr size=1><a href="http://us.rd.yahoo.com/evt=49935/*http://games.yahoo.com">Bored stiff?</a> Loosen up...<br><a href="http://us.rd.yahoo.com/evt=49935/*http://games.yahoo.com">Download and play hundreds of games for free</a> on Yahoo! Games.
--0-149941850-1172050391=:56324--

