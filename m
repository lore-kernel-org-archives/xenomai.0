Message-ID: <457820B7.3030603@domain.hid>
Date: Thu, 07 Dec 2006 15:09:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems using rt_queue_alloc: returns 0 although
	enough memory available (xenomai 2.2.3)
References: <OF0E0E01F1.79314A79-ONC125723D.002F4B91-C125723D.004B0598@domain.hid>
In-Reply-To: <OF0E0E01F1.79314A79-ONC125723D.002F4B91-C125723D.004B0598@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAEBBF5938736B6FC88B8DFB7"
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
To: juergen.lanner@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEBBF5938736B6FC88B8DFB7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

juergen.lanner@domain.hid wrote:
> Hi gentlemen!
>=20
> I had a problem with real time queues recently and want to know if I
> understood something wrong or if it is a real problem.
>=20
> The problem was that I couldn't alloc enough memory for my message in t=
he
> internal buffer before sending it.
>=20
> I tried to bring some light into the problem by printing the data I get=

> from rt_queue_inquire to see the queue's state in more detail.
> But this seems ok (at least from my point of view)
>=20
> Did anybody see the problem as well? What could be the reason?

I do not yet fully understand your problem (a self-contained demo
program can help to explain a scenario better). But if you are trying to
find out how many memory is still free in a queue-pool, rt_queue_inquire
will not help you. It always returns the full pool size without any
message allocated.

Maybe we could enhance this interface by the currently available pool
memory if this is desired.

Jan


--------------enigAEBBF5938736B6FC88B8DFB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFeCC3ncNeS9Q0k+IRAguUAKCW6bdX89+LsYcTx13WAATf02pCvQCfYPvj
n2Rk13+n5zz6ICzU64BKX8w=
=8qKb
-----END PGP SIGNATURE-----

--------------enigAEBBF5938736B6FC88B8DFB7--

