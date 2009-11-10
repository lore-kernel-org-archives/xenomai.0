Message-ID: <4AF927F7.5020100@domain.hid>
Date: Tue, 10 Nov 2009 09:44:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200911101355.24692.anisha.kaul@domain.hid>
In-Reply-To: <200911101355.24692.anisha.kaul@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEAA33C5990FA199B237B9DC8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] difference between rt_task_spawn and
	rtdm_task_init
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anisha Kaul <anisha.kaul@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEAA33C5990FA199B237B9DC8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[ Redirected to xenomai-help - this is a support question. ]

Anisha Kaul wrote:
> Hello,
>=20
> Both "rt_task_spawn" and "rtdm_task_init" functions are said to start a=
 task=20
> in the real time, so what is the difference in their functioning ?

RTDM services are for use by drivers inside the kernel. Native services
are for _applications_, which can technically still be run in kernel
space but should practically only be designed for user space.

Jan


--------------enigEAA33C5990FA199B237B9DC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr5J/cACgkQitSsb3rl5xQX8QCgrwttfhq/0vSujWp/w6hChims
NdoAoNUNCyVIqKtF0wzRgDFkJiNMCNXi
=Kaqv
-----END PGP SIGNATURE-----

--------------enigEAA33C5990FA199B237B9DC8--

