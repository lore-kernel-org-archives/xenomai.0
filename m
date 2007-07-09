From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <469250F0.9080601@domain.hid>
References: <46924A1A.4010909@domain.hid>
	<1183992374.6014.84.camel@domain.hid> <46924B1B.1010308@domain.hid>
	<4692501E.1060108@domain.hid>  <469250F0.9080601@domain.hid>
Content-Type: text/plain
Date: Mon, 09 Jul 2007 17:30:10 +0200
Message-Id: <1183995010.6014.102.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] __deprecated not defined for Linux 2.4
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2007-07-09 at 17:14 +0200, Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
> > Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Mon, 2007-07-09 at 16:45 +0200, Wolfgang Grandegger wrote:
> >>>> Hello,
> >>>>
> >>>> the attached patch changes:
> >>>>
> >>>>    2007-07-09  Wolfgang Grandegger  <wg@domain.hid>
> >>>>
> >>>>   * include/asm-generic/wrappers.h: add  __deprecated for Linux 2.4.
> >>>>
> >>> Merged, thanks.
> >>
> >> You are too fast for me - I was still test-building my approach!
> > 
> > Too fast? My i-Pipe patched Linux 2.4 kernel did simply not built ;-).
> 
> Yeah, and my 2.4 kernel was lying around in the corner, slightly dusty,
> definitely not touched for several months.
> 
> Hell, the amount of regressions one (specifically I) can produce due to
> all this config variants is amazing.

We all have a very well defined job in this project, and particularly:
- I do produce the original silly bugs.
- You are in charge of adding regressions to your past fixes of my bugs
- Dmitry is in charge of finding why our common code breaks.
- Wolfgang is in charge of making all the involved fixes compile
properly.
- Gilles is in charge of making the result run on bugous and/or sluggish
hardware.

Ok, all in all, my situation is the best one. Good.

>  What would be really nice is a
> playground for patches, some build system you could post a patch series
> and a set of .configs to and that will then "simply" try to generate
> various kernels and the xenomai userland for various archs
> automatically, reporting back any errors or warnings. Without going
> through SVN with the changes every time. Just a dream.

Niklaus already built most of this infrastructure for us, only the
automated patching part seems to be missing so far: 
http://ngiger.dyndns.org/buildbot/

We would also have to alleviate the burden of his server by providing
some dedicated hardware to do that, though.

> 
> Jan
> 
-- 
Philippe.



