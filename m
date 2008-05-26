Message-ID: <483A5FAD.40703@domain.hid>
Date: Mon, 26 May 2008 08:58:53 +0200
From: Paradoxxa <paradoxxa2001@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080908080504020003060100"
Sender: paradoxxa2001@domain.hid
Subject: [Xenomai-help] Latency times on AT91SAM9263
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

This is a multi-part message in MIME format.
--------------080908080504020003060100
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I have here a AT91SAM9263 with a 2.6.24 kernel, Xenomai 2.4.3 and Adeos 
Patch 1.9-01.
I'm wondering if the latency times are ok. What do you think about it?
In the attachment you can find the log files.


Thomas


--------------080908080504020003060100
Content-Type: text/plain;
 name="latency2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="latency2.log"

== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:03  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      21.862|      62.692|     111.882|       0|      21.862|     111.882
RTD|      20.897|      62.692|     111.239|       0|      20.897|     111.882
RTD|       9.002|      60.442|     131.172|       0|       9.002|     131.172
RTD|      10.609|      62.371|     126.993|       0|       9.002|     131.172
RTD|      10.288|      62.371|     126.993|       0|       9.002|     131.172
RTD|      10.288|      61.406|     128.600|       0|       9.002|     131.172
RTD|      26.041|      63.978|     141.782|       0|       9.002|     141.782
RTD|      26.041|      63.978|     141.782|       0|       9.002|     141.782
RTD|      26.041|      63.978|     141.782|       0|       9.002|     141.782
RTD|      26.041|      63.978|     141.782|       0|       9.002|     141.782
RTD|      26.041|      63.978|     141.782|       0|       9.002|     141.782
RTD|      26.041|      63.978|     141.782|       0|       9.002|     141.782
RTD|      26.041|      63.978|     141.782|       0|       9.002|     141.782
RTD|      26.041|      63.978|     141.782|       0|       9.002|     141.782
RTD|      26.041|      63.978|     141.782|       0|       9.002|     141.782
RTD|      26.041|      63.978|     141.782|       0|       9.002|     141.782
RTD|       9.002|      57.870|     128.922|       0|       9.002|     141.782
RTD|      10.931|      59.156|      99.987|       0|       9.002|     141.782
RTD|      10.609|      59.156|     100.630|       0|       9.002|     141.782
RTD|       9.645|      58.191|      99.665|       0|       9.002|     141.782
RTD|      10.609|      60.120|     165.895|       0|       9.002|     165.895
RTT|  00:00:34  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      10.609|      61.728|     134.066|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTD|      22.183|      63.014|     111.882|       0|       9.002|     165.895
RTT|  00:00:46  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       9.645|      59.477|     111.561|       0|       9.002|     165.895
RTD|      22.826|      63.014|     112.204|       0|       9.002|     165.895
RTD|      22.826|      63.014|     112.204|       0|       9.002|     165.895
RTD|      22.826|      63.014|     112.204|       0|       9.002|     165.895
RTD|       9.966|      60.442|     127.314|       0|       9.002|     165.895
RTD|      22.183|      62.049|     126.671|       0|       9.002|     165.895
RTD|      22.183|      62.049|     126.671|       0|       9.002|     165.895
RTD|      22.183|      62.049|     126.671|       0|       9.002|     165.895
RTD|      22.183|      62.049|     126.671|       0|       9.002|     165.895
RTD|      22.183|      62.049|     126.671|       0|       9.002|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTT|  00:04:12  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTT|  00:04:12  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTT|  00:04:12  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTT|  00:04:12  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTT|  00:04:12  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTT|  00:04:12  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTT|  00:04:12  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTT|  00:04:12  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|      18.004|      63.014|     132.458|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTT|  00:04:12  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTD|       8.680|      37.937|     140.817|       0|       8.680|     165.895
RTT|  00:04:16  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      10.288|      58.834|     114.454|       0|       8.680|     165.895
RTD|      23.148|      63.014|     112.525|       0|       8.680|     165.895
RTD|      23.148|      63.014|     112.525|       0|       8.680|     165.895
RTD|      10.288|      62.371|     111.882|       0|       8.680|     165.895
RTD|      22.505|      62.692|     131.172|       0|       8.680|     165.895
RTD|      10.931|      61.728|     128.279|       0|       8.680|     165.895
RTD|      10.288|      62.692|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.826|      63.014|     111.882|       0|       8.680|     165.895
RTT|  00:04:52  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      21.862|      63.014|     111.561|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTT|  00:04:55  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      23.148|      63.014|     111.882|       0|       8.680|     165.895
RTD|       8.680|      57.870|     111.882|       0|       8.680|     165.895
RTD|      22.183|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.183|      63.014|     111.882|       0|       8.680|     165.895
RTD|      22.183|      63.014|     111.882|       0|       8.680|     165.895
---|------------|------------|------------|--------|-------------------------
RTS|       8.680|      62.371|     165.895|       0|    00:05:05/00:05:00

--------------080908080504020003060100
Content-Type: text/plain;
 name="xeno-test1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-test1.log"

xeno-test: started 
withBusybox is 1
xeno-test: running tests

Thu Jul  6 14:56:25 WEDST 2006
running: /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
        --version="2.4.3"
        --cc="arm-at91-linux-gnu-gcc"
        --arch="arm"
        --prefix="/usr/xenomai"
        --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
        --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
        --posix-cflags="-I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
        --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
        --library-dir="/usr/xenomai/lib"

Thu Jul  6 14:56:26 WEDST 2006
running: /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
BusyBox v1.00 (2006.06.15-22:30+0000) multi-call binary

Usage: busybox [function] [arguments]...
   or: [function] [arguments]...

	BusyBox is a multi-call binary that combines many common Unix
	utilities into a single executable.  Most people will create a
	link to busybox for each function they wish to use, and BusyBox
	will act like whatever it was invoked as.

Currently defined functions:
	[, ar, ash, awk, basename, bunzip2, busybox, bzcat, cat, chgrp,
	chmod, chown, chroot, chvt, clear, cp, cpio, cut, date, dc, dd,
	deallocvt, df, dirname, dmesg, du, echo, egrep, env, expr, false,
	fbset, fdisk, fgrep, find, free, getkey, grep, gunzip, gzip, head,
	hexdump, hostname, hwclock, id, ifconfig, ifdown, ifup, insmod,
	ip, kill, killall, klogd, ln, logger, logname, logread, losetup,
	ls, lsmod, md5sum, mkdir, mkfifo, mknod, mkswap, mktemp, modprobe,
	more, mount, mv, nc, netstat, nslookup, od, openvt, ping, ping6,
	pivot_root, printf, ps, pwd, readlink, renice, reset, rm, rmdir,
	rmmod, route, run-parts, sed, seq, sh, sleep, sort, start-stop-daemon,
	strings, stty, swapoff, swapon, sync, syslogd, tail, tar, tee,
	telnet, test, tftp, top, touch, tr, traceroute, true, tty, udhcpc,
	umount, uname, uniq, uptime, vi, watch, wc, wget, which, who,
	whoami, xargs, yes, zcat

Linux pm9263 2.6.24-dienetho-pm9263 #6 Wed May 21 15:37:17 CEST 2008 armv5tejl unknown
 
module-init-tools      3.2.2
e2fsprogs              1.38
pcmcia-cs              3.2.8
PPP                    2.4.3
Modules Loaded         ext3 jbd ext2 vfat fat nls_base

Thu Jul  6 14:56:28 WEDST 2006
running: cat /proc/cpuinfo
Processor	: ARM926EJ-S rev 5 (v5l)
BogoMIPS	: 99.12
Features	: swp half thumb fastmult edsp java 
CPU implementer	: 0x41
CPU architecture: 5TEJ
CPU variant	: 0x0
CPU part	: 0x926
CPU revision	: 5
Cache type	: write-back
Cache clean	: cp15 c7 ops
Cache lockdown	: format C
Cache format	: Harvard
I size		: 16384
I assoc		: 4
I line length	: 32
I sets		: 128
D size		: 16384
D assoc		: 4
D line length	: 32
D sets		: 128

Hardware	: Ronetix PM9263/BB9263
Revision	: 0000
Serial		: 0000000000000000

Thu Jul  6 14:56:28 WEDST 2006
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
ed334d6f3362dd75f6a47b30b005b598  /proc/cpuinfo

Thu Jul  6 14:56:28 WEDST 2006
running: cat /proc/ipipe/Linux
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  A....
   1:  A....
   2:  A....
   3:  A....
   4:  A....
   5:  A....
   6:  A....
   7:  A....
   8:  A....
   9:  A....
  10:  A....
  11:  A....
  12:  A....
  13:  A....
  14:  A....
  15:  A....
  16:  A....
  17:  A....
  18:  A....
  19:  A....
  20:  A....
  21:  A....
  22:  A....
  23:  A....
  24:  A....
  25:  A....
  26:  A....
  27:  A....
  28:  A....
  29:  A....
  30:  A....
  31:  A....
  32:  A....
  33:  A....
  34:  A....
  35:  A....
  36:  A....
  37:  A....
  38:  A....
  39:  A....
  40:  A....
  41:  A....
  42:  A....
  43:  A....
  44:  A....
  45:  A....
  46:  A....
  47:  A....
  48:  A....
  49:  A....
  50:  A....
  51:  A....
  52:  A....
  53:  A....
  54:  A....
  55:  A....
  56:  A....
  57:  A....
  58:  A....
  59:  A....
  60:  A....
  61:  A....
  62:  A....
  63:  A....
  64:  A....
  65:  A....
  66:  A....
  67:  A....
  68:  A....
  69:  A....
  70:  A....
  71:  A....
  72:  A....
  73:  A....
  74:  A....
  75:  A....
  76:  A....
  77:  A....
  78:  A....
  79:  A....
  80:  A....
  81:  A....
  82:  A....
  83:  A....
  84:  A....
  85:  A....
  86:  A....
  87:  A....
  88:  A....
  89:  A....
  90:  A....
  91:  A....
  92:  A....
  93:  A....
  94:  A....
  95:  A....
  96:  A....
  97:  A....
  98:  A....
  99:  A....
 100:  A....
 101:  A....
 102:  A....
 103:  A....
 104:  A....
 105:  A....
 106:  A....
 107:  A....
 108:  A....
 109:  A....
 110:  A....
 111:  A....
 112:  A....
 113:  A....
 114:  A....
 115:  A....
 116:  A....
 117:  A....
 118:  A....
 119:  A....
 120:  A....
 121:  A....
 122:  A....
 123:  A....
 124:  A....
 125:  A....
 126:  A....
 127:  A....
 128:  A....
 129:  A....
 130:  A....
 131:  A....
 132:  A....
 133:  A....
 134:  A....
 135:  A....
 136:  A....
 137:  A....
 138:  A....
 139:  A....
 140:  A....
 141:  A....
 142:  A....
 143:  A....
 144:  A....
 145:  A....
 146:  A....
 147:  A....
 148:  A....
 149:  A....
 150:  A....
 151:  A....
 152:  A....
 153:  A....
 154:  A....
 155:  A....
 156:  A....
 157:  A....
 158:  A....
 159:  A....
 160:  A....
 161:  A....
 162:  A....
 163:  A....
 164:  A....
 165:  A....
 166:  A....
 167:  A....
 168:  A....
 169:  A....
 170:  A....
 171:  A....
 172:  A....
 173:  A....
 174:  A....
 175:  A....
 176:  A....
 177:  A....
 178:  A....
 179:  A....
 180:  A....
 181:  A....
 182:  A....
 183:  A....
 184:  A....
 185:  A....
 186:  A....
 187:  A....
 188:  A....
 189:  A....
 190:  A....
 191:  A....
 192:  G...V
 193:  G...V
[Domain info]
id=0x00000000
priority=100

Thu Jul  6 14:56:28 WEDST 2006
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
  19:  W..X.
 194:  W...V
[Domain info]
id=0x58454e4f
priority=topmost

Thu Jul  6 14:56:29 WEDST 2006
running: cat /proc/ipipe/version
1.9-01

Thu Jul  6 14:56:29 WEDST 2006
running: generate_loads 1
dd workload started, pids 3173 stored in /var/lock/xeno-test.2980.pids

Thu Jul  6 14:56:29 WEDST 2006
running: cat /proc/interrupts
           CPU0
  1:     382451         AIC  rtc0, atmel_serial
 14:          2         AIC  atmel_spi.0
 15:          4         AIC  atmel_spi.1
 18:          0         AIC  ac97
 19:     182293         AIC  at91_tick
 21:      13043         AIC  eth0
 26:          0         AIC  atmel_lcdfb
 29:          0         AIC  ohci_hcd:usb1
 31:          0         AIC  ads7846
 56:          0        GPIO  at91_cf
 62:          1        GPIO  at91_cf
Err:          0

Thu Jul  6 14:56:29 WEDST 2006
running: cat /proc/loadavg
1.14 2.61 2.43 3/40 3188

Thu Jul  6 14:56:30 WEDST 2006
running: cat /proc/meminfo
MemTotal:        61276 kB
MemFree:          3144 kB
Buffers:             0 kB
Cached:          47332 kB
SwapCached:          0 kB
Active:          10616 kB
Inactive:        39124 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
AnonPages:        2424 kB
Mapped:           2108 kB
Slab:             6516 kB
SReclaimable:      848 kB
SUnreclaim:       5668 kB
PageTables:        268 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     30636 kB
Committed_AS:    42768 kB
VmallocTotal:   956416 kB
VmallocUsed:    333252 kB
VmallocChunk:   587772 kB

Thu Jul  6 14:56:30 WEDST 2006
running: cat /proc/xenomai/affinity
00000001

Thu Jul  6 14:56:30 WEDST 2006
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:          780    (lostage_handler)
  2:           12    (registry_export)
  3:            0    (pse51_lostage_handler)

Thu Jul  6 14:56:30 WEDST 2006
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:          727    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)
  8:            0    (Unaligned access exception)

Thu Jul  6 14:56:31 WEDST 2006
running: cat /proc/xenomai/hal
1.9-01

Thu Jul  6 14:56:31 WEDST 2006
running: cat /proc/xenomai/heap
size=129536:used=4160:pagesz=512  (main heap)
size=32256:used=0:pagesz=512  (stack pool)

Thu Jul  6 14:56:31 WEDST 2006
running: cat /proc/xenomai/irq
IRQ         CPU0
 19:    10068893         [timer]
194:         797         [virtual]

Thu Jul  6 14:56:31 WEDST 2006
running: cat /proc/xenomai/latency
9645

Thu Jul  6 14:56:32 WEDST 2006
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Thu Jul  6 14:56:32 WEDST 2006
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          9574830    0     00500080   66.9  ROOT
  0  0      0          10068967   0     00000000    7.5  IRQ19: [timer]

Thu Jul  6 14:56:32 WEDST 2006
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set

Thu Jul  6 14:56:32 WEDST 2006
running: cat /proc/xenomai/timer
status=on:setup=321:clock=7361351009:timerdev=at91_tc0:clockdev=at91_tc0

Thu Jul  6 14:56:32 WEDST 2006
running: cat /proc/xenomai/version
2.4.3

Thu Jul  6 14:56:33 WEDST 2006
running: cat /proc/xenomai/interfaces/native
0

Thu Jul  6 14:56:33 WEDST 2006
running: cat /proc/xenomai/interfaces/posix
0

Thu Jul  6 14:56:33 WEDST 2006
running: cat /proc/xenomai/interfaces/rtdm
0

Thu Jul  6 14:56:33 WEDST 2006
running: cat /proc/xenomai/interfaces/sys
0

Thu Jul  6 14:56:34 WEDST 2006
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Thu Jul  6 14:56:34 WEDST 2006
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Thu Jul  6 14:56:34 WEDST 2006
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device		Owner [PID]

Thu Jul  6 14:56:34 WEDST 2006
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Thu Jul  6 14:56:35 WEDST 2006
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           
0    236853      236852      1109503    10000000   NULL         [host-timer]   

Thu Jul  6 14:56:35 WEDST 2006
running: top
[H[JMem: 58544K used, 2732K free, 0K shrd, 0K buff, 47424K cached
Load average: 1.45, 2.65, 2.45    (State: S=sleeping R=running, W=waiting)

[7m  PID USER     STATUS   RSS  PPID %CPU %MEM COMMAND[0m
 3173 root     R        444     1 75.4  0.7 dd
 3037 root     D        504  2980 12.7  0.8 tee
 1665 root     RWN        0     2  8.1  0.0 jffs2_gcd_mtd4
 3356 root     R        796  3355  4.5  1.2 top
 2928 root     S       1476     1  0.0  2.4 gconfd-2
 2735 root     S       1172  2693  0.0  1.9 dropbear

Thu Jul  6 14:56:36 WEDST 2006
running: ./run -- -sh -T 120 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:02  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      27.006|      50.154|     136.316|       0|      27.006|     136.316
RTD|      18.325|      49.832|     133.101|       2|      18.325|     136.316
RTD|      30.864|      49.832|     145.961|       2|      18.325|     145.961
RTD|      18.647|      50.797|     116.705|       2|      18.325|     145.961
RTD|      16.396|      50.797|     114.133|       2|      16.396|     145.961
RTD|      18.004|      50.475|     147.247|       3|      16.396|     147.247
RTD|      18.647|      50.475|     147.247|       4|      16.396|     147.247
RTD|      15.753|      50.475|     118.312|       4|      15.753|     147.247
RTD|      18.968|      50.154|     145.961|       5|      15.753|     147.247
RTD|      18.004|      49.832|     134.709|       5|      15.753|     147.247
RTD|      19.290|      50.475|     148.212|       6|      15.753|     148.212
RTD|      18.004|      50.154|     134.066|       6|      15.753|     148.212
RTD|      16.718|      51.440|     137.602|       6|      15.753|     148.212
RTD|      17.039|      50.475|     128.279|       6|      15.753|     148.212
RTD|      18.647|      50.154|     145.640|       8|      15.753|     148.212
RTD|      28.935|      49.832|     146.926|       8|      15.753|     148.212
RTD|       9.966|      48.868|     129.886|       8|       9.966|     148.212
RTD|      16.718|      50.797|     140.496|       8|       9.966|     148.212
RTD|      16.396|      50.475|     126.671|       8|       9.966|     148.212
RTD|      19.933|      50.475|     144.032|       8|       9.966|     148.212
RTD|      17.039|      50.475|     142.425|       8|       9.966|     148.212
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      13.503|      50.154|     133.423|       8|       9.966|     148.212
RTD|      16.396|      50.475|     134.709|       8|       9.966|     148.212
RTD|      16.718|      49.832|     135.352|       8|       9.966|     148.212
RTD|      18.004|      51.118|     134.387|       8|       9.966|     148.212
RTD|      18.004|      50.154|     147.569|       9|       9.966|     148.212
RTD|      17.682|      51.761|     135.673|       9|       9.966|     148.212
RTD|      18.325|      50.475|     148.533|      10|       9.966|     148.533
RTD|      18.647|      50.154|     131.815|      10|       9.966|     148.533
RTD|      16.075|      50.154|     132.780|      10|       9.966|     148.533
RTD|      15.753|      50.797|     141.782|      10|       9.966|     148.533
RTD|      16.396|      51.118|     140.817|      10|       9.966|     148.533
RTD|      18.004|      50.475|     114.133|      10|       9.966|     148.533
RTD|      17.682|      50.475|     141.460|      10|       9.966|     148.533
RTD|      19.290|      50.154|     143.068|      10|       9.966|     148.533
RTD|      18.325|      50.154|     141.782|      10|       9.966|     148.533
RTD|      16.075|      50.475|     133.744|      10|       9.966|     148.533
RTD|      18.004|      50.475|     134.066|      10|       9.966|     148.533
RTD|      18.968|      50.475|     134.709|      10|       9.966|     148.533
RTD|      15.432|      51.440|     139.210|      10|       9.966|     148.533
RTD|      16.075|      50.475|     114.454|      10|       9.966|     148.533
RTD|      17.039|      49.832|     140.817|      11|       9.966|     148.533
RTT|  00:00:44  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      28.292|      49.832|     147.569|      11|       9.966|     148.533
RTD|      18.004|      49.832|     135.995|      11|       9.966|     148.533
RTD|      18.004|      50.475|     129.565|      11|       9.966|     148.533
RTD|      15.432|      50.475|     129.886|      11|       9.966|     148.533
RTD|      17.361|      49.832|     141.782|      11|       9.966|     148.533
RTD|      15.753|      50.154|     129.565|      11|       9.966|     148.533
RTD|      16.396|      50.475|     140.174|      11|       9.966|     148.533
RTD|      19.933|      51.440|     137.602|      11|       9.966|     148.533
RTD|      18.647|      50.797|     133.423|      11|       9.966|     148.533
RTD|      18.325|      50.475|     141.782|      11|       9.966|     148.533
RTD|      17.682|      50.475|     141.139|      11|       9.966|     148.533
RTD|      18.004|      50.475|     135.352|      11|       9.966|     148.533
RTD|      18.647|      50.475|     153.677|      12|       9.966|     153.677
RTD|      18.325|      50.475|     152.391|      13|       9.966|     153.677
RTD|      16.396|      51.761|     133.423|      13|       9.966|     153.677
RTD|      18.004|      52.083|     133.101|      13|       9.966|     153.677
RTD|      18.004|      50.475|     145.961|      14|       9.966|     153.677
RTD|      13.181|      50.797|     148.533|      15|       9.966|     153.677
RTD|      18.004|      50.154|     146.604|      17|       9.966|     153.677
RTD|      29.899|      49.832|     146.283|      17|       9.966|     153.677
RTD|      17.039|      50.797|     132.458|      17|       9.966|     153.677
RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      19.290|      50.475|     146.604|      18|       9.966|     153.677
RTD|      16.718|      50.797|     116.383|      18|       9.966|     153.677
RTD|      18.004|      50.475|     134.066|      18|       9.966|     153.677
RTD|      18.647|      50.797|     147.569|      19|       9.966|     153.677
RTD|      18.004|      50.154|     136.638|      19|       9.966|     153.677
RTD|       9.966|      49.511|     148.212|      20|       9.966|     153.677
RTD|      17.682|      51.118|     133.101|      20|       9.966|     153.677
RTD|      19.290|      51.118|     147.247|      21|       9.966|     153.677
RTD|      18.004|      50.475|     149.819|      22|       9.966|     153.677
RTD|      18.004|      50.797|     148.855|      23|       9.966|     153.677
RTD|      17.361|      50.154|     134.387|      23|       9.966|     153.677
RTD|      18.004|      49.832|     133.423|      23|       9.966|     153.677
RTD|      16.718|      50.475|     149.498|      24|       9.966|     153.677
RTD|      16.396|      50.475|     132.137|      24|       9.966|     153.677
RTD|      18.647|      51.440|     145.640|      25|       9.966|     153.677
RTD|      18.004|      50.797|     132.780|      25|       9.966|     153.677
RTD|      17.039|      50.475|     147.247|      26|       9.966|     153.677
RTD|      17.039|      49.832|     135.030|      26|       9.966|     153.677
RTD|      18.647|      50.154|     145.640|      27|       9.966|     153.677
RTD|      18.647|      49.832|     133.744|      27|       9.966|     153.677
RTD|      16.718|      50.797|     136.316|      27|       9.966|     153.677
RTT|  00:01:25  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      19.611|      50.797|     138.245|      27|       9.966|     153.677
RTD|      19.290|      50.475|     126.671|      27|       9.966|     153.677
RTD|      17.039|      50.154|     127.957|      27|       9.966|     153.677
RTD|      18.968|      50.154|     138.567|      27|       9.966|     153.677
RTD|      16.396|      50.154|     146.926|      28|       9.966|     153.677
RTD|      17.361|      50.475|     139.531|      28|       9.966|     153.677
RTD|      17.361|      50.475|     134.066|      28|       9.966|     153.677
RTD|      18.968|      50.797|     138.888|      28|       9.966|     153.677
RTD|      16.075|      51.118|     126.993|      28|       9.966|     153.677
RTD|      16.396|      50.154|     134.066|      28|       9.966|     153.677
RTD|      17.682|      50.475|     137.602|      28|       9.966|     153.677
RTD|      18.647|      50.154|     147.890|      29|       9.966|     153.677
RTD|      19.611|      51.118|     146.926|      30|       9.966|     153.677
RTD|      16.718|      50.797|     133.423|      30|       9.966|     153.677
RTD|      18.325|      50.475|     134.387|      30|       9.966|     153.677
RTD|      16.075|      50.154|     134.387|      30|       9.966|     153.677
RTD|      18.004|      52.404|     148.533|      31|       9.966|     153.677
RTD|      18.968|      51.118|     132.137|      31|       9.966|     153.677
RTD|      17.039|      50.797|     130.851|      31|       9.966|     153.677
RTD|      18.968|      50.475|     148.212|      32|       9.966|     153.677
RTD|      16.718|      50.154|     135.030|      32|       9.966|     153.677
RTT|  00:01:47  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      18.325|      50.475|     148.533|      33|       9.966|     153.677
RTD|      17.361|      51.761|     134.066|      33|       9.966|     153.677
RTD|      19.933|      50.475|     145.318|      34|       9.966|     153.677
RTD|      16.075|      50.797|     135.030|      34|       9.966|     153.677
RTD|      17.361|      50.475|     146.926|      35|       9.966|     153.677
RTD|      18.004|      50.797|     143.389|      35|       9.966|     153.677
RTD|      16.718|      51.440|     131.172|      35|       9.966|     153.677
RTD|      17.039|      49.832|     128.922|      35|       9.966|     153.677
RTD|      16.396|      50.154|     134.066|      35|       9.966|     153.677
RTD|      17.682|      50.475|     135.995|      35|       9.966|     153.677
RTD|      19.290|      50.475|     137.924|      35|       9.966|     153.677
RTD|      17.682|      50.475|     131.815|      35|       9.966|     153.677
RTD|      16.396|      51.118|     120.241|      35|       9.966|     153.677
RTD|      17.361|      50.154|     137.924|      35|       9.966|     153.677
---|--param|----range-|--samples
HSD|    min|   9 - 10 |        2
HSD|    min|  13 - 14 |        2
HSD|    min|  15 - 16 |        5
HSD|    min|  16 - 17 |       26
HSD|    min|  17 - 18 |       23
HSD|    min|  18 - 19 |       45
HSD|    min|  19 - 20 |       11
HSD|    min|  27 - 28 |        1
HSD|    min|  28 - 29 |        2
HSD|    min|  29 - 30 |        1
HSD|    min|  30 - 31 |        1
---|--param|----range-|--samples
HSD|    avg|   9 - 10 |        3
HSD|    avg|  10 - 11 |      164
HSD|    avg|  11 - 12 |      292
HSD|    avg|  12 - 13 |       77
HSD|    avg|  13 - 14 |       10
HSD|    avg|  14 - 15 |        6
HSD|    avg|  15 - 16 |        7
HSD|    avg|  16 - 17 |       36
HSD|    avg|  17 - 18 |       45
HSD|    avg|  18 - 19 |      130
HSD|    avg|  19 - 20 |      130
HSD|    avg|  20 - 21 |      193
HSD|    avg|  21 - 22 |      318
HSD|    avg|  22 - 23 |      402
HSD|    avg|  23 - 24 |      399
HSD|    avg|  24 - 25 |      298
HSD|    avg|  25 - 26 |      167
HSD|    avg|  26 - 27 |       80
HSD|    avg|  27 - 28 |      143
HSD|    avg|  28 - 29 |      111
HSD|    avg|  29 - 30 |       57
HSD|    avg|  30 - 31 |      347
HSD|    avg|  31 - 32 |    24263
HSD|    avg|  32 - 33 |   135920
HSD|    avg|  33 - 34 |   188315
HSD|    avg|  34 - 35 |   119536
HSD|    avg|  35 - 36 |    52316
HSD|    avg|  36 - 37 |    23675
HSD|    avg|  37 - 38 |     3012
HSD|    avg|  38 - 39 |     1705
HSD|    avg|  39 - 40 |     3442
HSD|    avg|  40 - 41 |     8884
HSD|    avg|  41 - 42 |     5501
HSD|    avg|  42 - 43 |     5882
HSD|    avg|  43 - 44 |     4970
HSD|    avg|  44 - 45 |     3692
HSD|    avg|  45 - 46 |     3340
HSD|    avg|  46 - 47 |     1642
HSD|    avg|  47 - 48 |     1469
HSD|    avg|  48 - 49 |     1366
HSD|    avg|  49 - 50 |     1509
HSD|    avg|  50 - 51 |     1462
HSD|    avg|  51 - 52 |     1258
HSD|    avg|  52 - 53 |     1039
HSD|    avg|  53 - 54 |      783
HSD|    avg|  54 - 55 |      678
HSD|    avg|  55 - 56 |      466
HSD|    avg|  56 - 57 |      848
HSD|    avg|  57 - 58 |      808
HSD|    avg|  58 - 59 |      416
HSD|    avg|  59 - 60 |      207
HSD|    avg|  60 - 61 |      121
HSD|    avg|  61 - 62 |       53
HSD|    avg|  62 - 63 |       68
HSD|    avg|  63 - 64 |     2526
HSD|    avg|  64 - 65 |    55544
HSD|    avg|  65 - 66 |   212827
HSD|    avg|  66 - 67 |   195247
HSD|    avg|  67 - 68 |    72877
HSD|    avg|  68 - 69 |    13408
HSD|    avg|  69 - 70 |     2113
HSD|    avg|  70 - 71 |      986
HSD|    avg|  71 - 72 |      964
HSD|    avg|  72 - 73 |    19129
HSD|    avg|  73 - 74 |     2410
HSD|    avg|  74 - 75 |     3326
HSD|    avg|  75 - 76 |     4182
HSD|    avg|  76 - 77 |     2591
HSD|    avg|  77 - 78 |     1399
HSD|    avg|  78 - 79 |     1260
HSD|    avg|  79 - 80 |     1105
HSD|    avg|  80 - 81 |      823
HSD|    avg|  81 - 82 |      520
HSD|    avg|  82 - 83 |      172
HSD|    avg|  83 - 84 |       85
HSD|    avg|  84 - 85 |       56
HSD|    avg|  85 - 86 |       25
HSD|    avg|  86 - 87 |       31
HSD|    avg|  87 - 88 |       34
HSD|    avg|  88 - 89 |       32
HSD|    avg|  89 - 90 |       42
HSD|    avg|  90 - 91 |       23
HSD|    avg|  91 - 92 |       13
HSD|    avg|  92 - 93 |       16
HSD|    avg|  93 - 94 |       25
HSD|    avg|  94 - 95 |       36
HSD|    avg|  99 -100 |     2744
---|--param|----range-|--samples
HSD|    max|  99 -100 |      119
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|     17.538|      2.786
HSS|    avg|   1198632|     50.116|     16.471
HSS|    max|       119|     99.000|      0.000
---|------------|------------|------------|--------|-------------------------
RTS|       9.966|      50.475|     153.677|      35|    00:02:15/00:02:00

Thu Jul  6 14:58:56 WEDST 2006
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

Thu Jul  6 14:58:59 WEDST 2006
running: ./run -- -sh -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

Thu Jul  6 14:59:02 WEDST 2006
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
/usr/xenomai/bin/switchtest: /lib/libpthread.so.0: version `GLIBC_2.3.3' not found (required by /usr/xenomai/bin/switchtest)
/usr/xenomai/bin/switchtest: /lib/libpthread.so.0: version `GLIBC_2.3.3' not found (required by /usr/xenomai/lib/libpthread_rt.so.1)

Thu Jul  6 14:59:06 WEDST 2006
running: ./run -- -h # switchbench
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD| 3215020.576|       0.000|-3215020.576|      100000
---|---range-|---samples
HSS|         0|        nan|     -0.000

Thu Jul  6 14:59:30 WEDST 2006
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
/usr/xenomai/bin/cyclictest: /lib/libpthread.so.0: version `GLIBC_2.3.3' not found (required by /usr/xenomai/lib/libpthread_rt.so.1)

Thu Jul  6 14:59:33 WEDST 2006
running: cat /proc/interrupts
           CPU0
  1:     391094         AIC  rtc0, atmel_serial
 14:          2         AIC  atmel_spi.0
 15:          4         AIC  atmel_spi.1
 18:          0         AIC  ac97
 19:     199968         AIC  at91_tick
 21:      13043         AIC  eth0
 26:          0         AIC  atmel_lcdfb
 29:          0         AIC  ohci_hcd:usb1
 31:          0         AIC  ads7846
 56:          0        GPIO  at91_cf
 62:          1        GPIO  at91_cf
Err:          0

Thu Jul  6 14:59:33 WEDST 2006
running: cat /proc/loadavg
7.13 4.16 3.03 3/40 4078

Thu Jul  6 14:59:33 WEDST 2006
running: cat /proc/meminfo
MemTotal:        61276 kB
MemFree:          4200 kB
Buffers:             0 kB
Cached:          45984 kB
SwapCached:          0 kB
Active:          10980 kB
Inactive:        37412 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
AnonPages:        2424 kB
Mapped:           2108 kB
Slab:             6800 kB
SReclaimable:      848 kB
SUnreclaim:       5952 kB
PageTables:        268 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     30636 kB
Committed_AS:    42768 kB
VmallocTotal:   956416 kB
VmallocUsed:    333252 kB
VmallocChunk:   587772 kB

Thu Jul  6 14:59:33 WEDST 2006
running: cat /proc/xenomai/affinity
00000001

Thu Jul  6 14:59:33 WEDST 2006
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:          908    (lostage_handler)
  2:           16    (registry_export)
  3:            0    (pse51_lostage_handler)

Thu Jul  6 14:59:34 WEDST 2006
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:          843    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)
  8:            0    (Unaligned access exception)

Thu Jul  6 14:59:34 WEDST 2006
running: cat /proc/xenomai/hal
1.9-01

Thu Jul  6 14:59:34 WEDST 2006
running: cat /proc/xenomai/heap
size=129536:used=4160:pagesz=512  (main heap)
size=32256:used=0:pagesz=512  (stack pool)

Thu Jul  6 14:59:34 WEDST 2006
running: cat /proc/xenomai/irq
IRQ         CPU0
 19:    11639885         [timer]
194:         932         [virtual]

Thu Jul  6 14:59:34 WEDST 2006
running: cat /proc/xenomai/latency
9645

Thu Jul  6 14:59:34 WEDST 2006
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Thu Jul  6 14:59:35 WEDST 2006
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          10433886   0     00500080   33.0  ROOT
  0  0      0          11639952   0     00000000   13.6  IRQ19: [timer]

Thu Jul  6 14:59:35 WEDST 2006
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set

Thu Jul  6 14:59:35 WEDST 2006
running: cat /proc/xenomai/timer
status=on:setup=321:clock=7930385920:timerdev=at91_tc0:clockdev=at91_tc0

Thu Jul  6 14:59:35 WEDST 2006
running: cat /proc/xenomai/version
2.4.3

Thu Jul  6 14:59:35 WEDST 2006
running: cat /proc/xenomai/interfaces/native
0

Thu Jul  6 14:59:36 WEDST 2006
running: cat /proc/xenomai/interfaces/posix
0

Thu Jul  6 14:59:36 WEDST 2006
running: cat /proc/xenomai/interfaces/rtdm
0

Thu Jul  6 14:59:36 WEDST 2006
running: cat /proc/xenomai/interfaces/sys
0

Thu Jul  6 14:59:36 WEDST 2006
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Thu Jul  6 14:59:36 WEDST 2006
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Thu Jul  6 14:59:36 WEDST 2006
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device		Owner [PID]

Thu Jul  6 14:59:37 WEDST 2006
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Thu Jul  6 14:59:37 WEDST 2006
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           
0    255075      255074      6870177    10000000   NULL         [host-timer]   

Thu Jul  6 14:59:37 WEDST 2006
running: top
[H[JMem: 57760K used, 3516K free, 0K shrd, 0K buff, 46252K cached
Load average: 6.96, 4.17, 3.04    (State: S=sleeping R=running, W=waiting)

[7m  PID USER     STATUS   RSS  PPID %CPU %MEM COMMAND[0m
 3037 root     D        504  2980 71.5  0.8 tee
 1665 root     RWN        0     2 24.4  0.0 jffs2_gcd_mtd4
 4246 root     R        796  4245  5.4  1.2 top
 2928 root     S       1476     1  0.0  2.4 gconfd-2
 2735 root     S       1172  2693  0.0  1.9 dropbear
 2736 root     S        924  2735  0.0  1.5 sh
 3173 root        444 R   dd if=/dev/zero of=/dev/null 
 4252 root        560 S   grep 3173 
xeno-test: finished

--------------080908080504020003060100--

