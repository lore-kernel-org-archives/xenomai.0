Message-ID: <45758AF3.6010907@domain.hid>
Date: Tue, 05 Dec 2006 16:06:27 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Crash using userspace interrupts
References: <200612051557.44787.s.zimmermann@domain.hid>
In-Reply-To: <200612051557.44787.s.zimmermann@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig93F162E299C095A672078E93"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig93F162E299C095A672078E93
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Hello List,
> I am facing a crashing kernel when I use some rt_interupt_xxx funtions =
in my application.
>=20
> System: Dualcore AMD with Debian 3.1, kernel 2.7.17.14 with Xenomai SVN=
 rev 1920.=20
>=20
> Kernel crashes, leaving the following last words in syslog, the system =
keeps responding,=20
> but I am unable to restart my application.
>=20
> <syslog>
> I-pipe: Domain Xenomai registered.
> Dec  5 15:24:07 localhost kernel: Xenomai: hal/x86 started.
> Dec  5 15:24:07 localhost kernel: Xenomai: real-time nucleus v2.3-rc1 (=
Baroque) loaded.

#1920 implies -rc2. Something is probably inconsistent in your build.

Jan


--------------enig93F162E299C095A672078E93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdYrzncNeS9Q0k+IRAgP0AKClx1zQGFAddep8Ru7UGpVcxwUc5ACgp3tY
hOXcfCkhH17PP1yhKcPFtPM=
=ulJC
-----END PGP SIGNATURE-----

--------------enig93F162E299C095A672078E93--

