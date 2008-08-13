Message-ID: <48A2BFD1.40400@domain.hid>
Date: Wed, 13 Aug 2008 13:04:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <486E6E1D.2020209@domain.hid> <4871C676.90301@domain.hid>
In-Reply-To: <4871C676.90301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig71258B6629FBE42CE78F858A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] can: avoid naming conflict in 2.6.26
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
--------------enig71258B6629FBE42CE78F858A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Jan,
>=20
> Jan Kiszka wrote:
>> Due to a global definition of 'clock' in latest 2.6.26, we now have a
>> problem with two rtcan drivers. Below is a fix that breaks those
>> drivers' user interface by rename the conflicting variable which
>> unfortunately also renames the module parameter name.
>>
>> An alternative approach would be to add a kernel version dependent fix=

>> to the drivers. That would be required as compat_module_param_array
>> cannot be extended to use a different parameter name than the related
>> variable is called. Maybe someone sees a third, better solution, I do
>> not.
>=20
> Nor do I. But I would prefer prefixing the module parameters with=20
> "can_". Who knows what comes next.

The issue is still open. Wolfgang, will you take care?

Jan


--------------enig71258B6629FBE42CE78F858A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkiiv9EACgkQniDOoMHTA+lIsQCfRGuMORsh/0IvoBJlULJ9ynNA
c34An3Mj+j2+niDuTLbI2AQQl5lS42Iq
=gBfG
-----END PGP SIGNATURE-----

--------------enig71258B6629FBE42CE78F858A--

