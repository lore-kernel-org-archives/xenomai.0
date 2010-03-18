Message-ID: <4BA24469.1040508@domain.hid>
Date: Thu, 18 Mar 2010 16:19:05 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B97EB5C.2090600@domain.hid>
In-Reply-To: <4B97EB5C.2090600@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig76363FF74A0EF9413FF04E91"
Subject: Re: [Xenomai-core] proc_file_read: Apparent buffer overflow
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig76363FF74A0EF9413FF04E91
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 10.03.2010 19:56, schrieb Stefan Kisdaroczi:
> Hi,
>=20
> cat /proc/xenomai/heap returns the first 4096 Bytes and fails then with=
 "Bad address".
> On the console I see: "proc_file_read: Apparent buffer overflow!"
>=20
> xeno 2.5.1, linux 2.6.32.8, x86 32bit UP, native skin, lot of rt_queues=
:
> # ls -1 /proc/xenomai/registry/native/queues/ | wc -l
> 233
> # ls -1 /proc/xenomai/registry/native/heaps/ | wc -l
> 26

With some luck i get a oops doing cat /proc/xenomai/heap.
Looking at the while() loop in heap_read_proc() in ksrc/nucleus/heap.c
its obvious.

Stefan


--------------enig76363FF74A0EF9413FF04E91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLokRpIPTw9rIdn6oRAnaPAJ45m1LBv80tAnJf/7auAh5uNXzxNwCdGNfu
AN+W90Msf6tlryCaeFJ7t1Y=
=7SK7
-----END PGP SIGNATURE-----

--------------enig76363FF74A0EF9413FF04E91--

