Message-ID: <45C9CC87.1040106@domain.hid>
Date: Wed, 07 Feb 2007 13:56:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] availability of adeos for arm and kernel 2.6.8
References: <903DF812C6E12E48BD944B9C6DE719CD02786ED9@domain.hid>
In-Reply-To: <903DF812C6E12E48BD944B9C6DE719CD02786ED9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF4B9C1538E398E40074E188C"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Miguel Casas Sanchez <mcasas@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF4B9C1538E398E40074E188C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Miguel Casas Sanchez wrote:
> Hi all,
>=20
> I'm pretty new to this list so excuse me if my question sounds pesky :)=

>=20
> I have a arm920 and would like to set rtai 3.2, however I cannot find i=
n the CVS any ARM patch for earlier kernels than 2.6.14. Is there any pat=
ch available for my architecture and previous kernel versions? Concretely=
 I am interested in 2.6.8.1.

If you are forced to pick a) an old kernel like 2.6.8 and b) RTAI over
ARM, your are basically on your own. Current development around
Adeos/Ipipe on ARM takes place for 2.6.19, and it is used by Xenomai
(RTAI stopped working on ARM long ago).

So you should consider if saving some kernel update effort is worth the
costs of having to deal with all real-time issues without anyone being
able to help you.

Jan


--------------enigF4B9C1538E398E40074E188C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFycyHniDOoMHTA+kRAi97AJ9Pns2TXo9T2tlsToxOKQImMs2NEQCeMio2
yTitHM+Lkkc367FeaWG4AvM=
=TIF2
-----END PGP SIGNATURE-----

--------------enigF4B9C1538E398E40074E188C--

