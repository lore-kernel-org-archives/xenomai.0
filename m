Message-ID: <4BEBC119.4070408@domain.hid>
Date: Thu, 13 May 2010 11:06:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BEB0A05.5020006@domain.hid> <4BEB0EF2.7020604@domain.hid>
	<4BEB1C06.7030907@domain.hid> <4BEBB838.2080407@domain.hid>
In-Reply-To: <4BEBB838.2080407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1E024B8FC3B7D78D5FB92A47"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] native kernel task example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramoncostacastello@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E024B8FC3B7D78D5FB92A47
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ramon wrote:
> Hi,
>=20
> I have a system developed (teaching and research purposes) developed in=

> RTLinuxfree and currently I'm trying to migrate
> this system to Xenomai (several task periodical task with period of
> 100us (one at 50us)).
> As a first step I would like to run them at kernel level to preserve
> performance (hard realtime),

Unless your system is already running on its limits with this 20 KHz
job, kernel vs. user space won't make the big difference. Check the
results of the latency test while loading the system with I/O and memory
cache stress to get a first impression.

> latter I will try to migrate
> user space.

Specifically while trying to stabilize the port, you will quickly love
the robustness of user space: if something crashes or hangs, just attach
gdb - but don't forget to enable the Xenomai watchdog in order to catch
runaway tasks.

>=20
> This task contains low level  commands (out, in commands to access AD/D=
A
> card registers)

iopl(3) will grant your root user space process in/out privileges. Not
nice, but probably easier as a first step than porting over the Analogy
framework.

Jan

PS: Specifically for educational purposes, it is a bad idea to continue
spreading the legacy concept of kernel-based RT applications.


--------------enig1E024B8FC3B7D78D5FB92A47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvrwRwACgkQitSsb3rl5xS8vACeMjGPoYDxFQh81cPfTYQ6cXXE
mo8AnR8lBgoemx/G9G5IPEiEkTduPpPf
=vBKb
-----END PGP SIGNATURE-----

--------------enig1E024B8FC3B7D78D5FB92A47--

