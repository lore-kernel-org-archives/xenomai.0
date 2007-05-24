Message-ID: <4655800A.30506@domain.hid>
Date: Thu, 24 May 2007 14:07:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C8@domain.hid>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C8@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAF7066860FEE4EE00731430A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Newbie question] threads and task CPU affinity
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF7066860FEE4EE00731430A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

RAKOTOSALAMA, Nirilanto wrote:
> Thanks Jan,
>=20
> It's more and more clear.
> Just a question, I've a little doubt. Native tasks do not inherit
> affinity from their parent process. I've read that cpu affinity=20
> setting at pthread creation is only availablle in kernel space.
> Do Posix skin threads inherit affinity from their parent, in user space=
?

IIRC, pthread CPU affinity is not (yet) covered by the POSIX specs, thus
the behaviour depends on Linux here. Moreover,
pthread_attr_setaffinity_np support for Xenomai is infeasible due to
glibc compatibility issues - again: IIRC. Gilles, please correct my weak
memory on this topic.

>=20
> If not, when I "sched_setaffinity" a parent process, I have to=20
> recursively "sched_setaffinity" all its threads and force them to
> switch to primary mode. Is it right ?

If you want well-defined target CPUs, then you need explicit
sched_setaffinity, cpusets, or Xenomai 2.4's global affinity mask. But
you don't need to switch back to primary mode, that will happen
automatically.

Jan


--------------enigAF7066860FEE4EE00731430A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVYAKniDOoMHTA+kRAqtYAJ9PqK8gB0P0Gzl53zTr5jDMFkZSYwCcDld/
DotX2J2l/WGyBmlbt0UdOCY=
=JAZk
-----END PGP SIGNATURE-----

--------------enigAF7066860FEE4EE00731430A--

