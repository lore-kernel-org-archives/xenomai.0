Message-ID: <11339208.1173883411866.JavaMail.ngmail@domain.hid>
Date: Wed, 14 Mar 2007 15:43:31 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
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
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Philippe,

I tried with nmi_watchdog
However with nmi_watchdog=3D1 I am not able to load my module xeno_native a=
s=20
the PC resets during the modprobe command...
I remember that I had this strange issue a while ago with the 2.6.19 kernel=
...

With nmi_watchdog=3D2 I can modprobe xeno_native, however I do see any chan=
ge.
The PC is still freezing.

Regards

Mathias
----- Original Nachricht ----
Von:     Philippe Gerum <rpm@xenomai.org>
An:      "M. Koehrer" <mathias_koehrer@domain.hid>
Datum:   14.03.2007 14:32
Betreff: Re: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai

> On Wed, 2007-03-14 at 12:18 +0100, M. Koehrer wrote:
> > Hello Philippe,
> >=20
> > here is a table of the test I have done:
> > With the Xenomai SVN (#2292) I used the patches in the SVN repository:
> > 2.6.19.2 with adeos-ipipe-2.6.19-i386-1.7-02.patch
> > 2.6.20.2 with adeos-ipipe-2.6.20-i386-1.7-02.patch
> >=20
> > With Xenomai-2.3.0 I used=20
> > 2.6.19.2 with adeos-ipipe-2.6.19-i386-1.6-03.patch
> >=20
> > The result was, that with 2.6.20.2 it was working as expected,
> > with 2.6.19.2 there was the PC freeze.
>=20
> Ok, could you activate the nmi watchdog for the kernel (nmi_watchdog=3D2
> added to the bootparams) and CONFIG_FRAME_POINTER, and also the nucleus
> watchdog (CONFIG_XENO_OPT_WATCHDOG), in the failing case? Maybe one of
> them would trigger. TIA,
>=20
> >=20
> > Regards
> >=20
> > Mathias
> > > Could you confirm that, Adeos-wise, you tried both 2.6.19-1.6-03 (not
> > > working) and 2.6.20-1.7-02 (working)? if so, does 2.6.19-1.7-02 (or
> -03)
> > > also work in your configuration?
> > >=20
> >=20
> >=20
> --=20
> Philippe.
>=20
>=20
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

