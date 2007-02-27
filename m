Message-ID: <45E4646A.10205@domain.hid>
Date: Tue, 27 Feb 2007 18:03:38 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] high latency every 8 seconds
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

Hi all,

I'm installing xenomai 2.2.5 (kernel 2.6.17.14) on a number of
systems (MSI 945P, Intel P4 3Ghz). My kernel runs fine on several
other/older systems, but on the new systems there is something going
on every 8 seconds. See output of latency test below. What could
this be? Is this an SMI effect?

== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -0.234|      -0.063|       7.845|       0|      -0.234|       7.845
RTD|      -0.308|      -0.015|       8.496|       0|      -0.308|       8.496
RTD|      -0.313|      -0.014|       7.847|       0|      -0.313|       8.496
RTD|      -0.308|      -0.017|       8.502|       0|      -0.313|       8.502
RTD|      -0.424|      -0.012|       8.431|       0|      -0.424|       8.502
RTD|      -0.308|      -0.030|       8.329|       0|      -0.424|       8.502
RTD|      -0.311|      -0.012|       8.459|       0|      -0.424|       8.502
RTD|      -0.308|       0.696|    7169.625|      71|      -0.424|    7169.625
RTD|      -0.308|      -0.016|       8.351|      71|      -0.424|    7169.625
RTD|      -0.309|      -0.017|       8.421|      71|      -0.424|    7169.625
RTD|      -0.313|      -0.016|       8.340|      71|      -0.424|    7169.625
RTD|      -0.308|      -0.015|       8.395|      71|      -0.424|    7169.625
RTD|      -0.311|      -0.010|       8.607|      71|      -0.424|    7169.625
RTD|      -0.308|      -0.021|       8.450|      71|      -0.424|    7169.625
RTD|      -0.308|      -0.017|       8.401|      71|      -0.424|    7169.625
RTD|      -0.308|       0.704|    7161.139|     142|      -0.424|    7169.625
RTD|      -0.311|      -0.017|       8.349|     142|      -0.424|    7169.625
RTD|      -0.312|       0.042|       8.435|     142|      -0.424|    7169.625
RTD|      -0.318|       0.020|       8.467|     142|      -0.424|    7169.625
RTD|      -0.394|       0.335|       8.820|     142|      -0.424|    7169.625
RTD|      -0.363|       1.034|       5.484|     142|      -0.424|    7169.625
RTD|      -0.410|       0.185|       8.428|     142|      -0.424|    7169.625
RTD|      -0.312|       0.024|       8.478|     142|      -0.424|    7169.625
RTD|      -0.308|       0.728|    7060.879|     212|      -0.424|    7169.625
RTD|      -0.282|       0.016|       8.424|     212|      -0.424|    7169.625
RTD|      -0.499|       0.011|       8.490|     212|      -0.499|    7169.625

and so on...

Regards,
Theo




