Message-ID: <962875.1173800188148.JavaMail.ngmail@domain.hid>
Date: Tue, 13 Mar 2007 16:36:28 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
In-Reply-To: <1173799174.16997.47.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1173799174.16997.47.camel@domain.hid>
	<11906791.1173797505269.JavaMail.ngmail@domain.hid>
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
Cc: xenomai@xenomai.org

Hi Philippe,

thanks for your mail.
I retried everything with all the files that are in the official Xenomai 2.=
3.0 tar.bz2 file.
I.e. I used kernel 2.6.19.2 and the adeos-ipipe-2.6.19-i386-1.6-03.patch th=
at is in this version.
The same result.
It is a SMP kernel on a Dual Core Pentium. I use a isolcpus=3D1 kernel comm=
and line.

I am about to try the latest svn version of Xenomai and a 2.6.20.2 kernel.

I will let you know when I have found out more...

Regards

Mathias
>=20
> This would be the the sign that a problem exists at the I-pipe level
> with your current patch. The fault should have been propagated form
> primary to secondary domain, and obviously it's not.
>=20
> >=20
> > How can I catch a signal in a Xenomai real time task?
> >=20
>=20
> There is no difference with any regular Linux application.
>=20
> > I am running Xenomai 2.3.0 + NOCOW patch.
> > I have enclosed the .c file and a Makefile in a .tgz file.
>=20
> Can't reproduce the issue with 1.7-03 here.
> Please make sure to use a recent and official I-pipe patch if it's not
> already the case, and not a testing patch as published on this list, so
> that we don't start chasing wild gooses.
> http://download.gna.org/adeos/patches/v2.6/
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

