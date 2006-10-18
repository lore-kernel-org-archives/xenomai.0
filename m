Message-ID: <45367E43.5020208@domain.hid>
Date: Wed, 18 Oct 2006 21:19:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] BUG: sleeping function called from invalid context
	at kernel/xenomai/skins/posix/syscall.c:272
References: <45366314.5000904@domain.hid>
In-Reply-To: <45366314.5000904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE7E9FC6B5852D006860C151C"
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
--------------enigE7E9FC6B5852D006860C151C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> when I start the RT-Socket-CAN program rtcan_rtt.c, I get the attached
> error message. Any idea where the problem could be? It was working with=

> Xenomai under Linux 2.4.25.
>=20
> Thanks.
>=20
> Wolfgang.
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> bash-3.00# rtcan_rtt rtcan0 rtcan1
> BUG: sleeping function called from invalid context at kernel/xenomai/sk=
ins/posix/syscall.c:272
> in_atomic():0, irqs_disabled():1

Leaking lock somewhere? Some suggestions:

- Does it also happen with rtcan_virt?
- If no: switch on XENO_OPT_DEBUG and then XENO_OPT_DEBUG_RTDM (may
  catch leaking locks of the CAN driver)
- If yes: what arch are you on? PPC? On x86/2.6 I do not have problems
  with your demo over rtcan_virt.

Jan


--------------enigE7E9FC6B5852D006860C151C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNn5DniDOoMHTA+kRAk5WAJ9HrKNOuW5EwP0p7nBsuuzwWq+K0wCfe9hN
MsIlurt8m3J3k9LMMOneFGM=
=+llZ
-----END PGP SIGNATURE-----

--------------enigE7E9FC6B5852D006860C151C--

