MIME-Version: 1.0
In-Reply-To: <4F3141D2.7000605@domain.hid>
References: <CAMak2D-YfDCvjbZiLFYGntYdDCJVPiYtwt5z8k=PPT-9yj3S5A@mail.gmail.com>
	<4F3141D2.7000605@domain.hid>
Date: Tue, 7 Feb 2012 19:25:07 -0500
Message-ID: <CAMak2D_YWa_Dta3q8-E1yCq08a8bZ3Vm2FdHac8Ee=zcgh9emg@domain.hid>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thanks, Gilles.=A0 I enabled ipipe tracing but am a bit confused by what
it's telling me.=A0 What I would like to do is generate a trace during
the timed section of the benchmark, and not anywhere else.=A0 Looking at
the output, it seems max and frozen contain traces of the longest path
to date.=A0 It's not clear to me how this maps to my benchmark
latencies.=A0 For example, I can sample max and/or frozen and add up the
latency column and see them seemingly randomly exceed each other
regardless of whether dohell is running.

Looking at http://www.xenomai.org/index.php/Xenomai:I-pipe_Tracer#API
I see there are calls like xntrace_user_start and xntrace_user_stop.
Is it possible to wrap the timed parts of the benchmarks with calls
like this to get a more informative trace?

Also, do you think the latency degradation may be due to the VIVT
cache on the ARM?  I'm specifically referring to additional latency
due to different address spaces when switching between Linux user-mode
and Xenomai kernel.

Thanks again.

- Eric

On Tue, Feb 7, 2012 at 10:22 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> On 02/07/2012 01:01 AM, Eric Eric wrote:
> > Hello, I've been doing some more Xenomai benchmarking lately and have c=
ome
> > across what seems to be strange behavior. =A0I'm running Xenomai 2.6.0 =
on a
> > Beagleboard XM with kernel 2.6.37. =A0Just running the in-kernel period=
ic
> > task benchmark (./latency -t1) alone results in an average of 2.7uS
> > latency. =A0What is interesting is the effect of various parts of dohel=
l:
> >
> > 1) If I just run unmodified dohell with only the seconds argument, the
> > latency goes to about 17uS.
> >
> > 2) If I comment out all tests in dohell except for "dd if=3D/dev/zero
> > of=3D/dev/null &", average latency goes to 3.3uS (with top indicating a=
bout
> > 98% CPU usage by dd).
> >
> > 3) If I comment out all tests in dohell except for "while :; do cat
> > /proc/interrupts; done > /dev/null 2>&1 &", average latency goes to abo=
ut
> > 24uS.
> >
> > So it seems that trapping into the Linux kernel can have a drastic effe=
ct
> > on Xenomai real-time kernel latencies.
>
> You are drawing conclusions a bit too fast. dd also causes a lot of
> trapping into the kernel. If you are interested in knowing how the time
> is spent, I suggest using the I-pipe tracer.
>
> If you find an improvement of the I-pipe patch for your platform, we
> will gladly welcome patches.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.

