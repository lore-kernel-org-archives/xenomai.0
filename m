Message-ID: <4710F486.40403@domain.hid>
Date: Sat, 13 Oct 2007 18:38:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <470E8BFE.4070804@domain.hid>
	<1192179524.5149.23.camel@domain.hid>	<470F3B03.1040501@domain.hid>	<20071012110054.GA26325@domain.hid>	<470FD0AC.6040700@domain.hid>
	<470FD795.9070008@domain.hid>	<20071012215152.GA17187@domain.hid>	<1192226314.6499.174.camel@domain.hid>	<1192285734.8592.4.camel@domain.hid>
	<4710D953.1030604@domain.hid>
	<20071013161211.GB24909@domain.hid>
In-Reply-To: <20071013161211.GB24909@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8BC44EDC43A2E061D6E71919"
Sender: jan.kiszka@domain.hid
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
To: Stelian Pop <stelian@domain.hid>, rpm@xenomai.org, Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8BC44EDC43A2E061D6E71919
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Stelian Pop wrote:
> On Sat, Oct 13, 2007 at 04:42:27PM +0200, Jan Kiszka wrote:
>=20
>> Where do you get ENODEV? On nucleus startup? Please provide
>> /proc/timer_list output of the working and non-working setups.
>=20
> It turns out that I had the Linux NMI watchdog enabled (nmi_watchdog=3D=
1
> on the command line) and this was causing the -ENODEV problems. Once
> removed, I'm able to boot and successfully run all configurations: UP,
> UP + APIC, UP + APIC + IO_APIC, SMP. And the latencies are back to norm=
al.
>=20
> Maybe we should detect that the NMI watchdog is enabled and issue a
> warning message, this would save others a few hours and many kernel
> builds...

NMI is still broken for >=3D 2.6.22, known issue :-/. The problem is that=

Linux falls back to the PIT, leaving our beloved APIC in disabled state
which makes Xenomai fail when asking for it. $Someone has to look into
the reason why we cannot take over the APIC in that scenario...

>=20
> This is with your timer cleanup patch, of course.
>=20
>> PS: For unknown reasons your mails don't make it to my web.de address,=

>> only to the list. Do you get any error messages?
>=20
> I did get one saying:
> 	<jan.kiszka@domain.hid>: host mx-ha02.web.de[217.72.192.188] refused to ta=
lk to me:
> 	554 Transaction failed. For explanation visit
> 	http://freemail.web.de/reject/?ip=3D88.191.70.230
>=20
> I didn't investigate yet what's happenning.
>=20

Your IP is probably associated to some DSL access, and a lot of
providers block such senders categorically due to all the spam robots
running on hijacked user PCs.

Jan


--------------enig8BC44EDC43A2E061D6E71919
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHEPSJniDOoMHTA+kRAjVDAJ46UFgUW3gcHq9uOR0I2R/Q/6zXLACfRoqQ
Erq7KRBj3RL1s5zOIbvIwyI=
=8DQN
-----END PGP SIGNATURE-----

--------------enig8BC44EDC43A2E061D6E71919--

