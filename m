From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <463A1174.60105@domain.hid>
References: <4639D724.5010702@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>
	<1178204088.29605.85.camel@domain.hid>  <4639FAC7.9060207@domain.hid>
	<1178208712.29605.109.camel@domain.hid>  <463A1174.60105@domain.hid>
Content-Type: text/plain
Date: Thu, 03 May 2007 19:17:25 +0200
Message-Id: <1178212646.29605.120.camel@domain.hid>
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

On Thu, 2007-05-03 at 18:44 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Thu, 2007-05-03 at 17:07 +0200, Gilles Chanteperdrix wrote:
> > 
> > That was not my point. My point was: don't stuff huge semi-random values
> > into /proc/xenomai/latency to work around terrible jittery especially
> > when porting Xenomai over new platforms, because this is _likely_ the
> > sign of something going wrong elsewhere.
> > 
> > E.g. An oldish 90Mhz classic pentium exhibits ~25 us core latency
> > figures with Xenomai; some ARM hw may require more because of
> > unfortunate memory sub-systems, but in any case, you have to
> > _understand_ (e.g. using the tracer) why it is so, first.
> 
> I agree. I still have to see for myself why these damned ARMs have such
> high latencies.
> 

Stelian might jump in as well, but IIRC, a problem we saw on the
Integrator was due to the cost of TLB flushing upon switch_mm with hw
interrupts off. As a consequence of this, even regular Linux operations
would induce jittery for the real-time domain, since enabling hw
interrupts while invalidating is a no-go (actually, it's a go, even a
jump, but out of the window, to be precise...).

> 
> >>We should add a page on the wiki about the latency calibration.
> >>
> > 
> > 
> > We should also provide an external tool for determining the most
> > appropriate latency for a given workload / configuration.
> 
> The latency tool already does a great deal of this job.
> 

I was rather thinking of a tool that could explicitely search for and
approximate the best value for calibration, not something only providing
hints for that purpose.

-- 
Philippe.



