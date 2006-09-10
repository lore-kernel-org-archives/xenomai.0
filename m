Date: Mon, 11 Sep 2006 00:58:45 +0200
From: Bernhard Walle <bernhard.walle@domain.hid>
Subject: Re: [Xenomai-help] Another newbie problem
Message-ID: <20060910225845.GC12735@domain.hid>
References: <200609110032.53059.nicola17@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <200609110032.53059.nicola17@domain.hid>
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


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

* Nicola Pezzotti <nicola17@domain.hid> [2006-09-11 00:32]:
> Here I'm with another newbie question...
>=20
> Finally I have installed Xenomai 2.2 and all seems right.=20
>=20
> all testsuite go well but when I try to launch a demos I have the followi=
ng=20
> errors:
>=20
> "./latency: error while loading shared libraries: libnative.so.0: cannot =
open=20
> shared object file: No such file or directory"
>=20
>=20
> I also try to resolve with this command:
>=20
> "export LD_LIBRARY_PATH=3D/usr/xenomai/lib/:$LD_LIBRARY_PATH"

This works only for programs that are not running as root. Add the
patch /usr/xenomai/lib to /etc/ld.so.conf and run ldconfig.

       Bernhard
--=20
"Feature freeze means, that everyone has a bad feeling when he changes
something, almost nothing more :)"=20
        -- Stephan Kulow

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBRQSYnuiVHo+2lFT9AQLPqQP+NOnm8iSqE/cPY4D7/kmStoPLUNPWaHPs
7D7q589IFODZCX9Zij2Kwj8AK/GzTCXUibNOOhq4xcaQXamfL3xF8UVLjjZzGUtX
1blZlzm/mO5JkC67irWYblWRbgO1OFZQd4O5IxPp3dW/yhvGWCUMF9Aw3DO1C2cq
PebMzvIHwjc=
=Jdsn
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

