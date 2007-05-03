Message-ID: <463A1174.60105@domain.hid>
Date: Thu, 03 May 2007 18:44:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	
	<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>	
	<1178204088.29605.85.camel@domain.hid> <4639FAC7.9060207@domain.hid>
	<1178208712.29605.109.camel@domain.hid>
In-Reply-To: <1178208712.29605.109.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-help@domain.hid

Philippe Gerum wrote:
> On Thu, 2007-05-03 at 17:07 +0200, Gilles Chanteperdrix wrote:
> 
> That was not my point. My point was: don't stuff huge semi-random values
> into /proc/xenomai/latency to work around terrible jittery especially
> when porting Xenomai over new platforms, because this is _likely_ the
> sign of something going wrong elsewhere.
> 
> E.g. An oldish 90Mhz classic pentium exhibits ~25 us core latency
> figures with Xenomai; some ARM hw may require more because of
> unfortunate memory sub-systems, but in any case, you have to
> _understand_ (e.g. using the tracer) why it is so, first.

I agree. I still have to see for myself why these damned ARMs have such
high latencies.


>>We should add a page on the wiki about the latency calibration.
>>
> 
> 
> We should also provide an external tool for determining the most
> appropriate latency for a given workload / configuration.

The latency tool already does a great deal of this job.

-- 
                                                 Gilles Chanteperdrix

