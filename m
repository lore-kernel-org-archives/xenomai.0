Message-ID: <45D58770.6030201@domain.hid>
Date: Fri, 16 Feb 2007 11:29:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] heap allocation in xenomai
References: <528bc2040702160148j5c63209fi40face4810613bfd@domain.hid>
In-Reply-To: <528bc2040702160148j5c63209fi40face4810613bfd@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig98AEBC51477433D34D01EEBE"
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
To: manoj kumar <manojkpanghal@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98AEBC51477433D34D01EEBE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

manoj kumar wrote:
> Hi,
>=20
> Could anybody tell me about heap allocation in xenomai by API
> rt_heap_create().
>=20
> Why heap creation is required? Please tell the uses in detail?

The native skin's heaps provide means to reserve separate memory pools
and to perform deterministic allocation on it (as far as the heap usage
patterns are known).

For further derails, please read the API documentation and consult e.g.
the demo code: ksrc/skins/native/snippets/local_heap.c. Or ask a bit
more concrete questions.

>=20
> Can kmalloc & free be used in any RT program at kernel space? If yes, A=
re
> there any limitation on that? if Yes, then which are those.

You can, but only during module init/cleanup, *NOT* while running inside
an RT task. That's because these Linux services may have been preempted
by Xenomai at any point while Linux was using it, and a re-entrance from
a Xenomai task would corrupt them.

Jan


--------------enig98AEBC51477433D34D01EEBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1YdwniDOoMHTA+kRAoRtAJ0TWyzsT2qDYvuDoZk3IA2qTKJg7gCeNCXt
JN+4R37IHJfRqH0G1arsAdU=
=1sRQ
-----END PGP SIGNATURE-----

--------------enig98AEBC51477433D34D01EEBE--

