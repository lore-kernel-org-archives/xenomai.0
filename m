Message-ID: <4641C3E9.4050105@domain.hid>
Date: Wed, 09 May 2007 14:51:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4641B5CF.80303@domain.hid>
	<22908039.1178707932628.JavaMail.ngmail@domain.hid>
	<13086080.1178713660670.JavaMail.ngmail@domain.hid>
In-Reply-To: <13086080.1178713660670.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig428B9576C5305C4530ABF888"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized for
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig428B9576C5305C4530ABF888
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
> =20
> primarily I want to execute my simulation models as fast as possible. T=
his is, I want=20
> to optimize the average execution time. As there are a series of critic=
al sections to
> be passed this should also have an impact on the worst execution time.
>=20
> The critical region in the simulation are at locations when a lower pri=
o thread and a higher
> prio thread access the same data. This happens at a couple of times wit=
hin a simulation step=20
> (within that critical region there are typically some copy operations).=

> However, once the higher prio thread has entered one critical region it=
 is sure (at least if
> both threads run on the same CPU core) that it will be able to enter th=
e next critical region without
> waiting.
> That means, that improving the average runtime should also help to impr=
ove the worst case
> runtime of the highest prio thread.

Not saying that the futex idea itself is not worth pursuing, but I would
first of all think about if there aren't other, far simpler
optimisations available at application level: lock-less algorithms e.g.
that flip some current-buffer pointers instead of locking the access to
a single shared buffer. Or a locking scheme that reduces the number of
locks the highest prio thread has to take in a row. Specifically when
you say that taking lock A implies to succeed in taking B as well, I
wonder if there is a need for A!=3DB.

Jan


--------------enig428B9576C5305C4530ABF888
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGQcPpniDOoMHTA+kRAusuAJ4+mduqyH9BiUc7vnMgcMcd03STIACeOlo2
7hFv7WZQ8J9ThDIzMU2eEKc=
=Yuyc
-----END PGP SIGNATURE-----

--------------enig428B9576C5305C4530ABF888--

