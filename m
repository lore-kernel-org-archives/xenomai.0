From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4639FAC7.9060207@domain.hid>
References: <4639D724.5010702@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>
	<1178204088.29605.85.camel@domain.hid>  <4639FAC7.9060207@domain.hid>
Content-Type: text/plain
Date: Thu, 03 May 2007 18:11:52 +0200
Message-Id: <1178208712.29605.109.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Latency calculation and test
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

On Thu, 2007-05-03 at 17:07 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > Sidenote: It obviously makes no sense to stuff gigantic values
> > into /proc/xenomai/latency; large core latencies are likely the sign of
> > 1) a bug in the arch-dep section (probably Adeos), 2) inadequation of
> > the hw for real-time usage (e.g. some ARM platforms with MMU, mmm...
> > issues).
> 
> Here I disagree: if a platform run ten times slower than another, why
> not having a latency ten times bigger ?
> 

That was not my point. My point was: don't stuff huge semi-random values
into /proc/xenomai/latency to work around terrible jittery especially
when porting Xenomai over new platforms, because this is _likely_ the
sign of something going wrong elsewhere.

E.g. An oldish 90Mhz classic pentium exhibits ~25 us core latency
figures with Xenomai; some ARM hw may require more because of
unfortunate memory sub-systems, but in any case, you have to
_understand_ (e.g. using the tracer) why it is so, first.

As a corollary, raising the core latency figure artificially (i.e. by
papering over the real cause of the problem) often ends up worsening the
max. latency (remember when we chased extra latencies caused by root
domain ISRs preempting the nucleus in the old days? raising the
pre-calibrated value would have been the wrong way, stalling the topmost
Adeos domain at hw level as you suggested was the right solution).

> 
> > Said differently, I had no clue, so I'm expecting users to have some.
> 
> Additionnaly, the latency depends on the kind of load put on the system
> during the test. A user is expected to calibrate the nucleus latency of
> his system under the particular load which is expected on his system.
> 
> We should add a page on the wiki about the latency calibration.
> 

We should also provide an external tool for determining the most
appropriate latency for a given workload / configuration.

-- 
Philippe.



