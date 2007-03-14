Date: Wed, 14 Mar 2007 05:51:33 -0700 (PDT)
From: poornima r <rpoornar@domain.hid>
Subject: Re: [Adeos-main] test results for switchtest and cyclictest on x86
In-Reply-To: <45DBF120.2040202@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1520790537-1173876693=:46909"
Content-Transfer-Encoding: 8bit
Message-ID: <696883.46909.qm@domain.hid>
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

--0-1520790537-1173876693=:46909
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,
   
  There were the results for cyclictest and switchbench test results run on X86
  (without load)
   
  System specifications:-
  Xenomai: xenomai-2.3.0
  Linux kernel: linux-2.6.19.3
  CPU speed : 2.79GHz
  Cache: 512KB
  
 
  a) Switchtest:-
   
  Results:
   
  ./switchtest -T 50 -n rtk rtup rtus
  (-T:limit of test duration i.e 50 seconds
  -n:disables any use of FPU instructions.
  threadspec:rtk i.e kernel-space realtime thread ,rtup i.e for a user-space real-time thread running in primary mode,rtus i.e user-space real-time thread running in secondary mode)
   
  RTT| 00:00:01
  RTH|ctx switches|-------total
  RTD| 1000| 1000
  RTD| 1004| 2004
  RTD| 1002| 3006
  RTD| 1006| 4012
  RTD| 1004| 5016
  RTD| 1002| 6018
  RTD| 1006| 7024
  RTD| 998| 8022
  RTD| 1006| 9028
  RTD| 1004| 10032
  RTD| 516| 10548
  RTD| 504| 11052
  RTD| 504| 11556
  RTD| 504| 12060
  RTD| 504| 12564
  RTD| 504| 13068
  RTD| 504| 13572
  RTD| 504| 14076
  RTD| 504| 14580
  RTD| 504| 15084
  RTD| 504| 15588
  RTT| 00:00:22
  RTH|ctx switches|-------total
  RTD| 510| 16098
  RTD| 846| 16944
  RTD| 996| 17940
  RTD| 1002| 18942
  RTD| 996| 19938
  RTD| 1006| 20944
  RTD| 1004| 21948
  RTD| 1000| 22948
  RTD| 1004| 23952
  RTD| 1002| 24954
  RTD| 1006| 25960
  RTD| 1004| 26964
  RTD| 1002| 27966
  RTD| 1006| 28972
  RTD| 1004| 29976
  RTD| 1002| 30978
  RTD| 1006| 31984
  RTD| 998| 32982
  RTD| 1006| 33988
  RTD| 1004| 34992
  RTD| 1002| 35994
  RTT| 00:00:43
  RTH|ctx switches|-------total
  RTD| 1002| 36996
  RTD| 1002| 37998
  RTD| 1006| 39004
  RTD| 1004| 40008
  RTD| 1002| 41010
  RTD| 1002| 42012
  RTD| 1002| 43014
  RTD| 790| 43804
   
  Total no of context switches between kernel-space realtime thread ,user-space real-time 
  thread running in primary mode and user-space real-time thread running in secondary mode is 43804.
   
  b)cyclictest:-
   
  Results:- 
   
  ./cyclictest -l 100
  0.59 0.13 0.06 1/99 25688
  T: 0 (25688) P:99 I: 1000 C: 100 Min: 7 Act: 7 Avg: 9 Max: 24
   
  1) Please comment on these results.
  2) What are we benchmarking from the above cyclictest result?
   
  Thanks and Regards,
  Poornima

   
   
   
   
  Wolfgang Grandegger <wg@domain.hid> wrote:
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
> RTT| 00:00:01 (periodic user-mode task, 1000000 us
> period, priority 99)
> RTH|-----lat min|-----lat
> avg|-----latmax|-overrun|----lat best|---lat worst
> RTD| 167.000| 167.000| 167.000| 0| 
> 167.000| 167.000
> RTD| 176.000| 176.000| 176.000| 0| 
> 167.000| 176.000
> RTD| 168.000| 168.000| 168.000| 0| 
> 167.000| 176.000
> RTD| 171.000| 171.000| 171.000| 0| 
> 167.000| 176.000
> 
> Kernel mode:-
> root@domain.hid# ./latency -t1
> == Sampling period: 1000000 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> warming up...
> RTT| 00:00:00 (in-kernel periodic task, 1000000 us
> period, priority 99)
> RTH|-----lat min|-----lat
> avg|-----latmax|-overrun|----lat best|---lat worst
> RTD| 123.000| 123.000| 123.000| 0| 
> 123.000| 123.000
> RTD| 125.000| 125.000| 125.000| 0| 
> 123.000| 125.000
> RTD| 128.333| 128.333| 128.333| 0| 
> 123.000| 128.333
> RTD| 127.000| 127.000| 127.000| 0| 
> 123.000| 128.333
> 
> Interrupt mode:-
> root@domain.hid# ./latency -t2
> == Sampling period: 1000000 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> warming up...
> RTT| 00:00:01 (in-kernel timer handler, 1000000 us
> period, priority 99)
> RTH|-----lat min|-----lat
> avg|-----latmax|-overrun|----lat best|---lat worst
> RTD| 45.334| 45.334| 45.334| 0| 
> 45.334| 45.334
> RTD| 45.000| 45.000| 45.000| 0| 
> 45.000| 45.334
> RTD| 46.000| 46.000| 46.000| 0| 
> 45.000| 46.000
> RTD| 47.334| 47.334| 47.334| 0| 
> 45.000| 47.334
> RTD| 46.334| 46.334| 46.334| 0| 
> 45.000| 47.334

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
> RTT| 00:00:01 (periodic user-mode task, 100 us
> period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat
> max|-overrun|----lat best|---lat worst
> RTD| 3.807| 12.825| 21.565| 0| 
> 3.807| 21.565
> RTD| 3.796| 12.792| 21.483| 0| 
> 3.796| 21.565
> RTD| 3.770| 12.799| 21.501| 0| 
> 3.770| 21.565
> RTD| 3.578| 12.806| 20.890| 0| 
> 3.578| 21.565
> RTD| 3.755| 12.809| 21.486| 0| 
> 3.578|
> 
> kernel mode:-
> Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> warming up...
> 
> RTT| 00:00:01 (in-kernel periodic task, 100 us
> period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat
> max|-overrun|----lat best|---lat worst
> RTD| 2.381| 3.451| 19.620| 0| 
> 2.381| 19.620
> RTD| 2.332| 3.480| 19.930| 0| 
> 2.332| 19.930
> RTD| 2.382| 3.649| 19.609| 0| 
> 2.332| 19.930
> RTD| 2.323| 2.786| 14.351| 0| 
> 2.323| 19.930
> RTD| 2.375| 2.532| 5.519| 0| 
> 2.323| 19.930
> RTD| 2.332| 3.971| 19.617| 0| 
> 2.323| 19.930
> 
> Interrupt mode:-
> Sampling period: 100 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> warming up...
> 
> RTT| 00:00:01 (in-kernel timer handler, 100 us
> period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat
> max|-overrun|----lat best|---lat worst
> RTD| -1.563| 7.553| 15.736| 0| 
> -1.563| 15.736
> RTD| -1.579| 7.558| 15.804| 0| 
> -1.579| 15.804
> RTD| -1.584| 7.529| 16.167| 0| 
> -1.584| 16.167
> RTD| -1.548| 7.553| 16.186| 0| 
> -1.584| 16.186
> RTD| -1.585| 7.556| 16.275| 0| 
> -1.585| 16.275

Latencies are mainly due to cache refills on the P4. Have you already 
put load onto your system? If not, worst case latencies will be even longer.

Wolfgang.

> Thanks,
> Poornima
> 
> 
> --- Wolfgang Grandegger wrote:
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
>>>>> TRAP CPU0
>>>>> 0: 0 (Data or instruction
>> access)
>>>>> 1: 0 (Alignment)
>>>>> 2: 0 (Altivec unavailable)
>>>>> 3: 0 (Program check exception)
>>>>> 4: 0 (Machine check exception)
>>>>> 5: 0 (Unknown)
>>>>> 6: 0 (Instruction breakpoint)
>>>>> 7: 0 (Run mode exception)
>>>>> 8: 0 (Single-step exception)
>>>>> 9: 0 (Non-recoverable exception)
>>>>> 10: 1 (Software emulation)
>>>>> 11: 0 (Debug)
>>>>> 12: 0 (SPE)
>>>>> 13: 0 (Altivec assist)
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
>>> unit, which will allow programs that 
>>> use floating-point 
>> 
>>> instructions to run
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
>>> --- Wolfgang Grandegger wrote:
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
>>>>> T: 0 ( 0) P:99 I: 1000 C: 0 Min:
>>>> 1000000
>>>>> Act: 0 Avg: 0 Max:-1000000
>>>>> Illegal instruction
>>>>>
>>>>> 4)Output of /proc/xenomai/faults after the
>> illegal
>>>>> instruction:-
>>>>> root@domain.hid# cat
>>>>> /proc/xenomai/faults
>>>>> TRAP CPU0
>>>>> 0: 0 (Data or instruction
>> access)
>>>>> 1: 0 (Alignment)
>>>>> 2: 0 (Altivec unavailable)
>>>>> 3: 0 (Program check exception)
>>>>> 4: 0 (Machine check exception)
>>>>> 5: 0 (Unknown)
>>>>> 6: 0 (Instruction breakpoint)
>>>>> 7: 0 (Run mode exception)
>>>>> 8: 0 (Single-step exception)
>>>>> 9: 0 (Non-recoverable exception)
>>>>> 10: 1 (Software emulation)
>>>>> 11: 0 (Debug)
>>>>> 12: 0 (SPE)
>>>>> 13: 0 (Altivec assist)
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
>>>>>>> 3)cyclictest was run with -t5 option(5
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
>>>>>>> RTT| 00:00:01 (periodic user-mode task,
>>>> 1000000
>>>>>> us
>>>>>>> period, priority 99)
>>>>>>> RTH|-----lat min|-----lat avg|-----lat
>>>>>>> max|-overrun|----lat best|---lat worst
>>>>>>> RTD| 167.000| 167.000| 167.000| 
>> 
>>>>>> 0| 
>>>>>>> 167.000| 167.000
>>>>>>> RTD| 176.000| 176.000| 176.000| 
>> 
>>>>>> 0| 
>>>>>>> 167.000| 176.000
>>>>>>> RTD| 168.000| 168.000| 168.000| 
>> 
>>>>>> 0| 
>>>>>>> 167.000| 176.000
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
Don't pick lemons.
See all the new 2007 cars at Yahoo! Autos.
 
---------------------------------
Never miss an email again!
Yahoo! Toolbar alerts you the instant new Mail arrives. Check it out.
--0-1520790537-1173876693=:46909
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hello,</div>  <div>&nbsp;</div>  <div>There were the results for cyclictest and switchbench test results run on X86</div>  <div>(without load)</div>  <div>&nbsp;</div>  <div>System specifications:-</div>  <div>Xenomai: xenomai-2.3.0</div>  <div>Linux kernel: linux-2.6.19.3</div>  <div>CPU speed : 2.79GHz</div>  <div>Cache: 512KB</div>  <div><BR>&nbsp;</div>  <div>a) Switchtest:-</div><FONT size=2>  <div>&nbsp;</div>  <div>Results:</div>  <div>&nbsp;</div>  <div>./switchtest -T 50 -n rtk rtup rtus</div>  <div>(-T:limit of test duration i.e 50 seconds</div>  <div>-n:disables any use of FPU instructions.</div>  <div>threadspec:rtk i.e kernel-space realtime thread ,rtup i.e for a user-space real-time thread running in primary mode,rtus i.e user-space real-time thread running in secondary mode)</div>  <div>&nbsp;</div>  <div>RTT| 00:00:01</div>  <div>RTH|ctx switches|-------total</div>  <div>RTD| 1000| 1000</div>  <div>RTD| 1004| 2004</div>  <div>RTD| 1002| 3006</div> 
 <div>RTD| 1006| 4012</div>  <div>RTD| 1004| 5016</div>  <div>RTD| 1002| 6018</div>  <div>RTD| 1006| 7024</div>  <div>RTD| 998| 8022</div>  <div>RTD| 1006| 9028</div>  <div>RTD| 1004| 10032</div>  <div>RTD| 516| 10548</div>  <div>RTD| 504| 11052</div>  <div>RTD| 504| 11556</div>  <div>RTD| 504| 12060</div>  <div>RTD| 504| 12564</div>  <div>RTD| 504| 13068</div>  <div>RTD| 504| 13572</div>  <div>RTD| 504| 14076</div>  <div>RTD| 504| 14580</div>  <div>RTD| 504| 15084</div>  <div>RTD| 504| 15588</div>  <div>RTT| 00:00:22</div>  <div>RTH|ctx switches|-------total</div>  <div>RTD| 510| 16098</div>  <div>RTD| 846| 16944</div>  <div>RTD| 996| 17940</div>  <div>RTD| 1002| 18942</div>  <div>RTD| 996| 19938</div>  <div>RTD| 1006| 20944</div>  <div>RTD| 1004| 21948</div>  <div>RTD| 1000| 22948</div>  <div>RTD| 1004| 23952</div>  <div>RTD| 1002| 24954</div>  <div>RTD| 1006| 25960</div>  <div>RTD| 1004| 26964</div>  <div>RTD| 1002| 27966</div>  <div>RTD| 1006| 28972</div>  <div>RTD|
 1004| 29976</div>  <div>RTD| 1002| 30978</div>  <div>RTD| 1006| 31984</div>  <div>RTD| 998| 32982</div>  <div>RTD| 1006| 33988</div>  <div>RTD| 1004| 34992</div>  <div>RTD| 1002| 35994</div>  <div>RTT| 00:00:43</div>  <div>RTH|ctx switches|-------total</div>  <div>RTD| 1002| 36996</div>  <div>RTD| 1002| 37998</div>  <div>RTD| 1006| 39004</div>  <div>RTD| 1004| 40008</div>  <div>RTD| 1002| 41010</div>  <div>RTD| 1002| 42012</div>  <div>RTD| 1002| 43014</div>  <div>RTD| 790| 43804</div>  <div>&nbsp;</div>  <div>Total no of context switches between kernel-space realtime thread ,user-space real-time </div>  <div>thread running in primary mode and user-space real-time thread running in secondary mode is 43804.</div></FONT>  <div>&nbsp;</div><FONT size=2>  <div>b)cyclictest:-</div>  <div>&nbsp;</div>  <div>Results:- </div>  <div>&nbsp;</div>  <div>./cyclictest -l 100</div>  <div>0.59 0.13 0.06 1/99 25688</div>  <div>T: 0 (25688) P:99 I: 1000 C: 100 Min: 7 Act: 7 Avg: 9 Max:
 24</div></FONT>  <div>&nbsp;</div>  <div>1) Please comment on these results.</div>  <div>2) What&nbsp;are we&nbsp;benchmarking&nbsp;from the above cyclictest result?</div>  <div>&nbsp;</div>  <div>Thanks and Regards,</div>  <div>Poornima<BR></div>  <div><STRONG><EM></EM></STRONG>&nbsp;</div>  <div><STRONG><EM></EM></STRONG>&nbsp;</div>  <div><STRONG><EM></EM></STRONG>&nbsp;</div>  <div><B><I></I></B>&nbsp;</div>  <div><B><I>Wolfgang Grandegger &lt;wg@domain.hid&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hello,<BR><BR>poornima r wrote:<BR>&gt; Hello,<BR>&gt; <BR>&gt; These were the scheduling latency and interrupt<BR>&gt; latency test results on ppc and x86 with IPIPE tracer<BR>&gt; option disabled.<BR>&gt; <BR>&gt; 1.Please comment on these results (whether valid) and <BR><BR>Your results are OK. These are actually the figures I remember from my <BR>own tests in the past.<BR><BR>&gt;
 2.Is there any method to optimize these results.<BR><BR>No that I know of. There are a few ideas how to reduce latencies further <BR>like cache locking or TLB pinning.<BR><BR>&gt; 1)PPC:-<BR>&gt; (MPC-860 at 48 MHz, 4 kB I-Cache and 4 kB D-Cache) <BR>&gt; <BR>&gt; User mode:-<BR>&gt; root@domain.hid# ./latency -t0<BR>&gt; == Sampling period: 1000000 us<BR>&gt; == Test mode: periodic user-mode task<BR>&gt; == All results in microseconds<BR>&gt; warming up...<BR>&gt; RTT| 00:00:01 (periodic user-mode task, 1000000 us<BR>&gt; period, priority 99)<BR>&gt; RTH|-----lat min|-----lat<BR>&gt; avg|-----latmax|-overrun|----lat best|---lat worst<BR>&gt; RTD| 167.000| 167.000| 167.000| 0| <BR>&gt; 167.000| 167.000<BR>&gt; RTD| 176.000| 176.000| 176.000| 0| <BR>&gt; 167.000| 176.000<BR>&gt; RTD| 168.000| 168.000| 168.000| 0| <BR>&gt; 167.000| 176.000<BR>&gt; RTD| 171.000| 171.000| 171.000| 0| <BR>&gt; 167.000| 176.000<BR>&gt; <BR>&gt; Kernel mode:-<BR>&gt;
 root@domain.hid# ./latency -t1<BR>&gt; == Sampling period: 1000000 us<BR>&gt; == Test mode: in-kernel periodic task<BR>&gt; == All results in microseconds<BR>&gt; warming up...<BR>&gt; RTT| 00:00:00 (in-kernel periodic task, 1000000 us<BR>&gt; period, priority 99)<BR>&gt; RTH|-----lat min|-----lat<BR>&gt; avg|-----latmax|-overrun|----lat best|---lat worst<BR>&gt; RTD| 123.000| 123.000| 123.000| 0| <BR>&gt; 123.000| 123.000<BR>&gt; RTD| 125.000| 125.000| 125.000| 0| <BR>&gt; 123.000| 125.000<BR>&gt; RTD| 128.333| 128.333| 128.333| 0| <BR>&gt; 123.000| 128.333<BR>&gt; RTD| 127.000| 127.000| 127.000| 0| <BR>&gt; 123.000| 128.333<BR>&gt; <BR>&gt; Interrupt mode:-<BR>&gt; root@domain.hid# ./latency -t2<BR>&gt; == Sampling period: 1000000 us<BR>&gt; == Test mode: in-kernel timer handler<BR>&gt; == All results in microseconds<BR>&gt; warming up...<BR>&gt; RTT| 00:00:01 (in-kernel timer handler, 1000000 us<BR>&gt; period, priority
 99)<BR>&gt; RTH|-----lat min|-----lat<BR>&gt; avg|-----latmax|-overrun|----lat best|---lat worst<BR>&gt; RTD| 45.334| 45.334| 45.334| 0| <BR>&gt; 45.334| 45.334<BR>&gt; RTD| 45.000| 45.000| 45.000| 0| <BR>&gt; 45.000| 45.334<BR>&gt; RTD| 46.000| 46.000| 46.000| 0| <BR>&gt; 45.000| 46.000<BR>&gt; RTD| 47.334| 47.334| 47.334| 0| <BR>&gt; 45.000| 47.334<BR>&gt; RTD| 46.334| 46.334| 46.334| 0| <BR>&gt; 45.000| 47.334<BR><BR>On the MPC860, the latencies are mainly due code execution time as this <BR>processor is very slow.<BR><BR>&gt; 2)X86:-<BR>&gt; (Pentium4, 3.06GHz, 1024 KB cache size)<BR>&gt; User mode:-<BR>&gt; Sampling period: 100 us<BR>&gt; == Test mode: in-kernel periodic task<BR>&gt; == All results in microseconds<BR>&gt; warming up...<BR>&gt; <BR>&gt; RTT| 00:00:01 (periodic user-mode task, 100 us<BR>&gt; period, priority 99)<BR>&gt; RTH|-----lat min|-----lat avg|-----lat<BR>&gt; max|-overrun|----lat best|---lat worst<BR>&gt; RTD| 3.807| 12.825| 21.565| 0| <BR>&gt;
 3.807| 21.565<BR>&gt; RTD| 3.796| 12.792| 21.483| 0| <BR>&gt; 3.796| 21.565<BR>&gt; RTD| 3.770| 12.799| 21.501| 0| <BR>&gt; 3.770| 21.565<BR>&gt; RTD| 3.578| 12.806| 20.890| 0| <BR>&gt; 3.578| 21.565<BR>&gt; RTD| 3.755| 12.809| 21.486| 0| <BR>&gt; 3.578|<BR>&gt; <BR>&gt; kernel mode:-<BR>&gt; Sampling period: 100 us<BR>&gt; == Test mode: in-kernel periodic task<BR>&gt; == All results in microseconds<BR>&gt; warming up...<BR>&gt; <BR>&gt; RTT| 00:00:01 (in-kernel periodic task, 100 us<BR>&gt; period, priority 99)<BR>&gt; RTH|-----lat min|-----lat avg|-----lat<BR>&gt; max|-overrun|----lat best|---lat worst<BR>&gt; RTD| 2.381| 3.451| 19.620| 0| <BR>&gt; 2.381| 19.620<BR>&gt; RTD| 2.332| 3.480| 19.930| 0| <BR>&gt; 2.332| 19.930<BR>&gt; RTD| 2.382| 3.649| 19.609| 0| <BR>&gt; 2.332| 19.930<BR>&gt; RTD| 2.323| 2.786| 14.351| 0| <BR>&gt; 2.323| 19.930<BR>&gt; RTD| 2.375| 2.532| 5.519| 0| <BR>&gt; 2.323| 19.930<BR>&gt; RTD| 2.332| 3.971| 19.617| 0| <BR>&gt; 2.323| 19.930<BR>&gt;
 <BR>&gt; Interrupt mode:-<BR>&gt; Sampling period: 100 us<BR>&gt; == Test mode: in-kernel timer handler<BR>&gt; == All results in microseconds<BR>&gt; warming up...<BR>&gt; <BR>&gt; RTT| 00:00:01 (in-kernel timer handler, 100 us<BR>&gt; period, priority 99)<BR>&gt; RTH|-----lat min|-----lat avg|-----lat<BR>&gt; max|-overrun|----lat best|---lat worst<BR>&gt; RTD| -1.563| 7.553| 15.736| 0| <BR>&gt; -1.563| 15.736<BR>&gt; RTD| -1.579| 7.558| 15.804| 0| <BR>&gt; -1.579| 15.804<BR>&gt; RTD| -1.584| 7.529| 16.167| 0| <BR>&gt; -1.584| 16.167<BR>&gt; RTD| -1.548| 7.553| 16.186| 0| <BR>&gt; -1.584| 16.186<BR>&gt; RTD| -1.585| 7.556| 16.275| 0| <BR>&gt; -1.585| 16.275<BR><BR>Latencies are mainly due to cache refills on the P4. Have you already <BR>put load onto your system? If not, worst case latencies will be even longer.<BR><BR>Wolfgang.<BR><BR>&gt; Thanks,<BR>&gt; Poornima<BR>&gt; <BR>&gt; <BR>&gt; --- Wolfgang Grandegger <WG@GRANDEGGER.COM>wrote:<BR>&gt; <BR>&gt;&gt;
 Hello,<BR>&gt;&gt;<BR>&gt;&gt; poornima r wrote:<BR>&gt;&gt;&gt; Hello,<BR>&gt;&gt;&gt;<BR>&gt;&gt;&gt; Srry for not replying all these days...<BR>&gt;&gt;&gt; (Was not in in station, may be too personal!!!!!)<BR>&gt;&gt;&gt;<BR>&gt;&gt;&gt; About software emulation error:<BR>&gt;&gt;&gt;<BR>&gt;&gt;&gt; 4)Output of /proc/xenomai/faults after the illegal<BR>&gt;&gt;&gt;&gt;&gt; instruction:-<BR>&gt;&gt;&gt;&gt;&gt; root@domain.hid# cat<BR>&gt;&gt;&gt;&gt;&gt; /proc/xenomai/faults<BR>&gt;&gt;&gt;&gt;&gt; TRAP CPU0<BR>&gt;&gt;&gt;&gt;&gt; 0: 0 (Data or instruction<BR>&gt;&gt; access)<BR>&gt;&gt;&gt;&gt;&gt; 1: 0 (Alignment)<BR>&gt;&gt;&gt;&gt;&gt; 2: 0 (Altivec unavailable)<BR>&gt;&gt;&gt;&gt;&gt; 3: 0 (Program check exception)<BR>&gt;&gt;&gt;&gt;&gt; 4: 0 (Machine check exception)<BR>&gt;&gt;&gt;&gt;&gt; 5: 0 (Unknown)<BR>&gt;&gt;&gt;&gt;&gt; 6: 0 (Instruction breakpoint)<BR>&gt;&gt;&gt;&gt;&gt; 7: 0 (Run mode exception)<BR>&gt;&gt;&gt;&gt;&gt; 8: 0
 (Single-step exception)<BR>&gt;&gt;&gt;&gt;&gt; 9: 0 (Non-recoverable exception)<BR>&gt;&gt;&gt;&gt;&gt; 10: 1 (Software emulation)<BR>&gt;&gt;&gt;&gt;&gt; 11: 0 (Debug)<BR>&gt;&gt;&gt;&gt;&gt; 12: 0 (SPE)<BR>&gt;&gt;&gt;&gt;&gt; 13: 0 (Altivec assist)<BR>&gt;&gt;&gt;&gt; Hm, I see a software emulation exception which is<BR>&gt;&gt;&gt;&gt; also the reason for <BR>&gt;&gt;&gt;&gt; the illegal instructions. What toolchain do you<BR>&gt;&gt; use?<BR>&gt;&gt;&gt;&gt; The toolchain <BR>&gt;&gt;&gt;&gt; should support software FP emulation.<BR>&gt;&gt;&gt; 1)I am using open source too chain with software<BR>&gt;&gt;&gt; floating point emulation support.<BR>&gt;&gt;&gt; (#ppc_8xx-gcc --v<BR>&gt;&gt;&gt;<BR>&gt; /lib/gcc/powerpc/3.4.3/../../../../target_powerpc/usr/include/c++/3.4.3<BR>&gt;&gt;&gt; --with-numa-policy=no --with-float=soft)<BR>&gt;&gt;&gt;<BR>&gt;&gt;&gt; 2)And the kernel is included with code to emulate<BR>&gt;&gt; a<BR>&gt;&gt;&gt; floating-point <BR>&gt;&gt;
 <BR>&gt;&gt;&gt; unit, which will allow programs that <BR>&gt;&gt;&gt; use floating-point <BR>&gt;&gt; <BR>&gt;&gt;&gt; instructions to run<BR>&gt;&gt;&gt;<BR>&gt;&gt;&gt; Kernel configuration <BR>&gt;&gt;&gt; ----CONFIG_MATH_EMULATION:y<BR>&gt;&gt; If you build with "--with-float=soft" there is no<BR>&gt;&gt; need for math <BR>&gt;&gt; emulation in the kernel. Likely, there is something<BR>&gt;&gt; wrong with your <BR>&gt;&gt; tool-chain. Could you please try a known-to-work<BR>&gt;&gt; tool-chain like the <BR>&gt;&gt; ELDK v4.x from http://www.denx.de.<BR>&gt;&gt;<BR>&gt;&gt; Wolfgang.<BR>&gt;&gt;<BR>&gt;&gt;&gt; Thanks,<BR>&gt;&gt;&gt; Poornima<BR>&gt;&gt;&gt;<BR>&gt;&gt;&gt; --- Wolfgang Grandegger <WG@GRANDEGGER.COM>wrote:<BR>&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt; poornima r wrote:<BR>&gt;&gt;&gt;&gt;&gt; Hi,<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; 1)I am using open source kernel from Kernel.org,<BR>&gt;&gt;&gt;&gt;&gt; but what is meant by vanilla kernel
 from<BR>&gt;&gt;&gt;&gt; Kernel.org?<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt; It's the kernel from kernel.org. This means that<BR>&gt;&gt; the<BR>&gt;&gt;&gt;&gt; Linux kernel 2.6.18 <BR>&gt;&gt;&gt;&gt; is running fine on your MPC860 platform as is?<BR>&gt;&gt;&gt;&gt; Thanks for the info.<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; 2)With sampling period of 500usec the system<BR>&gt;&gt;&gt;&gt; simply<BR>&gt;&gt;&gt;&gt;&gt; hangs without printing any results (./latenct<BR>&gt;&gt;&gt;&gt; -p500)<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt; OK.<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; 3)cyclictest with -t1 option (without<BR>&gt;&gt;&gt;&gt; IPIPE-tracer)<BR>&gt;&gt;&gt;&gt;&gt; root@domain.hid#<BR>&gt;&gt; ./cyclictest<BR>&gt;&gt;&gt;&gt; -t1<BR>&gt;&gt;&gt;&gt;&gt; 2.04 0.50 0.17 8/27 174<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; T: 0 ( 0) P:99 I: 1000 C: 0 Min:<BR>&gt;&gt;&gt;&gt; 1000000<BR>&gt;&gt;&gt;&gt;&gt; Act: 0 Avg: 0
 Max:-1000000<BR>&gt;&gt;&gt;&gt;&gt; Illegal instruction<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; 4)Output of /proc/xenomai/faults after the<BR>&gt;&gt; illegal<BR>&gt;&gt;&gt;&gt;&gt; instruction:-<BR>&gt;&gt;&gt;&gt;&gt; root@domain.hid# cat<BR>&gt;&gt;&gt;&gt;&gt; /proc/xenomai/faults<BR>&gt;&gt;&gt;&gt;&gt; TRAP CPU0<BR>&gt;&gt;&gt;&gt;&gt; 0: 0 (Data or instruction<BR>&gt;&gt; access)<BR>&gt;&gt;&gt;&gt;&gt; 1: 0 (Alignment)<BR>&gt;&gt;&gt;&gt;&gt; 2: 0 (Altivec unavailable)<BR>&gt;&gt;&gt;&gt;&gt; 3: 0 (Program check exception)<BR>&gt;&gt;&gt;&gt;&gt; 4: 0 (Machine check exception)<BR>&gt;&gt;&gt;&gt;&gt; 5: 0 (Unknown)<BR>&gt;&gt;&gt;&gt;&gt; 6: 0 (Instruction breakpoint)<BR>&gt;&gt;&gt;&gt;&gt; 7: 0 (Run mode exception)<BR>&gt;&gt;&gt;&gt;&gt; 8: 0 (Single-step exception)<BR>&gt;&gt;&gt;&gt;&gt; 9: 0 (Non-recoverable exception)<BR>&gt;&gt;&gt;&gt;&gt; 10: 1 (Software emulation)<BR>&gt;&gt;&gt;&gt;&gt; 11: 0 (Debug)<BR>&gt;&gt;&gt;&gt;&gt;
 12: 0 (SPE)<BR>&gt;&gt;&gt;&gt;&gt; 13: 0 (Altivec assist)<BR>&gt;&gt;&gt;&gt; Hm, I see a software emulation exception which is<BR>&gt;&gt;&gt;&gt; also the reason for <BR>&gt;&gt;&gt;&gt; the illegal instructions. What toolchain do you<BR>&gt;&gt; use?<BR>&gt;&gt;&gt;&gt; The toolchain <BR>&gt;&gt;&gt;&gt; should support software FP emulation.<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; 5)Running switchtest:-<BR>&gt;&gt;&gt;&gt;&gt; root@domain.hid#<BR>&gt;&gt; ./switchtest<BR>&gt;&gt;&gt;&gt; -n<BR>&gt;&gt;&gt;&gt;&gt; --The system hangs wihtout printing any results<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; Thanks,<BR>&gt;&gt;&gt;&gt;&gt; Poornima<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; --- Wolfgang Grandegger <WG@GRANDEGGER.COM><BR>&gt;&gt; wrote:<BR>&gt;&gt;&gt;&gt;&gt;&gt; poornima r wrote:<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi,<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks for the
 reply.<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Linux version:linux-2.6.18<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; Xenomai: xenomai-2.3.0 (Stable version)<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; adeos patch:<BR>&gt;&gt; adeos-ipipe-2.6.18-ppc-1.5-01.patch<BR>&gt;&gt;&gt;&gt;&gt;&gt; OK, I'm curious, did you use the vanilla kernel<BR>&gt;&gt;&gt;&gt; from<BR>&gt;&gt;&gt;&gt;&gt;&gt; kernel.org?<BR>&gt;&gt;&gt;&gt;&gt;&gt; More comments below.<BR>&gt;&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; The tests were run as follows:<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 1)The sampling period in the code for latency<BR>&gt;&gt;&gt;&gt; and<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; switchbench was changed to 1000000000ns(to<BR>&gt;&gt;&gt;&gt; remove<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; overrun error) <BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2)switchtest was run with -n5 option<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 3)cyclictest was run with -t5 option(5<BR>&gt;&gt; threads
 <BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; were created.)<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 4)cyclictest was terminated with Illegal<BR>&gt;&gt;&gt;&gt;&gt;&gt; instruction<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; (after creating 5 threads) with IPIPE tracer<BR>&gt;&gt;&gt;&gt;&gt;&gt; enabled.<BR>&gt;&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; These were the results without I-PIPE Tracer<BR>&gt;&gt;&gt;&gt;&gt;&gt; option:<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; (All the tests were run without any load)<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 1)LATENCY TEST:-<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; User mode:-<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; /mnt/out_xen/bin# ./latency -t0<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; == Sampling period: 1000000 us<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; == Test mode: periodic user-mode task<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; == All results in microseconds<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; warming up...<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; RTT| 00:00:01 (periodic user-mode task,<BR>&gt;&gt;&gt;&gt;
 1000000<BR>&gt;&gt;&gt;&gt;&gt;&gt; us<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; period, priority 99)<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; RTH|-----lat min|-----lat avg|-----lat<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; max|-overrun|----lat best|---lat worst<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; RTD| 167.000| 167.000| 167.000| <BR>&gt;&gt; <BR>&gt;&gt;&gt;&gt;&gt;&gt; 0| <BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 167.000| 167.000<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; RTD| 176.000| 176.000| 176.000| <BR>&gt;&gt; <BR>&gt;&gt;&gt;&gt;&gt;&gt; 0| <BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 167.000| 176.000<BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; RTD| 168.000| 168.000| 168.000| <BR>&gt;&gt; <BR>&gt;&gt;&gt;&gt;&gt;&gt; 0| <BR>&gt;&gt;&gt;&gt;&gt;&gt;&gt; 167.000| 176.000<BR>&gt; === message truncated ===<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; ____________________________________________________________________________________<BR>&gt; Get your own web address. <BR>&gt; Have a HUGE year through Yahoo! Small Business.<BR>&gt;
 http://smallbusiness.yahoo.com/domains/?p=BESTDEAL<BR>&gt; <BR>&gt; _______________________________________________<BR>&gt; Adeos-main mailing list<BR>&gt; Adeos-main@domain.hid<BR>&gt; https://mail.gna.org/listinfo/adeos-main<BR>&gt; <BR>&gt; <BR><BR></BLOCKQUOTE><BR><p> 

<hr size=1>Don't pick lemons.<br>
See all the <a href="http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE0OGRsc3F2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3Y2Fycw--">new 2007 cars</a> at <a href="http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE0OGRsc3F2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3Y2Fycw--">Yahoo! Autos.</a><p>&#32;

<hr size=1><a href="http://us.rd.yahoo.com/evt=49938/*http://tools.search.yahoo.com/toolbar/features/mail/">Never miss an email again!<br>Yahoo! Toolbar</a> alerts you the instant new Mail arrives.<a href="
http://us.rd.yahoo.com/evt=49937/*http://tools.search.yahoo.com/toolbar/features/mail/"> Check it out.</a>
--0-1520790537-1173876693=:46909--

