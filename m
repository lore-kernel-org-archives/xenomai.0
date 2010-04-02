Message-ID: <4BB5C1D5.8030804@domain.hid>
Date: Fri, 02 Apr 2010 12:07:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>	
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>	
	<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>	
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>	
	<4BB5B874.5090904@domain.hid>	
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>	
	<4BB5BA2D.1080604@domain.hid>
	<k2rb88603c31004020243k8d9681f8y453b25393bb5d3a0@domain.hid>
In-Reply-To: <k2rb88603c31004020243k8d9681f8y453b25393bb5d3a0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5A7487FBC766689F7E6FAD66"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A7487FBC766689F7E6FAD66
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Henri Roosen wrote:
> Actually that is what I thought in the first place, however Jan's
> comment "That's not true, Xenomai threads can run in non-RT scheduling
> classes as well. They may just gain RT priority while holding some
> lock that is requested by a RT thread as well." made me think I was
> wrong...
>=20
> So we would really need a SCHED_IDLE for Xenomai then to solve this pro=
blem?

I don't think so. But we do need to solve the issue that a non-RT thread
stays too long in primary mode and is thus scheduled by Xenomai with the
wrong priority /wrt other Linux task at its level.

For the time being, you can work around this by issuing a Linux syscall
before entering long processing loops - unless your task doesn't do this
anyway, e.g. to perform some Linux I/O.

Jan


--------------enig5A7487FBC766689F7E6FAD66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1wdUACgkQitSsb3rl5xSqPQCg5g8yl/sp88Br+Qrrseu89lRC
3jYAoLzrHA/0cBnpk1zXRzImX8429VFT
=/M8+
-----END PGP SIGNATURE-----

--------------enig5A7487FBC766689F7E6FAD66--

