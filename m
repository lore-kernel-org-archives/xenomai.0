Message-ID: <4D24D30E.7060108@domain.hid>
Date: Wed, 05 Jan 2011 21:22:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4D20D7A7.2090003@domain.hid> <4D21A5CF.9000107@domain.hid>
In-Reply-To: <4D21A5CF.9000107@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig12F8E7F59A4D124F9D338905"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Build issue with rtcan and I-pipe for linux
	2.6.36 on powerpc.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12F8E7F59A4D124F9D338905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 03.01.2011 11:32, Wolfgang Grandegger wrote:
> Hi Gilles,
>=20
> the attached patch fixes the issue.
>=20

Nothing critical, but I think we should consistently wrap the other way
around

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
#define platform_device of_device
#endif

and update the users to the new style.

Jan


--------------enig12F8E7F59A4D124F9D338905
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk0k0w4ACgkQitSsb3rl5xQgWACfTQanUClBaSqYgLGwXrj5sgb9
swIAoJFcY0VDip6nV6MlEuUxBvfBuuFG
=5hWb
-----END PGP SIGNATURE-----

--------------enig12F8E7F59A4D124F9D338905--

