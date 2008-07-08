Message-ID: <4873464B.9090703@domain.hid>
Date: Tue, 08 Jul 2008 12:49:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <486E6486.5060000@domain.hid>
	<200807072312.57613.berlemont.hauw@domain.hid>
	<48731B11.80906@domain.hid> <1215513338.487342fa9659c@domain.hid>
In-Reply-To: <1215513338.487342fa9659c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF82F6B19578467C2A199EDD9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] comedi: Fix include for do_div
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: berlemont.hauw@domain.hid
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF82F6B19578467C2A199EDD9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

berlemont.hauw@domain.hid wrote:
> Hi,
>=20
>> Sorry, but the committed fix is bogus for 2.6.26. I would suggest just=

>> to pick up what I proposed, kernel headers do the same since ages
>> (including 2.4).
>=20
> Argh... I am an [CENSORED].
>=20
> I missed everything, I was in another dimension. I had a too quick look=
 at your
> fix (I saw linux/div64 instead of asm/div64) so I decided to put a temp=
orary fix
> (as I was running out of time to get some 2.6.26-rcx sources).
>=20
> I will fix that tonight.
>=20
> Sorry I will be more careful (next time, I directly apply your patch).

(Please don't - I may post patches from other dimensions as well.) :)



--------------enigF82F6B19578467C2A199EDD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkhzRk4ACgkQniDOoMHTA+nc5wCfXa1tGPXcdybFAog1IUanBHvJ
4UUAn0hiIkLMWX2Wk5/bDx7e8EfDo783
=MZID
-----END PGP SIGNATURE-----

--------------enigF82F6B19578467C2A199EDD9--

