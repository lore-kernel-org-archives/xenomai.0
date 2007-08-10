Message-ID: <46BC7A0A.1060309@domain.hid>
Date: Fri, 10 Aug 2007 16:45:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <000c01c7db59$181f8680$c124a986@domain.hid>
In-Reply-To: <000c01c7db59$181f8680$c124a986@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig31210766813DD5D7DE5441BB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters of
 threads in other processes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig31210766813DD5D7DE5441BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Torsten Kr=F6ger wrote:
> 3. Is there a possibility of using the native skin and the posix skin a=
t
> the same time?

Yes: Write your message passing protocol as an RTDM protocol device.
That way you would have the socket API as interface (for all skins!) and
could even fiddle with priority as you like. We went this way for our
TiMS (Tiny Message Passing Service) in the RACK framework [1]. It's
fairly specialised due to its roots and its applications domain, but the
general idea is surely transferable.

Note that we do _not_ play with the receiver priorities, we rather
prefer a stable _static_ system configuration. That's better for hard
RT, and prio-inheriting MPI generally doesn't help about worst-case
latencies anyway (given a non-broken static prio design).

Jan

[1] http://developer.berlios.de/projects/rack


--------------enig31210766813DD5D7DE5441BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGvHoKniDOoMHTA+kRAl5JAJ9Unpm/jwBnbqErYNxUqifO0+/yGwCfdNDa
7lwtYiyfBUDteiXzhpTe+l4=
=9qSe
-----END PGP SIGNATURE-----

--------------enig31210766813DD5D7DE5441BB--

