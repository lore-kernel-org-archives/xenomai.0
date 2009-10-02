From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AC62883.1080908@domain.hid>
References: <4AC2448B.1080500@domain.hid>
	<1254396765.2703.234.camel@domain.hid>  <4AC62883.1080908@domain.hid>
Content-Type: text/plain
Date: Fri, 02 Oct 2009 19:41:44 +0200
Message-Id: <1254505304.2703.347.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Fri, 2009-10-02 at 18:21 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Tue, 2009-09-29 at 19:31 +0200, Gilles Chanteperdrix wrote:
> >> Hi guys,
> >>
> >> full of energy after this tremendous first XUM,
> > 
> > Agreed, thanks to the DENX folks for having thought of it in the first
> > place, and organized it nicely.
> > 
> >>  I would like to start a
> >> discussion about what people would like to see in the 2.5 branch.
> >>
> > 
> > Jan has described the situation quite accurately already, regarding the
> > trade-off between getting everything we want into 2.5 so that no 2.6 is
> > required, and releasing the too long-awaited 2.5 asap.
> > 
> > As you mentioned already, the key issue is ABI stability.
> > Any change we want before 3.0 that breaks the ABI should preferably go
> > to 2.5, so that we don't end up maintaining 2.5.x, 2.6.x and 3.x. At any
> > rate, we could not afford the latter anyway. This is a different matter
> > than API issues; we already allowed API extensions during a stable
> > cycle, provided they do not break existing application code (except in
> > emergency cases), so I see no problem in pushing a few more services to
> > 2.5.1 and beyond, provided that condition is met.
> > 
> >> Here is a first list, please feel free to criticize it:
> >> - signals in primary domain (something that we almost forgot)
> > 
> > Yes, this one must be in. At least, we should break the ABI one more
> > time for this before releasing 2.5.0. This item has priority #1 for
> > me, since providing that infrastructure will enable a series of
> > additional services to be implemented properly. In fact, this is more a
> > matter of allowing nucleus callouts to user-space than anything else;
> > POSIX RT signals in full primary mode being an application of them.
> 
> Ok. So, if we add the core skin fdtable, this leaves us with two items:
> - signals in primary domain
> - core skin fdtable
> 

Ack. Add the following I-pipe stuff as well:

- nios2 design upgrade. Those FPGA thingies require a bit of support to
be included into the soft-core in order to run a real-time system, like
a high precision timer and some stable monotonic clock source. Patrice
Kadionik (the guy who lives there: http://uuu.enseirb.fr/~kadionik/)
sent me an update for the FPGA design I used to do the initial port over
nios2. This is mostly a matter of a couple of hours to fix and validate
the I-pipe core accordingly, though.

- powerpc32 updates for 2.6.30. Mainly to merge the once experimental
bits that prevent most alignment faults from triggering a secondary mode
switch. Andreas told me this works like a charm on 83xx, and I did not
see any issue on 52xx, 85xx or 86xx either.

- probably blackfin updates. I need to have a closer look, but I'm
afraid I will have to resync with mainline before 2.5.0 is out. Blackfin
folks never sleep it seems.

- x86* updates to issue patches for the 2.6.30-stable and 2.6.31-stable
series.

You may have a few ARM patches brewing as well?

-- 
Philippe.



