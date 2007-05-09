Message-ID: <13086080.1178713660670.JavaMail.ngmail@domain.hid>
Date: Wed, 9 May 2007 14:27:40 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <4641B5CF.80303@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4641B5CF.80303@domain.hid>
	<22908039.1178707932628.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized for
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
=20
primarily I want to execute my simulation models as fast as possible. This =
is, I want=20
to optimize the average execution time. As there are a series of critical s=
ections to
be passed this should also have an impact on the worst execution time.

The critical region in the simulation are at locations when a lower prio th=
read and a higher
prio thread access the same data. This happens at a couple of times within =
a simulation step=20
(within that critical region there are typically some copy operations).
However, once the higher prio thread has entered one critical region it is =
sure (at least if
both threads run on the same CPU core) that it will be able to enter the ne=
xt critical region without
waiting.
That means, that improving the average runtime should also help to improve =
the worst case
runtime of the highest prio thread.

Regards

Mathias
>=20
> Your analysis is not wrong. But before going into any detail may I ask
> you for on clarification: What do you want to optimise *primarily*, the
> average execution time of your RT threads in order to gain more CPU time
> for non-RT Linux jobs *or* the worst case execution time of your RT
> threads?
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

