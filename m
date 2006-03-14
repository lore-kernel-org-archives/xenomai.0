Message-ID: <44174400.3010803@domain.hid>
Date: Tue, 14 Mar 2006 23:30:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenoami task pids
References: <067C9A1F6AFEB643895EA4513E116884178FBD@exfp1.Railpowertech.local>
In-Reply-To: <067C9A1F6AFEB643895EA4513E116884178FBD@exfp1.Railpowertech.local>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig92509054AB2CC5977F22D5DA"
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
To: "Moser, Dan" <DMoser@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92509054AB2CC5977F22D5DA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Moser, Dan wrote:
> Hi,
>=20
> I am a Linux and Xenomai newbie.
>=20
> I have two separate Xenomai 2.1-rc4 environments, one I built with
> Gentoo running under VMware (WindowsXP Host) and another (that somebody=

> else built sometime in the recent past) with Gentoo running native on a=

> PC.
>=20
> I have identical code (and Makefile) that simply executes an
> rt_task_create(), rt_task_set_periodic(), and rt_task_start() and runs
> (seemingly) proper on both boxes.
>=20
> But:
>=20
> On one box, the main thread and the Xenomai task thread have DIFFERENT
> pids (reported via a call to getpid()).  On the other box, the main
> thread and the Xenomai task thread have the SAME pid (again, reported
> via a call to getpid()).

getpid =3D get process id, not thread id (there is pthread_self() for thi=
s).

My blind guess is that you are running linux_threads on the one machine
and NPTL threads on the other. Those are the libraries providing POSIX
thread support to the application, and this is also what Xenomai uses as
platform for its RT-threads. The first (older) library maps threads on
light-weight processes, the latter (NPTL) on real threads. Thus you get
a new id in the first and the same id in the second case. Again, just a
guess, I never stumbled over this behaviour consciously.

>=20
> Is there some sort of Xenomai and/or application config/build option
> that controls this behavior?
>=20
> Thanks in advance,
> Dan
>=20

Jan


--------------enig92509054AB2CC5977F22D5DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEF0QBniDOoMHTA+kRAsXnAJ4miSBVEM9UP+mATIguL7xHVRJNJACfTUPI
o5J0UXGsGVzVp4VJ7HmUmNE=
=ICYl
-----END PGP SIGNATURE-----

--------------enig92509054AB2CC5977F22D5DA--

