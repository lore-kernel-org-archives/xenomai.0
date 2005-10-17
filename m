Message-ID: <4354033B.4060800@domain.hid>
Date: Mon, 17 Oct 2005 22:02:03 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Testing the adeos-ipipe-2.6.13-ppc-1.0-00.patch
References: <1CFEB358338412458B21FAA0D78FE86D4F0E28@domain.hid>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E28@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Fillod Stephane wrote:
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

Great you tested that, thanks. The calibration looks a bit pessimistic, so I 
guess that a narrowed one would leave us with something in the 10-12 us range 
worst-case in user-space, which would still be quite decent.

> Load for klatency/latency was ping flooding on FCC (piece of cake),
> and cache calibrator. IMHO, we can do nastier.
> 
> 

Mixed LTP stuff and dd loops are quite good punishers AFAICS here.

-- 

Philippe.

