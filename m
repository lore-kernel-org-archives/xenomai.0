Message-ID: <45D0F4AF.3030309@domain.hid>
Date: Tue, 13 Feb 2007 00:13:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] interrupt latencies (irqloop/irqbench)
References: <45D0E411.4010807@domain.hid>
	<45D0EDBC.5020402@domain.hid>
	<45D0F1E2.3020201@domain.hid>
In-Reply-To: <45D0F1E2.3020201@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig30CD7647486601B01C5F64C7"
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
To: Markus.Franke@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig30CD7647486601B01C5F64C7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Jan Kiszka wrote:
>> This test mode exploits the I-pipe support for multiple domains
>> intensively.=20
>=20
> I know....I read the nice txt-document :-)
>=20
>> By default, Xenomai is configured to be the topmost domain
>> and is optimised for this use case. But it can also be "second-best" a=
nd
>> let someone else be first in the interrupt pipeline - e.g. xeno_irqloo=
p.
>> To achieve this, switch off CONFIG_XENO_OPT_PIPELINE_HEAD (nucleus
>> option) and retry the test.
>=20
> Ok I understand. It would be good if such a hint would be in this txt-f=
ile.
>=20
>> Then there is a bug - in the doc. :)
>=20
> Why? The above information is simply missing. :-)

I consider missing information as a bug too. However, fixed now.

Jan


--------------enig30CD7647486601B01C5F64C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF0PSwniDOoMHTA+kRAkb8AJ0bOxQG3SR7PAA2hFgnvmgaEmxIeACfY09k
6dPyXlgBNGm9yZAeJnaTHKI=
=G05r
-----END PGP SIGNATURE-----

--------------enig30CD7647486601B01C5F64C7--

