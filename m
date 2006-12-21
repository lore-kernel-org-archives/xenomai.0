Message-ID: <25528819.1166701882755.JavaMail.ngmail@domain.hid>
Date: Thu, 21 Dec 2006 12:51:22 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1166700491.4936.5.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1166700491.4936.5.camel@domain.hid>
	<b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>
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
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Re: Re: Re: A fairly small rtnet/Xenomai
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

Hello Philippe,=20

> The important issue to check is the above one. Please try calling
> rt_task_delete(NULL), and in a second test, rt_task_suspend(NULL),
> instead of letting the thread routine return. TIA,
O.K, here are the results:
I have placed rt_task_delete() at all possible positions in realtimetask().
The system freezes when I place rt_task_delete() after the printf() stateme=
nt.
At all other positions (after system(), after rt_task_sleep()) the system d=
oes not freeze.
I get the very same results when I use rt_task_suspend() instead of rt_task=
_delete().

It means, that the printf() call causes the freeze.

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

