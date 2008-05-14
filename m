Date: Wed, 14 May 2008 14:32:00 +0200
Message-Id: <752338162@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi

First I'd like to thank everybody who helped.
I think it works now (more or less).
I found someone who had the root passwort, so I could "make devices" for testing.
The tests in the testsuite also give out some things. 

Can anyone give me hints where to find documents for the following two things:

1. Something about what should be the result of the tests in the testsuite or some documents about the testsuite at all.

I get things like that:

bash-3.00# ./switchbench
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      -25970|       30476|       49003|       12491

bash-3.00# ./latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.000|      19.643|      61.780|       0|      18.000|      61.780
RTD|      14.780|      20.090|      86.570|       0|      14.780|      86.570
RTD|      17.890|      19.836|      74.070|       0|      14.780|      86.570
RTD|      17.870|      21.056|      80.750|       0|      14.780|      86.570
RTD|      17.870|      19.826|      69.910|       0|      14.780|      86.570
RTD|      18.000|      19.806|      69.380|       0|      14.780|      86.570
RTD|      17.870|      19.870|     108.270|       0|      14.780|     108.270
RTD|      16.580|      19.810|      86.050|       0|      14.780|     108.270
RTD|      17.870|      19.826|      75.160|       0|      14.780|     108.270
RTD|      17.870|      19.800|      70.520|       0|      14.780|     108.270
RTD|      17.870|      19.826|      86.640|       0|      14.780|     108.270
RTD|      17.870|      19.850|      73.890|       0|      14.780|     108.270
RTD|      17.870|      19.826|      81.730|       0|      14.780|     108.270
RTD|      17.870|      19.810|      68.730|       0|      14.780|     108.270
RTD|      17.870|      19.820|      72.030|       0|      14.780|     108.270
RTD|      17.870|      19.816|      73.430|       0|      14.780|     108.270
RTD|      17.870|      21.073|      76.690|       0|      14.780|     108.270
RTD|      15.430|      19.813|      85.030|       0|      14.780|     108.270
RTD|      17.870|      19.826|      76.680|       0|      14.780|     108.270
RTD|      17.870|      19.806|      72.320|       0|      14.780|     108.270
RTD|      17.870|      19.823|      81.160|       0|      14.780|     108.270
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)

the result of the cycletest is, that the system freezes.

bash-3.00# modprobe xeno_irqbench
FATAL: Could not load /lib/modules/2.6.23xlnx/modules.dep: No such file or directory

bash-3.00# ./switchtest
XSysAce: Queue is plugged
== Testing FPU check routines...
Illegal instruction

My PPC405 (on an Virtex 2 pro) has no FPU, I believe.
I haven't installed any modules yet, but I need modules for xenomai, do I?


2. Some Beginners Howto for programming with Xenomai

Thx 
Joachim
_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066


