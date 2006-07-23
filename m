Message-ID: <44C3E243.5050703@domain.hid>
Date: Sun, 23 Jul 2006 22:55:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_intr_create returns ENOSYS ?
References: <44C3CF5C.3010806@domain.hid> <44C3D581.1010101@domain.hid>
	<44C3E0A0.4060604@domain.hid>
In-Reply-To: <44C3E0A0.4060604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA415059B199049EFF8A14C87"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA415059B199049EFF8A14C87
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Jan Kiszka wrote:
>> Hannes Mayer wrote:
>>> Hi all!
>>>
>>> Subject basically says it.
>>>
>>> I'm trying to do this:
>>> err =3D rt_intr_create(&intr_desc, "parint", PARPORTINT, I_PROPAGATE)=
;
>>> in main() before spawning an RT tasks, but it fails with ENOSYS.
>>> Xeno2.2, 2.4.32
>>>
>>> Any enlightenment very much appreciated!
>>
>> CONFIG_XENO_OPT_NATIVE_INTR? It's default off now.
>=20
> Yeah, works. Thanks! :-)
>=20
> What's the reason for defaulting to off ?
> Force users to write RTDM stuff ?

No one is forced. We only kindly remind the user to think about the
design decision. :) (and for all others this removes unused code)

One day we will have RTDM services in user space as well. Then this
decision will be even simpler, I'm sure.

Jan


--------------enigA415059B199049EFF8A14C87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEw+JDniDOoMHTA+kRAhRNAJ0QuLue5xEsiJsaKM/pSRdFRPau8ACeOBMJ
1aKjpA1w3fLGYxLe0xWbMzc=
=A9zE
-----END PGP SIGNATURE-----

--------------enigA415059B199049EFF8A14C87--

