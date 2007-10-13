From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <1192226314.6499.174.camel@domain.hid>
References: <470E8BFE.4070804@domain.hid> <1192179524.5149.23.camel@domain.hid>
	<470F3B03.1040501@domain.hid>
	<20071012110054.GA26325@domain.hid>
	<470FD0AC.6040700@domain.hid> <470FD795.9070008@domain.hid>
	<20071012215152.GA17187@domain.hid>
	<1192226314.6499.174.camel@domain.hid>
Content-Type: text/plain; charset=utf-8
Date: Sat, 13 Oct 2007 16:28:54 +0200
Message-Id: <1192285734.8592.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

Le vendredi 12 octobre 2007 =C3=A0 23:58 +0200, Philippe Gerum a =C3=A9cr=
it :
> On Fri, 2007-10-12 at 23:51 +0200, Stelian Pop wrote:
> > On Fri, Oct 12, 2007 at 10:22:45PM +0200, Stelian Pop wrote:
> >=20
> > > Or even go crazy and activate SMP again ?
> >=20
> > Would have been too easy:
> >=20
> > # modprobe xeno_native
> > Xenomai: native skin init failed, code -19.
> >=20
>=20
> The I-pipe likely told Xenomai that the LAPIC was unusable, because it
> has been put in dummy state by the clock event layer. Must be something
> silly going on at I-pipe level. Please switch HPET off just for kicks.

No, it doesn't change a thing.

What does change something however is CONFIG_X86_UP_IOAPIC. Without it
(UP or UP+APIC), latency works (albeit with higher latencies - up to 30
us - than with 2.6.20+xeno-2.3.4 - where I saw latencies up to 20-25
_in_SMP_mode_). With IOAPIC I get code 19.

--=20
Stelian Pop <stelian@domain.hid>


