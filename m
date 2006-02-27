Message-ID: <440324EE.6030309@domain.hid>
Date: Mon, 27 Feb 2006 17:12:30 +0100
From: Rudolf Marek <rudolf.marek@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] negative values of latency/klatency
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

Hello all,

I tried the latency and klatency demo on some PPC procesor(s) (e500 and 60x) and the measurement results are rather strange.
I observed this with arbitrary version of Adeos/ipipe and on Xenomai 2.0.3 older 2.0.x too.

-sh-3.00# ./run -- -T 10 -h -l 5
...
RTT|  00:00:01
RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat worst
RTD|       -4525|       -4323|        5777|       0|       -4525|        5777
RTD|       -4525|       -4444|       -1777|       0|       -4525|        5777
RTD|       -4525|       -4444|        -565|       0|       -4525|        5777
RTD|       -4525|       -4444|       -1656|       0|       -4525|        5777
RTD|       -4525|       -4444|       -1979|       0|       -4525|        5777
RTT|  00:00:06
RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat worst
RTD|       -4525|       -4444|       -2020|       0|       -4525|        5777
RTD|       -4525|       -4444|       -1050|       0|       -4525|        5777
RTD|       -4525|       -4444|       -1616|       0|       -4525|        5777
RTD|       -4525|       -4444|       -1898|       0|       -4525|        5777
RTD|       -4525|       -4444|       -1939|       0|       -4525|        5777
...
Well if I set scheduling latency from automatic "0" to "1" I get:

-sh-3.00# ./run -- -T 10 -h -l 5

RTT|  00:00:01
RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat worst
RTD|        4767|        4929|       15191|       0|        4767|       15191
RTD|        4767|        4808|        8282|       0|        4767|       15191
RTD|        4767|        4808|        8080|       0|        4767|       15191
RTD|        4808|        4808|        7838|       0|        4767|       15191
RTD|        4767|        4808|        7272|       0|        4767|       15191
RTT|  00:00:06
RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat worst
RTD|        4808|        4808|        7555|       0|        4767|       15191
RTD|        4767|        4808|        7959|       0|        4767|       15191
RTD|        4767|        4808|        7393|       0|        4767|       15191
RTD|        4808|        4808|        7191|       0|        4767|       15191
RTD|        4767|        4808|        7313|       0|        4767|       15191

Is this a bug or feature please? Can someone throw the light?
Good would be to print the units to the numbers too (ns).


Thank you,

Regards,
Rudolf

chipset         : 8541E
Vendor          : Freescale Semiconductor
Machine         : CDS - MPC8541E (11)
clock           : 396MHz


