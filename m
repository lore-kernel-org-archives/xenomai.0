Message-ID: <12420573.1166713240349.JavaMail.ngmail@domain.hid>
Date: Thu, 21 Dec 2006 16:00:40 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1166710393.4960.13.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1166710393.4960.13.camel@domain.hid>
	<b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>
	<b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<458A4DE0.5030005@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>
	<1166700491.4936.5.camel@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Re: Re: Re: Re: Re: A fairly small rtnet/Xenomai
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

here are some of the results:=20
> Please check the following assertions on your setup:
>=20
> - does enabling the debug option for the Xenomai nucleus cause Xenomai
> warnings to appear (messages about forced switches of the crashtest task
> to secondary mode), even over 2.6.17 with the very same test code?
Yes, on 2.6.17 I get the line
Xenomai: Switching crashtest to secondary mode after exception #14 from use=
r-space at 0xb7ff2c7c (pid 1616)
On 2.6.19.1, the system freezes, i.e. I cannot see any message.

>=20
> - does enabling CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP in
> the kernel hacking section cause Linux warnings to appear while the test
> code runs over 2.6.19, before the box crashes?
I am about to recompile the kernel, this takes a while...

> - does the bug still occurs after the call to the system() routine has
> been replaced by the following frag?
>=20
>     if (vfork() =3D=3D 0)
>             execlp("/bin/ls", "ls", "-l", NULL);
>     else
>             wait(NULL);
>=20
I have replaced the system() call by your code fragement. And yes, this wor=
ks!
No freeze!

Regards

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

