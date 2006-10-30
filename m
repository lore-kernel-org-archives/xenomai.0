Message-ID: <15328399.1162222490427.JavaMail.ngmail@domain.hid>
Date: Mon, 30 Oct 2006 16:34:50 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: [Xenomai-help] Results of xenomai's latency test vs. RTAI's
In-Reply-To: <1162219241.5188.21.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1162219241.5188.21.camel@domain.hid> <1162208265.4955.17.camel@domain.hid>
	<21364954.1162202747823.JavaMail.ngmail@domain.hid>
	<16802252.1162217706570.JavaMail.ngmail@domain.hid>
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

Hi everybody,

I have repeated the test using a parallel stress test (dd if=3D/dev/sda of=
=3D/dev/null, I have
a SATA harddisk).
The results are that my RTAI latency of 4=B5s is not valid, here the latenc=
y is about 26=B5s.
However, xenomai shows a higher latency of about 40=B5s.
The interesting thing is, that without load RTAI seems to run very long in =
a very=20
low latency region, at the same setup xenomai shows large latencies earlier=
.


Well, I have repeated these tests on a different PC that has a server mainb=
oard and=20
a Pentium D 4 (real dual core) CPU.
The results (measured under load) are much better here:
RTAI shows a latency of about 6=B5s
Xenomai shows a latency of about 10=B5s.
Both values are acceptable, however I wonder where the difference comes fro=
m?

Thanks for all the feedback on that issue!

Regards

Mathias
> > I have rebuild my system using V2.2.4 of xenomai.
> > Also, I had a look to reuse the kernel configuration from the 2.4.33 RT=
AI
> system.
> > However, the results are more or less the same.
> > The only kernel module I have loaded is the "tg3" network driver, the
> chipset of the=20
> > PC (ICH6) is supported by the SMI detection and it is activated.
> >=20
>=20
> On such hw, you may want to enable the following:
> CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> CONFIG_BLK_DEV_IDEDMA=3Dy
> CONFIG_IDEDMA_AUTO=3Dy
>=20
> > I have enclosed my kernel configuration, perhaps this can help to ident=
ify
> an issue.
> > I do not have X11 running, it is a text-mode only system that is
> controlled via telnet from
> > another PC.
> >=20
> > I'll try to do a stress test on the RTAI system as well.
> >=20
>=20
> You could try running RTAI 3.3 over 2.6.17 with the very same config
> file too (Xenomai opts aside, of course), so you could rule out any
> configuration problem if the gap still exists.


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

