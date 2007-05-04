From: CAMUS Benoit <benoit.camus@domain.hid>
Content-Type: text/plain
Date: Fri, 04 May 2007 10:40:43 +0200
Message-Id: <1178268043.5391.47.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Latencies while ethernet access
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'm using Xenomai 2.3.1 with a 2.6.19.2 kernel (from ELDK) on a custom
board based on Xscale PXA processor and with smc91c111 ethernet chip. 
I did modifications on Linux kernel to port it on board and then just
applied Adeos's patch following Xenomai's proceedings.
Http and telnet servers are running on and i notice that latencies get
really worse while i access any of them (see traces below).

I understood that Adeos might avoid that kind of behavior due to its
architecture. So i infer that the ethernet driver might access the
hardware by-passing Adeos ?
In this way and before modificate the driver, i decided to try RT driver
thanks to Rtnet project and get an oops error at device probing due to
memory mapping wich i still don't resolve.
I don't have experience with Xenomai and would apreciate any advice on
that phenomenum.

I'm a bit surprised too about gap between best and worst latencies so
i'm asking question to myself about my porting, does this gap seam
strange for you  too?

Thanks in advance and sorry for my english

Ben



/ # latency -p 10000
== Sampling period: 10000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 10000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      24.685|      25.227|      55.609|       0|      24.685|
55.609
RTD|      24.685|      25.499|      60.763|       0|      24.685|
60.763
RTD|      24.142|      26.584|      91.417|       0|      24.142|
91.417
RTD|      24.685|     204.806|     332.845|       0|      24.142|
332.845
RTD|     153.537|     230.034|     324.435|       0|      24.142|
332.845
RTD|      24.685|      68.359|     235.188|       0|      24.142|
332.845
RTD|      24.685|      25.499|      69.173|       0|      24.142|
332.845
RTD|      24.685|      24.956|      65.646|       0|      24.142|
332.845
RTD|      24.685|      26.041|      82.194|       0|      24.142|
332.845
---|------------|------------|------------|--------|-------------------------
RTS|      24.142|      72.970|     332.845|       0|
00:00:10/00:00:10

/ # latency -p 10000 -t 1
== Sampling period: 10000 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 10000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      14.269|      15.226|      44.108|       0|      14.269|
44.108
RTD|      14.269|      15.388|      44.108|       0|      14.269|
44.108
RTD|      14.269|      15.549|      37.326|       0|      14.269|
44.108
RTD|      13.997|      47.365|     134.169|       0|      13.997|
134.169 
RTD|      60.927|      94.029|     187.337|       0|      13.997|
187.337
RTD|      14.269|      25.187|     108.127|       0|      13.997|
187.337
RTD|      14.269|      16.482|      94.292|       0|      13.997|
187.337
RTD|      14.269|      15.058|      51.975|       0|      13.997|
187.337
RTD|      14.269|      15.066|      30.816|       0|      13.997|
187.337
---|------------|------------|------------|--------|-------------------------
RTS|      13.997|      28.816|     187.337|       0|
00:00:10/00:00:10

/ # latency -p 10000 -t 2
== Sampling period: 10000 us
== Test mode: in-kernel timer handler
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 10000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|       3.960|       4.144|      12.912|       0|       3.960|
12.912
RTD|       3.960|       4.369|      13.183|       0|       3.960|
13.183
RTD|       3.960|       4.404|      23.491|       0|       3.960|
23.491
RTD|       3.960|      25.707|      92.393|       0|       3.960|
92.393
RTD|       4.231|      46.546|      82.628|       0|       3.960|
92.393
RTD|       3.960|       4.204|      11.827|       0|       3.960|
92.393
RTD|       3.960|       4.391|      21.321|       0|       3.960|
92.393
---|------------|------------|------------|--------|-------------------------
RTS|       3.960|      13.395|      92.393|       0|
00:00:09/00:00:09





