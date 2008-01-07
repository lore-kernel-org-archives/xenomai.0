Message-ID: <f8f856500801070737s2934e741i99717c5b2a2d3d88@domain.hid>
Date: Mon, 7 Jan 2008 16:37:58 +0100
From: fabien <fabien.fb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Xenomai latency tests on MPC8xx
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

Here, there is some xenomai tests on a MPC855T, could you comment
these results please ?
Are they correct ?

# cat cpuinfo
processor       : 0
cpu             : 8xx
clock           : 50MHz
bus clock       : 50MHz
revision        : 0.0 (pvr 0050 0000)
bogomips        : 48.38

The kernel is a 2.6.23-6 (ppc branch) from DENX git repository,
Xenomai 2.4.0, and adeo-ipipe patch :
adeos-ipipe-2.6.23-ppc-1.6-00.patch.

I'm new in realtime system and xenomai so i have also some questions :
First, what's the purpose of the cyclic and switchbench test ?
How could i interpret the results of switchtest ?
And finaly, it's seem there is something wrong with irqloop test, but what ?

First, tests without load :

# ./latency -t0 -p1000 -T30
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      75.520|      84.480|     128.640|       0|      75.520|     128.640
RTD|      75.520|      86.080|     136.960|       0|      75.520|     136.960
[...]
RTS|      75.520|      86.080|     185.920|       0|    00:00:30/00:00:30

# ./latency -t1 -p1000 -T30
== Sampling period: 1000 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      56.960|      66.118|      92.800|       0|      56.960|      92.800
RTD|      56.960|      66.777|     106.240|       0|      56.960|     106.240
RTD|      56.960|      66.037|     136.640|       0|      56.960|     136.640
[...]
RTS|      56.960|      66.308|     149.440|       0|    00:00:30/00:00:30

# ./latency -t2 -p1000 -T30
== Sampling period: 1000 us
== Test mode: in-kernel timer handler
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.560|      20.938|      34.880|       0|      18.560|      34.880
RTD|      18.560|      21.446|      45.760|       0|      18.560|      45.760
[...]
RTS|      18.560|      21.320|     118.400|       0|    00:00:30/00:00:30

# ./cyclictest -t5 -l 30000
T: 0 (   64) P:99 I:    1000 C:   30000 Min:      97 Act:     138 Avg:
    127 Max:     180
T: 1 (   65) P:98 I:    1500 C:   30000 Min:      97 Act:     101 Avg:
    195 Max:     431
T: 2 (   66) P:97 I:    2000 C:   30000 Min:      97 Act:     138 Avg:
    290 Max:     660
T: 3 (   67) P:96 I:    2500 C:   25569 Min:      95 Act:     881 Avg:
    286 Max:     881
T: 4 (   68) P:95 I:    3000 C:   21308 Min:      96 Act:     168 Avg:
    552 Max:    1354

# ./switchbench -n10000 -p 1000
== Sampling period: 1000 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|     137.920|     143.040|     160.640|           0

# ./switchtest -T30 -n
== Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 rtuo-8
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|         999|         999
RTD|         993|        1992
RTD|        1005|        2997
RTD|         999|        3996
RTD|         993|        4989
RTD|        1005|        5994
RTD|         999|        6993
RTD|         990|        7983
RTD|         993|        8976
RTD|        1005|        9981
RTD|         999|       10980
[...]

# insmod ./xeno_irqbench.ko
# ./irqloop -t0
irqloop: error starting test: Inappropriate ioctl for device
Xenomai: POSIX: destroyed thread c03a0e10
# lsmod
Module                  Size  Used by    Not tainted
xeno_irqbench           9788  -
xeno_posix            179428  -
xeno_switchtest         8704  -
xeno_rtdm              30572  -
#



----
Now tests with load : dd if=/dev/zero of=/dev/null
----

# ./latency -t0 -p1000 -T30
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|     108.160|     119.680|     133.760|       0|     108.160|     133.760
RTD|     115.840|     120.000|     154.240|       0|     108.160|     154.240
[...]
RTS|      95.040|     119.680|     202.880|       0|    00:00:30/00:00:30

# ./latency -t1 -p1000 -T30
== Sampling period: 1000 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      65.920|      73.409|     100.480|       0|      65.920|     100.480
RTD|      65.920|      74.055|     107.840|       0|      65.920|     107.840
RTD|      65.920|      73.954|     100.800|       0|      65.920|     107.840
[...]
RTS|      65.920|      73.868|     132.480|       0|    00:00:30/00:00:30

# ./latency -t2 -p1000 -T30
== Sampling period: 1000 us
== Test mode: in-kernel timer handler
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      21.120|      25.826|      39.680|       0|      21.120|      39.680
RTD|      21.120|      26.073|      39.360|       0|      21.120|      39.680
[...]
RTS|      20.800|      25.987|      54.400|       0|    00:00:30/00:00:30

# ./cyclictest -t5 -l 30000
T: 0 (   68) P:99 I:    1000 C:   30000 Min:      96 Act:     135 Avg:
    144 Max:     177
T: 1 (   69) P:98 I:    1500 C:   30000 Min:      96 Act:     130 Avg:
    216 Max:     483
T: 2 (   70) P:97 I:    2000 C:   30000 Min:     128 Act:     133 Avg:
    313 Max:     704
T: 3 (   71) P:96 I:    2500 C:   30000 Min:      98 Act:     136 Avg:
    292 Max:     932
T: 4 (   72) P:95 I:    3000 C:   30000 Min:     127 Act:     135 Avg:
    470 Max:    1378

# ./switchbench -n10000 -p 1000
== Sampling period: 1000 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|     144.960|     156.160|     162.240|           0

# ./switchtest -T30 -n
== Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 rtuo-8
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|         999|         999
RTD|         993|        1992
RTD|        1005|        2997
RTD|         999|        3996
RTD|        1008|        5004
RTD|         993|        5997
RTD|        1005|        7002
RTD|         999|        8001
RTD|         999|        9000
RTD|         999|        9999
RTD|         993|       10992



Thanks a lot
Fabien

