Message-ID: <4354C77E.109@domain.hid>
Date: Tue, 18 Oct 2005 11:59:26 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Testing the adeos-ipipe-2.6.13-ppc-1.0-00.patch
References: <1CFEB358338412458B21FAA0D78FE86D4F0E28@domain.hid>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E28@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

On 10/17/2005 05:42 PM Fillod Stephane wrote:
> Hi Philippe,
> 
> Sorry for the late report, Xenomai appears to work fine on a Freescale
> e500
> board (MPC8541E) under Linux 2.6.13. Xenomai version was v1.9.9, ie. the
> daily
> snapshot as of today. Here are some preliminary figures (CPU 800MHz, Bus
> 133MHz, 
> 32 kiB I-Cache 32 kiB D-Cache, 256 kiB L2):
> 
> switch $ ./run
> == Sampling period: 100 us
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|        3660|        3690|        8070|           0
> 
> kaltency $ ./run
> RTH|----klat min|----klat avg|----klat max| overrun|
> RTS|       -7350|       -5715|        6420|       0|
> 00:03:17/00:03:17
> 
> latency $ ./run
> == Sampling period: 100 us
> RTT|  00:08:04
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|
> RTS|       -6930|       -4260|        8700|       0|
> 00:08:06/00:08:06
> 
> Load for klatency/latency was ping flooding on FCC (piece of cake),
> and cache calibrator. IMHO, we can do nastier.

Comparing the corrected latency figures (+9500ns) of your MPC8541E with
my Ocotea-Board (AMCC 440 GX at 533 MHz) gives:

Ocotea   |        3575|        7438|       24474|       0|    00:10:50
MPC8541E |        2570|        5240|       18200|       0|

This scales rather well with the CPU clocks 533/800. L1 and L2 caches
and the memory interface seem almost identical.

Wolfgang.

