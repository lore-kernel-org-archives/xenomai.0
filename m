Message-ID: <25501221.1198142506055.JavaMail.ngmail@domain.hid>
Date: Thu, 20 Dec 2007 10:21:46 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: [Xenomai-help] [RTnet-users] /proc/xenomai/affinity and
	T_CPU(n) in
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

	rt_task_create
Cc: xenomai@xenomai.org, rtnet-users@domain.hid
In-Reply-To: <47693FE6.30707@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <47693FE6.30707@domain.hid> <5864711.1198077318353.JavaMail.ngmail@domain.hid>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 91.32.110.150

Hi Jan,

does this mean that the value of /proc/xenomai/affinity is only relevant fo=
r creation of a new task?
I.e., once it is created I can modify it without "destroying" anything in t=
he already created tasks?=20
If this is the case I think I get everything up and running following your =
hint.

Perhaps the word "affinity" does not exactly describe the behaviour here as=
 it is not only affinity but also=20
"allowed CPUs for new tasks"....

Thanks a lot.

Regards

Mathias



>=20
> Suggested procedure:
> 1. set global affinity for RTnet and start up the stack
> 2. set global affinity for your application (or open it) and start that
>    one up
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT F=DCR ALLE NEUEINSTEIGER
Jetzt bei Arcor: g=FCnstig und schnell mit DSL - das All-Inclusive-Paket
f=FCr clevere Doppel-Sparer, nur  29,95 Euro  inkl. DSL- und ISDN-Grundgeb=
=FChr!
http://www.arcor.de/rd/emf-dsl-2

