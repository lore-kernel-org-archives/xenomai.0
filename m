Date: Thu, 1 Feb 2007 01:54:10 -0800 (PST)
From: poornima r <rpoornar@domain.hid>
Subject: Re: [Adeos-main] switchbench tests with IPIPE tracer disabled
In-Reply-To: <45C19C09.20903@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <70651.51913.qm@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

Thanks for the reply.

Linux version:linux-2.6.18
Xenomai: xenomai-2.3.0 (Stable version)
adeos patch: adeos-ipipe-2.6.18-ppc-1.5-01.patch

The tests were run as follows:
1)The sampling period in the code for latency and
switchbench was changed to 1000000000ns(to remove
overrun error) 
2)switchtest was run with -n5 option
3)cyclictest was run with  -t5 option(5 threads 
were created.)
4)cyclictest was terminated with Illegal instruction
(after creating 5 threads) with IPIPE tracer enabled.
 

These were the results without I-PIPE Tracer option:
(All the tests were run without any load)
1)LATENCY TEST:-
User mode:-
/mnt/out_xen/bin# ./latency -t0
== Sampling period: 1000000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000000 us
period, priority 99)
RTH|-----lat min|-----lat avg|-----lat
max|-overrun|----lat best|---lat worst
RTD|     167.000|     167.000|     167.000|       0|  
  167.000|     167.000
RTD|     176.000|     176.000|     176.000|       0|  
  167.000|     176.000
RTD|     168.000|     168.000|     168.000|       0|  
  167.000|     176.000
RTD|     171.000|     171.000|     171.000|       0|  
  167.000|     176.000

Kernel mode:-
root@domain.hid# ./latency -t1
== Sampling period: 1000000 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:00  (in-kernel periodic task, 1000000 us
period, priority 99)
RTH|-----lat min|-----lat avg|-----lat
max|-overrun|----lat best|---lat worst
RTD|     123.000|     123.000|     123.000|       0|  
  123.000|     123.000
RTD|     125.000|     125.000|     125.000|       0|  
  123.000|     125.000
RTD|     128.333|     128.333|     128.333|       0|  
  123.000|     128.333
RTD|     127.000|     127.000|     127.000|       0|  
  123.000|     128.333

Interrupt mode:-
root@domain.hid# ./latency -t2
== Sampling period: 1000000 us
== Test mode: in-kernel timer handler
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 1000000 us
period, priority 99)
RTH|-----lat min|-----lat avg|-----lat
max|-overrun|----lat best|---lat worst
RTD|      45.334|      45.334|      45.334|       0|  
   45.334|      45.334
RTD|      45.000|      45.000|      45.000|       0|  
   45.000|      45.334
RTD|      46.000|      46.000|      46.000|       0|  
   45.000|      46.000
RTD|      47.334|      47.334|      47.334|       0|  
   45.000|      47.334
RTD|      46.334|      46.334|      46.334|       0|  
   45.000|      47.334

2)CYCLICTEST RESULTS:-
root@domain.hid# ./cyclictest -t5
5.14 3.71 1.72 6/31 216

T: 0 (    0) P:99 I:    1000 C:       0 Min: 1000000
Act:       0 Avg:       0 Max:-1000000
T: 1 (    0) P:98 I:    1500 C:       0 Min: 1000000
Act:       0 Avg:       0 Max:-1000000
T: 2 (  212) P:97 I:    2000 C:    8112 Min:     169
Act:     189 Avg:     204 Max:     288
T: 3 (    0) P:96 I:    2500 C:       0 Min: 1000000
Act:       0 Avg:       0 Max:-1000000
T: 4 (  216) P:95 I:    3000 C:   21596 Min:     180
Act:    1279 Avg:     702 Max:    1336

3)SWITCHBENCH TEST RESULTS:-
root@domain.hid# ./switchbench -n5
== Sampling period: 1000000 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|       
lost
RTD|     229.333|      45.666|     229.333|          
0

Test results with IPIPE tracer enabled
1)LATENCY TEST RESULTS:-
User mode:-
root@domain.hid# ./latency -t0
== Sampling period: 1000000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000000 us
period, priority 99)
RTH|-----lat min|-----lat avg|-----lat
max|-overrun|----lat best|---lat worst
RTD|     340.000|     340.000|     340.000|       0|  
  340.000|     340.000
RTD|     338.666|     338.666|     338.666|       0|  
  338.666|     340.000
RTD|     341.000|     341.000|     341.000|       0|  
  338.666|     341.000
RTD|     342.000|     342.000|     342.000|       0|  
  338.666|     342.000

2)kernel mode:-
root@domain.hid# ./latency -t1
== Sampling period: 1000000 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:00  (in-kernel periodic task, 1000000 us
period, priority 99)
RTH|-----lat min|-----lat avg|-----lat
max|-overrun|----lat best|---lat worst
RTD|     303.333|     303.333|     303.333|       0|  
  303.333|     303.333
RTD|     309.666|     309.666|     309.666|       0|  
  303.333|     309.666
RTD|     325.000|     325.000|     325.000|       0|  
  303.333|     325.000
RTD|     306.333|     306.333|     306.333|       0|  
  303.333|     325.000

Interrupt mode:-
root@domain.hid# ./latency -t2
== Sampling period: 1000000 us
== Test mode: in-kernel timer handler
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 1000000 us
period, priority 99)
RTH|-----lat min|-----lat avg|-----lat
max|-overrun|----lat best|---lat worst
RTD|     153.334|     153.334|     153.334|       0|  
  153.334|     153.334
RTD|     154.667|     154.667|     154.667|       0|  
  153.334|     154.667
RTD|     164.334|     164.334|     164.334|       0|  
  153.334|     164.334
RTD|     154.667|     154.667|     154.667|       0|  
  153.334|     164.334
RTD|     163.667|     163.667|     163.667|       0|  
  153.334|     164.334

2)CYCLICTEST RESULTS:-
root@domain.hid# ./cyclictest -t5
0.18 0.15 0.09 3/26 194

T: 0 (    0) P:99 I:    1000 C:       0 Min: 1000000
Act:       0 Avg:       0 Max:-1000000
T: 1 (    0) P:98 I:    1500 C:       0 Min: 1000000
Act:       0 Avg:       0 Max:-1000000
T: 2 (  190) P:97 I:    2000 C:       0 Min: 1000000
Act:       0 Avg:       0 Max:-1000000
T: 3 (    0) P:96 I:    2500 C:       0 Min: 1000000
Act:       0 Avg:       0 Max:-1000000
T: 4 (  193) P:95 I:    3000 C:       0 Min: 1000000
Act:       0 Avg:       0 Max:-1000000
Illegal instruction

3)SWITCHBENCHTEST RESULTS:-
root@domain.hid# ./switchbench -n5
== Sampling period: 1000000 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|       
lost
RTD|     667.333|     133.333|     667.333|          
0


SWITCHTEST:-
Since FPU is not enabled for ppc, I was not able to
get proper results for switchtest. Please mail the
results of switchtest. 

Thanks,
Poornima


--- Wolfgang Grandegger <wg@domain.hid> wrote:

> poornima r wrote:
> > Hi,
> > 
> > I was able to run latency and switchbench tests on
> > MPC860 board with IPIPE tracer feature
> > enabled/disabled.
> 
> Nice, what versions of Linux and Xenomai did you use
> for your tests? It 
> is known that Linux 2.6 does not yet work properly
> for 8xx. It would 
> also be nice if you could briefly post your results
> on this list as well.
> 
> > Interrupt & scheduling Latencies and switching
> > latencies (with IPIPE tracer option disabled) were
> > having lower values when compared to latency
> values
> > with IPIPE tracer enabled. 
> 
> The ipipe tracer introduces some overhead (extra
> code) and as this CPU 
> is very slow, you will notice it.
> 
> > cyclictest test results were same with or without
> > IPIPE tracer enabled. 
> 
> Your results would really be of interest.
> 
> > Is this reduced context switching latency in
> > switchbench test due to timer interrupt?  
> 
> Likely it also due to overhead introduced by the
> ipipe tracer.
> 
> BTW: the switchtest should run as well with the
> option "-n" (for not 
> using the FPU),
> 
> Wolfgang.
> 
> 



 
____________________________________________________________________________________
8:00? 8:25? 8:40? Find a flick in no time 
with the Yahoo! Search movie showtime shortcut.
http://tools.search.yahoo.com/shortcuts/#news

