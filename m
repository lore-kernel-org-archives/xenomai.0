Message-ID: <48A8A873.1060501@domain.hid>
Date: Mon, 18 Aug 2008 00:38:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <486E6E1D.2020209@domain.hid> <4871C676.90301@domain.hid>
	<48A2BFD1.40400@domain.hid> <200808162315.31868.paul_c@domain.hid>
	<48A7D636.7020500@domain.hid>
In-Reply-To: <48A7D636.7020500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0C4ABAF99074A3AD69875AD1"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C4ABAF99074A3AD69875AD1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Paul wrote:
>> On Wednesday 13 August 2008, Jan Kiszka wrote:
>>> Wolfgang Grandegger wrote:
>>>> Hi Jan,
>>>>
>>>> Jan Kiszka wrote:
>>>>> Due to a global definition of 'clock' in latest 2.6.26, we now have=
 a
>>>>> problem with two rtcan drivers. Below is a fix that breaks those
>>>>> drivers' user interface by rename the conflicting variable which
>>>>> unfortunately also renames the module parameter name.
>>>>>
>>>>> An alternative approach would be to add a kernel version dependent =
fix
>>>>> to the drivers. That would be required as compat_module_param_array=

>>>>> cannot be extended to use a different parameter name than the relat=
ed
>>>>> variable is called. Maybe someone sees a third, better solution, I =
do
>>>>> not.
>>>> Nor do I. But I would prefer prefixing the module parameters with
>>>> "can_". Who knows what comes next.
>>> The issue is still open. Wolfgang, will you take care?
>=20
> Didn't find time yet to fix it, sorry.
>=20
>>> Jan
>> Just bringing the issue back to the top (had to fix locally before com=
piling=20
>> 2.6.26.2).
>>
>>  Attached, a patch in line with Wolfgang's recommendation - Also inclu=
des a=20
>> trivial spelling correction.
>=20
> Your patch looks good.
>=20

OK, finally committed.

Jan


--------------enig0C4ABAF99074A3AD69875AD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkioqHYACgkQniDOoMHTA+m/OQCfVwovjJyrdRRdfDaGYF/j/P1v
yMIAnjHSdurvCWZ+U6kqLgSz+CK6S/rl
=3t0B
-----END PGP SIGNATURE-----

--------------enig0C4ABAF99074A3AD69875AD1--

