Message-ID: <43EA37E9.8060101@domain.hid>
Date: Wed, 08 Feb 2006 19:26:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
	<200602081043.47859.lbocseg@domain.hid> <43E9EEBA.1050405@domain.hid>
	<200602081603.10267.lbocseg@domain.hid>
In-Reply-To: <200602081603.10267.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8A7B7D24AF2841593D2BCCD1"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A7B7D24AF2841593D2BCCD1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Quarta 08 Fevereiro 2006 11:14, Jan Kiszka escreveu:
>=20
>>> ...
>>> Jan, actually I didn't like the /dev/zero hack. If someone else is
>>> using /dev/zero it will result in a problem... I think it would be be=
tter
>>> to
>> Why? It isn't an exclusive device. And I'm only invoking open/close on=

>> the original instance (which even have no handlers associated, see
>> drivers/char/mem.c), mmap gets overloaded.
>=20
> I'm a little confused here. I noted you have made a backup of the=20
> file_operations struct and private_data. So, I've concluded, wrongly, t=
hat=20
> those handlers would be used by every process that called that open han=
dler.=20
> But, looking at the mem.c code, I think that those data (file_ops and=20
> private_data) are different structs each time the user issues a call to=
 open.=20

Yep, that's the point. Actually, I was inspired by some other mmap'ing
driver which does a similar overloading on it's own device type.

> If that is true, I don't see any problem in using your approach. But I =
don't=20
> see neither any needs for making that backup...

On first sight this is true and the backup is redundant. But it is
cleaner to not rely on a specific kernel implementation. Instead it's
saner to look at the model: I'm changing the fops without knowing what
the open handler did, so make sure that a possible release handler can
run. And this is also not very costly here. :)

Jan


--------------enig8A7B7D24AF2841593D2BCCD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD6jfpniDOoMHTA+kRAu47AJ0dFTu7KS6V3L5xsHNch8YpKz1ckwCeJGEK
B+jtPeOKmMOl485RNViDJyc=
=QMoq
-----END PGP SIGNATURE-----

--------------enig8A7B7D24AF2841593D2BCCD1--

