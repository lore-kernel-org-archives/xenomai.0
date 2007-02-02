Message-ID: <19495517.1170421114020.JavaMail.ngmail@domain.hid>
Date: Fri, 2 Feb 2007 13:58:34 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
In-Reply-To: <1170420270.4981.58.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1170420270.4981.58.camel@domain.hid>
	<19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170408789.4981.1.camel@domain.hid> <1170409755.4981.11.camel@domain.hid>
	<45C309BF.9090808@domain.hid>  <1170415388.4981.36.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Hi Philippe,=20

I can. Which of the many values in /proc/vmstat is the relevant one to chec=
k?

Regards

Mathias

> On Fri, 2007-02-02 at 12:23 +0100, Philippe Gerum wrote:
> > On Fri, 2007-02-02 at 10:51 +0100, Gilles Chanteperdrix wrote:
> > > Philippe Gerum wrote:
> > > > On Fri, 2007-02-02 at 10:33 +0100, Philippe Gerum wrote:
> > > >=20
> > > >>On Fri, 2007-02-02 at 09:43 +0100, M. Koehrer wrote:
> > > >>
> > > >>>Hi everybody,
> > > >>>
> > > >>>I have a strange issue frequently when reading /proc/xenomai/stat.
> > > >>>I do a cat /proc/xenomai/stat and I get an "Cannot allocate memory=
"
> error.
> > > >>>This happens typcially after I have started and terminated by
> application that uses a number of tasks.
> > > >>>I am able to reproduce it deterministically...
> > > >>>While the application is running, I can see the stat values
> perfectly.
> > > >>>Here is the head output of all /proc/xenomai/* files:
> > > >>
> > > >>At first sight looking at the code, there seems to be a memory leak
> > > >>caused by an unfree kmalloc() block in the sched & stat sequence
> > > >>routines. Will confirm and fix. Thanks,
> > > >>
> > > >=20
> > > >=20
> > > > Not confirmed for the leakage part regarding kmalloc(). We do have =
a
> > > > seq_release_private() freeing the allocated block, so back to squar=
e
> #1.
> > > > This said, some kernel memory is not released somewhere, as running
> > > > vmstat tells me here.
> > > >=20
> > > > Btw, is the rest of your system functional after the error occurs, =
or
> is
> > > > a reboot needed afterwise?
> > >=20
> > > Do you observe the same leakage without the nocow patch ?
> > >=20
> >=20
> > Yes, 2.6.19-1.6-04 (without nowcow) has the same problem. But the
> > interesting things is that reading /proc/interrupts in loop seems to
> > silently eat kernel memory by small chunks too. I'm now trying on a
> > vanilla kernel.
> >=20
>=20
> Confirmed. A vanilla 2.6.19 silently eats memory when
> reading /proc/interrupts in loop. Mathias, could you please confirm this
> on your box too? TIA,
>=20
> --=20
> Philippe.
>=20
>=20
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

