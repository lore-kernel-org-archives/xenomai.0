Message-ID: <441AECF1.70708@domain.hid>
Date: Fri, 17 Mar 2006 18:08:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] broken svn
References: <441AE349.1090406@domain.hid> <441AE652.701@domain.hid>
	<441AE836.6020708@domain.hid> <441AEA09.9090301@domain.hid>
In-Reply-To: <441AEA09.9090301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB9FE7F7EAE8405E5CE65D654"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB9FE7F7EAE8405E5CE65D654
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Hi,
>>>>
>>>> latest src/skin/uvm and src/skin/vxworks doesn't build. Work in
>>>> progress
>>>> or broken check-in?
>>>
>>> Should be ok now.
>>
>>
>> Almost:
>> intLib.c:21:26: error: vxworks/defs.h: No such file or directory
>>
>=20
> Did you resync your auto-stuff?

A simple configure re-run didn't help, but after deleting the build
directory it's fine now. End of warning.

Jan


--------------enigB9FE7F7EAE8405E5CE65D654
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGuzxniDOoMHTA+kRAqgmAKCA6y/z31e0+uSuBMC6nEtl4ryr3QCcDkGl
Ah0OjuPbDVgU1V1pma8V25k=
=ZqVw
-----END PGP SIGNATURE-----

--------------enigB9FE7F7EAE8405E5CE65D654--

