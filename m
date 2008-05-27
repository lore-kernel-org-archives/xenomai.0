Date: Tue, 27 May 2008 18:11:36 +0200
Message-Id: <781147006@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Cross-Compile Xenomai
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

Hi

I finally found time to go on with my xenomai installation. 
I managed to build the drivers for the testsuite as modules and installed them. But some things still doesn't work, I think. What should i do now?

irqloop sometimes says: 
------------------------------------------------------------------------
irqloop: error starting test: Inappropriate ioctl for device
------------------------------------------------------------------------
sometimes it runs but nothing happens:
------------------------------------------------------
bash-3.00# irqbench/irqloop
Test mode:    user-space task
Port type:    serial
Port address: 0x3f8
Port IRQ:     4

Received IRQs:     0
Acknowledged IRQs: 0
bash-3.00#
------------------------------------------------------
I tried different Port IRQs but it has no effect.

switchtest
-----------------------------------------------------
bash-3.00# switchtest/switchtest -n
== Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 rtuo-8
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|        1791|        1791
RTD|        1785|        3576
RTD|        1800|        5376
RTD|        1797|        7173
RTD|        1800|        8973
RTD|        1803|       10776
RTD|        1788|       12564
RTD|        1809|       14373
RTD|        1530|       15903
bash-3.00#
-------------------------------------------------------------
I stopped it with ctrl+c because it never stops, does it?

switchbench
----------------------------------------------------
bash-3.00# switchbench/switchbench
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      -31150|        2833|       51573|       93825
bash-3.00#
---------------------------------------------------

latency
------------------------------------------------------------
bash-3.00# latency/latency -
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      15.390|      19.706|      54.080|       0|      15.390|      54.080
RTD|      12.130|      20.150|      81.790|       0|      12.130|      81.790
RTD|      15.350|      19.943|      70.800|       0|      12.130|      81.790
RTD|      15.390|      20.760|      85.400|       0|      12.130|      85.400
RTD|      15.390|      19.886|      68.830|       0|      12.130|      85.400
RTD|      15.390|      19.906|      70.750|       0|      12.130|      85.400
RTD|      15.390|      19.890|      68.960|       0|      12.130|      85.400
RTD|      15.350|      19.986|      71.450|       0|      12.130|      85.400
RTD|      15.390|      19.890|      75.100|       0|      12.130|      85.400
RTD|      15.350|      19.913|      72.440|       0|      12.130|      85.400
RTD|      15.390|      19.893|      70.720|       0|      12.130|      85.400
---|------------|------------|------------|--------|-------------------------
RTS|      12.130|      19.993|      85.400|       0|    00:00:12/00:00:12
bash-3.00#
---------------------------------------------------------------------------------------
also stopped with ctrl+c

latency -t1
------------------------------------------------------------------------------------
bash-3.00# latency/latency -t1
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|------------|------------|------------|--------|-------------------------
RTS|  267928.028|  805352.732|      32.768|       0|    00:00:40/00:00:40
bash-3.00#
------------------------------------------------------------------------------------
Doesn't it work as module?

cyclictest 
-------------------------------------------------------------------------
bash-3.00# cyclic/cyclictest -l 50000
0.00 0.06 0.07 2/19 551

T: 0 (  551) P: 0 I:    1000 C:   50000 Min:-50463972 Act:-50463972 Max: -993974
bash-3.00#
--------------------------------------------------------------------------

Greez & Thanks
Joachim


_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114


