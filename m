Message-ID: <4B2F3898.2060900@domain.hid>
Date: Mon, 21 Dec 2009 09:58:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B2EB7DA.7020709@domain.hid> <4B2EBA98.5060002@domain.hid>
In-Reply-To: <4B2EBA98.5060002@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF2CE267635EA9FB78C858C33"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Remove outdated x86 adeos patches
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2CE267635EA9FB78C858C33
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi Philippe,
>>
>> as adeos-ipipe-2.4.35.5-i386-1.3-05.patch and
>> adeos-ipipe-2.6.29.5-x86-2.4-02.patch are no longer up to date /wrt to=

>> latest i-pipe fixes, I would suggest to remove them for 2.5-final.
>> Avoids that people trap into known issues.
>=20
> What latest fixes? Are they expected to oops or something?

2.6.29 on x86-64: definitely (irq stack corruption). 32 bits and 2.4.35
are lacking the halt fix (I bet other arch beyond x86 that use a
hlt-like idle do so as well). It's not that they aren't fixable, it's
just the question if we should bother anymore.

Jan


--------------enigF2CE267635EA9FB78C858C33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAksvOJ0ACgkQitSsb3rl5xRpewCggefJqzFe0L4ImMTsoIkERK0G
In8An37CyRPE9HG+N0NVd4gVVRLZ3V2S
=+Mjw
-----END PGP SIGNATURE-----

--------------enigF2CE267635EA9FB78C858C33--

