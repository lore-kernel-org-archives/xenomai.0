Message-ID: <4639FAC7.9060207@domain.hid>
Date: Thu, 03 May 2007 17:07:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>
	<1178204088.29605.85.camel@domain.hid>
In-Reply-To: <1178204088.29605.85.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
> Sidenote: It obviously makes no sense to stuff gigantic values
> into /proc/xenomai/latency; large core latencies are likely the sign of
> 1) a bug in the arch-dep section (probably Adeos), 2) inadequation of
> the hw for real-time usage (e.g. some ARM platforms with MMU, mmm...
> issues).

Here I disagree: if a platform run ten times slower than another, why
not having a latency ten times bigger ?


> Said differently, I had no clue, so I'm expecting users to have some.

Additionnaly, the latency depends on the kind of load put on the system
during the test. A user is expected to calibrate the nucleus latency of
his system under the particular load which is expected on his system.

We should add a page on the wiki about the latency calibration.

-- 
                                                 Gilles Chanteperdrix

