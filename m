Message-ID: <7145056.1166514841031.JavaMail.ngmail@domain.hid>
Date: Tue, 19 Dec 2006 08:54:01 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: [Xenomai-help] NMI watchdog: Loading of xeno_native leads to reboot
	of PC
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

Hi!

Before digging deeper into the issue I have mailed yesterday (see below), I=
 have to solve and
to understand the NMI watchdog feature.
I have enabled the NMI watchdog in the kernel configuration and set the tim=
e value to 100 now (100us).
Also, I passed the nmi_watchdog=3D1 kernel parameter to GRUB.
In dmesg's output I see the line:
Testing NMI watchdog ... OK.
=20
The Xenomai functionality is compiled as modules (as far as it is possible)=
.

Now, I do a=20
modprobe xeno_nucleus
This looks fine.

Now, I do a=20
modprobe xeno_native
to load the native skin (I need it for my application to run).
Then the PC reboots directly.
This means I have no chance to  start my application as the PC reboots befo=
re
I can start it...

I have the impression that some important thing is missing in my test.
The xeno timer is not started after modprobe xenu_nucleus
The contents of /proc/timer is:
status=3Doff:setup=3D120:tickval=3D0:jiffies=3D0

Could this be a reason for the behaviour?
Can I start the timer before loading xeno_native to avoid the NMIs?

Thanks for all help on this topic as without this feature it seems to be im=
possible
to detect the bug/issue with a freezing system with the latest Xenomai/rtne=
t and=20
kernel 2.6.19.1. (see https://mail.gna.org/public/xenomai-help/2006-12/msg0=
0109.html)

Regards

Mathias



----- Original Nachricht ----
Von:     Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
An:      "M. Koehrer" <mathias_koehrer@domain.hid>
Datum:   18.12.2006 16:32
Betreff: Re: Aw: Re: Aw: Re: [RTnet-users] [Xenomai-help] rtnet / Xenomai:
 Kernel

> M. Koehrer wrote:
> > O.k,
> >=20
> > I tried once more with the  NMI watchdog stuff.
> > However, it looks as if I do not understand the NMI watchdog correctly.=
..
> > I passed nmi_watchdog=3D1 as kernel parameter.
> > Now, the NMI watchdog seems to be o.k.
> > I have set the kernel parameter "NMI watchdog latency threshold (us)" t=
o
> 1000000 (1 second).
> > Now I do a modprobe xeno_nucleus.
> > This is o.k.
> > Then I do a modprobe xeno_native.
> > This leads to a watchdog NMI on the console after 1s.
> > "NMI watchdog detected timer latency above 100000us"
> > CPU 1
> > EIP is at mwait_idle 0x23/0x37
> >=20
> > When I compile the Xenomai functionality directly into the kernel (no
> modules), I never reach
> > the login prompt at my PC as the NMI watchdog from above came first...
> >=20
> > Well, somehow the NMI stuff seems to work. However, I am not able to st=
art
> my application
> > as my systems gets the NMI before I have the chance to start the
> application...
> > What is wrong here? I think, I miss one piece in the puzzle...
> >=20
> > Thanks for any support on that strange behaviour.
>=20
> 1 second is probably way to much and overflow a 32 bits value when
> converted to a processor ticks count. The defaults of 100 us is more
> reasonable.
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

