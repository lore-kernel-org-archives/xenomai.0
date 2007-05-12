Message-ID: <4645F633.8080308@domain.hid>
Date: Sat, 12 May 2007 19:15:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3f027d060705120736h73663da1v9bcf819f6c7452f9@domain.hid>
In-Reply-To: <3f027d060705120736h73663da1v9bcf819f6c7452f9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC4CA7B53893D53E9CC2650B9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Problem compiling kernel-2.6.20-11-ipipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Zany Super Chimp <zanychimp@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC4CA7B53893D53E9CC2650B9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Zany Super Chimp wrote:
> Hi !
>=20
> I just configured my kernel with the prepare-kernel script:
>=20
> sudo ./scripts/prepare-kernel.sh
> --linux=3D/usr/src/linux-2.6.20.11-ipipe--adeos=3D~/xenomai/src/ksrc
> /arch/i386/patches/adeos-ipipe-2.6.20-i386-1.8-00.patch --arch=3Di386
>=20
>=20
> When I make all, I get the following error:
>=20
>  CHK     include/linux/version.h
>  CHK     include/linux/utsrelease.h
>  CHK     include/linux/compile.h
>  AS      arch/i386/kernel/entry.o
> arch/i386/kernel/entry.S: Assembler messages:
> arch/i386/kernel/entry.S:270: Error: invalid character '_' in mnemonic
> arch/i386/kernel/entry.S:347: Error: invalid character '_' in mnemonic
> arch/i386/kernel/entry.S:477: Error: invalid character '_' in mnemonic
> arch/i386/kernel/entry.S:520: Error: invalid character '_' in mnemonic
> arch/i386/kernel/entry.S:534: Error: invalid character '_' in mnemonic
> make[1]: *** [arch/i386/kernel/entry.o] Error 1
> make: *** [arch/i386/kernel] Error 2
>=20
> I'm using gcc 4.1.2 and GNU assembler 2.17.50 on Ubuntu 7.04. Maybe it =
is
> the problem...
>=20
> Did someone already stumble over that problem ?

Please check your .config for CONFIG_PARAVIRT, that must be off (maybe
we should catch this...). If it already is, please post your .config.

Jan


--------------enigC4CA7B53893D53E9CC2650B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGRfYzniDOoMHTA+kRAuInAJ97Em1yTg7MqP0a+7tSLUknIfeVCgCfZu1q
A+fk4ef6FKNO69+p4aqKnLo=
=rAne
-----END PGP SIGNATURE-----

--------------enigC4CA7B53893D53E9CC2650B9--

