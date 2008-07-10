Date: Thu, 10 Jul 2008 16:34:44 +0200
Message-Id: <870187678@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] latency in kernel mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno Carneiro Pinheiro <brenodee@domain.hid>
Cc: xenomai@xenomai.org

Hi

Sorry my answer took so long. I appreciate your offer. But I don't know mcuh about Xenomai, so the test results doesn't say much to me, perhaps you can tell me more. I was more interested to verify with the tests, that I installed Xenomai right. Here the output of some tests. Most times I used default values because, like I said before, I don't know the purpose of most tests:

I use a XUPv2p Board with an Virtex II pro (XC2VP30)
-------------------------------------------
bash-3.00# cat /proc/cpuinfo
processor       : 0
cpu             : Virtex-II Pro
clock           : 300MHz
revision        : 8.160 (pvr 2001 08a0)
bogomips        : 297.98
machine         : Xilinx XUPV2P
plb bus clock   : 100MHz
bash-3.00#
------------------------------------------

clocktest
-------------------------------------------
bash-3.00# cd clocktest/ && ./run -- -T 10 && cd ..
./run: line 1: dirname: command not found
*
*
* Type ^C to stop this application.
*
*
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0             817999.8           -0.002          0            0.0
bash-3.00#
---------------------------------------------

cyclic
----------------------------------------
bash-3.00# cd cyclic/ && ./run -- -l 50000 && cd ..
./run: line 1: dirname: command not found
*
*
* Type ^C to stop this application.
*
*
0.02 0.07 0.08 1/22 2006

T: 0 ( 2006) P:99 I:    1000 C:   49215 Min:      31 Act:     110 Avg:      43 Max:     145
bash-3.00#
--------------------------------------------


latency in both modes
------------------------------------------------------------
bash-3.00# cd latency && ./run -- -T 30 && cd ..
./run: line 1: dirname: command not found
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
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.403|      19.820|      63.993|       0|      18.403|      63.993
RTD|      17.163|      20.216|      95.543|       0|      17.163|      95.543
RTD|      18.383|      20.016|      95.523|       0|      17.163|      95.543
RTD|      16.633|      21.550|      74.733|       0|      16.633|      95.543
RTD|      18.333|      20.013|     106.983|       0|      16.633|     106.983
RTD|      18.333|      19.990|      89.173|       0|      16.633|     106.983
RTD|      18.403|      20.003|      81.633|       0|      16.633|     106.983
RTD|      18.363|      19.976|      74.103|       0|      16.633|     106.983
RTD|      18.333|      20.190|      70.833|       0|      16.633|     106.983
RTD|      18.363|      19.980|      69.953|       0|      16.633|     106.983
RTD|      18.333|      20.006|      71.613|       0|      16.633|     106.983
RTD|      18.403|      19.970|      88.343|       0|      16.633|     106.983
RTD|      18.333|      19.996|      71.413|       0|      16.633|     106.983
RTD|      18.383|      20.156|     107.603|       0|      16.633|     107.603
RTD|      18.333|      20.000|      71.473|       0|      16.633|     107.603
RTD|      18.363|      19.993|      74.183|       0|      16.633|     107.603
RTD|      18.333|      20.010|      75.823|       0|      16.633|     107.603
RTD|      18.403|      19.983|      74.233|       0|      16.633|     107.603
RTD|      18.383|      20.193|      75.563|       0|      16.633|     107.603
RTD|      18.403|      19.996|     108.583|       0|      16.633|     108.583
RTD|      18.333|      20.020|      73.563|       0|      16.633|     108.583
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      17.283|      20.020|      87.283|       0|      16.633|     108.583
RTD|      18.333|      20.250|      75.183|       0|      16.633|     108.583
RTD|      18.333|      20.166|      75.213|       0|      16.633|     108.583
RTD|      18.333|      20.020|     109.183|       0|      16.633|     109.183
RTD|      18.333|      20.003|      74.113|       0|      16.633|     109.183
RTD|      18.333|      19.996|      68.613|       0|      16.633|     109.183
RTD|      18.333|      19.983|      74.223|       0|      16.633|     109.183
RTD|      18.333|      20.196|      81.173|       0|      16.633|     109.183
---|------------|------------|------------|--------|-------------------------
RTS|      16.633|      20.093|     109.183|       0|    00:00:30/00:00:30
bash-3.00# cd latency && ./run -- -t 1 -T 30 && cd ..
./run: line 1: dirname: command not found
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       4.270|       4.961|      32.380|       0|       4.270|      32.380
RTD|       4.270|       5.166|      41.780|       0|       4.270|      41.780
RTD|       4.270|       5.038|      36.790|       0|       4.270|      41.780
RTD|       4.270|       5.880|      43.340|       0|       4.270|      43.340
RTD|       4.270|       5.552|      39.830|       0|       4.270|      43.340
RTD|       4.270|       5.050|      57.710|       0|       4.270|      57.710
RTD|       4.270|       5.050|      44.120|       0|       4.270|      57.710
RTD|       4.270|       5.048|      56.770|       0|       4.270|      57.710
RTD|       4.270|       5.039|      44.170|       0|       4.270|      57.710
RTD|       4.270|       5.528|      43.090|       0|       4.270|      57.710
RTD|       4.270|       5.045|      35.190|       0|       4.270|      57.710
RTD|       4.270|       5.033|      46.260|       0|       4.270|      57.710
RTD|       4.270|       5.040|      39.260|       0|       4.270|      57.710
RTD|       4.270|       5.046|      43.910|       0|       4.270|      57.710
RTD|       4.270|       5.065|      45.320|       0|       4.270|      57.710
RTD|       4.270|       5.030|      42.820|       0|       4.270|      57.710
RTD|       4.270|       5.043|      42.790|       0|       4.270|      57.710
RTD|       4.270|       5.035|      42.440|       0|       4.270|      57.710
RTD|       4.270|       5.047|      44.110|       0|       4.270|      57.710
RTD|       4.270|       5.057|      40.040|       0|       4.270|      57.710
RTD|       4.270|       5.033|      52.410|       0|       4.270|      57.710
RTT|  00:00:22  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       4.270|       5.041|      45.520|       0|       4.270|      57.710
RTD|       4.270|       5.143|      44.180|       0|       4.270|      57.710
RTD|       4.270|       5.030|      40.780|       0|       4.270|      57.710
RTD|       4.270|       5.542|      31.540|       0|       4.270|      57.710
RTD|       4.270|       5.037|      58.200|       0|       4.270|      58.200
RTD|       4.270|       5.054|      39.280|       0|       4.270|      58.200
RTD|       4.270|       5.039|      34.010|       0|       4.270|      58.200
RTD|       4.270|       5.043|      41.780|       0|       4.270|      58.200
---|------------|------------|------------|--------|-------------------------
RTS|       4.270|       5.128|      58.200|       0|    00:00:30/00:00:30
bash-3.00#
---------------------------------------------------------------------------------


switchbench
-----------------------------------------------------------------------------------
bash-3.00# cd switchbench/ && ./run -- -p 200 -n 100000 && cd
./run: line 1: dirname: command not found
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 200 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      43.916|      54.773|      91.860|           1
bash-3.00#
--------------------------------------------------------------------------------------


switchtest
----------------------------------------------------------------------------------
bash-3.00# cd switchtest/ && ./run -- -T 30 -n && cd ..
./run: line 1: dirname: command not found
*
*
* Type ^C to stop this application.
*
*
== Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 rtuo-8
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|        1791|        1791
RTD|        1782|        3573
RTD|        1791|        5364
RTD|        1692|        7056
RTD|        1800|        8856
RTD|        1791|       10647
RTD|        1785|       12432
RTD|        1815|       14247
RTD|        1800|       16047
RTD|        1800|       17847
RTD|        1800|       19647
RTD|        1800|       21447
RTD|        1800|       23247
RTD|        1800|       25047
RTD|        1800|       26847
RTD|        1800|       28647
RTD|        1785|       30432
RTD|        1800|       32232
RTD|        1797|       34029
RTD|        1800|       35829
RTD|        1800|       37629
RTT|  00:00:22
RTH|ctx switches|-------total
RTD|        1800|       39429
RTD|        1800|       41229
RTD|        1800|       43029
RTD|        1800|       44829
RTD|        1800|       46629
RTD|        1791|       48420
RTD|        1800|       50220
RTD|        1800|       52020
RTD|        1584|       53604
bash-3.00#
------------------------------------------------------------------------------------

Greez
Joachim
_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066


