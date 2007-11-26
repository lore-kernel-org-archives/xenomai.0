Message-ID: <474A6BC8.6010705@domain.hid>
Date: Mon, 26 Nov 2007 07:46:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <41f748550711252024x51cf33ctd97a076c741274be@domain.hid>
In-Reply-To: <41f748550711252024x51cf33ctd97a076c741274be@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5F57FD2F39C04653C6210C6C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] /proc/xenomai/sched
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
--------------enig5F57FD2F39C04653C6210C6C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Iwan Budi Kusnanto wrote:
> Hello all.
> Is all task will listed in /proc/xenomai/sched ?
> One of may tasks not in there.
> rt_task_spawn return 0 (success) and no error message in dmesg.
>=20

May be you should check if your task happens to exit before you have a
chance to spot it in /proc. And yes, as long as it exists, it is listed
there.

Jan


--------------enig5F57FD2F39C04653C6210C6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHSmvMniDOoMHTA+kRArE+AJ9xfIPfxgQnKx8Qf/PYWYEIJeZ5cQCggUbm
gcIqZZYd1j8IHgcrJGpOrL4=
=tUD4
-----END PGP SIGNATURE-----

--------------enig5F57FD2F39C04653C6210C6C--

