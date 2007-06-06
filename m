Message-ID: <1181140977.4666c7f17f634@domain.hid>
Date: Wed, 06 Jun 2007 16:42:57 +0200
From: garryt <garryt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] xenomai for mach-imx.
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

Hello,

I have compiled xenomai for an mach-imx (MC9328 MX-1) with ipipe 1.7-03. =
This
include small modifications to files according to the =93adapting ARM I-p=
ipe patch
to a new board=94 Documentation taht i could provide 4 sure.
By the way there is an additional __ipipe_mach_get_tscinfo function to de=
fine..

ipipe is 1.7-03, Linux kernel is 2.6.20 and xenomai from svn trunk.

I then run the testsuite to be sure that it is ok...Could someone on this=
 list
tell me if these results are valid and similar to close architecture ?
Unfortunately i only have this board and nothing to compare to...

By the way would it be a possible "idea" to create a repository of result=
s of
testsuite prgs on different architure ( with no load for example ? ) from=
 people
on this list ? I have looked with no success for that...

Anyway here are the results from various tests that I run for only few se=
conds,
but further testing shows me this is stable.

All these tests were performed with no extra load...

--------------------------------------------
# arm-latency -t 0 -T 10 -p 1000
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|       7.312|     101.812|     107.750|       0|       7.312|     107=
.750
RTD|       7.187|      46.750|     108.625|       0|       7.187|     108=
.625
RTD|       7.187|      45.500|     113.437|       0|       7.187|     113=
.437
RTD|       6.937|      44.812|     107.875|       0|       6.937|     113=
.437
RTD|       6.937|      43.562|     112.750|       0|       6.937|     113=
.437
RTD|       7.187|      42.875|     108.562|       0|       6.937|     113=
.437
RTD|       6.937|      41.687|     114.375|       0|       6.937|     114=
.375
RTD|       7.187|      41.000|     107.937|       0|       6.937|     114=
.375
RTD|       6.937|      39.875|     111.000|       0|       6.937|     114=
.375
---|------------|------------|------------|--------|---------------------=
----
RTS|       6.937|      49.750|     114.375|       0|    00:00:10/00:00:10

# arm-latency -t 1 -T 10 -p 1000
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|       3.312|       3.735|      44.125|       0|       3.312|      44=
.125
RTD|       3.312|       3.769|      43.687|       0|       3.312|      44=
.125
RTD|       3.312|       3.843|      43.687|       0|       3.312|      44=
.125
RTD|       3.312|       3.741|      43.687|       0|       3.312|      44=
.125
RTD|       3.312|       3.823|      44.125|       0|       3.312|      44=
.125
RTD|       3.375|       3.742|      43.750|       0|       3.312|      44=
.125
RTD|       3.375|       3.822|      44.250|       0|       3.312|      44=
.250
RTD|       3.312|       3.777|      43.625|       0|       3.312|      44=
.250
RTD|       3.312|       3.821|      43.875|       0|       3.312|      44=
.250
---|------------|------------|------------|--------|---------------------=
----
RTS|       3.312|       3.785|      44.250|       0|    00:00:10/00:00:10


# arm-latency -t 2 -T 10 -p 1000
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: in-kernel timer handler
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat w=
orst
RTD|      -3.500|      -3.385|      16.125|       0|      -3.500|      16=
.125
RTD|      -3.500|      -3.327|      16.063|       0|      -3.500|      16=
.125
RTD|      -3.562|      -3.337|      16.063|       0|      -3.562|      16=
.125
RTD|      -3.500|      -3.341|      15.938|       0|      -3.562|      16=
.125
RTD|      -3.562|      -3.333|      16.125|       0|      -3.562|      16=
.125
RTD|      -3.500|      -3.339|      16.563|       0|      -3.562|      16=
.563
RTD|      -3.500|      -3.342|      16.125|       0|      -3.562|      16=
.563
RTD|      -3.562|      -3.341|      16.000|       0|      -3.562|      16=
.563
RTD|      -3.500|      -3.336|      16.188|       0|      -3.562|      16=
.563
---|------------|------------|------------|--------|---------------------=
----
RTS|      -3.562|      -3.342|      16.563|       0|    00:00:10/00:00:10

?? <0 results ?? is there a particular meaning to this...

# ./arm-cyclictest -l 20000
0.00 0.00 0.00 1/24 290

T: 0 (  290) P:99 I:    1000 C:   20000 Min:      12 Act:      12 Avg:   =
   21 1
Xenomai: POSIX: destroyed thread c0c01320


# arm-switchbench
=3D=3D Sampling period: 100 us
=3D=3D Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      15.625|       7.625|      83.187|       51470

# arm-switchbench -n 20000
=3D=3D Sampling period: 100 us
=3D=3D Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      14.875|       6.000|      32.937|       12422

almost lost??

# arm-switchbench -n 20000 -p 300
=3D=3D Sampling period: 300 us
=3D=3D Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      15.625|      48.312|      89.062|           0

# arm-switchtest -n
=3D=3D Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 =
rtuo-8
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|         900|         900
RTD|         909|        1809
RTD|         903|        2712
RTD|         906|        3618
RTD|         909|        4527
RTD|         909|        5436
RTD|         909|        6345
RTD|         900|        7245
RTD|         900|        8145
RTD|         900|        9045
RTD|         909|        9954
RTD|         333|       10287
Xenomai: POSIX: destroyed thread c0c00b20

Thanks for your answer, this mail is long, sorry ;)







