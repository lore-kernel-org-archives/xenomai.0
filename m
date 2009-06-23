Mime-Version: 1.0
Date: Tue, 23 Jun 2009 16:25:10 +0530
Message-ID: <1245754510.25830.5.camel@domain.hid>
From: Shashank Bhatia <shashank.bhatia@domain.hid>
content-type: text/plain
content-transfer-encoding: 7bit
Subject: [Xenomai-core] Regarding latency benchmarks
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai Help <xenomai@xenomai.org>

Dear All,

I was trying all latency benchmark programs, in one such session, i had
loaded my linux with some program which will read the hard drive to
create an iso image. This program had taken my Dual core processor to
100%. And both core showed up 100% in gnome-system-monitor.

While this was running, i tried the klatency benchmarks, i got some
strange results :

root@domain.hid# ./run 
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:00  (in-kernel periodic task, 100 us period, priority 99)
RTH|-lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat 
RTD| -2.593|      -2.410|       2.229|       0|      -2.593|       2.229
RTD|100.000|       0.001|       0.000|   -2590|      -2.411|      -0.001
RTD| -4.821|    2419.968|      -0.001|   -2590|      -2.411|      -0.001
RTD|100.000|       0.001|       0.000|   -2585|      -2.381|      -0.001
RTD| -7.202|    2419.968|      -0.001|   -2585|      -2.381|      -0.001
RTD|100.000|       0.001|       0.000|   -2585|      -2.405|      -0.001
RTD| -9.607|    2419.968|      -0.001|   -2585|      -2.405|      -0.001
RTD|100.000|       0.001|       0.000|   -2587|      -2.380|      -0.001
RTD|-11.987|    2419.968|      -0.001|   -2587|      -2.380|      -0.001
RTD|100.000|       0.001|       0.000|   -2579|      -2.360|      -0.001
RTD|-14.347|    2419.968|      -0.001|   -2579|      -2.360|      -0.001
RTD|100.000|       0.001|       0.000|   -2598|      -2.359|      -0.001
RTD|-16.706|    2419.968|      -0.001|   -2598|      -2.359|      -0.001
RTD|100.000|       0.001|       0.000|   -2588|      -2.373|      -0.001
RTD|-19.079|    2419.968|      -0.001|   -2588|      -2.373|      -0.001
RTD|100.000|       0.001|       0.000|   -2668|      -2.397|      -0.001
RTD|-21.476|    2419.968|      -0.001|   -2668|      -2.397|      -0.001
RTD|100.000|       0.001|       0.000|   -2589|      -2.405|      -0.001
RTD|-23.881|    2419.968|      -0.001|   -2589|      -2.405|      -0.001
RTD|100.000|       0.001|       0.000|   -2588|      -2.406|      -0.001
RTD|-26.287|    2419.968|      -0.001|   -2588|      -2.406|      -0.001


Then i tried the same with user space latency benchmarks, and these are
the results i got:
root@domain.hid# ./run 
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|--lat min|-----lat avg|-----lat max|-overrun|----lat best|---worst
RTD| -0.851|      -0.165|       8.607|       0|      -0.851|       8.607
RTD| -0.861|      -0.297|       8.141|       0|      -0.861|       8.607
RTD| -0.876|      -0.357|       6.562|       0|      -0.876|       8.607
RTD| -0.881|      -0.367|      10.051|       0|      -0.881|      10.051
RTD| -0.871|      -0.214|       6.487|       0|      -0.881|      10.051
RTD| -0.866|      -0.246|       9.038|       0|      -0.881|      10.051
RTD| -0.871|      -0.247|      10.677|       0|      -0.881|      10.677
RTD| -0.886|      -0.307|      10.597|       0|      -0.886|      10.677
RTD| -0.840|      -0.251|      11.880|       0|      -0.886|      11.880
RTD| -0.861|      -0.301|       8.873|       0|      -0.886|      11.880
RTD| -1.081|      -0.415|       6.582|       0|      -1.081|      11.880
RTD| -0.891|      -0.395|       7.925|       0|      -1.081|      11.880
RTD| -0.896|      -0.352|       8.622|       0|      -1.081|      11.880
RTD| -0.896|      -0.398|       9.259|       0|      -1.081|      11.880
RTD| -0.881|      -0.287|       7.459|       0|      -1.081|      11.880
RTD| -0.891|      -0.155|      10.081|       0|      -1.081|      11.880
RTD| -0.871|      -0.147|       8.572|       0|      -1.081|      11.880
RTD| -0.861|      -0.232|       6.432|       0|      -1.081|      11.880
RTD| -0.876|      -0.397|      12.181|       0|      -1.081|      12.181
RTD| -0.881|      -0.397|       6.858|       0|      -1.081|      12.181
RTD| -0.886|      -0.349|       6.667|       0|      -1.081|      12.181



My CPU is a dual core intel processor 1.8 GHz, and i am using
xenomai-2.4.8 with 2.6.28.9 kernel.


-Shashank


-------------------------------------
Hi-Tech Gears Limited, Gurgaon, India





