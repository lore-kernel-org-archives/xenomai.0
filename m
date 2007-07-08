From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46908B79.30908@domain.hid>
References: <1183144465.6574.99.camel@domain.hid>  <46908B79.30908@domain.hid>
Content-Type: text/plain
Date: Sun, 08 Jul 2007 10:16:18 +0200
Message-Id: <1183882578.6014.58.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Support for 2.6.22/x86
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org


Hi Jim,

On Sun, 2007-07-08 at 01:00 -0600, Jim Cromie wrote:
> Philippe Gerum wrote:
> > Our development trunk now contains the necessary support for running
> > Xenomai over 2.6.22/x86. This work boils down to enabling Xenomai to use
> > the generic clock event device abstraction that comes with newest
> > kernels. Other archs / kernel versions still work the older way, until
> > all archs eventually catch up with clockevents upstream.
> >
> > This support won't be backported to 2.3.x, because it has some
> > significant impact on the nucleus. Tested as thoroughly as possible here
> > on low-end and mid-range x86 boxen, including SMP.
> >
> > Please give this hell.
> >
> > http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch
> >
> >   
> 
> Ive been running 22-rc7 on my Sony VAIO with this patch applied since 
> July 3,
> 
> the only thing wrong Ive seen is that perl ( both bleed and maint )
> is failing its time related regression tests.
> ie
>     rsync -avz rsync://public.activestate.com/perl-current/ .
>     rsync -avz rsync://public.activestate.com/perl-5.8.x .
> 
> Failed 3 tests out of 1429, 99.79% okay.
>         ../ext/Time/HiRes/t/HiRes.t
>         ../lib/Benchmark.t
>         op/time.t
> 
> the lib/Benchmark.t test is hanging, and must be killed manually

Thanks for the feedback.

Does this happen with the I-pipe switched off too?
Also, is Xenomai patched in your kernel with any of the skins statically
enabled, or just the I-pipe?

> .
> 
> These tests pass on Fedora -
> Linux harpo.jimc.earth 2.6.20-1.2962.fc6 #1 SMP Tue Jun 19 19:27:14 EDT 
> 2007 i686 i686 i386 GNU/Linux
> 
> thanks
> 
-- 
Philippe.



