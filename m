Message-ID: <45DEF482.9030903@domain.hid>
Date: Fri, 23 Feb 2007 15:04:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45DEDED6.4070202@domain.hid> <1172237401.26738.13.camel@domain.hid>	
	<45DEED50.4070007@domain.hid> <1172238537.26738.15.camel@domain.hid>
In-Reply-To: <1172238537.26738.15.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig654EF6CA1A3087ABF95134B9"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [BUG] trunk: oops with Stephan's stress test
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig654EF6CA1A3087ABF95134B9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2007-02-23 at 14:34 +0100, Jan Kiszka wrote:
>=20
>> Attached with 3000 points (to play safe).
>=20
> Great, thanks.
>=20

FYI: Switching prio-coupling off doesn't let it trigger anymore. Which
/may/ mean that it's related to this feature, but which may also mean
that this corner-case race is just far more unlikely in non-RPI setups
(and the effects Stephan see are all related to the same bug - hopefully)=
=2E

Jan


--------------enig654EF6CA1A3087ABF95134B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3vSCniDOoMHTA+kRAvT+AJ9PStrooKM9l508SrJY3+BvTKSxJwCeKtje
D1id/ukz+467F3Db+/5ybjo=
=p0c6
-----END PGP SIGNATURE-----

--------------enig654EF6CA1A3087ABF95134B9--

