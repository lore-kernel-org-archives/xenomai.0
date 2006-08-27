Date: Sun, 27 Aug 2006 14:24:49 +0200
From: Bernhard Walle <Bernhard.Walle@domain.hid>
Subject: Re: [Xenomai-help] Timer problems?
Message-ID: <20060827122449.GC4340@domain.hid>
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid> <44EF37BE.70207@domain.hid>
	<44F0B06B.6050102@domain.hid> <44F17616.9080701@domain.hid>
	<1156680494.4325.68.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <1156680494.4325.68.camel@domain.hid>
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


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Philippe,

* Philippe Gerum <rpm@xenomai.org> [2006-08-27 14:08]:
> With Linux 2.4, the sound generator is reached through a callback
> pointer, so Xenomai just routes the latter to a dummy routine, and we
> are done. With Linux 2.6, the callback has disappeared from the vanilla
> kernel, and sound event requests are sent to the input sub-system for
> processing, where we have currently no hack to void them. This is the
> reason why disabling CONFIG_VT entirely is recommended when there is a
> risk of conflict (which is rather drastic, I agree).

Why not patching the kernel at this point? Xenomai requires a kernel
patch anyway.


Regards,=20
  Bernhard

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBRPGPDOiVHo+2lFT9AQJQJAP/VKM5eMXFB5oPsgRrstT46ffdp8aey+Y8
HnJ5RMzvNeR0tx4F9Yftyv6ylhNvUdMhVV1f3ZrCF2awyqP/8zRLQxFsMj4xTCkJ
UjOPNMo32dfnus2jeyFdUNEy1wtjM23mO2F/KSPlAhEg/O0eCMCtHL3ztwHQbslB
AAqMsQfLw9g=
=6O0q
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--

