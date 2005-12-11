Message-ID: <439C654F.9080805@domain.hid>
Date: Sun, 11 Dec 2005 18:43:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig535BA8AB6A5F4626CC8BE0CF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Extensible heaps - needed for the future?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig535BA8AB6A5F4626CC8BE0CF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

I noticed that xnhead_extend() is not used at the moment [1], thus the
whole extent management is redundent for now. Are there plans to use it
in the future? Should we keep this feature?

I'm asking as I still have the idea in my head of breaking up the heap
service and introducing a generic allocator interface to select
different heap allocators at compile time. So, should extensions be an
optional feature of an allocator?

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/ident?v=SVN-trunk;i=xnheap_extend

--------------enig535BA8AB6A5F4626CC8BE0CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDnGVPniDOoMHTA+kRArCjAJwL3aeh7KdFb5lEaZMxzzv/sH6GjwCcCCb7
qfnbWdk38Elrjmanckdm4Zg=
=Nlzq
-----END PGP SIGNATURE-----

--------------enig535BA8AB6A5F4626CC8BE0CF--

