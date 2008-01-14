Message-ID: <478BCC76.9040006@domain.hid>
Date: Mon, 14 Jan 2008 21:56:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BF58A8AFB316514587D61EADBFBF4C41DB1FC4@domain.hid>
	<478BCA51.3030006@domain.hid>
In-Reply-To: <478BCA51.3030006@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig383E1BE5D1E127214260722C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] Fix typo bug in ipipe_pin_range
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig383E1BE5D1E127214260722C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Kyle Howell wrote:
>> Hi,
>>
>> Ran across these typos in ipipe_pin_pud_range and ipipe_pin_pmd_range.=
=20
>> On large vmas, they cause a lot of extra iteration and may cause some =

>> page table corruption.
>>
>=20
> Oops. Will merge, thanks.

Ah, that might explain why I saw bad entries after applying my=20
safe-iteration patch [1]. Great!

Jan

[1] https://mail.gna.org/public/xenomai-help/2008-01/msg00051.html


--------------enig383E1BE5D1E127214260722C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHi8x3niDOoMHTA+kRAqODAJ9M49lArpC+v4k2B2AVbPtoSZlQsQCffVBM
ARgYPPYF+pFo/WoPQA1im50=
=lRZT
-----END PGP SIGNATURE-----

--------------enig383E1BE5D1E127214260722C--

