Message-ID: <32472916.1184157954131.JavaMail.ngmail@domain.hid>
Date: Wed, 11 Jul 2007 14:45:54 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <469487A7.8030204@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <469487A7.8030204@domain.hid> <4693A702.1010604@domain.hid>
	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<12423528.1184136237522.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Sporadic PC freeze after rt_task_start
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

I tried with Xenomai 2.3.2 and (still) the kernel 2.6.20.4 - same configura=
tion as before.
I used the adeos patch for 2.6.20 that is part of Xenomai 2.3.2
Same effect.
The system freezes...

Regards

Mathias

> M. Koehrer wrote:
> > Hi Jan,
> >=20
> > as I mentioned in my first mail on this topic, I have extracted this
> example from a huge
> > real time application where the system sporadically freezes.
> > What I have found out there was, that the system freeze happened always
> when trying
> > to start a thread (in the original application, the tasks run fairly
> long).
>=20
> OK, so it's one of rt_task_create (unlikely), rt_task_start, usleep, or
> some early code in the task function itself. Still, a lot of "or"...
>=20
> Again, please consider my further debugging suggestions.
>=20
> > I think it has to do with rt_task_start() followed by usleep() and the
> non-realtime stuff running
> > on CPU 0 and the realtime stuff running on CPU 1.
> > I never saw that issue on a single core CPU (even if the same SMP kerne=
l
> was used).
>=20
> Yeah, it must be a nice race that requires real parallelism.
>=20
> Jan
>=20
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

