Message-ID: <43DE03CF.3070603@domain.hid>
Date: Mon, 30 Jan 2006 13:17:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] broken docs
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210CE1@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210CE1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig413787EEE3F986665E1AAA9F"
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
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig413787EEE3F986665E1AAA9F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ROSSIER Daniel wrote:
> Dear Xenomai workers,
>=20
> Would it be possible to have an updated API documentation for Xenomai
> 2.0.x ? (I mean with formal parameters in function prototypes)
>=20
> I tried to regenerate it with make generate-doc, but it seems that a
> SVN working dir is required.
>=20
> It would be great.

I just had a "quick" look at the status of the documentation in
SVN-trunk (2.1). Unfortunately, doxygen is a terrible tool (to express
it politely) when it comes to tracking down bugs in your formatting.
Something is broken in all modules except RTDM, and although I spent *a
lot* of time in getting RTDM correctly formatted, I cannot tell what's
wrong with the rest. This will require some looooong evenings of
continuous patching the docs, recompiling, and checking the result. Any
volunteers - I'm lacking the time? :-/

Jan


--------------enig413787EEE3F986665E1AAA9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3gPPniDOoMHTA+kRAs9mAJ9D78v8P68YP5DeTuNLUhSBayCgmwCfVPu8
Ky9f6npGdtQI9ZU5+F6Gulo=
=BU/3
-----END PGP SIGNATURE-----

--------------enig413787EEE3F986665E1AAA9F--

