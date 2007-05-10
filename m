Message-ID: <46439123.60705@domain.hid>
Date: Thu, 10 May 2007 23:39:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <D412DC851FDFAB4D8976895AC5C1F8AD30A6E0@domain.hid>
In-Reply-To: <D412DC851FDFAB4D8976895AC5C1F8AD30A6E0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1ACB6E565795CB499BB2F48A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtdm_iomap_to_user question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Zhang, Haobo" <haobo.zhang@domain.hid>
Cc: xenomai@xenomai.org, stelian@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1ACB6E565795CB499BB2F48A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Zhang, Haobo wrote:
> Hi,
>=20
> I am currently working on a project which is running on a PowerPC
> platform. In my rtdm driver, I use "rtdm_iomap_to_user" to map a few I/=
O
> memory locations to be accessed from my application. All the function
> calls seem to work (no error code returned). But my application fails t=
o
> use these pointers to manipulate any I/O. Is there any restrictions I
> have to be aware in order to use those mapped I/O mem? I am new to
> xenomai. I would really appreciate any help to this.=20

Maybe you can post code or relevant code snippets so that we can have a
look. As I personally haven't work with this particular service yet, I
put Stelian in CC who contributed it and might already have some
suggestion. But, again, code talks much more.

Jan


--------------enig1ACB6E565795CB499BB2F48A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQ5EjniDOoMHTA+kRApOyAJ9EahPHEAjowAQQDWpXoWX6nv61tQCePEEU
q1ZthHKbXF4nzFF9r3iIveA=
=BlBa
-----END PGP SIGNATURE-----

--------------enig1ACB6E565795CB499BB2F48A--

