MIME-Version: 1.0
Date: Wed, 12 May 2010 18:46:20 +0800
Message-ID: <AANLkTinbt2EqgVr_rzyJJEgOVfgRYgHEhQB8CtBOCGsr@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] my first test run on beagleboard
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

I finally managed to compile and install xenomai on my beagleboard C4.
I just did a
kernel latency test and this is the result. Does it look reasonable?
the board is not running
anything except the kernel latency in the testsuit directory (C4
running at 720Mhgz)


* Type ^C to stop this application.
*
*
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      4.615|     12.538|     44.307|       0|     0|      4.615|     44.307
RTD|      3.923|     12.923|     45.923|       0|     0|      3.923|     45.923
RTD|      5.153|     12.923|     44.923|       0|     0|      3.923|     45.923
RTD|     11.076|     12.999|     45.923|       0|     0|      3.923|     45.923
RTD|      1.307|     12.538|     44.384|       0|     0|      1.307|     45.923
RTD|      3.461|     12.846|     46.461|       0|     0|      1.307|     46.461
RTD|      4.999|     12.538|     47.615|       0|     0|      1.307|     47.615
RTD|     10.615|     12.923|     48.076|       0|     0|      1.307|     48.076
RTD|     11.153|     12.923|     45.538|       0|     0|      1.307|     48.076
RTD|      3.461|     12.846|     47.076|       0|     0|      1.307|     48.076
RTD|     11.153|     12.538|     44.692|       0|     0|      1.307|     48.076
RTD|      8.692|     12.846|     47.461|       0|     0|      1.307|     48.076
RTD|      5.307|     12.538|     48.769|       0|     0|      1.307|     48.769
RTD|      1.692|     12.846|     45.307|       0|     0|      1.307|     48.769


Best regards,

Everett

