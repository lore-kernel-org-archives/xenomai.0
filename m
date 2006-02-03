Message-ID: <43E321CC.9090503@domain.hid>
Date: Fri, 03 Feb 2006 10:26:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] some results on my laptop
References: <43E288AA.3050203@domain.hid>	<43E28EE8.3020103@domain.hid>	<43E2A31D.9000807@domain.hid>	<43E30B8D.6030507@domain.hid>
	<43E31186.1000007@domain.hid> <43E313BF.2010104@domain.hid>
	<43E31FE0.5010609@domain.hid>
In-Reply-To: <43E31FE0.5010609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig03C285EA9FFFD61ED04C904C"
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03C285EA9FFFD61ED04C904C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>
>>> ...
>>> What about other time sources on x86? Which systems already have HPET=

>>> these days, and does this source not suffer from frequency scaling? I=

>>> once read that HPET is quite easy to program, is this true? IOW, woul=
d
>>> it be worth considering to add this to the HAL?
>>
>>
>> There are actually only few registers:
>>
>> http://www.intel.com/hardwaredesign/hpetspec_1.pdf
>>
>> Even a replacement for the TSC is available ("Main Counter"), but I
>> guess that some effort will be required to replace all direct usages o=
f
>> rdtsc in the current Xenomai code, right?
> And unfortunately they aren't guaranteed to survive S3 sleep, which
> laptops spend a lot of time in (around 50% when doing coantrol at 100 H=
z).
>=20

Great. Someone should go out and choke a few hardware developers again
for being that short-sighted. So the PM timer is the most robust one,
just a bit slow.

Jan


--------------enig03C285EA9FFFD61ED04C904C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4yHMniDOoMHTA+kRAveMAJ0THr61spIbQmpMq6HF1eheI1zrKwCePBqP
wsTb7TRjJGE11fe60f/7x7A=
=N2Ke
-----END PGP SIGNATURE-----

--------------enig03C285EA9FFFD61ED04C904C--

