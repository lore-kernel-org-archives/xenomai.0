Message-ID: <4F3141D2.7000605@domain.hid>
Date: Tue, 07 Feb 2012 16:22:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMak2D-YfDCvjbZiLFYGntYdDCJVPiYtwt5z8k=PPT-9yj3S5A@mail.gmail.com>
In-Reply-To: <CAMak2D-YfDCvjbZiLFYGntYdDCJVPiYtwt5z8k=PPT-9yj3S5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] in-kernel periodic task latencies caused by
	dohell
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Eric <ericrebates@domain.hid>
Cc: xenomai@xenomai.org

On 02/07/2012 01:01 AM, Eric Eric wrote:
> Hello, I've been doing some more Xenomai benchmarking lately and have come
> across what seems to be strange behavior.  I'm running Xenomai 2.6.0 on a
> Beagleboard XM with kernel 2.6.37.  Just running the in-kernel periodic
> task benchmark (./latency -t1) alone results in an average of 2.7uS
> latency.  What is interesting is the effect of various parts of dohell:
> 
> 1) If I just run unmodified dohell with only the seconds argument, the
> latency goes to about 17uS.
> 
> 2) If I comment out all tests in dohell except for "dd if=/dev/zero
> of=/dev/null &", average latency goes to 3.3uS (with top indicating about
> 98% CPU usage by dd).
> 
> 3) If I comment out all tests in dohell except for "while :; do cat
> /proc/interrupts; done > /dev/null 2>&1 &", average latency goes to about
> 24uS.
> 
> So it seems that trapping into the Linux kernel can have a drastic effect
> on Xenomai real-time kernel latencies. 

You are drawing conclusions a bit too fast. dd also causes a lot of
trapping into the kernel. If you are interested in knowing how the time
is spent, I suggest using the I-pipe tracer.

If you find an improvement of the I-pipe patch for your platform, we
will gladly welcome patches.

-- 
                                                                Gilles.

