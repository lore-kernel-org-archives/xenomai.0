Message-ID: <16382545.1166699974895.JavaMail.ngmail@domain.hid>
Date: Thu, 21 Dec 2006 12:19:34 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>
	<31078593.1166623877982.JavaMail.ngmail@domain.hid>
	<45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<458A4DE0.5030005@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Re: Re: A fairly small rtnet/Xenomai application
	that freezes the
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: dmitry.adamushko@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Hi Dmitry,=20

thanks for your response.
>=20
>=20
> Is it still true that when you place printf() right after the system()
> call, it works?
Yes, a printf() directly after the system() fixes the issue.

>=20
> What happens when you try different sleep intervals : 0, say 1000 ?
>=20
> Just to be sure where we are stuck. Insert exit() (or rt_task_delete(NULL=
))
> :
>=20
> (0) after system() --- if said above about printf() is not true;
> (1) after rt_task_sleep();
> (2) after printf("rt_task_sleep done...\n").
I have added a hacky trace mechanism in the kernel to see what's happening
(whenever the nmi_watchdog with the kernel oops appears).
What I can see is that rt_task_sleep(); is completely passed.
If I modify my application to add a second rt_task_sleep() directly after t=
he
existing one, I see the both rt_task_sleep() calls are passed.
The freeze seems to happen with the printf() call after the rt_task_sleep.
Unfortunately, I do not know where I can trace here...

Best regards

Mathias


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

