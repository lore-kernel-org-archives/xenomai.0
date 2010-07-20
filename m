From: Tim Cussins <timcussins@domain.hid>
In-Reply-To: <1279210298.1995.38.camel@domain.hid>
References: <1278943817.7023.18.camel@domain.hid>  <4C3EF6D6.6040907@domain.hid>
	<1279210298.1995.38.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Jul 2010 12:00:45 +0100
Message-ID: <1279623645.2187.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Marvell sheeva support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi guys,

I hope you don't mind if I reply to you together.

On Thu, 2010-07-15 at 18:11 +0200, Philippe Gerum wrote:
> On Thu, 2010-07-15 at 13:53 +0200, Gilles Chanteperdrix wrote:
> > Tim Cussins wrote:
> > > Hi all,
> > > 
> > > We're looking at migrating to one of Marvell's MV88F series SOC's, and
> > > are very keen to deploy Xenomai as part of our solution.
> > > 
> > > I noticed Sergey Didenko was looking at this a few months back and
> > > things looked to be ok - has his (or anyone else's) work made it into a
> > > stable release?
> > > 
> > > I will be able to assist in about a fortnight if that would be useful
> > > for squaring that work away.
> > > 
> > > Let me know if I can help!
> > 
> > We are interested. I seem to remember that Serguey had unexplained
> > latencies issues, so, if you start with his work, please bear this in
> > mind, there was probably something wrong with his port. A guide
> > explaining how to port the I-pipe patch on ARM exists:
> > http://www.xenomai.org/index.php/I-pipe:ArmPorting

> > The section about chained GPIOs irqs is outdated, if your platform has
> > some, I will explain how it should be implemented.
> > 
> > Please start from the I-pipe git (git://git.denx.de/ipipe-2.6.git),
> > merging it with the branch you will use if needed, so that you can
> > submit a patch only containing the modifications necessary for the
> > Sheeva platform.

Not a problem :)

> > We can also provide you with a root filesystem for validating this platform.

That would be brilliant. I imagine I'll be iterating though uImages on
an SD card loaded with your rootfs. Sound ok? Let me know how to obtain
the rootfs (or better, show me how you prefer to do it, so I learn
something! Ta.)

> 
> You can also use the patch below as a starting point for your port:
> http://download.gna.org/adeos/patches/tmp/adeos-ipipe-2.6.29-mv88f6290.patch

I've tried applying this to vanilla 2.6.29 and 2.6.29.6 - it doesn't
apply cleanly (well, fails :P). Am I approaching this the wrong way?
Also tried chucking the patch into the xenomai tree and getting
prepare_kernel.sh to try: still no joy.

> caveats:
> 
> - it is based on an old kernel release, and moving to 2.6.3x would
> require some work. If you need so, then you should merge the
> arm-dependent bits from the patch above with the generic I-pipe bits
> from a newer release as available here (e.g. 2.6.33):
> http://download.gna.org/adeos/patches/v2.6/arm/

Building and running the current patch (2.6.29) seems like a reasonable
starting point, but producing a 2.6.33 patch seems like the right thing
to do...

> - the fcse implementation in that patch won't work with the l2 outer
> cache enabled. The two options have been made mutually exclusive via
> Kconfig.

Out of interest: is this a fundamental limitation, or do you believe
that the L2 and FCSE might be happy together after a bit of work?

>  you should use Xenomai 2.5.3 or above to get this running.
> 
> As a reference point, the worst-case scheduling latency for user-space
> threads, observed on a mv88f6290 using that patch with fcse enabled (no
> l2), is below 70 us.

That's brilliant. Our requirements aren't for super-low latency, but
definitely realtime. We might go with L2 and no FCSE if the latency is
still ok. Just FYI :)

> HTH,
> 

Yep, thanks. I'll be able to do this work: I'm just trying to estimate
how long it'll take me to get up to speed and produce a patch for 2.6.33.
Any thoughts on the volume and nature of the work remaining would be helpful.

Cheers,
Tim


