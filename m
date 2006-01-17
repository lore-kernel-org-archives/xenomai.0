Message-ID: <43CCF7C2.6070403@domain.hid>
Date: Tue, 17 Jan 2006 14:57:22 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3F4F96119D2D501E00AA28E8"
Subject: [Xenomai-core] rt_heap in userspace, heapsize
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3F4F96119D2D501E00AA28E8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I made a small test with rt_heap_ in userspace,
i think I understood the actual limitations of the userspace support.
I used 10000 as heapsize. Xenomai 2.1-RC2/x86.

This should alloc the entire heap, according to the API documentation:
rt_heap_create( ..., ..., 10000, ... )
rt_heap_alloc( ..., 10000, ..., .... ) -> This call fails, but it should =
work

Using heapsize 0 it works:
rt_heap_create( ..., ..., 10000, ... )
rt_heap_alloc( ..., 0, ..., .... )

rt_heap_inquire shows a heapsize of 12228 (IIRC).
So, this would probably work (untested):
rt_heap_create( ..., ..., 10000, ... )
rt_heap_alloc( ..., 12228, ..., .... )

The 2228 bytes difference seems to be the space needed for the heap contr=
ol structures.

I think the following should be fixed:
1) rt_create_alloc should alter the heapsize the same as rt_heap_create d=
oes
2) rt_heap_inquire should return the _real_ heapsize

thx
kisda



--------------enig3F4F96119D2D501E00AA28E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFDzPfJIPTw9rIdn6oRAn77AJ9I0H/I6o4BCnqZHerfVfkCttR/ugCePz2Y
+R6uCqSqYrRgp+BqzKNrv0M=
=7h1p
-----END PGP SIGNATURE-----

--------------enig3F4F96119D2D501E00AA28E8--

