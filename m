Message-ID: <12423528.1184136237522.JavaMail.ngmail@domain.hid>
Date: Wed, 11 Jul 2007 08:43:57 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <4693A702.1010604@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4693A702.1010604@domain.hid> <46937E70.10903@domain.hid>
	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
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

as I mentioned in my first mail on this topic, I have extracted this exampl=
e from a huge
real time application where the system sporadically freezes.
What I have found out there was, that the system freeze happened always whe=
n trying
to start a thread (in the original application, the tasks run fairly long).
I think it has to do with rt_task_start() followed by usleep() and the non-=
realtime stuff running
on CPU 0 and the realtime stuff running on CPU 1.
I never saw that issue on a single core CPU (even if the same SMP kernel wa=
s used).

Regards

Mathias


> M. Koehrer wrote:
> > Hi Jan,
> >=20
> > yes, it terminates nicely.
> > I have attached my config.
>=20
> Nothing obvious. Leaves us with probable timing differences or the
> different versions of our setups (I found this over 2.3.2 and trunk).
>=20
> OK, further analysis on your side would be appreciated. E.g. trying the
> latest release, switching on debug features in Xenomai like the NMI
> watchdog or nucleus debugging. Also, nailing down what service call
> precisely locks up (the join, the termination of the task, etc.) would
> be good to reduce the search space.
>=20
> Jan
>=20
>=20
>=20
> --------------------------------
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
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

