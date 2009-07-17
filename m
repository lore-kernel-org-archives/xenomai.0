Message-ID: <4A60A0D7.5020006@domain.hid>
Date: Fri, 17 Jul 2009 18:03:35 +0200
From: Pierre Ficheux <pierre.ficheux@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai on Crusoe TM5900
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

I try to use Xenomai on TM5900 CPU:

Kernel is 2.6.28.9
Xenomai is 2.4.8

First configuration (CONFIG_HPET_TIMER is not set) gives lots of
overruns with latency program:

== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|       4.493|      12.861|      25.111|       0|       4.493|
25.111
RTD|       9.057|      13.876|    1152.413|      37|       4.493|
1152.413
RTD|      12.180|      13.755|     640.259|      53|       4.493|
1152.413
RTD|      12.285|      13.924|     618.703|      70|       4.493|
1152.413
...

Please not I use CONFIG_HZ=250 as CONFIG_HZ=1000 freezes at boot time
system with "clocksource tsc unstable" message.


If I set HPET:

CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

I have a very strange message when starting latency:

Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

Of course native skin is present and CONFIG_XENO_OPT_PERVASIVE enabled

CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_PERVASIVE=y

Any idea?

Thx by advance.

-- 
Pierre FICHEUX -/- CTO OW/OS4I, France -\- pierre.ficheux@domain.hid
                                         http://www.os4i.com
                                         http://www.ficheux.org
I would love to change the world, but they won't give me the source code



