Message-ID: <4434BDBD.9060102@domain.hid>
Date: Thu, 06 Apr 2006 09:05:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] question about the latency test running on Blackfin
References: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>
	<1144294706.12272.32.camel@domain.hid>
In-Reply-To: <1144294706.12272.32.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: adam li <yi.li@domain.hid>
Cc: xenomai@xenomai.org

adam li wrote:
> Hi,
> 
> I tried to run the "latency" test on Blackfin 533-STAMP board, in
> different modes. Here is the output of the test result:
> 
> (I am using xenomai-2.1.0 with default configuration,(adding "timer
> benchmark" driver)).
> 
> 1. # latency -h -t0 -T30
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|        29|      9.862|      0.581
> HSS|    avg|    299964|     11.380|      2.676
> HSS|    max|        29|     49.759|      5.296
> 
> # cat /proc/xenomai/stat
> CPU  PID    MSW        CSW        PF    STAT      NAME
>   0  0      0/0        288239     0     00400080  ROOT
>   0  47     23/22      145        0     00300082  display
>   0  48     1/0        220501     0     00300084  sampling
> 
> 
> 2. # latency -h -t1 -T30
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|        29|      6.552|      0.686
> HSS|    avg|    299985|      8.849|      1.601
> HSS|    max|        29|     35.379|      6.383
> 
> cat /proc/xenomai/stat
> CPU  PID    MSW        CSW        PF    STAT      NAME
>   0  0      0/0        436079     0     00400080  ROOT
>   0  58     6/5        42         0     00300082  display
>   0  0      0/0        57685      0     00000084  timerbench
> 
> 
> 3. # latency -h -t2 -T30
> == Sampling period: 100 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel timer handler, 100 us period)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|      -5.340|      -4.385|       8.064|       0|      -5.340|
> 8.064
> RTD|      -6.848|      -4.359|       8.907|       0|      -6.848|
> 8.907
> RTD|      -6.443|      -4.518|      23.878|       0|      -6.848|
> 23.878
> RTD|      -5.757|      -4.240|      23.377|       0|      -6.848|
> 23.878
> RTD|      -6.153|      -4.144|      24.107|       0|      -6.848|
> 24.107
> RTD|      -5.446|      -4.040|      18.754|       0|      -6.848|
> 24.107
> RTD|      -7.697|      -4.690|      20.319|       0|      -7.697|
> 24.107
> 
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|        29|      5.621|      0.820
> HSS|    avg|    299979|      3.990|      0.774
> HSS|    max|        29|     15.966|      6.248
> 
> 
> And my questions are:
> 
> 1). Compared the output of Mode 0 (user space task) and Mode 1 (kernel
> space task), the average latency of Mode 1 is shorter. In Mode 1, the
> "timerbench" thread is running in primary mode, but what makes the
> latency in secondary mode longer?
> 

Both modes 0 and 1 exhibit threads running in primary mode. The 
difference is that mode 1 runs kernel based threads which are mostly 
seen as co-routines, whilst mode 0 runs user-space based ones. Mode 0 
involves the additional cost of dealing with full user-space context 
switches.

> 2) From the output of Mode 0, the "MSW" field of "sampling" thread is
> always 1/0, does that mean the "sampling" thread will switch to primary
> mode and keep stay in primary mode throughout the test?
> 

Yes.

> 3) In Mode 2 (timer handler in kernel space), the "lat min" and "lat
> avg" is negative, is this correct?

Yes, it only means that your pre-calibrated jitter compensation value is 
over-pessimistic, and could be lowered. This value is substracted from 
timer shot dates in order to take into account the intrinsic latency of 
your board and of Xenomai-related scheduling latency. See 
ksrc/include/asm-blackfin/calibration.h. You can override this value 
using the "timing" configuration menu.

  If it is correct, why the latency is
> much shorter than mode 1(kernel space task)?
> 

Because mode 1 measures the scheduling latency, whilst mode 2 only 
measures the interrupt latency.

> And finally a general question:
> 4) why there is RTDM? What is the design purpose?

It's a unifying, RTOS-agnostic, driver-class agnostic, API-agnostic 
framework for building real-time device drivers. It's the cornerstone of 
  Xenomai's real-time device support.

  If I were to write
> Realtime device drivers, shall I use RTDM?
> 

Yes, definitely.

> 
> Thanks,
> 
> -Li Yi
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

