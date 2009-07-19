Message-ID: <4A62D396.3090006@domain.hid>
Date: Sun, 19 Jul 2009 10:04:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1247750127.306081.22356.nullmailer@domain.hid>		<1247754601.4228.73.camel@domain.hid>		<1247829470.829653.30773.nullmailer@domain.hid>		<1247832340.4228.132.camel@domain.hid>		<1247837534.904271.19070.nullmailer@domain.hid>	<1247838733.4228.139.camel@domain.hid>	<1247845909.586479.22758.nullmailer@domain.hid>
	<4A618239.90506@domain.hid> <4A61A4BE.5070308@domain.hid>
	<4A61C690.3030306@domain.hid> <4A61C7B6.2080704@domain.hid>
	<4A61CEAF.6060902@domain.hid> <4A61D0C1.30607@domain.hid>
In-Reply-To: <4A61D0C1.30607@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig41F631EDE2C7088A177ED516"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rt_task_shadow returns always -EFAULT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41F631EDE2C7088A177ED516
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> What was the precise brokenness you saw? Also a missing syscall
>> argument initialization? Can you easily reproduce the ARM issue?
>> Would be
>=20
> It is here:
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D38815
>=20
> The arm syscalls contain a workaround, I copy the values to some
> temporary variables, but I can not make it work with the bugzilla sampl=
e
> (though I am almost sure I tested it when I did it, I may have changed
> toolchain version in the mean time).
>=20
>=20
>> interesting to know if '+r' makes a difference there, too.
>=20
> I tested it after you mention it, and no, it makes no difference.
>=20

Meanwhile I also had troubles with the "+r" approach and even more
aspects of the Xen way. But I found a different workaround, see the pull
request.

Also note that even removing all TLS references from rt_task_shadow made
no difference for me. So this was really a different kind of bug than
what you saw on ARM.

Jan


--------------enig41F631EDE2C7088A177ED516
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpi05YACgkQniDOoMHTA+n+mACeIEkVr6LZlKk2oKoWnbWNII/q
EUoAmwfF+UMffO09Er2cPy019LxHacZv
=BCWM
-----END PGP SIGNATURE-----

--------------enig41F631EDE2C7088A177ED516--

