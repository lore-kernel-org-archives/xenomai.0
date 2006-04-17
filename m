Message-ID: <444404DC.60905@domain.hid>
Date: Mon, 17 Apr 2006 23:13:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] collecting xenomai statistics
References: <200604171047.51730.niklaus.giger@domain.hid>
In-Reply-To: <200604171047.51730.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5444CAC973BA37EB64C06295"
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
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5444CAC973BA37EB64C06295
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi
>=20
> Following a suggestion from Philippe Gerum I propose to collect and pre=
pare=20
> like this:
>=20
> a) Make it easy to collect information
>=20
> add -s/-c option to xeno-test, help text would look like=20
> -s         send output of xeno-test to xeno-stat@domain.hid
> -c <name>  if -s, send also kernel config file to xeno-stat@domain.hid=

> (May be patch xeno-config to emit also the revision of the svn checkout=
?)
>=20
> b) Setup an e-mail account xeno-stat@domain.hid.
>=20
> c) Add a archiver which generates daily a gzipped tar file of all messa=
ges=20
> ever sent to xeno-stat@domain.hid (e.g. of its mbox). Make it availabl=
e=20
> somewhere on the internet.
>=20
> d) Write a converter the raw messages into more suitable representation=
, eg. a=20
> MySQL-DB, a spreadsheet format. Extract the raw message and kernel conf=
ig and=20
> store the publicly accessible on the internet. The DB/spreadsheet will =

> contain pointers (URLs) to the raw message/kernel config.
>=20
> e) Write viewers which present interesting statistics. E.g. X/HTML page=
s to=20
> present a ordered (by architecture, board, version, etc) view of the=20
> available  results.

Do you know http://issaris.org/rtai (the RTAI LiveCD)? It's no longer
maintained but may still contain useful ideas, and Takis (Panagiotis
Issaris) will likely be happy to answer questions on details of his
approach.

>=20
> I would like to advance like this:
>=20
> I am not interested in step a), as it is easy for me just to write a tr=
ivial=20
> script to sent the xeno-test output to any address. Also adding the rev=
ision=20
> of svn checkout is not very difficult.
>=20
> For point b+c) I am lacking the necessary rights, but it easy for me to=
 setup=20
> a similar account for my tests here. But I would appreciate, if somebod=
y of=20
> the core team would help me to get this work done.
>=20
> For point d+e) I will (after a week of vacation with my son) invest som=
e work.=20
> But I would be very interested in knowing exactly which kind of informa=
tion=20
> the core developers are interested in. How should it be presented? In t=
abular=20
> form? Graphs, which ones? And kind of feedback will be evaluated and=20
> integrated.
>=20

I think starting with what Takis once collected would be more than
enough for a first round.

I cannot provide you access to the infrastructure, but I vote for
granting it. Great commitment!

Jan


--------------enig5444CAC973BA37EB64C06295
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERATcniDOoMHTA+kRAn2NAJ9dahE6a0EUSrAX1CdWyIR80vheZACdG80b
zwRaRA3QMOABYY5BHt3wo94=
=imEH
-----END PGP SIGNATURE-----

--------------enig5444CAC973BA37EB64C06295--

