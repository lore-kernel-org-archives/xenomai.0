Message-ID: <44F1A478.4000504@domain.hid>
Date: Sun, 27 Aug 2006 15:56:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Timer problems?
References: <1903864415@domain.hid>
	<1154964748.4322.31.camel@domain.hid>	<44EF17E8.5040606@domain.hid>
	<44EF37BE.70207@domain.hid>	<44F0B06B.6050102@domain.hid>	<44F17616.9080701@domain.hid>
	<1156680494.4325.68.camel@domain.hid>	<17649.37187.585271.837835@domain.hid>
	<1156683742.4325.75.camel@domain.hid>
In-Reply-To: <1156683742.4325.75.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBE32324B23E3BF0319E548F8"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE32324B23E3BF0319E548F8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2006-08-27 at 14:34 +0200, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>  > - It is automatically solved by Xenomai over Linux 2.4, and should =
be
>>  > solved by disabling CONFIG_VT entirely over Linux 2.6 for configura=
tions
>>
>> Disabling PC speaker is not enough to avoid the conflict on 2.6 ?
>>
>=20
> CONFIG_INPUT_PCSPKR? Yes, it should actually be even better, since I
> don't see any dependency of CONFIG_VT on CONFIG_INPUT_PCSPKR. Only the
> input sub-system infrastructure is required.
>

For sure, it's CONFIG_INPUT_PCSPKR (that's also what we are now testing
for in 2.3-devel). My bad, I confused some options.

Jan


--------------enigBE32324B23E3BF0319E548F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE8aR4niDOoMHTA+kRAr0FAJ9QafdbjDs7zA2Ug7n+QUykn1RWSQCeKIwb
1DSmZhvIDGZDc1h3lupPugE=
=swF5
-----END PGP SIGNATURE-----

--------------enigBE32324B23E3BF0319E548F8--

