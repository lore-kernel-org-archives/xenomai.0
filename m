Date: Wed, 16 Jul 2014 18:18:01 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Message-ID: <20140716161801.GA20328@lukather>
References: <20140701141536.GN28647@lukather> <53B30D96.60500@xenomai.org>
 <20140704092736.GC13487@lukather> <53B7B3BF.3090807@xenomai.org>
 <20140707160239.GF13423@lukather> <53BAC5C4.5060704@xenomai.org>
 <20140708125505.GN13423@lukather> <53BC2AB5.4050801@xenomai.org>
 <20140710150540.GE27469@lukather> <53BEC794.6090208@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53BEC794.6090208@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] AT91: SAMA5D3: Adapt Ipipe for AIC5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Thomas Petazzoni <thomas@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org

On Thu, Jul 10, 2014 at 07:04:20PM +0200, Gilles Chanteperdrix wrote:
> >> The test you are interested in is latency, not clocktest. The main
> >> differences between latency and the test you run are:
> >> - - the "period" (which BTW, in your case would only be a real period if
> >> you removed the call to clock_gettime at the beginning of the loop,
> >> only keeping the one before the loop), which is 1ms in latency case,
> >> 100us in your case
> > 
> > I don't really get what you mean here. If we don't call gettime at the
> > beginning of the loop, but only outside, how are we supposed to get
> > the next sleep expiration time?
> 
> Look at the code, time1 is not a loop local variable, the next sleep
> expiration date is computed and passed to clock_nanosleep. So, you
> simply have to add the period to this date, and use the new date. This
> is the classical way of using clock_nanosleep for periodic task.
> Re-reading the current time before computing the wake up time introduces
> an error which breaks the periodicity of the task, and makes the use of
> absolute clock_nanosleep useless, a relative sleep would do the same
> thing much more simply.

Except that we don't really care for the periodicity of a task. The
purpose of this test is actually to compute a single latency, over a
large enough number of samples to be meaningful.

So the drift away from the start of the loop is not taken into account,
on purpose.

> Another problem with this code is that it does not check for
> clock_nanosleep return value, so does not account correctly for overruns.

That's true.

> 
> > 
> >> - - the fact that your function timespec_diff returns unsigned value, so
> >> in case of early shot, you will get a very large value instead of a
> >> negative ones.
> >>
> >> As a general rule, we prefer Xenomai users to use the latency test,
> >> because this is the one we collectively spent time debugging, so it
> >> has more chances to be correct, and if you find a bug, everyone
> >> benefits from the fix.
> > 
> > Yes, I don't doubt that latency is much more tested and reliable.
> > 
> > The thing is, as you probably know, we're also a training company, and
> > we're using this script in our training to give an idea of the latency
> > on a regular linux kernel, and then on xenomai. It also have the
> > benefit of being simple enough for the trainees to be able to
> > understand it rather quickly.
> 
> It is simple but broken.

See above.

> > I don't think latency fits both these criterias, that are quite
> > essential for us. But if you have any better solution that might,
> > we're definitely open to suggestions :)
> 
> Xenomai forge's latency is based on timerfd, so will be usable on Linux,
> preempt-rt and xenomai. But that is for the future.

Ah, good to know.

> I suggest you fix the issue with negative latencies, and see if it
> avoids the large latencies you observe.

So, I tested it today with the latency calibration disabled.

It doesn't change anything. I slightly modified it to dump the time1
and time2 variables to see if we're observing negative latencies.

The code is here: http://code.bulix.org/y7f8tc-86530?raw
And here is the output of a single run: http://code.bulix.org/ciamlo-86531?raw

So, if you look at it, we can see that we have around half a dozen of
these huge latency spikes, while we gather 180k samples, but these
spikes are not actually caused by some negative latencies. There
actually is such a different of a few 100's of ms between our two
timespec structures.

And it's not due to an error reported by any of the clock functions
either.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140716/a502de69/attachment.sig>
