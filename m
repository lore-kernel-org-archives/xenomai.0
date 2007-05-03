Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 3 May 2007 15:43:07 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01E43DC9@domain.hid>
In-Reply-To: <4639FAC7.9060207@domain.hid>
References: <4639D724.5010702@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>
	<1178204088.29605.85.camel@domain.hid> <4639FAC7.9060207@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, rpm@xenomai.org
Cc: Xenomai-help@domain.hid

Hmm,

I understand now that the value for /proc/xenomai/latency is for the =
anticipation algorithm of timers. This anticipation algorithm is =
responsible for optimizing the minimal jitter time for timers. Is the =
latency value used also elsewhere in Xenomai ?

If, say, I would use latencies calibrated with user space POSIX timers =
for a typical work load, what would happen to timers that are running in =
kernel or interrupt space ? Would they then be too early ? Have negative =
values any negative effect besides running too early ?

In other words: when one uses timers inside Kernel, ISR's and User space =
at the same time, which value should be used for /proc/xenomai/latency ? =
Wouldn't it make sense then to have 3 different latency values for the 3 =
possible environments ?



Best regards,

Daniel Schnell.




-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: 3. ma=ED 2007 15:08
To: rpm@xenomai.org
Cc: Daniel Schnell; Xenomai-help@domain.hid
Subject: Re: [Xenomai-help] Latency calculation and test

Philippe Gerum wrote:
> Sidenote: It obviously makes no sense to stuff gigantic values into=20
> /proc/xenomai/latency; large core latencies are likely the sign of
> 1) a bug in the arch-dep section (probably Adeos), 2) inadequation of=20
> the hw for real-time usage (e.g. some ARM platforms with MMU, mmm...
> issues).

Here I disagree: if a platform run ten times slower than another, why =
not having a latency ten times bigger ?


> Said differently, I had no clue, so I'm expecting users to have some.

Additionnaly, the latency depends on the kind of load put on the system =
during the test. A user is expected to calibrate the nucleus latency of =
his system under the particular load which is expected on his system.

We should add a page on the wiki about the latency calibration.

--=20
                                                 Gilles Chanteperdrix

