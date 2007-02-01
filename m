Message-ID: <7286181.1170341643748.JavaMail.ngmail@domain.hid>
Date: Thu, 1 Feb 2007 15:54:03 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: : [Xenomai-help] Running real time task on one of the cores of
In-Reply-To: <45C1EBF9.1060409@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <45C1EBF9.1060409@domain.hid>
	<16848045.1170336251056.JavaMail.ngmail@domain.hid>
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

Hi Jan,=20

I tried to apply the patch of #2011 to the 2.3 Xenomai and this works fine.
I can now determine the CPU to run all real time stuff by writing into
/proc/xenomai/affinity.

Thanks a lot.

Mathias
> > I found it in the latest SVN version but not in the 2.3 Xenomai...=20
> > As my system is working currently very stable, I do not want to change =
the
> Xenomai version...
>=20
> Oh, indeed, that got merged after the release. Obviously I'm too
> bleeding-edge focused. :)
>=20
> Try to extract the diff of #2011 and apply it on your tree. This should
> fit seamlessly.
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

