Message-ID: <46DBA5D8.8030106@domain.hid>
Date: Mon, 03 Sep 2007 08:12:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <41f748550709022126g1bf2bf0bvb3fbf74373932b00@domain.hid>
In-Reply-To: <41f748550709022126g1bf2bf0bvb3fbf74373932b00@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig955C8FCE387777B008EBAE8D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Down interruptible
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Iwan Budi Kusnanto <iwanbk@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig955C8FCE387777B008EBAE8D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Iwan Budi Kusnanto wrote:
> Hello all
> why rt_sem_p does not have behaviour like down_interruptible (that
> receive a signal while being blocked on a semaphore to give up the
> "down"/"p" operation).Is that a bad design?
> sem_wait (posix skin)have behaviour like that.

rt_sem_p() does have the desired property. If you observed anything
different in practice, it would be a bug and we would be happy to hear
more details (used versions, testcase code, etc.).

Just note that signal delivery breaks the determinism of the target
application.

>=20
> In what situation we must use posix skin?
> In what situation we must use native skin?

There are no technical reasons to pick any of them, it's purely a design
question of your application (/me being in hurry and can't go into
details ATM).

Jan


--------------enig955C8FCE387777B008EBAE8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG26XYniDOoMHTA+kRAjDGAJ0b8D1Xi2MOeYJ4gKC9Eafq4rldZgCeKmhL
suafjsMPzD5evFiHcWjrFdg=
=uVHW
-----END PGP SIGNATURE-----

--------------enig955C8FCE387777B008EBAE8D--

