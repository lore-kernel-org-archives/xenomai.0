Message-ID: <44F5A58B.2070601@domain.hid>
Date: Wed, 30 Aug 2006 16:49:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [Fwd: Performance decrease]
References: <1156941389.4323.17.camel@domain.hid>
	<1156942089.4323.29.camel@domain.hid> <44F58E8A.3040000@domain.hid>
In-Reply-To: <44F58E8A.3040000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9C500A0E59A2BC3D41CDCD91"
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
To: rpm@xenomai.org, Daniel Schnell <danielsch@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C500A0E59A2BC3D41CDCD91
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>>>  On the other side I cannot compile RTDM support in without it; the e=
rror message when linking vmlinux
>>> at the end of the Kernel compile stage is:
>>>> =20
>>>>
>>>> drvlib.c:(.text+0x19f8): undefined reference to `__va_to_kva'
>>>>
>> I guess that rtdm_mmap_buffer() should be made dependent on
>> CONFIG_XENO_OPT_PERVASIVE too.
>=20
> True. Will craft some patch.
>=20

Should be fixed in SVN now.

Jan


--------------enig9C500A0E59A2BC3D41CDCD91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9aWLniDOoMHTA+kRApK2AJ4iLKj5xOwg3r/PzI0/NuLHD1NwkgCfe0Zp
2PrS2S0JjHGX4RFhzprd6pQ=
=esDC
-----END PGP SIGNATURE-----

--------------enig9C500A0E59A2BC3D41CDCD91--

