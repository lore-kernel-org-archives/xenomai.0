Message-ID: <21969019.1184569651818.JavaMail.ngmail@domain.hid>
Date: Mon, 16 Jul 2007 09:07:31 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <46973753.6010206@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <46973753.6010206@domain.hid> <4694ED98.6000000@domain.hid>
	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	<1982070.1184078400928.JavaMail.ngmail@domain.hid>	<4693A702.1010604@domain.hid>
	<913919.1184311634860.JavaMail.ngmail@domain.hid>
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

I left my PC running the whole weekend using the kernel command line parame=
ter "nmi_watchdog=3D1".
However, using this option, the PC did not freeze at all...
This is really ugly.
The kernel configuration was the same I mailed a couple of days ago.

Also, I tried (a couple of hours) to run with Xeno debugging (Nucleus debug=
ging and Watchdog support) enabled. However, this did not lead to a freeze =
either.

This seems to be a really nasty timing issue...

Any ideas on how to continue are welcome.

Regards

Mathias

> > I did another test to identify the freeze. I have plugged in a POST-COD=
E
> 80 PCI board into the PC
> > and instrumented the code to write to port 80 to find out where the fre=
eze
> actually happens.
> > It seems not to return for rt_task_start as the last written POST code
> (see source code below)  is 0x30.
> > I hope to find a time slot to modify the kernel to do another test.
>=20
> Again: Please consider NMI watchdog and nucleus debugging support for
> those tests as well. Maybe (I dare to say: likely on SMP) they catch
> where the CPUs hang around instead of doing their work.
>=20
> > The bad thing is that it takes really long to get the freeze (up to a
> couple of hours).
>=20
> Your effort is appreciated even more!
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

