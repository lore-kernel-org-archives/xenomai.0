Message-ID: <47F60323.2090100@domain.hid>
Date: Fri, 04 Apr 2008 12:29:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47F5FC80.3060603@domain.hid>
In-Reply-To: <47F5FC80.3060603@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCF4CE8755DD7D199A6D0C197"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] problem with trivial-periodic.c example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Thomas_H=E4berle?= <thomas.haeberle@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF4CE8755DD7D199A6D0C197
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Thomas H=E4berle wrote:
> Hello!
>=20
> I am running Xenomai 2.3.5 on my MPC5200S on a STK52xx with a Linux=20
> 2.4.25-DENX kernel (cross-compiling to the target).
>=20
> When I try to compile the "trivial-periodic.c" example with
>  >>> $ ppc_6xx-gcc SimpleTask.c -I $XENOINSTALL/include -L=20
> $XENOINSTALL/lib -o SimpleTask -Wall

-lnative

Jan


--------------enigCF4CE8755DD7D199A6D0C197
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH9gMjniDOoMHTA+kRAmgRAKCEDA/nT6cmYZcGbGJuFAlz/fCHegCfWY9e
Nwc9q6g2GypM9fBEHS8OwZk=
=AFQ3
-----END PGP SIGNATURE-----

--------------enigCF4CE8755DD7D199A6D0C197--

