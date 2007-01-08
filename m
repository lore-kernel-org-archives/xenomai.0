Date: Mon, 8 Jan 2007 17:22:16 +0100
From: Kai Timmer <email@domain.hid>
Message-ID: <20070108162216.GD23411@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
Subject: [Xenomai-help] xenomai on blackfin/uclinux does not compile
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
it tried to compile xenomai 2.3.0 with the uClinux 2006R1 RC2 Release
for a Blackfin (BF537). The kernel patch i used was the=20
adeos-ipipe-R06R1RC2-bf53x-1.4-03.patch file. It applied fine to the
source tree.
But now if i=B4going to compile the uClinux distribution i always get this
error:

/------------------------------------------------------------------------
kernel/built-in.o: In function `xntimer_do_tick_aperiodic':
kernel/xenomai/nucleus/timer.c:(.text+0x24244): undefined reference to
`bfin_write_TCOUNT'
kernel/xenomai/nucleus/timer.c:(.text+0x2424c): undefined reference to
`bfin_write_TCNTL'
kernel/built-in.o: In function `xntimer_do_start_aperiodic':
kernel/xenomai/nucleus/timer.c:(.text+0x24a42): undefined reference to
`bfin_write_TCOUNT'
kernel/xenomai/nucleus/timer.c:(.text+0x24a4a): undefined reference to
`bfin_write_TCNTL'
kernel/built-in.o: In function `xntimer_do_stop_aperiodic':
kernel/xenomai/nucleus/timer.c:(.text+0x24dde): undefined reference to
`bfin_write_TCOUNT'
kernel/xenomai/nucleus/timer.c:(.text+0x24de6): undefined reference to
`bfin_write_TCNTL'
arch/blackfin/xenomai/built-in.o: In function `rthal_timer_release':
(.text+0x2b4): undefined reference to `bfin_write_TCNTL'
arch/blackfin/xenomai/built-in.o: In function `rthal_timer_request':
(.text+0x2ee): undefined reference to `bfin_write_TCNTL'
arch/blackfin/xenomai/built-in.o: In function `rthal_timer_request':
(.text+0x2f6): undefined reference to `bfin_write_TSCALE'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory
`/home/kai/workspace/studium/praktika/dspschool/uClinux-dist/linux-2.6.x'
make: *** [linux] Error 1
/------------------------------------------------------------------------

I also tried to apply the xenomai patches to uClinux 2006R2 RC2. But
all of the included patchfiles failed to apply.

I would be very pleased if someone can tell me whats going wrong.

Greets,
--=20
Kai Timmer             | Jabber-ID: kait@domain.hid
PGP-Key ID: 0x8295374E | Blog: http://www.kaitimmer.de
------------------------------------------------------
   http://chemnitzer.linux-tage.de (3.-4. M=E4rz 2007)


--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFom+4/PH6zoKVN04RAlyQAJ46Ycniw2g1vnttWoVDYXHiLUMgSQCgsjca
V+QTOlmPpDfPt4fNOhzKE34=
=9qW2
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--

