MIME-Version: 1.0
Date: Fri, 11 Feb 2011 11:01:21 +0100
Message-ID: <AANLkTikj+m-orgz_HgQ=-u4PLtS+eAXuMxLWbV6ZmR5m@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Clocksource tsc unstable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

As soon as I start our Xenomai application we get a Linux kernel
message "Clocksource tsc unstable (delta = 305181188 ns)", after which
it switches to the pit clock.

Will this have impact on Xenomai threads running in relaxed mode?

Is this normal behavior? Is this because primary domain interrupted
the Linux clocksource watchdog for 305 ms? Should we disable the Linux
clocksource wathdog so it keeps using the tsc?

Xenomai: 2.5.5.2
Linux-kernel: 2.6.32.15
Platform: x86

