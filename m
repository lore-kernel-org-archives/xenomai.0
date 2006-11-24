Message-ID: <24272255.1164380283049.JavaMail.ngmail@domain.hid>
Date: Fri, 24 Nov 2006 15:58:03 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Aw: Re: Aw: Re: [Xenomai-help] Strange SIGXCPU signal at
In-Reply-To: <1164379061.4973.65.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1164379061.4973.65.camel@domain.hid> <1164377274.4973.62.camel@domain.hid>
	<29451992.1164376099993.JavaMail.ngmail@domain.hid>
	<29192885.1164378650832.JavaMail.ngmail@domain.hid>
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

HI Philippe,=20

> > unfortunately this patch did not help.
> > It is the same situation as before.
> >=20
>=20
> Mm, ok, thanks for trying this out. Is T_WARNSW passed to
> rt_task_create() in your case?
No, I pass T_FPU | T_CPU(0)

Well, I have decided to restructure the application to create the tasks
only once during lifetime (which has some other benefits as well).
That means, that this issue hopefully will no longer hurt...

Thanks a lot

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

