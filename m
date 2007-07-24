Message-ID: <30117851.1185278735407.JavaMail.ngmail@domain.hid>
Date: Tue, 24 Jul 2007 14:05:35 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1185202908.5998.271.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1185202908.5998.271.camel@domain.hid>
	<16123805.1184916759093.JavaMail.ngmail@domain.hid>
	<1184890451.28303.356.camel@domain.hid>
	<1184852543.28303.67.camel@domain.hid>
	<24703926.1184851660664.JavaMail.ngmail@domain.hid>
	<32098568.1184853156077.JavaMail.ngmail@domain.hid>
	<25782679.1184932464850.JavaMail.ngmail@domain.hid>
	<1184933771.5998.3.camel@domain.hid>
Subject: Re: [Xenomai-core] RPI is good for you
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

Hi Philippe,

I have attached this patch to my application. So far it looks really good.
However, I leave my test running to be sure that it works.

Regards

Mathias=20


> On Fri, 2007-07-20 at 14:16 +0200, Philippe Gerum wrote:=20
> > On Fri, 2007-07-20 at 13:54 +0200, M. Koehrer wrote:
> > > Hi Philippe,
> > > I left my test running for a couple of hours - no freeze so far...=20
> > >=20
> > > However, I have to do some other stuff on this machine, I have to sto=
p
> the test now...
> > >=20
> >=20
> > Ok, thanks for the feedback. I will send an extended patch later today,
> > so that you could test it on a longer period when you see fit.
>=20
> It took me a bit longer than expected, but here is a patch which
> addresses all the pending issues with RPI, hopefully (applies against
> 2.3.1 stock).
>=20
> The good thing about Jan grumbling at me, is that this usually makes me
> look at the big picture anew. And the RPI picture was not that nice,
> that's a fact.
>=20
> Beside the locking sequence issue, the ex-aequo #1 problem was that CPU
> migration of Linux tasks causing a RPI boost had some very nasty
> side-effects on RPI management, and would create all sort of funky
> situations I'm too shameful to talk about, except under the generic term
> of "horrendous mess".
>=20
> Now, regarding the deadlock issue, suppressing the RPI-specific locking
> entirely would have been the best solution, but unfortunately, the
> migration scheme makes this out of reach, at least without resorting to
> some hairy and likely unreliable implementation. Therefore, the solution
> I came with consists of making the RPI lock a per-cpu thing, so that
> most RPI routines are actually grabbing a _local_ lock wrt the current
> CPU, those routines being allowed hold the nklock as they wish. When
> some per-CPU RPI lock is accessed from a remote CPU, it is guaranteed
> that _no nklock_ may be held nested. Actually, the remote case only
> occurs once, in rpi_clear_remote(), and all its callers are guaranteed
> to be nklock-free (a debug assertion even enforces that).
>=20
> For the migration issue, the RPI transitions have been ironed out to
> make sure we deal properly with all the subtleties of the Linux load
> balancer.
>=20
> Mathias, please let me know if the attached patch improves the situation
> on your side.
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
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT F=DCR ALLE NEUEINSTEIGER
Jetzt bei Arcor: g=FCnstig und schnell mit DSL - das All-Inclusive-Paket
f=FCr clevere Doppel-Sparer, nur  34,95 =80  inkl. DSL- und ISDN-Grundgeb=
=FChr!
http://www.arcor.de/rd/emf-dsl-2

