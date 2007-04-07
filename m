Message-ID: <46180712.2070702@domain.hid>
Date: Sat, 07 Apr 2007 23:03:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: RT-Socket-CAN bus error rate and latencies
References: <46002EE0.9040406@domain.hid>	<460167F8.50703@domain.hid>	<46017CA7.2080801@domain.hid>	<4601958C.90502@domain.hid>	<4601A6E4.9020908@domain.hid>	<46023991.4020301@domain.hid>	<46036D32.7000603@domain.hid>	<46036F22.60709@domain.hid>	<46039128.90609@domain.hid>	<4603950D.9040801@domain.hid>	<460510D8.2010205@domain.hid>
	<460529D2.7020406@domain.hid> <46112DB7.9090200@domain.hid>
In-Reply-To: <46112DB7.9090200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5957F0ED76E37CE2F08C7052"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5957F0ED76E37CE2F08C7052
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> OK, I have just commited the following changes:
>=20
> 2007-04-02  Wolfgang Grandegger  <wg@domain.hid>
>=20
>   * ksrc/drivers/can/*: The option CONFIG_XENO_DRIVERS_CAN_BUS_ERR now
>     enables bus error interrupts when an application is calling a recei=
ve
>     function on a socket listening on bus errors. After one bus error h=
as
>     occured, the interrupt will be disabled to allow the application ti=
me
>     for error processing and to efficiently avoid bus error interrupt
>     flooding. This option is automatically selected for CAN controllers=

>     supporting bus error interrupts like the SJA1000.

Just one final nitpicking question: Who's to read the help text of
CONFIG_XENO_DRIVERS_CAN_BUS_ERR - except people reading Kconfig
directly? (My point is that this explanation may rather become a code
comment.)

Jan


--------------enig5957F0ED76E37CE2F08C7052
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGGAcSniDOoMHTA+kRAlk2AJ477juX7gMyEbg/GEuWYqTb/fVZqQCfQFMW
8KOa3F4bGszRIxDDQuKM7fE=
=u9xH
-----END PGP SIGNATURE-----

--------------enig5957F0ED76E37CE2F08C7052--

