Message-ID: <455D6D3B.9000009@domain.hid>
Date: Fri, 17 Nov 2006 09:05:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>	
	<455C8B8A.80105@domain.hid> <455CBC4A.5010108@domain.hid>	
	<54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>	
	<455CC9DE.6030601@domain.hid>
	<54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>
In-Reply-To: <54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF2F737BCCD681D9CB751AE49"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2F737BCCD681D9CB751AE49
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Frits de Klark wrote:
> Hi,
>=20
> to get back on my earlier question: IF the memory mapping might work fo=
r
> me,
> how should I call it?
> The PCI card has two CAN ports. Here's (a part of) the output of lspci =
-vv:
>=20
> Interrupt: pin A routed to IRQ 11
> Region 0: Memory at e1003000 (32-bit, non prefetchable) [size=3D128]
> Region 2: I/O ports at d800 [size=3D128]
> Region 3: I/O ports at dc00 [size=3D128]
> Region 4: I/O ports at e000 [size=3D4]
>=20
> What should the insmod command to try if it might work?

You could try handing region 2 or 3 to the rtcan_isa driver or region 0
to rtcan_mem. Maybe your adapter actually does 1:1 mapping of the
SJA1000 address space (it looks like). I just wonder what region 4 is
doing. Maybe it controls the content of region 0, which may either hold
the first or the second CAN controller. Just a theory...

Jan


--------------enigF2F737BCCD681D9CB751AE49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXW1AniDOoMHTA+kRAlovAJ499p6UAvq8O5HWJ+AgS0gD2M02HACeIfrQ
M8MQuoGDLiICU9rvqeId30M=
=1W1C
-----END PGP SIGNATURE-----

--------------enigF2F737BCCD681D9CB751AE49--

