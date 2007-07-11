Message-ID: <469487A7.8030204@domain.hid>
Date: Wed, 11 Jul 2007 09:32:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4693A702.1010604@domain.hid>
	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<12423528.1184136237522.JavaMail.ngmail@domain.hid>
In-Reply-To: <12423528.1184136237522.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5005C94430479E364776F8B0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Sporadic PC freeze after rt_task_start
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
--------------enig5005C94430479E364776F8B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> as I mentioned in my first mail on this topic, I have extracted this ex=
ample from a huge
> real time application where the system sporadically freezes.
> What I have found out there was, that the system freeze happened always=
 when trying
> to start a thread (in the original application, the tasks run fairly lo=
ng).

OK, so it's one of rt_task_create (unlikely), rt_task_start, usleep, or
some early code in the task function itself. Still, a lot of "or"...

Again, please consider my further debugging suggestions.

> I think it has to do with rt_task_start() followed by usleep() and the =
non-realtime stuff running
> on CPU 0 and the realtime stuff running on CPU 1.
> I never saw that issue on a single core CPU (even if the same SMP kerne=
l was used).

Yeah, it must be a nice race that requires real parallelism.

Jan


--------------enig5005C94430479E364776F8B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGlIeoniDOoMHTA+kRApSzAJ9RSFl6+L4mOLTlGFyglkSg6MhUjQCeM4WD
72IT3/aB7qZuE6/nj8ssfg4=
=AIS3
-----END PGP SIGNATURE-----

--------------enig5005C94430479E364776F8B0--

