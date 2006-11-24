Message-ID: <29192885.1164378650832.JavaMail.ngmail@domain.hid>
Date: Fri, 24 Nov 2006 15:30:50 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Aw: Re: [Xenomai-help] Strange SIGXCPU signal at rt_task_trampoline
In-Reply-To: <1164377274.4973.62.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1164377274.4973.62.camel@domain.hid>
	<29451992.1164376099993.JavaMail.ngmail@domain.hid>
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

unfortunately this patch did not help.
It is the same situation as before.

Regards

Mathias
> > I have the strange effect, that I get a reproducable SIGXCPU signal in =
gdb
>=20
> > when running my Xenomai (native skin) application.
> > It occurs in rt_task_trampoline() within the do..while loop.
> > The situation is that I am re-creating and starting a task that has bee=
n=20
> > terminated before.
> > Unfortunately I was not able to create a very simple application that
> shows this
> > effect.
> > I am using xenomai (SVN 1882), Pentium 4, gcc 4.1.2
> > I have enclosed the output of the gdb session:
> >=20
>=20
> Could you try this? TIA,


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

