Message-ID: <453911D4.8060901@domain.hid>
Date: Fri, 20 Oct 2006 20:13:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig96213CE9585476FA2149F0CD"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 0/2] Selectable heap allocators
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Miguel Angel Masmano Tello <mimastel@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96213CE9585476FA2149F0CD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

here comes a patch series for an idea I have in mind for quite some
time: break up the nucleus heap layer so that it can support different
allocation schemes. Motivated was this idea by the great TLSF allocator
by Miguel Masmano et al.

I once played with TLSF in userspace as a malloc replacement for RT
apps, and I wondered if we shouldn't make use of it as well in the
nucleus. It's most beautiful property is its strict O(1) complexity in
my eyes, but it seems to provide even more qualities: less
fragmentation, less overhead, maybe even better performance.

I haven't done any thorough analysis on those advantages (I'm counting
on Miguel and others to prove them ;) ), only stability tests over the
last weeks and a simple comparisons of the overhead. With 8 user-space
tasks, a few mutexes, 8 RTDM sockets, and likely some other stuff
allocated I get e.g. these usage numbers:

bsdalloc:
size=3D524288:used=3D17720:pagesz=3D512

tlsfalloc:
size=3D524288:used=3D14036:pagesz=3D512


This patch series now first tries to abstract a common interface for
heap allocators. Those allocators can be statically selected at compile
time. As the second step it adds latest TLSF version 2.2.0 as an
alternative to BSD. Default remains BSD for now.

TLSF is currently limited to 32-bit archs, but 64-bit support is on the
roadmap according to Miguel. He kindly helped me with preparing the TLSF
patch for Xenomai usage. Thanks to him at this point!

Jan


--------------enig96213CE9585476FA2149F0CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFORHUniDOoMHTA+kRAnNaAKCFE8XE6W5PPLLoSquFFlDDkJrkSACfTtaq
YJbA8KHlxWnVIHvol5NZQII=
=gz0T
-----END PGP SIGNATURE-----

--------------enig96213CE9585476FA2149F0CD--

