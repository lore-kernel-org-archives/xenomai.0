Message-ID: <46385699.6060002@domain.hid>
Date: Wed, 02 May 2007 11:15:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4630F1EA.8020206@domain.hid> <1178097353.5111.80.camel@domain.hid>
In-Reply-To: <1178097353.5111.80.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0F63903A9995CD4F37688F9B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 0/7] I-pipe fixes, cleanups,
	and enhancements
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
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0F63903A9995CD4F37688F9B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-04-26 at 20:39 +0200, Jan Kiszka wrote:
>=20
>>  5. Extract minimal, dependency-free linux/ipipe_base.h from main
>>     ipipe.h
>>
>>  6. Optimise __ipipe_stall_root, __ipipe_test_root, and
>>     __ipipe_test_and_stall_root for execution on UP (only i386 and
>>     x86_64 so far). This should improve Linux performance over I-pipe,=

>>     at least it did with the original version I posted last year.
>>
>>  7. Detect illicit cross-domain calls down the pipeline. Together with=

>>     the included Linux instrumentation, this can help to diagnose brok=
en
>>     RT code in the kernel, namely in drivers and skins. Might be of so=
me
>>     interest for RTDM hackers as recent user postings demonstrated...
>=20
> Merged, thanks.
>=20

That reminds me: please add #include <linux/bitops.h> to ipipe_base.h
for patch #6 (because of all the bit fiddling) - I had a compile error
with a different .config yesterday.

Jan


--------------enig0F63903A9995CD4F37688F9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOFaZniDOoMHTA+kRAtgBAKCCEn0lJ+9ZjyaxYCzbmnD6nz4uDwCeJIy8
Ir6lPHvdiQBQTVl3TfND04E=
=aCZs
-----END PGP SIGNATURE-----

--------------enig0F63903A9995CD4F37688F9B--

