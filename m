Subject: Re: Re: [Xenomai-help] Results of xenomai's latency test vs. RTAI's
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <16802252.1162217706570.JavaMail.ngmail@domain.hid>
References: <1162208265.4955.17.camel@domain.hid>
	<21364954.1162202747823.JavaMail.ngmail@domain.hid>
	<16802252.1162217706570.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Oct 2006 15:40:40 +0100
Message-Id: <1162219241.5188.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-10-30 at 15:15 +0100, M. Koehrer wrote:
> Hi Philippe,
>=20
> I have rebuild my system using V2.2.4 of xenomai.
> Also, I had a look to reuse the kernel configuration from the 2.4.33 RT=
AI system.
> However, the results are more or less the same.
> The only kernel module I have loaded is the "tg3" network driver, the c=
hipset of the=20
> PC (ICH6) is supported by the SMI detection and it is activated.
>=20

On such hw, you may want to enable the following:
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_IDEDMA_AUTO=3Dy

> I have enclosed my kernel configuration, perhaps this can help to ident=
ify an issue.
> I do not have X11 running, it is a text-mode only system that is contro=
lled via telnet from
> another PC.
>=20
> I'll try to do a stress test on the RTAI system as well.
>=20

You could try running RTAI 3.3 over 2.6.17 with the very same config
file too (Xenomai opts aside, of course), so you could rule out any
configuration problem if the gap still exists.

> Regards
>=20
> Mathias
>=20
> > > I am currently checking XENOMAI (V2.2.3 on a 2.6.17.7 kernel P4) to=
 see if
> > I can use it
> > > as replacement for a RTAI 3.3-cv application.
> > > The first thing I did was to run the latency test in the the xenoma=
i's
> > testsuite directory.
> > > The results of the worst time latency are really ugly - about 40=C2=
=B5s!
> > > On the very same PC I got a value of about 5=C2=B5s using RTAI 3.3-=
cv running
> > the RTAI's
> > > user/latency test.
> > >=20
> > > My question is now: Why can there be such a huge difference between=
 the
> > two systems on the very same
> > > hardware??
> > > Is there a way to improve this value?
> > >=20
> > > The RTAI system uses a 2.4.33 kernel, the XENOMAI uses the 2.6.17.7
> > kernel. Could this
> > > be an issue?
> > >=20
> >=20
> > Several issues there:
> >=20
> > - are you 100% sure that your kernel config file for 2.4.33 is perfec=
tly
> > recycled for 2.6.17, e.g. are all latency killer options as listed in
> > the TROUBLESHOOTING file really disabled? P4 configurations are
> > jitter-prone; some options are know to induce bad latencies.
> >=20
> > - worst-case figures do not depend on how fast you get them, the latt=
er
> > information gives you nothing to interpret from. You may want to stre=
ss
> > test the box for a longer period of time, using things like e.g. a dd
> > loop, and a compilation in the background (dd if=3D/dev/zero of=3D/so=
mefile
> > count=3D500 bs=3D1M). "ping" network test is not the worst latency ra=
iser,
> > actually, under some circumstances, it could even hide some latency
> > issues, basically because it favours the code locality in i-cache. Al=
so
> > make sure to measure without X-window interaction in both cases; some
> > graphic card drivers induce latencies, some don't. YMMV.
> >=20
> > This said, 40us on a P4 class machine is not an expected value for
> > Xenomai/x86. To give you some reference figures, I have a uniprocesso=
r
> > 2.8Ghz Xeon box (no HT) performing at 15 us worst-case, and an older
> > dual 2.4Ghz Xeon SMP which honours 25 us worst-case in SMP mode. Fact=
 is
> > that to get that, I need to disable a number of ACPI options (except
> > those which are needed to boot properly in SMP mode), and activate th=
e
> > SMI work-around.
> >=20
> > And above all, a good starting point would be to send your kernel
> > configuration file, so that we could discuss about facts. Additionall=
y,
> > you may want to upgrade to 2.2.4; 2.2.3 has a FPU issue on some hw.
> >=20
>=20
>=20
> --=20
> Mathias Koehrer
> mathias_koehrer@domain.hid
>=20
>=20
> Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
> ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=C3=
=BCnstig
> und schnell mit DSL - das All-Inclusive-Paket f=C3=BCr clevere Doppel-S=
parer,
> nur  44,85 =E2=82=AC  inkl. DSL- und ISDN-Grundgeb=C3=BChr!
> http://www.arcor.de/rd/emf-dsl-2
--=20
Philippe.



