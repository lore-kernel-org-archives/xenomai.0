Message-ID: <2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>
Date: Wed, 23 Jan 2008 11:04:23 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <20080123065221.GB6573@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080123065221.GB6573@domain.hid>
Subject: Re: [Xenomai-help] AT91SAM9260 latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

On Jan 23, 2008 7:52 AM, Juan Antonio Garcia Redondo
<juan-antonio.garcia@domain.hid> wrote:
> Hi list,
>
> These are my latency results over a custom board based on AT91SAM9260.
>
> Environment:
>         kernel 2.6.20 + xenomai 2.4.0
>         Load: dd if=/dev/zero of=/dev/null plus an external ping -f to
>         stress the ethernet.
>
> The results:
> running: ./run -- -p 500 -T 60 -t0 # latency
>
> == Sampling period: 500 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 500 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|      45.747|      62.177|      78.286|       0|      45.747|      78.286
> .............................................................................
> RTD|      39.948|      61.211|      78.286|       0|      39.304|      88.273
> ---|------------|------------|------------|--------|-------------------------
> RTS|      39.304|      61.855|      88.273|       0|    00:01:00/00:01:00
>
> Thu Mar 30 01:51:36 UTC 2000
> running: ./run -- -p 500 -T 60 -t1 # latency
> == Sampling period: 500 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel periodic task, 500 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|      19.007|      31.731|      43.813|       0|      19.007|      43.813
> .............................................................................
> ---|------------|------------|------------|--------|-------------------------
> RTS|      13.501|      31.126|      71.188|       0|    00:01:00/00:01:00
>
> Thu Mar 30 01:52:52 UTC 2000
> running: ./run -- -p 500 -T 60 -t2 # latency
> *
> *
> * Type ^C to stop this application.
> *
> *
> == Sampling period: 500 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel timer handler, 500 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> .............................................................................
> ---|------------|------------|------------|--------|-------------------------
> RTS|      -0.977|       8.521|      28.337|       0|    00:01:00/00:01:00
>
> Thu Mar 30 01:54:07 UTC 2000
> running: ./run -- -T 120 # switchtest
> == Testing FPU check routines...
> == FPU check routines: unimplemented, skipping FPU switches tests.
> == Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 rtuo-8
> RTT|  00:00:01
> RTH|ctx switches|-------total
> RTD|         756|         756
> ..............................
> RTD|         723|       87717
> RTD|         762|       88479
> RTD|         750|       89229
> RTD|          42|       89271
>
> Thu Mar 30 01:56:22 UTC 2000
> running: ./run -- -p500 -h # switchbench
> == Sampling period: 500 us
> == Do not interrupt this program
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|      47.358|      52.512|      68.298|           0
> ---|---range-|---samples
> HSD| 47 - 48 |          1
> HSD| 48 - 49 |          5
> HSD| 49 - 50 |          6
> HSD| 50 - 51 |       2065
> HSD| 51 - 52 |      22440
> HSD| 52 - 53 |      41582
> HSD| 53 - 54 |      19749
> HSD| 54 - 55 |      11696
> HSD| 55 - 56 |       2131
> HSD| 56 - 57 |          1
> HSD| 60 - 61 |          1
> HSD| 62 - 63 |          1
> HSD| 63 - 64 |         21
> HSD| 64 - 65 |         95
> HSD| 65 - 66 |        107
> HSD| 66 - 67 |         63
> HSD| 67 - 68 |         29
> HSD| 68 - 69 |          3
> HSS|     99996|     52.271|      1.278
>
> Thu Mar 30 01:57:25 UTC 2000
> running: ./run -- -p 10 -n -l 1000 # cyclictest
>
> T: 0 (    0) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
>  [3A1.30 1.01 0.63 2/33 2107
>
> ...........................................................................................
>
> T: 0 ( 2107) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
>  [3A1.30 1.01 0.63 2/33 2107
>
> T: 0 ( 2107) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
>  [3A1.30 1.01 0.63 2/33 2107
>
> T: 0 ( 2107) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
>  [3A1.30 1.01 0.63 2/33 2107
>
> T: 0 ( 2107) P:10 I:    1000 C:      19 Min:      45 Act:      45 Avg:      69 Max:      78
>  [3A1.30 1.01 0.63 2/33 2107
>
> ...........................................................................................
>
> T: 0 ( 2107) P:10 I:    1000 C:     999 Min:      39 Act:      48 Avg:      65 Max:      84
>
> I see everything OK except for the first samples of cyclictests. Any comments ?

The load you apply does not load the cache, which is a source of
jitter. You should run the cache calibrator (I do not find the cache
calibrator URL, but it is somewhere in Xenomai distribution or wiki).

>
> Gilles, I've read your comments on adeos list about the performance
> problems which you have to solve before upgrading to 2.6.23. Any news ?
> Could you tell me if the above numbers shows the perfomance problem or
> if I have to do another kind of test to reproduce it ?

I gave news about this issue on xenomai-core mailing list.
Unfortunately, there is no spurious masking section, the big masking
section is the one which takes place around Xenomai user-space context
switches. So, we can only improve interrupt latency, the only way to
improve scheduling latency is to avoid user-space real-time.

>
> Regards,
>         Juan Antonio
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>



-- 
                                               Gilles Chanteperdrix

