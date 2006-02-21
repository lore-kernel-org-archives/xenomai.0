Message-ID: <43FAEF27.2050701@domain.hid>
Date: Tue, 21 Feb 2006 11:44:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Open a RTDM device driver with standard open()
References: <43FA139D.9020906@domain.hid>
	<1140517850.7870.22.camel@domain.hid>
In-Reply-To: <1140517850.7870.22.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig11FA43C6D5D388CB89AF4EA6"
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
To: Alessio Igor Bogani <abogani@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig11FA43C6D5D388CB89AF4EA6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alessio Igor Bogani wrote:
> Hi All, Hi Jan,
>=20
> Apologize for my (very) bad english.
>=20
> I have a doubt about RTDM:
> Is it possible open a rtdm device driver with a open() standard syscall=

> (without rt_dev_open())? I already tried but open() return always -1 :-=
(
> Obviously rt_dev_open() works perfectly.

Yes and no: When using the POSIX skin standard open is mapped to RTDM
open via the RTDM syscall (but also to standard open in case RTDM does
not know the device). But there is no hook in the Linux open syscall to
redirect RTDM open requests.

Jan



--------------enig11FA43C6D5D388CB89AF4EA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD+u8nniDOoMHTA+kRAsvLAJwJvPsEWGxFzoqTQKOm3sOP2KJMgACcC5fG
23VfaQe9ZjUkxgxv+S0FUP8=
=vIN4
-----END PGP SIGNATURE-----

--------------enig11FA43C6D5D388CB89AF4EA6--

