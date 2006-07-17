From: Danilo Levantesi <vagninu@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on PXA
Date: Tue, 18 Jul 2006 00:33:30 +0200
References: <200607071703.10700.vagninu@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
In-Reply-To: <17595.47131.142881.132531@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12544523.PusPUTKiic";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607180033.39079.vagninu@domain.hid>
Reply-To: vagninu@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--nextPart12544523.PusPUTKiic
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Starting from Detlef patch, I made some tests on an SA1100 based ARM,
> attached is a patch that works for me, which I also adapted to PXA
> without testing it. It would be nice if someone could test it on PXA.
>
> In order to do these tests, I had to adapt the ARM ipipe 2.6.15 patch to
> linux 2.6.16, so the 2.6.16 ipipe patch is attached too for further
> testing. Note that I had to make a small modification in
> include/asm-arm/system.h, because the SA1100 version of __xchg uses
> local_irq_restore, which use PSR_I_BIT, which is defined elsewhere, so I
> replaced PSR_I_BIT with its value. I now wonder if it is the proper fix,
> or if __xchg should be fixed to use local_irq_save_hw and
> local_irq_restore_hw instead, as is the case for the atomic operations
> defined in atomic.h and bitops.h.
I'm sorry, but probably i can't test it, because i need an handelds.org=20
patched kernel to load linux into my ipaq (i need the mmc driver), and the=
=20
latest stable version is 2.4.19-rmk6-pxa1-hh41... No official support for=20
2.6 :'(=20
BTW, if i can find a working 2.6.16 kernel i'll give it a try!

Danilo Levantesi

--nextPart12544523.PusPUTKiic
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEvBBDQbvwSSpGUgQRAhGfAKCX33JvfQHQaBNZOfnU8RF1oANiWACg5sJF
AoWss97u+pKoM8oQatN0NZ8=
=OF39
-----END PGP SIGNATURE-----

--nextPart12544523.PusPUTKiic--

