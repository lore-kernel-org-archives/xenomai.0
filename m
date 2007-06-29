Message-ID: <4684BFA5.8020005@domain.hid>
Date: Fri, 29 Jun 2007 10:15:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB14C@rennsmail04.eu.thmulti.com>
	<4680DA9B.5020501@domain.hid> <46838C9C.7030303@domain.hid>
	<4684BD02.1070002@domain.hid> <4684BEA9.1050705@domain.hid>
In-Reply-To: <4684BEA9.1050705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAC1BDBA791952CACD320DFDC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Group-based RT caps
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
--------------enigAC1BDBA791952CACD320DFDC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Johan Borkhuis wrote:
>> One thing I would like to see is to have the xenomai_gid parameter as =
a
>> kernel config parameter, next to the module parameter. The default can=

>> be -1, but I would like to have my configured xenomai-group as the
>> default value, so I don't have to pass an extra parameter or modify
>> /sys/module/xeno_nucleus/parameters/xenomai_gid.
>=20
> Build the nucleus into the kernel, and you'll have it (with kernel 2.6
> at least): "xeno_nucleus.xenomai_gid=3D<some-gid>"

Sorry, I likely misunderstood your request. You mean a build-time config
parameter? Hmm, that sounds a bit weird, given that you don't build your
/etc/passwd or /etc/group into the kernel either, do you?

Jan


--------------enigAC1BDBA791952CACD320DFDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGhL+lniDOoMHTA+kRAuTDAJ9DJJ97tJjr6kROEh3ZFFsNQI01yQCfdrIh
s5f6F20PCpNPu56Gg9WzlJ0=
=2fgI
-----END PGP SIGNATURE-----

--------------enigAC1BDBA791952CACD320DFDC--

