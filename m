Message-ID: <4354E039.9010305@domain.hid>
Date: Tue, 18 Oct 2005 13:44:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai latency tests on various PowerPC boards
References: <4354C0A9.5060901@domain.hid> <4354DB29.9060004@domain.hid>
In-Reply-To: <4354DB29.9060004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Wolfgang Grandegger wrote:
> 
>> Hallo,
>>
>> attached you will find the results of Xemonai latency measurements on
>> various embedded PowerPC boards using MPC 8xx and AMCC 4xx processors,
>> from low to high end covering a worst case latency range from 25 to 225
>> us. It also includes a comparison with RTAI 3.0r5 on the slowest CPU.
>> Here are some remarks and comments:
>>
>> - On low-end processor code size matters a lot and it's difficult to
>>   beat RTAI/RTHAL.
>>
> 
> Beat no, get closer, yes, probably. The good news is that looking at the 
> figures, we do have a margin of improvement! :o>
> 
> Btw, the nucleus can be configured so that the user-space threading 
> engine is compiled out (i.e. CONFIG_XENO_OPT_PERVASIVE from the nucleus 
> menu), which would be the corresponding profile to compare with klatency 
> (i.e. sched_up). Disabling this option reduces the code size for the 
> nucleus from:
> 
>    text       data        bss        dec        hex    filename
>   66740        792       6540      74072      12158    
> nucleus/xeno_nucleus.ko
> 
> to:
> 
>   text       data        bss        dec        hex    filename
>   52596        576       3956      57128       df28    
> nucleus/xeno_nucleus.ko
> 

Disabling the periodic timer support which is unused for the klatency test 
brings this down to:

    text	   data	    bss	    dec	    hex	filename
   51040	    544	   3956	  55540	   d8f4	nucleus/xeno_nucleus.ko

> Still a bit fat though.
> 
>> - Apart from the CPU power, big caches and a fast memory interface
>>   improves latencies.
>>
>> - L2 cache improves latencies a lot (compare Ocotea with Yosemite).
>>
>> - I'm a bit puzzled about the results of the "cruncher" test. Could
>>   someone explain the output, please?
>>
> 
> This test is reminiscent of the HYADES project (ia64 port of 
> RTAI/fusion), where we wanted to illustrate the level of execution 
> determinism one could achieve using the interrupt shield technique on 
> large ia64 SMP systems. To this end, we measured the jitter in execution 
> time of a calibrated float-crunching loop, with and without interrupt 
> load. This test is likely going to disappear at some point in time, 
> because it's not that informative in Xeno's context.
> 
>> - Stability seems already quite good. At least I did not observe any
>>   crash yet :-).
>>
> 
> That's cool. I see no other way to properly improve performances than 
> first having something which could be run on various platforms without 
> them randomly jumping out of the window, or us relying on plain Voodoo 
> stuff to explain why those setup would work or not.
> 
>> The PowerPC port of Xenomai is already in good shape. That's great!
>>
> 
> Thanks. This is likely because I do feel better since I have been aware 
> that there's life beyond x86. :o)
> 
>> Wolfgang.
>>
>>
>>
>>
>>
>> ------------------------------------------------------------------------
>>
>> Latency tests with Xenomai on various PowerPC boards
>> ----------------------------------------------------
>>
>> Board   : Processor  CPU-Clk Bus-Clk I-Cache D-Cache Memory Remarks
>>
>> TQM860L : MPC 860     50 MHz  50 MHz    4 KB    4 kB  16 MB
>> TQM866M : MPC 866    133 MHz  66 MHz   16 KB    8 kB 128 MB
>>
>> Walnut  : AMCC 405GP 200 MHz 100 MHz   16 KB    8 kB  32 MB
>> Yosemite: AMCC 440EP 533 MHz 133 MHz   32 KB   32 KB 256 MB DDR-RAM, FPU
>> Ocotea  : AMCC 440GX 533 MHz 152 MHz   32 KB   32 KB 256 MB DDR-RAM, 
>> L2 256 KB
>>
>>
>> Linux  : DENX linux-2.6.14-rc3-g4c234921
>> iPipe  : 1.0-00
>> Xenomai: SVN 2005-10-15
>>
>>
>> CRUNCER without load:
>>
>>          | Ideal computation time
>> TQM860L  |   368 us ???
>> TQM866L  | 10008 us Walnut   | 10150 us
>> Yosemite |  9911 us
>> Ocotea   |  9479 us
>>
>> SWITCH without load:
>>
>>          |     lat min|     lat avg|     lat max|        lost
>> TQM860L  |      103360|      107840|      209280|           0
>> TQM866L  |       25745|       31880|       51369|           5
>> Walnut   |       24620|       25965|       32280|           1
>> Yosemite |        5626|        5655|       17403|           0
>> Ocotea   |        5158|        5169|       10038|           0
>>
>>
>> KLATENCY with load:
>>
>>          |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
>> TQM860L  |       50560|       98976|      199040|       0|    00:09:45
>> TQM866L  |       13835|       28571|       74348|       0|    00:11:44
>> Walnut   |       16195|       25062|       45755|       0|    00:10:09
>> Yosemite |        3106|        9697|       36832|       0|    00:09:55
>> Ocotea   |        3575|        7438|       24474|       0|    00:10:50
>>
>>
>> LATENCY with load:
>>
>>          |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
>> TQM860L  |       60480|      120960|      224320|       0|    00:09:46
>> TQM866L  |       15759|       34286|       78799|       0|    00:11:14
>> Walnut   |       21070|       31650|       64500|       0|    00:09:58
>> Yosemite |        3808|       12163|       47898|       0|    00:10:00
>> Ocotea   |        3575|        7438|       24474|       0|    00:10:50
>>
>>
>> KLATENCY comparison Xenomai 2.0 vs. RTAI/RTHAL 3.0r5 on TQM860L:
>> ---------------------------------------------------------------
>>
>> KLATENCY with load:
>>
>>             |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
>> Xenomai 2.0 |       50560|       98976|      199040|       0|    00:09:45
>> RTAI 3.0r5  |       23120|       31838|       70520|       ?|    00:12:26
>>
>>
>>
>> Note: load has been put onto the system by running in a telnet session
>>       "ping -f <remote-host-ip>" and "while ls; do ls; done".
>>
>> Note: all test have been run with CONFIG_XENO_HW_TIMER_LATENCY="1" and
>>       CONFIG_XENO_HW_SCHED_LATENCY="1" to get correct latancy values.
>>       RTAI figures have been corrected manually.
>>
>>
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
> 
> 
> 


-- 

Philippe.

