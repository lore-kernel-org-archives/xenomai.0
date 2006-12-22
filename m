Message-ID: <16771347.1166780307106.JavaMail.ngmail@domain.hid>
Date: Fri, 22 Dec 2006 10:38:27 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <458BA432.2000205@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <458BA432.2000205@domain.hid> <458ACFDA.8070300@domain.hid>
	<b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>	
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>	
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>	
	<1166700491.4936.5.camel@domain.hid>	
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>	
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>	
	<1166710393.4960.13.camel@domain.hid>	
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>	
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>	
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>
	<9212697.1166778373331.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Re: Re: A fairly small rtnet/Xenomai...
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
Cc: xenomai@xenomai.org

Hi Gilles and Dmitry,

I actually prefer Gilles proposal to add the fault_vm() function after call=
ing
a forking function.=20
Dmitry's idea with a different context and inter process communication will=
 surely
work but it makes the code less transparent as when using the fault_vm() fu=
nction.
Are there situations where the fault_vm() could fail or is this fine in all=
 situations?

Regards

Mathias
> M. Koehrer wrote:
> > Good morning everybody,
> >=20
> > here are some more news concerning the Xenomai crash issue.=20
> > 1) I have tried to enable the CONFIG_DEBUG_SPINLOCK and
> CONFIG_DEBUG_SPINLOCK_SLEEP
> > kernel config parameters. But I did not get any messages before the ker=
nel
> freezes.
> >=20
> > 2) I have tried to link a static application (using -lstatic). When I
> pass
> > the -L/usr/lib/nptl  option to force the linker to use the nptl libs, t=
he
> effect is the same.
> > Well, I have now a static binary that freezes the system.
> > I can mails you the binary file (about 280kByte bz2 file) if you like.
> > I think this file is too large to be posted to the list.
> >=20
> > One additional question comes in my mind:
> > As I learned from all that things that are related to the issue, it see=
ms
> to be fairly
> > critical to fork out of a real time task or to create new processes out=
 of
> it.
>=20
> In absence of a better solution, I would recommend to use the "fault_vm"
>  function after each fork.
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

