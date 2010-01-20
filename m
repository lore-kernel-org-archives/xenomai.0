From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100117225108.71A21C88AE@gemini.denx.de>
References: <4B209B9C.7010309@domain.hid>
	<20100108105925.GA14163@domain.hid>
	<1262949018.2455.5.camel@domain.hid>
	<1263312199.2455.169.camel@domain.hid>
	<20100112172443.GP8605@domain.hid>
	<1263318551.2455.188.camel@domain.hid>
	<20100112185012.GQ8605@domain.hid>
	<1263324215.2455.293.camel@domain.hid>
	<20100112221802.GR8605@domain.hid>
	<20100114075343.GA5179@domain.hid>
	<1263765606.2428.908.camel@domain.hid>
	<20100117225108.71A21C88AE@gemini.denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jan 2010 23:27:22 +0100
Message-ID: <1264026442.2350.44.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main] I-pipe for 2.6.32 PPC
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org, Lennart Sorensen <lsorense@domain.hid>

On Sun, 2010-01-17 at 23:51 +0100, Wolfgang Denk wrote:
> Dear Philippe,
> 
> in message <1263765606.2428.908.camel@domain.hid> you wrote:
> >
> > What we may be aiming at, if workable, is something like:
> > 
> > ipipe-*-mainline
> > ipipe-*-amcc
> > ipipe-*-512x
> 
> This sounds fine to me.
> 
> I guess we don't even need a 'ipipe-*-amcc' branch - the only things
> that should be in our tree but not in mainline are the Synopsis USB
> and S-ATA drivers (which are in such a state that they have no chance
> of being accepted for mainline), and these additional features are
> probably not of relevance for use with Xenomai.
> 

The 8250 serial support put aside, I don't think we have any hunks in
non-core Linux code, so we likely don't need this branch indeed.

> ACK for 'ipipe-*-512x', but this is a work-in-progress tree, with the
> clear intention to push this stuff into mainline ASAP.
> 

Ok.

> > Maybe one for the PA6T as well, if we want to keep supporting the old A2
> > board rev. I'm unsure right now, since B0 is fine in mainline already.
> 
> Are there any significant differences between A2 and Bx as far as
> Xenomai in concerned? I mean, would a mainline patch (for Bx) be
> missing anything so it doesn't run on A2?

Basically the work-arounds to fix the A2 errata; some of them have to be
adapted to run in any context from the pipeline code (some bits in the
process switching and tlbie handling code come to mind). This said, this
could be solved by a supplemental patch moving those work-arounds on top
of a mainline-based support.

> 
> > A mainline pipeline branch for everything that directly works over
> > mainline, and platform-specific branches for those that do not. Those
> > special branches would then disappear as soon as mainline is fine for
> > the platforms they host as well.
> 
> I like this approach :-)
> 

Ok, thanks. ETA is in the 2.6.33 time frame.

> Best regards,
> 
> Wolfgang Denk
> 


-- 
Philippe.



