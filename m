Message-ID: <10606813.1166451623805.JavaMail.ngmail@domain.hid>
Date: Mon, 18 Dec 2006 15:20:23 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Aw: Re: [RTnet-users] [Xenomai-help] rtnet / Xenomai: Kernel 2.6.19.1
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
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

Hi Jan,

I tried disabling SMP - but no success...
Unfortuantely, the SMI watchdog does not work on my machine.
After booting the PC, dmesg shows me the line
Xenomai: NMI watchdog not available.

Is the NMI watchdog support somehow configurable or is this a real hardware=
 issue?

For patching the kernel, I used the adeos-ipipe-2.6.19-i386-1.6-02.patch wh=
ich is
part of Xenomai.

As I do not see an easy way to get the 2.6.19.* running,  I think, I will s=
witch back to=20
the latest 2.6.17.* kernel (2.6.17.14) which works fine.

Regards

Mathias
> > I have an issue with the latest Xenomai (svn #1962) and rtnet (svn #109=
5)
> versions
> > using kernel 2.6.19.1. The very same application worked fine on 2.6.17.=
7
> (same Xenomai/rtnet).
>=20
> /Might/ be an issue of the still fresh 2.6.19 patch. You are using
> latest ipipe 1.6-02? Any difference with an earlier version of the
> patch? Is the IRQ routing identical for both 2.6.19 and .17?
>=20
> > My application does the following steps in user space:
> > 1) I open one UDP socket to an embedded device.
> > 2) The timeout of the socket is set to 5 seconds.
> > 3) I send out one UDP message A via rt_dev_send() to the device.
> > 4) Then I wait for the response for A in rt_dev_recv()
> > 5) Directly after the return of rt_dev_recv() I send  message B via
> rt_dev_send()
> > 6) Then I wait for the response for B in rt_dev_recv()
> > Here my PC freezes. I am no longer able to access it, I have to press t=
he
> reset button on the PC.
> >=20
> > I have connected the PC and the embedded device with a hub. This allows=
 me
> to monitor the network
> > traffic using a second PC. Ethereal shows me, that message B is sent to
> the embedded device
> > and the response of B is sent back to the PC.
> >=20
> > Whenever I place a printf() directly after the rt_dev_recv() statements=
 to
> see what happens,
> > everything works fine and the PC no longer freezes.
>=20
> printf causes a mode switch and certainly some delay that may let the
> system avoid the race situation above.
>=20
> >=20
> > As mentioned above, when I use the very same application with 2.6.17.7
> (same Xenomai, rtnet version)
> > everything is perfect!
> > I have a Pentium 4 Dual core, SMP enabled.
> >=20
> > Any idea on this strange behaviour?
>=20
> Not directly.
>=20
> OK, this is what you could try: Switch on the Xenomai watchdogs (soft
> and NMI). Check if the NMI watchdog is working: boot log messages, maybe
> even a test triggering via small /proc/xenomai/nmi_maxlat (we had
> problems with it already on some other user's box, so some confirmation
> the NMI works is useful). Then see if you system can at least issue some
> oops on lock-up. Attach a serial console to grab it.
>=20
> Beyond this test, could you also try with CONFIG_SMP switched off?
>=20
> Jan
>=20
>=20
>

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

