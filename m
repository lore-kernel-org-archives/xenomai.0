Message-ID: <4B10DE61.60005@domain.hid>
Date: Sat, 28 Nov 2009 09:25:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B104F96.5090200@domain.hid>
In-Reply-To: <4B104F96.5090200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDBE9399237D2143BC32F7051"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Bug in rt_task_sleep() ?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?ISO-8859-1?Q?Michael_L=F6ffler?= <ml+xenomai@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDBE9399237D2143BC32F7051
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael L=F6ffler wrote:
> Hello List!
>=20
> I have an application running rt_task_sleep() in a loop. After a more o=
r
> less random number of loops, something up to 5000 cycles, the system
> reboots with the following error message:
>=20
> Kernel panic - not syncing:
> BUG!
> <4>BUG: failure at kernel/ipipe/core.c:319/__ipipe_restore_root()!
>=20
> For me it's not a bigger issue, as I can replace it with usleep() and

usleep means that your RT task leaves real-time space for the execution
of this Linux service. So you effectively avoid the permanent switch
between primary and secondary mode that your demo currently triggers due
to rt_task_sleep vs. printf.

> everything works fine, but maybe it's something, someone could have a
> closer look at. On my system (blackfin537-stamp, uclinux2008, xenomai
> 2.4.0) it can be reproduced with the following code:

Already tried with a non-outdated Xenomai release, namely 2.4.10 or 2.5
git? It makes no sense hunting already fixed bugs.

Jan


--------------enigDBE9399237D2143BC32F7051
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAksQ3mcACgkQitSsb3rl5xRWzwCgw4eTyhd+wI7oju/2gEdaorJL
oSsAoOuBqUCa8pP0XiC1LO96PUCsV8i/
=j0lJ
-----END PGP SIGNATURE-----

--------------enigDBE9399237D2143BC32F7051--

