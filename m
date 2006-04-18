Message-ID: <009601c662f1$f164e700$1701a8c0@domain.hid>
From: "Kiichi Kameda" <k-kameda@domain.hid>
Date: Tue, 18 Apr 2006 23:11:10 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai port to SH4
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


I have been porting Xenomai-2.0.2 to SH(SuperH) architecture.
Currently almost all functions work well. And, I am mesuring the performance
from user-space program using posix skin on a 240MHz SH7750R(SH4) machine,
mainly 1 ms periodic dispatch latency. The measured data shows small
latency(tens of micro seconds) when system has a light workload.
In case of heavy workload such as frequent linux command input, the latency
increases to some 200 micro seconds, though.

Following is the testsuit/latency/latency program(using native skin -
slightly modified) output with comment.
In case of posix skin, the data shows similar tendency.

RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
...(no workload)
RTD|         333|        1400|        9733|       0|         333|
27066
RTD|         333|        1466|       34533|       0|         333|
34533
RTD|         266|        1400|       14533|       0|         266|
34533
RTD|         400|        1400|       14466|       0|         266|
34533
RTD|         333|        1333|        7533|       0|         266|
34533
RTD|         266|        1400|       14333|       0|         266|
34533
RTD|         333|        1400|       40866|       0|         266|
40866
RTD|         333|        1466|       25533|       0|         266|
40866
RTD|         266|        1400|       14400|       0|         266|
40866
RTD|         400|        1400|       13600|       0|         266|
40866
RTD|         266|        1400|        7466|       0|         266|
40866
RTD|         333|        1466|       40800|       0|         266|
40866
RTD|         333|        1400|       18466|       0|         266|
40866
RTD|         333|        1400|       13533|       0|         266|
40866
...
RTD|         333|        1333|        7133|       0|         266|
40866
(telnet login)
RTD|         266|        4400|      111000|       0|         266|
111000
RTD|         333|        1400|       27266|       0|         266|
111000
RTD|         333|        1466|       28000|       0|         266|
111000

RTD|         333|        1466|       33133|       0|         266|
111000
RTD|         333|        1466|       26800|       0|         266|
111000
(single ps aux command)
RTD|         333|       22800|      112533|       0|         266|
112533
RTD|         333|        1400|       19400|       0|         266|
112533
RTD|         266|        1466|       35000|       0|         266|
112533
RTD|         333|        1400|        7533|       0|         266|
112533
RTD|         333|        1400|       15733|       0|         266|
112533
RTD|         266|        1866|       71333|       0|         266|
112533
RTD|         333|        9866|      105866|       0|         266|
112533
RTD|         266|        1400|       14400|       0|         266|
112533

RTD|         266|        1400|       11266|       0|         266|
112533
RTD|         400|        1466|       50133|       0|         266|
112533
RTD|         333|        3066|      116866|       0|         266|
116866
(successive ps aux command)
RTD|        1266|       15933|      218866|       0|         266|
218866
RTD|        1266|        2400|       76666|       0|         266|
218866
RTD|         333|        1400|       15000|       0|         266|
218866
RTD|         266|        1400|       27600|       0|         266|
218866
RTD|         400|        1400|       15333|       0|         266|
218866
RTD|         266|        1333|        6933|       0|         266|
218866
RTD|         333|        1400|       16533|       0|         266|
218866
RTD|         400|        1800|       75933|       0|         266|
218866


It is enough possible I have misported the Xenomai to SH, but I also think
Xenomai user-space program(primary mode) suffers such extra latency when
Linux kernel runs Linux programs.

I will appreciate any suggestion for latency improvement.

Thank you,

Kiichi Kameda


