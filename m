Message-ID: <45FD12D4.3070901@domain.hid>
Date: Sun, 18 Mar 2007 11:22:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>	<E1HOW5u-0006Ap-EW@mailer.emlix.com>	<45F7DEA8.2050309@domain.hid>	<E1HRSws-0007cE-R3@domain.hid>
	<45FBD768.9050407@domain.hid>
In-Reply-To: <45FBD768.9050407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig040D402E8415D997EA39A6BD"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig040D402E8415D997EA39A6BD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Back to our preferred solution 1. Attached is a patch for review
> including some other fixes and suggestions accumulated over time:
>=20
>      * ksrc/drivers/can/*: To avoid unnecessary bus error interrupt
>      flooding, the option CONFIG_XENO_DRIVERS_CAN_BUS_ERR now allows to=

>      enable bus error interrupts "on demand" only if an application is
>      interested in such errors. It is automatically selected for CAN
>      controllers supporting bus error interrupts like the SJA1000.

Jumping into this more or less blindly: Could you explain to me (as well
as the poor CAN users...) what the downsides of enabling
CONFIG_XENO_DRIVERS_CAN_BUS_ERR are? If there isn't anything
significant, I would strongly vote for keeping the switch forest as
small as possible.

Jan


--------------enig040D402E8415D997EA39A6BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF/RLVniDOoMHTA+kRAhk4AJ9kYMxPmQpBIn3h2Mt1G4KTRooN5wCfSpMS
gUi/kNNFMZT3EVCP04QlaHs=
=x14j
-----END PGP SIGNATURE-----

--------------enig040D402E8415D997EA39A6BD--

