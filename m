Message-ID: <454781B2.8070202@domain.hid>
Date: Tue, 31 Oct 2006 18:02:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel OOps large appl.
References: <DD39B5C3F4963040ADC9768BE7E430CB0144D777@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0144D777@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig21A9A9253D0D3F6E36DDC236"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig21A9A9253D0D3F6E36DDC236
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Daniel Schnell wrote:
> Philippe Gerum wrote:
> =20
> =20
>> IOW, something seems out of sync in your configuration. Does the
>> testsuite work on your board, and specifically the "cyclic" test?=20
>=20
>=20
> The cyclic test does the following output:
>=20
> ./cyclictest -c 1 -d 500 -i 500 -l 10000 -n
> 0.06 0.03 0.01 1/21 354
>=20
> T: 0 (  354) P: 0 I:     500 C:   10000 Min:       7 Act:       7 Avg:
> 10 Max:     201
> (needs a relatively short time)
>=20
> ./cyclictest -c 0 -d 500 -i 500 -l 10000 -n
> 0.00 0.01 0.00 1/21 357
>=20
> T: 0 (  357) P: 0 I:     500 C:   10000 Min:       6 Act:       6 Avg:
> 12 Max:     403
> (needs a relatively short time)
>=20
> ./cyclictest -c 1 -d 500 -i 500 -l 10000 -n -r
> 0.00 0.00 0.00 1/21 367
>=20
> T: 0 (  367) P: 0 I:     500 C:   10000 Min:      10 Act:      11 Avg:
> 19 Max:     491
> (needs a relatively short time)
>=20
> ./cyclictest -c 1 -d 500 -i 500 -l 10000 -s
> T: 0 (  360) P: 0 I:     500 C:   10000 Min:   -6174 Act:94983888
> Avg:47488852 Max:94983888
> (needs much longer)
>=20
> ./cyclictest -c 1 -d 500 -i 500 -l 10000
> 0.16 0.03 0.01 1/22 379
>=20
> T: 0 (  379) P: 0 I:     500 C:   10000 Min:-5964339 Act:-5964339
> Avg:-3481100 Max: -997872
>=20
> (returns immediately without doing anything)
>=20
> ./cyclictest
>=20
> (locks up system immediately)
>=20
>=20
>=20
> Probably not good....

False positive of the test: only the -n mode is supported over Xenomai,
which is unfortunately not default. The default mode seems to cause a
busy loop in cyclictest, effectively locking up the box (the Xenomai
watchdog would have detected this).

Anyway, the test needs fixing to avoid misunderstandings.

Jan


--------------enig21A9A9253D0D3F6E36DDC236
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFR4GyniDOoMHTA+kRApSOAJ90rgB/VdShH9cH0gGW5BVvSnQFxQCePYJx
O1Qg03S45575C8/Aawn4Hms=
=owZr
-----END PGP SIGNATURE-----

--------------enig21A9A9253D0D3F6E36DDC236--

