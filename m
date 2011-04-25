Date: Mon, 25 Apr 2011 08:48:52 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110425064852.GA3700@domain.hid>
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA192E0.2090802@domain.hid>
	<20110414164248.GA4725@domain.hid>
	<4DA846FF.5040204@domain.hid> <4DB11857.4030604@domain.hid>
	<4DB484C4.6040204@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DB484C4.6040204@domain.hid>
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, Apr 24, 2011 at 10:15:00PM +0200, Gilles Chanteperdrix wrote:
> 
> some temporary results on the benchmark here:
> http://www.xenomai.org/~gch/latency-at91sam9263.png
> 
> The worst case latency seems not to vary much over time, it looks like
> it is decreasing a bit, but the differences may well be in the
> measurement noise. Unlocked context switch actually improves the latency.
> 
> I will update the png as I get new results.

Gilles,

That is a very interesting graph. It might be nice to have a
"performance benchmarks" page on the wiki, including that figure, plus
the description of the test setup. I can contribute IXP and some
PowerPC results.

Regarding the measured performance, the graphs are shaped like the
letter, H (or like a Bactrian camel, with two humps).

I appears to me that the peaks of the 2.4.10 lines (red, green) are
standing clearly to the left of the 2.5.6 lines (blue, purple), by
about 10 microseconds. I would say that 2.4.10 outperforms 2.5.6, on
average.

The absolute worst case appears to be about the same, or perhaps
slightly improved in 2.5.6.

So the differences are not huge, but still I think 2.4.10 is looking
better.

Thanks,

Richard


