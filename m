Message-ID: <444F9BDB.200@domain.hid>
Date: Wed, 26 Apr 2006 18:12:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1FYmA5-0003S9-00@domain.hid>
In-Reply-To: <E1FYmA5-0003S9-00@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6A0B2E63D773291519E85821"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] Re: Adeos-cvs Digest, Vol 10, Issue 11
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A0B2E63D773291519E85821
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

adeos-cvs-request@domain.hid wrote:
> ...
> Commit from rpm (2006-04-26 17:41 CEST)
> ---------------
>=20
> Make IPIPE_TRACE_PATHS configurable
>=20
>   ipipe  v2.6/common/kernel/ipipe/tracer.c       1.10
>   ipipe  v2.6/common/kernel/ipipe/Kconfig.trace  1.4

=46rom a quick glance it appears to me you provided a nice interface to
break some stuff :). At least the explanation is not correct.

Those four paths are required to 1) always have an active path at hand
for recording, 2+3) keep the latest max or frozen path, and 4) escape
with to an alternative slot during max/frozen updates in case the
previous one is currently locked for output or whatever and cannot
become the new active path.

So, the absolute minimum is 3 when there is definitely no concurrent
usage of ipipe_trace_begin/end vs. ipipe_trace_freeze (remember that
users may want to define their own begin/end points if
IPIPE_TRACE_IRQSOFF is not set). Raising it above 4 is of no practical
use so far.

What is your idea behind it?

Jan


--------------enig6A0B2E63D773291519E85821
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFET5vbniDOoMHTA+kRAp3nAJ433YB9xPNUHGWaD5bXSVMAX6bv4gCdF+j3
68bLj9geDlIvjqkQWshP8nw=
=9ZSj
-----END PGP SIGNATURE-----

--------------enig6A0B2E63D773291519E85821--

