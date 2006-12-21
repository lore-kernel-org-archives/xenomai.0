Message-ID: <23277778.1166700903619.JavaMail.ngmail@domain.hid>
Date: Thu, 21 Dec 2006 12:35:03 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <458A67B6.8000207@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <458A67B6.8000207@domain.hid> <458A4DE0.5030005@domain.hid>
	<31078593.1166623877982.JavaMail.ngmail@domain.hid>
	<45894179.8060805@domain.hid> <4587E404.2050101@domain.hid>
	<4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
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
To: gilles.chanteperdrix@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Hi Gilles,

thanks for your answer.
That is quite interesting.=20
I have added your function and placed at call to it directly after
the system() call. Then, everything works fine.
However, a couple of questions come up:

1.) Why does a printf() directly after the system() seems to help aswell?
I do not think, that printf cares about write protection of pages...

2.)  I think, I never saw this behaviour with the 2.6.17.* kernel, only wit=
h the
2.6.19.1. Is there any difference related to that?
I will doublecheck this.

3) On Jan's PC, the issue never appears, as he has a slower PC.
How can that be related to that?

4.) Could this somehow be handled by Xenomai? Well, adding the function
is - in my eyes - a workaround around the issue, but I expect Xenomai to=20
do this things for me. It needs a lot of "magic knowledge" to get this runn=
ing...
Another approach could be to encapsulate this somehow in the native library
(and in the other libraries) and to document clearly, that fork and related=
 functions
should not be called out of the realtime task without additional cleanup co=
de.

Anyway, this seems to be the right track!

Regards

Mathias

> > I have stripped down my program that is crashing Xenomai even further.
> > (I have attached the complete source code).
> > No rtnet is required.
> > Now I have the following real time task:
> >=20
> > static void realtimetask(void *arg)
> > {
> >     system("ls -l");
>=20
> If you want to use system (or any function calling fork, eg popen or
> vfork) with Xenomai, you have to make sure to fault all pages mapped
> with write permission after the fork before trying to use services in
> priimary mode, because fork write protects all pages with write
> permission and notably the threads stacks. A piece of code that faults
> all pages follows.
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

