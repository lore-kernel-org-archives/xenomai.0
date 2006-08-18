Message-ID: <44E60587.10205@domain.hid>
Date: Fri, 18 Aug 2006 20:23:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Test, benchmark
References: <44DA896F.9060102@domain.hid>	<44DB1865.90004@domain.hid>	<44DB9958.10109@domain.hid>	<44DCAF88.2060801@domain.hid>	<44E5F0B4.8070405@domain.hid>
	<17637.63157.596008.331241@domain.hid>
	<44E60313.8000803@domain.hid>
In-Reply-To: <44E60313.8000803@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DD8653706B67B1B1F561CF9"
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DD8653706B67B1B1F561CF9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
> ...
> Also, 2 possible output change requests:
>=20
> a - print per-sample measures, not accumulating ones.
>    this is more consistent with latency, which prints the latencies
>    seen over the 1-sec sample period
>    This also feeds better into histogram, w/o adding 'delta' logic to
> histogrammer
>=20
> b - label output lines more in spirit of latency

My idea on this is to get that part (the formatting and dumping) out of
the individual test, into a shared benchmark library. That would
consolidate things, simplify the individual tests (irqbench is lacking
it therefore), and help to modify things later when requirements for the
data processing change/enhance.

Would you like to work on this? Of course, you can count on useless to
weird comments by us when you'll post any API design or patch. ;)

Jan


PS: But I'm not sure if that library would apply well to switchtest...


--------------enig5DD8653706B67B1B1F561CF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE5gWHniDOoMHTA+kRAjZfAJ4pWCdFDIWsdQM3wnAxScoHQuy99gCeIwn9
eRuLu/PmSIHho8P6AYbqnXs=
=tsJK
-----END PGP SIGNATURE-----

--------------enig5DD8653706B67B1B1F561CF9--

