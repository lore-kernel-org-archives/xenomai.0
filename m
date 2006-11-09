Date: Thu, 9 Nov 2006 14:36:33 +0100
From: Matthias Fechner <idefix@domain.hid>
Message-ID: <20061109133632.GA4205@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Matthias Fechner <idefix@domain.hid>
Subject: [Xenomai-help] Strange results with latency test
Reply-To: xenomai@xenomai.org
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

I tested today Xenomai on my AMD64 (32-bit mode) with the latency
program from the testsuite and I got for lat min negative values.

Can my computer predict the future? :)

How can I interpret these values?

100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.337|      -0.958|       0.970|       0|      -1.337| 0.970
RTD|      -1.290|      -0.907|       1.959|       0|      -1.337| 1.959
...
RTD|      -1.406|      -0.923|       1.884|       0|      -1.468| 4.358
---|------------|------------|------------|--------|-------------------------
RTS|      -1.468|      -0.922|       4.358|       0| 00:00:34/00:00:34



Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook

