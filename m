Message-ID: <4940CF82.2070709@domain.hid>
Date: Thu, 11 Dec 2008 09:29:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200812090832.43063.roberto.bucher@domain.hid>
	<493E20BE.4070600@domain.hid>
	<200812091044.41645.roberto.bucher@domain.hid>
In-Reply-To: <200812091044.41645.roberto.bucher@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigACC748BA2F643AC2C0F7ECB4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] Problems with last adeos patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Roberto Bucher <roberto.bucher@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigACC748BA2F643AC2C0F7ECB4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roberto Bucher wrote:
> Attached you can find my config. Basically, this is the same config the=
 works=20
> with version 2.6.24.7 (the only differencies are given by the new CONFI=
G_XXX of=20
> the new linux version).
>=20
> I have a nvidia card and I use the commercial NVIDIA driver 177.80 unde=
r X in=20
> Ubuntu 8.10.

Thanks for the .config, will see if it triggers anything strange as well
(ideally in kvm...), though I don't have nvidia nor its binary drivers
around.

Still some questions remain: Have you seen the problem without the
nvidia driver, too? And is there a chance to capture the kernel console
via serial or netconsole? Seeing an oops would help a lot.

Jan

PS: Please keep the list in CC.


--------------enigACC748BA2F643AC2C0F7ECB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklAz4IACgkQniDOoMHTA+n83wCfeCzx+Z7+FEg8OphdwK14KF5R
eTEAn3/7GM/djgG/hEeanI38HrwNueTF
=PQgT
-----END PGP SIGNATURE-----

--------------enigACC748BA2F643AC2C0F7ECB4--

