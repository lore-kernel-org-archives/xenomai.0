From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AC63CF0.7090001@domain.hid>
References: <4AC2448B.1080500@domain.hid>
	<1254396765.2703.234.camel@domain.hid>  <4AC62883.1080908@domain.hid>
	<1254505304.2703.347.camel@domain.hid>  <4AC63CF0.7090001@domain.hid>
Content-Type: text/plain
Date: Fri, 02 Oct 2009 21:18:08 +0200
Message-Id: <1254511088.2703.367.camel@domain.hid>
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
Cc: Patrice Kadionik <patrice.kadionik@domain.hid>, Xenomai core <Xenomai-core@domain.hid>

On Fri, 2009-10-02 at 19:48 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> >> Ok. So, if we add the core skin fdtable, this leaves us with two items:
> >> - signals in primary domain
> >> - core skin fdtable
> >>
> > 
> > Ack. Add the following I-pipe stuff as well:
> > 
> > - nios2 design upgrade. Those FPGA thingies require a bit of support to
> > be included into the soft-core in order to run a real-time system, like
> > a high precision timer and some stable monotonic clock source. Patrice
> > Kadionik (the guy who lives there: http://uuu.enseirb.fr/~kadionik/)
> > sent me an update for the FPGA design I used to do the initial port over
> > nios2. This is mostly a matter of a couple of hours to fix and validate
> > the I-pipe core accordingly, though.
> 
> Maybe you could ask for a hardware implementation of mul64by64_high...

It looks like custom instructions are restricted to input(32bit x 2) =>
output(32bit).

Patrice, do you confirm, or would it be possible to implement such
instruction, that would return the highest 32 bits from a 64 x 64
multiply op? We need this to speed up some arithmetics, especially on a
50Mhz CPU.

If we can't, well, I will likely have to subject myself to write a small
assembly block doing just this, because gcc's output is likely not going
to look like the way Gilles wants.

> 
> > 
> > - powerpc32 updates for 2.6.30. Mainly to merge the once experimental
> > bits that prevent most alignment faults from triggering a secondary mode
> > switch. Andreas told me this works like a charm on 83xx, and I did not
> > see any issue on 52xx, 85xx or 86xx either.
> > 
> > - probably blackfin updates. I need to have a closer look, but I'm
> > afraid I will have to resync with mainline before 2.5.0 is out. Blackfin
> > folks never sleep it seems.
> > 
> > - x86* updates to issue patches for the 2.6.30-stable and 2.6.31-stable
> > series.
> > 
> > You may have a few ARM patches brewing as well?
> 
> Actually yes. The "pic mute" feature was disabled on AT91 because it was
> causing latency peaks, but I plan to enable it ultimately. I think the
> latency peaks were due to the fact that I was testing a 2.4 with the bug
> which we fixed in 2.4.9.1, I just need to check that. And if pic mute
> works on AT91, then I would implement it for other SOCs. And an upgrade
> to 2.6.31 would be fine too.
> 

Ok. How many interrupt controllers would be impacted by the PIC mute
feature?

-- 
Philippe.



