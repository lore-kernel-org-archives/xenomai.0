Message-ID: <4960BD85.6040703@domain.hid>
Date: Sun, 04 Jan 2009 14:45:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200808312323.29665.berlemont.hauw@domain.hid>	<48BCF4D9.8030100@domain.hid>
	<200812310119.48242.berlemont.hauw@domain.hid>
In-Reply-To: <200812310119.48242.berlemont.hauw@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC46804BA38B489C68A912AD9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 0/2] RTDM in user mode
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC46804BA38B489C68A912AD9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Alexis,

Alexis Berlemont wrote:
> Hi,
>=20
> Il already tried to send this mail to xenomai-core; I have been waiting=
 for it=20
> for the past 24 hours. So I tried again with a few changes. Sorry for t=
he=20
> noise.
>=20
> Here are three patches which provide the whole RTDM API to user-land. T=
hanks=20
> to these features, driver code can be executed by common user processes=
=2E
>=20
>  - As Jan suggested, this first version is a "single process" driver, i=
t can=20
> only be used (many times) by one process as it runs as library within t=
he=20
> context of the user process. The multiple user space contexts implement=
ation=20
> will follow (if you consider it as interesting).
>=20
> - The Linux framework for common Linux services (lists, ioremap(), etc.=
 at=20
> least) is not available yet. It will follow.
>=20
> - The RTDM API has not changed... (except the IRQ and NRT sig handlers =

> functions headers...).
>=20
> - The code has been tested thanks to the examples (available in=20
> examples/rtdm/user-api / patch n=B02).
>=20
> Do you find such patches interesting for inclusion ?

Very nice stuff! And obviously already fairly complete even in details,
which is impressing for the first run.

I already created some local branch with your patches and compiled them.
Only minor issues visible: please check for pointer<->int conversion
warnings on 64-bit - and please add spaces after if, while, for etc. :).
I will look into this in more details soon.

Did you already tried to build or even run some existing single-user
driver against your extension? I'm thinking of the 16550A e.g. (it even
has a test case). Also the irqbench driver could be a candidate. Is
there some standard how-to-convert/build procedure?

Jan


--------------enigC46804BA38B489C68A912AD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklgvYkACgkQniDOoMHTA+lqMQCeK+VArKi/y5ZyqrHc6M9QIFH9
E30AnRCZfCQxf1E8/1o7MN2kof/dP8aT
=6uqX
-----END PGP SIGNATURE-----

--------------enigC46804BA38B489C68A912AD9--

