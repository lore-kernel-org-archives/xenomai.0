Message-ID: <32751131.1166455208340.JavaMail.ngmail@domain.hid>
Date: Mon, 18 Dec 2006 16:20:08 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Aw: Re: Aw: Re: [RTnet-users] [Xenomai-help] rtnet / Xenomai: Kernel
In-Reply-To: <4586A5AE.6020002@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4586A5AE.6020002@domain.hid>
	<10606813.1166451623805.JavaMail.ngmail@domain.hid>
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

O.k,

I tried once more with the  NMI watchdog stuff.
However, it looks as if I do not understand the NMI watchdog correctly...
I passed nmi_watchdog=3D1 as kernel parameter.
Now, the NMI watchdog seems to be o.k.
I have set the kernel parameter "NMI watchdog latency threshold (us)" to 10=
00000 (1 second).
Now I do a modprobe xeno_nucleus.
This is o.k.
Then I do a modprobe xeno_native.
This leads to a watchdog NMI on the console after 1s.
"NMI watchdog detected timer latency above 100000us"
CPU 1
EIP is at mwait_idle 0x23/0x37

When I compile the Xenomai functionality directly into the kernel (no modul=
es), I never reach
the login prompt at my PC as the NMI watchdog from above came first...

Well, somehow the NMI stuff seems to work. However, I am not able to start =
my application
as my systems gets the NMI before I have the chance to start the applicatio=
n...
What is wrong here? I think, I miss one piece in the puzzle...

Thanks for any support on that strange behaviour.

Regards

Mathias



----- Original Nachricht ----
Von:     Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
An:      "M. Koehrer" <mathias_koehrer@domain.hid>
Datum:   18.12.2006 15:29
Betreff: Re: Aw: Re: [RTnet-users] [Xenomai-help] rtnet / Xenomai: Kernel
 2.6.19.1

> M. Koehrer wrote:
> > Hi Jan,
> >=20
> > I tried disabling SMP - but no success...
> > Unfortuantely, the SMI watchdog does not work on my machine.
> > After booting the PC, dmesg shows me the line
> > Xenomai: NMI watchdog not available.
> >=20
> > Is the NMI watchdog support somehow configurable or is this a real
> hardware issue?
> >=20
> > For patching the kernel, I used the adeos-ipipe-2.6.19-i386-1.6-02.patc=
h
> which is
> > part of Xenomai.
> >=20
> > As I do not see an easy way to get the 2.6.19.* running,  I think, I wi=
ll
> switch back to=20
> > the latest 2.6.17.* kernel (2.6.17.14) which works fine.
>=20
> In order to get the NMI watchdog, you have to enable it on kernel
> command line, passing nmi_watchdog=3D2 or nmi_watchdog=3D1. Read linux
> Documentation/nmi_watchdog.txt for more details.
>=20
> --=20
>                                                  Gilles Chanteperdrix
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

