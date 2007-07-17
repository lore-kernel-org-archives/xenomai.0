Message-ID: <469CDD47.6030608@domain.hid>
Date: Tue, 17 Jul 2007 17:16:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469C7D3E.7020009@domain.hid>
In-Reply-To: <469C7D3E.7020009@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig021DDB63B27BB3451197F6F5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Minor issue: compiler warning on rtdm.h
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig021DDB63B27BB3451197F6F5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johan Borkhuis wrote:
> When compiling with an extended warnings I get the following warning:
>=20
> /nfsroot/common/usr/xenomai/include/rtdm/rtdm.h: In function=20
> 'rt_dev_sendto':
> /nfsroot/common/usr/xenomai/include/rtdm/rtdm.h:323: warning: missing=20
> initializer
> /nfsroot/common/usr/xenomai/include/rtdm/rtdm.h:323: warning: (near=20
> initialization for 'msg.msg_flags')
>=20
> The structure-type msghdr has 7 elements, but the initializer only has =
6=20
> elements.

Yeah, known problem under pedantic compiler switches. But it's already
fixed in upcoming 2.4, I was likely just to lazy to back-port it.

Thanks nevertheless,
Jan


--------------enig021DDB63B27BB3451197F6F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGnN1HniDOoMHTA+kRAlVXAJwPiAjcrocViDrNZNm7CBOM5I6NiACfd5fI
zTTyhaUGDd75VdoZOBfLlmc=
=6y+n
-----END PGP SIGNATURE-----

--------------enig021DDB63B27BB3451197F6F5--

