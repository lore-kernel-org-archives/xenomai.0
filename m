Message-ID: <5626198.1178177559304.JavaMail.ngmail@domain.hid>
Date: Thu, 3 May 2007 09:32:39 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <46360605.4020901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <46360605.4020901@domain.hid>
	<17043901.1177943488672.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] [RTnet-users] Xenomai/rtnet vs. 2.6.21 realtime
	preempt patch
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
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

Hi Jan,

> > I have tried the latest 2.6.21 kernel + Ingo Molnar's realtime preempt
> patch
> > (see: http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO)
> >=20
> > And I am really amazed about the results.
> > On my Pentium 4D (dual core) system, 3.2 GHz, I ran the cyclictest
> > application (which is something similar to the "latency" application of
> Xenomai/RTAI)
> > and I get values below 15 microseconds on my PC (for a single task runn=
ing
> with 200 microseconds).
> >=20
....
> >=20
> > Currently, my application is working quite nice using Xenomai/rtnet
> however there are some
> > drawbacks like the issue with limited IRQs: Sharing of IRQs between
> Ethernet-Drivers of rtnet
> > and non-realtime drivers is not possible (at least I did not manage
> that...).
> > A smooth usage of real time features from a "standard" kernel could hel=
p
> here!
>=20
> Nope, not really. As I think to have explained earlier, IRQ sharing
> between drivers that are designed for real-time and others that are not
> will never work deterministically. That has nothing to do with the
> design of your RTOS underneath. Actually, the same issue once came up
> for -rt over some ARM board that did poor IRQ line sharing as well.
>=20
> Jan
I agree, the best is actually to have separate IRQs for real time and non r=
eal time drivers.
However, reality shows me, that this is very hard to get with standard PCs.
I can plug in one or two PCI boards to have an unique IRQ for them. However=
, if I want
to use more PCI boards IRQ sharing cannot be avoided.
As with the preempt patch, the duration of non-realtime IRQ routines seems =
to be fairly short.
>From this, I think it is at least an option to share IRQs between real time=
 and non real time drivers
even if the IRQ routine of the non real time driver may lead to a delay of =
the real time IRQ routine.
It is a question of acceptable delays for the IRQs.

Regards

Mathias




--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

