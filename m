From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AC661D5.9090101@domain.hid>
References: <4AC2448B.1080500@domain.hid>
	<1254396765.2703.234.camel@domain.hid>  <4AC62883.1080908@domain.hid>
	<1254505304.2703.347.camel@domain.hid>  <4AC63CF0.7090001@domain.hid>
	<1254511088.2703.367.camel@domain.hid>  <4AC661D5.9090101@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 03 Oct 2009 00:20:39 +0200
Message-Id: <1254522039.2703.382.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Patrice Kadionik <patrice.kadionik@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Fri, 2009-10-02 at 22:25 +0200, Patrice Kadionik wrote:
> Hi all,
> Philippe Gerum a =C3=A9crit :=20
> > On Fri, 2009-10-02 at 19:48 +0200, Gilles Chanteperdrix wrote:
> >  =20
> > > Philippe Gerum wrote:
> > >    =20
> > > > > Ok. So, if we add the core skin fdtable, this leaves us with tw=
o items:
> > > > > - signals in primary domain
> > > > > - core skin fdtable
> > > > >=20
> > > > >        =20
> > > > Ack. Add the following I-pipe stuff as well:
> > > >=20
> > > > - nios2 design upgrade. Those FPGA thingies require a bit of supp=
ort to
> > > > be included into the soft-core in order to run a real-time system=
, like
> > > > a high precision timer and some stable monotonic clock source. Pa=
trice
> > > > Kadionik (the guy who lives there: http://uuu.enseirb.fr/~kadioni=
k/)
> > > > sent me an update for the FPGA design I used to do the initial po=
rt over
> > > > nios2. This is mostly a matter of a couple of hours to fix and va=
lidate
> > > > the I-pipe core accordingly, though.
> > > >      =20
> > > Maybe you could ask for a hardware implementation of mul64by64_high=
...
> > >    =20
> >=20
> > It looks like custom instructions are restricted to input(32bit x 2) =
=3D>
> > output(32bit).
> >  =20
> Yes you're right. Just 32-bit HW multipliers at this time for the NIOS
> II softcore.
> > Patrice, do you confirm, or would it be possible to implement such
> > instruction, that would return the highest 32 bits from a 64 x 64
> > multiply op? We need this to speed up some arithmetics, especially on=
 a
> > 50Mhz CPU.
> >=20
> >  =20
> Yes, it would be always possible to develop such a specific multiplier
> in VHDL . I just have a doubt to integrate it as a NIOS II custom
> instruction...
> > If we can't, well, I will likely have to subject myself to write a sm=
all
> > assembly block doing just this, because gcc's output is likely not go=
ing
> > to look like the way Gilles wants.
> >=20
> >  =20
> You have in the NIOS II Instruction Set Reference the multiply
> extended (mulxuu...) instruction for this at this time.
>=20

Ok, let's go the assembly way.

>=20
> Cheers,
>=20
> Patrice
> > > > - powerpc32 updates for 2.6.30. Mainly to merge the once experime=
ntal
> > > > bits that prevent most alignment faults from triggering a seconda=
ry mode
> > > > switch. Andreas told me this works like a charm on 83xx, and I di=
d not
> > > > see any issue on 52xx, 85xx or 86xx either.
> > > >=20
> > > > - probably blackfin updates. I need to have a closer look, but I'=
m
> > > > afraid I will have to resync with mainline before 2.5.0 is out. B=
lackfin
> > > > folks never sleep it seems.
> > > >=20
> > > > - x86* updates to issue patches for the 2.6.30-stable and 2.6.31-=
stable
> > > > series.
> > > >=20
> > > > You may have a few ARM patches brewing as well?
> > > >      =20
> > > Actually yes. The "pic mute" feature was disabled on AT91 because i=
t was
> > > causing latency peaks, but I plan to enable it ultimately. I think =
the
> > > latency peaks were due to the fact that I was testing a 2.4 with th=
e bug
> > > which we fixed in 2.4.9.1, I just need to check that. And if pic mu=
te
> > > works on AT91, then I would implement it for other SOCs. And an upg=
rade
> > > to 2.6.31 would be fine too.
> > >=20
> > >    =20
> >=20
> > Ok. How many interrupt controllers would be impacted by the PIC mute
> > feature?
> >=20
> >  =20
>=20
--=20
Philippe.



