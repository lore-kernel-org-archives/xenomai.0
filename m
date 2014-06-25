Date: Wed, 25 Jun 2014 19:13:29 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Message-ID: <20140625171329.GC19569@lukather>
References: <20140610095422.GK9791@lukather> <5396D780.4020704@xenomai.org>
 <20140611092532.GE4254@lukather> <53989CEF.3080205@xenomai.org>
 <20140612075401.GH4254@lukather> <539966B7.3080900@xenomai.org>
 <20140612150313.GA3448@lukather> <539B4A85.7030302@xenomai.org>
 <20140623140559.GE19730@lukather> <53A8BBD6.3020701@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53A8BBD6.3020701@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Atmel SAMA5D3 with a 3.14 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Michael Opdenacker <michael@free-electrons.com>, Thomas Petazzoni <thomas@free-electrons.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine@free-electrons.com>

On Tue, Jun 24, 2014 at 01:44:22AM +0200, Gilles Chanteperdrix wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 06/23/2014 04:05 PM, Maxime Ripard wrote:
> > On Fri, Jun 13, 2014 at 09:01:25PM +0200, Gilles Chanteperdrix
> > wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> On 06/12/2014 05:03 PM, Maxime Ripard wrote:
> >>> On Thu, Jun 12, 2014 at 10:37:11AM +0200, Gilles Chanteperdrix 
> >>> wrote:
> >>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>> 
> >>>> On 06/12/2014 09:54 AM, Maxime Ripard wrote:
> >>>>> On Wed, Jun 11, 2014 at 08:16:15PM +0200, Gilles
> >>>>> Chanteperdrix wrote:
> >>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>>>> 
> >>>>>> On 06/11/2014 11:25 AM, Maxime Ripard wrote:
> >>>>>>> On Tue, Jun 10, 2014 at 12:01:36PM +0200, Gilles 
> >>>>>>> Chanteperdrix wrote:
> >>>>>>>> If you compile the kernel without I-pipe and Xenomai 
> >>>>>>>> support and enable the tcb_clksrc clocksource driver
> >>>>>>>> does it work?
> >>>>>>> 
> >>>>>>> Yep, with the exact same config, except for
> >>>>>>> CONFIG_IPIPE and CONFIG_XENOMAI being disabled, it
> >>>>>>> boots fine.
> >>>>>>> 
> >>>>>> Read again, I am not insterested in exactly the same
> >>>>>> config, I am interested in the a config with tcb_clksrc
> >>>>>> clocksource, which is disabled by CONFIG_IPIPE. Only if
> >>>>>> you enable this clocksource do you get to use the
> >>>>>> atmel_tclib code.
> >>>>> 
> >>>>> Let me rephrase then. It works with the exact same config,
> >>>>> with CONFIG_IPIPE and CONFIG_XENOMAI disabled, and 
> >>>>> CONFIG_ATMEL_TCB_CLKSRC enabled.
> >>>> 
> >>>> Then I would tend to think that the clocksource is not your 
> >>>> problem and repeat that you should check everything else in
> >>>> the porting guide.
> >>> 
> >>> Ok. I will.
> >>> 
> >> Looking rapidly at the code, at least the irq controller and pic 
> >> muting need fixing.
> > 
> > Ok, so, a bit of news on this one.
> > 
> > After fixing the irq controller to work on the AIC5, and disabling
> > the pic muting, I get almost 100% of the time a system freeze when
> > running: 
> > http://git.free-electrons.com/training-materials/tree/lab-data/realtime/rttest/data/rttest.c
> >
> >  The TCB timer is still ticking, at a rate around 1Hz, while, when
> > the system hangs, the PIT interrupt isn't firing anymore (which
> > explains the freeze). So there's probably something wrong related
> > to the ipipe I guess, or the interrupt being masked and not
> > unmasked at some point.
> 
> Well:
> - - the existing at91 I test also use a PIT and they do not hang
> - - if you disabled the pic muting, noone is disabling the PIT interrupt.
> 
> So, I would suggest looking carefully at the sama5 code.

Ok, that's good to know. I'll look a bit more at this and what we did
for the AIC5 then.

Thanks again!
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
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140625/8d54ee08/attachment.sig>
