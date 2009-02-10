Date: Tue, 10 Feb 2009 17:49:09 +0100
From: Georg Gottleuber <gg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <E1LWvjc-0006Xw-FB@mailer.emlix.com>
Subject: [Xenomai-help] strange latency output (xenomai-2.4.5)
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

Hi,

I recently port a  ARM926EJ-S mach to Xenomai
(like described in http://www.xenomai.org/index.php/I-pipe:ArmPorting).

While testing with latency I got this output:
# /usr/xenomai/bin/latency  -p 1000 -h -s -H 500 -t 1
== Sampling period: 1000 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      78.992|     104.308|     124.131|       0|      78.992|     124.131
...
RTD|      14.678|      68.413|      96.275|       0|       9.528|     155.321
RTD|      84.046|     116.435|     175.192|       0|       9.528|     182.139
...                                ^^^^^^^                            ^^^^^^^

Some time earlier I had a problem in my clock code and got this:
# /usr/xenomai/bin/latency  -p 1000 -h -s -H 500 -T 900
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|     130.208|     131.944|     135.416|       0|     130.208|     135.416
RTD|      63.368|     132.812|     155.381|       0|      63.368|     155.381
...
RTD|      33.854|      38.194|      55.555|       0|      29.513|     236.979
RTD|      32.986|      38.194|      62.500|      56|      29.513|   56978.298
RTD|      33.854|      38.194|      50.347|      56|      29.513|   56978.298
...

This is a very rare behavior. Normally I got (with bad clock code):
RTD|      36.458|      44.270|     168.402|       0|      33.854|     208.333
RTD|      37.326|     156.250|   56973.958|      28|      33.854|   56973.958
RTD|      36.458|      46.875|     164.062|      28|      33.854|   56973.958

I'm using xenomai-2.4.5 and made a ping test from the host:
ping -l 7 -q -s 10 -f <target IP>

Has anybody seen this behavior before?

Kind regards,
  Georg Gottleuber



