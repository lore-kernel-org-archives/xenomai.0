Message-ID: <4800B4FA.1050309@domain.hid>
Date: Sat, 12 Apr 2008 15:11:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0804111759280.5433@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0804111759280.5433@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig984D24B492ABCDCB468DF201"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rt_task_sleep_until question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig984D24B492ABCDCB468DF201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Klaas Gadeyne wrote:
> Hi,
>=20
> I've noticed that threads which, in my ignorant opinion, are supposed
> to be sleeping, get woken up much earlier than I expect them to be.
>=20
> Please find attached a modified version of the trivial-periodic.c
> application, which creates a RT_TASK that should sleep as long as
> possible (i.e. until unblocked by a signal handler).  However, the
> task gets woken up much earlier (and many times) _before_ that time it
> seems.
>=20
>  head /tmp/app.txt
> current_time =3D 1207928393295939429
> sleep until 18446744073709551615
> [TIMERLOOP] Total errors =3D 1, return code =3D -110
> current_time =3D 1207928393296000379
> sleep until 18446744073709551615
> [TIMERLOOP] Total errors =3D 2, return code =3D -110
> current_time =3D 1207928393296005409
> sleep until 18446744073709551615
> [TIMERLOOP] Total errors =3D 3, return code =3D -110
> current_time =3D 1207928393296009604
>=20
> What did I overlook here?

Probably an overflow issue: (RTIME)~0 will be converted to TSCs, and if=20
your box runs at > 1GHZ, the result of this conversion will by something =

< (RTIME)~0 due to the overflow. And this can result in an absolute=20
timeout date (in TSC units) before the current date -> ETIMEDOUT. Can=20
you confirm this?

Jan


--------------enig984D24B492ABCDCB468DF201
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIALT/niDOoMHTA+kRAn/1AJ90dD6z0i4+LwvbyFBMk8UieORnNwCdGZr1
zLsOnb+xqlzVcnovpcNra58=
=vsaq
-----END PGP SIGNATURE-----

--------------enig984D24B492ABCDCB468DF201--

