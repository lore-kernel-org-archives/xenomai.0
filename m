Message-ID: <32098568.1184853156077.JavaMail.ngmail@domain.hid>
Date: Thu, 19 Jul 2007 15:52:36 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1184852543.28303.67.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1184852543.28303.67.camel@domain.hid>
	<24703926.1184851660664.JavaMail.ngmail@domain.hid>
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
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Hi all,

I got a freeze after 30 minutes running...
The bad thing is, that the PC was frozen but no Oops message was printed ou=
t...=20
This did not help at all...
I will run my system again with nmi_disable=3D1 (and the kernel debug activ=
e) to see if=20
I can catch a freeze...


Regards

Mathias
> > > Mathias, I guess this test has not been run with the nucleus debug
> > > option enabled. Any chance to get a disassembly of the rpi_pop routin=
e
> > > as compiled into your kernel, so that we could check if we are really
> > > stuck on this lock, or rather on some infinite walk into a corrupted
> RPI
> > > list?
> > I tried last week with debug on and I did not get the freeze...
> > However, I will try again. I will enable all Xeno debug options
> (CONFIG_XENO_OPT_DEBUG,
> > CONFIG_XENO_OPT_DEBUG_NUCLEUS, CONFIG_XENO_OPT_DEBUG_QUEUE,=20
> > CONFIG_XENO_OPT_WATCHDOG) and run the test again...
> >=20
> > For this test I leave CONFIG_XENO_OPT_RPIDISABLE unset (default).
> >=20
>=20
> Yes.
>=20
> > I hope to have more information on the results tomorrow morning...
> >=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

