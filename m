Date: Mon, 28 Dec 2009 00:50:40 +0800 (CST)
From: robert165 <robert165@domain.hid>
Message-ID: <27218735.319731261932640576.JavaMail.coremail@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_82841_13262078.1261932640576"
Subject: [Xenomai-help] test result on at91rm9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_82841_13262078.1261932640576
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

Hi,
I have tested xenomai on my at91rm9200 board, I used
xenomai 2.4.10 + linux-2.6.28 + adeos-ipipe-2.6.28-arm-1.12-05.patch
Test result seems very poor, is that correct?
And is there any introduction of the tests, as their purper, their meanling...

Test is under loads as followed,
    dd if=/dev/zero of=/dev/null > /dev/null &
    ping 172.18.23.10 > /dev/null &
    while ls; do ls; done > /dev/null &
Test info are:
running: cat /proc/cpuinfo
Processor    : ARM920T rev 0 (v4l)
BogoMIPS    : 89.53
Features    : swp half 
CPU implementer    : 0x41
CPU architecture: 4T
CPU variant    : 0x1
CPU part    : 0x920
CPU revision    : 0

Hardware    : Atmel AT91RM9200-DK
Revision    : 0000
Serial        : 0000000000000000

Thu Jan  1 00:15:21 UTC 1998
running: ./run -- -p 1000 -T 180 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
RTS|      12.286|      64.102|     158.119|       0|    00:03:00/00:03:00

Thu Jan  1 00:18:29 UTC 1998
running: ./run -- -p 1000 -T 180 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 1000 us
== Test mode: in-kernel periodic task
== All results in microseconds
RTS|       5.298|      40.892|     123.382|       0|    00:03:00/00:03:00

Thu Jan  1 00:21:37 UTC 1998
running: ./run -- -p 1000 -T 180 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 1000 us
== Test mode: in-kernel timer handler
== All results in microseconds
RTS|      -3.750|      11.424|      66.755|       0|    00:03:00/00:03:00

Thu Jan  1 00:24:45 UTC 1998
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
== Testing FPU check routines...
== FPU check routines: unimplemented, skipping FPU switches tests.
== Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 rtuo-8
...
RTD|        1161|      133272
RTD|        1152|      134424
RTD|        1143|      135567
RTD|        1137|      136704
RTD|         432|      137136

Thu Jan  1 00:26:53 UTC 1998
running: ./run -- -p 1000 # switchbench
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 1000 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      17.094|      45.940|     111.111|           0

Thu Jan  1 00:28:39 UTC 1998
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
3.68 3.49 2.28 5/32 15633  


Thanks for helps!

regards 
Robert

------=_Part_82841_13262078.1261932640576
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: 7bit

<div>Hi,<br>I have tested xenomai on my at91rm9200 board, I used<br>xenomai 2.4.10 + linux-2.6.28 + adeos-ipipe-2.6.28-arm-1.12-05.patch<br>Test result seems very poor, is that correct?<br>And is there any introduction of the tests, as their purper, their meanling...<br><br>Test is under loads as followed,<br>&nbsp;&nbsp;&nbsp; dd if=/dev/zero of=/dev/null &gt; /dev/null &amp;<br>&nbsp;&nbsp;&nbsp; ping 172.18.23.10 &gt; /dev/null &amp;<br>&nbsp;&nbsp;&nbsp; while ls; do ls; done &gt; /dev/null &amp;<br>Test info are:<br>running: cat /proc/cpuinfo<br>Processor&nbsp;&nbsp;&nbsp; : ARM920T rev 0 (v4l)<br>BogoMIPS&nbsp;&nbsp;&nbsp; : 89.53<br>Features&nbsp;&nbsp;&nbsp; : swp half <br>CPU implementer&nbsp;&nbsp;&nbsp; : 0x41<br>CPU architecture: 4T<br>CPU variant&nbsp;&nbsp;&nbsp; : 0x1<br>CPU part&nbsp;&nbsp;&nbsp; : 0x920<br>CPU revision&nbsp;&nbsp;&nbsp; : 0<br><br>Hardware&nbsp;&nbsp;&nbsp; : Atmel AT91RM9200-DK<br>Revision&nbsp;&nbsp;&nbsp; : 0000<br>Serial&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 0000000000000000<br><br>Thu Jan&nbsp; 1 00:15:21 UTC 1998<br>running: ./run -- -p 1000 -T 180 -t0 # latency<br>*<br>*<br>* Type ^C to stop this application.<br>*<br>*<br>== Sampling period: 1000 us<br>== Test mode: periodic user-mode task<br>== All results in microseconds<br>RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.286|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64.102|&nbsp;&nbsp;&nbsp;&nbsp; 158.119|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; 00:03:00/00:03:00<br><br>Thu Jan&nbsp; 1 00:18:29 UTC 1998<br>running: ./run -- -p 1000 -T 180 -t1 # latency<br>*<br>*<br>* Type ^C to stop this application.<br>*<br>*<br>== Sampling period: 1000 us<br>== Test mode: in-kernel periodic task<br>== All results in microseconds<br>RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.298|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 40.892|&nbsp;&nbsp;&nbsp;&nbsp; 123.382|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; 00:03:00/00:03:00<br><br>Thu Jan&nbsp; 1 00:21:37 UTC 1998<br>running: ./run -- -p 1000 -T 180 -t2 # latency<br>*<br>*<br>* Type ^C to stop this application.<br>*<br>*<br>== Sampling period: 1000 us<br>== Test mode: in-kernel timer handler<br>== All results in microseconds<br>RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.750|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11.424|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 66.755|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp; 00:03:00/00:03:00<br><br>Thu Jan&nbsp; 1 00:24:45 UTC 1998<br>running: ./run -- -T 120 # switchtest<br>*<br>*<br>* Type ^C to stop this application.<br>*<br>*<br>== Testing FPU check routines...<br>== FPU check routines: unimplemented, skipping FPU switches tests.<br>== Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 rtuo-8<br>...<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1161|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 133272<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1152|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 134424<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1143|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 135567<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1137|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 136704<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 432|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 137136<br><br>Thu Jan&nbsp; 1 00:26:53 UTC 1998<br>running: ./run -- -p 1000 # switchbench<br>*<br>*<br>* Type ^C to stop this application.<br>*<br>*<br>== Sampling period: 1000 us<br>== Do not interrupt this program<br>RTH|&nbsp;&nbsp;&nbsp;&nbsp; lat min|&nbsp;&nbsp;&nbsp;&nbsp; lat avg|&nbsp;&nbsp;&nbsp;&nbsp; lat max|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lost<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17.094|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45.940|&nbsp;&nbsp;&nbsp;&nbsp; 111.111|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br><br>Thu Jan&nbsp; 1 00:28:39 UTC 1998<br>running: ./run -- -p 10 -n -l 1000 # cyclictest<br>*<br>*<br>* Type ^C to stop this application.<br>*<br>*<br>3.68 3.49 2.28 5/32 15633&nbsp; <br><br><br>Thanks for helps!<br><br>regards <br>Robert<br></div><br><br><span title="neteasefooter"/></span>
------=_Part_82841_13262078.1261932640576--


