Message-ID: <2ff1a98a0708030142i1fc6e532o25f9bb592f85cc82@domain.hid>
Date: Fri, 3 Aug 2007 10:42:08 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80708030127r2a9b5c8as49139fed67369644@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2ff1a98a0707180135q24ab6515kf573215edf0aaafa@domain.hid>
	<2862c2c80707180255h7197a055i58b90228bc2c52df@domain.hid>
	<2ff1a98a0707180739y59f673c3tc7d8668877686212@domain.hid>
	<2862c2c80707182309r2d49f8b6xeb85601230a4be43@domain.hid>
	<18095.41752.74240.393339@domain.hid>
	<18095.43878.759358.210266@domain.hid>
	<2862c2c80707312153w1765ceaeo9d81a55db2ce6dea@domain.hid>
	<18098.23646.615920.431030@domain.hid>
	<2862c2c80708030127r2a9b5c8as49139fed67369644@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 8/3/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> On 8/3/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> >
> > Yeoh Chun Yeow wrote:
> > > Dear Gilles,
> > >
> > > Did you figure out what is wrong with the I-PIPE patch?
> > >
> > > My kernel hangs at this stage, not even until the mounting of NFS:
> > > udc: at91_udc version 3 May 2006
> > > mice: PS/2 mouse device common for all mice
> > > AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire
> > > TCP cubic registered
> > > NET: Registered protocol family 1
> > > NET: Registered protocol family 17
> > >
> > > I find out that the problem is not coming from "excessive" interrupts
> that I
> > > faced last time.
> > >
> > > Yes, when I-PIPE disabled, everything works fine.
> >
> > Ok, I got it. The problem is that the I-pipe patch registers its own
> > clock object for the tc it uses. This is fine with the stock kernel
> > which does not registers clock objects for tcs. But it fails to work
> > with the AT91 patch, because the AT91 patch registers and disables the
> > TC clocks. So, the solution is to use the kernel clock objects if they
> > exist. This way, the I-pipe patch works with or without the AT91 patch.
> > Attached a patch which does that.
> >
> Dear Gilles,
>
> Thanks. I get what you mean and the problem is solved.
>
> I saw the registration of TCs in the at91rm9200.c. Anyway, can you pinpoint
> where the TC clocks are disable?

at91_periphclk_reset in arch/arm/mach-at91rm9200/clock.c turns off all
unused clocks.

-- 
                                               Gilles Chanteperdrix

