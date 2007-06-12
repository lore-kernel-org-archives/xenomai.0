Message-ID: <466ED96E.4050806@domain.hid>
Date: Tue, 12 Jun 2007 19:35:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <30228710.1181630552942.JavaMail.ngmail@domain.hid>
	<1181630207.7354.20.camel@domain.hid>
In-Reply-To: <1181630207.7354.20.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig39688894D9BA3AC8A272146A"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] CONFIG_SMP in switchtest (was: Xenomai configure
	--enable-smp...)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39688894D9BA3AC8A272146A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2007-06-12 at 08:42 +0200, M. Koehrer wrote:
>> Hi everybody,
>>
>> I want to know why the --enable-smp option for "configure" of Xenomai =
is used when there
>> is already the corresponding option selected with the kernel configura=
tion?
>=20
> --enable-smp is only used when you want the user-space side to _require=
_
> SMP support to be present into the running kernel; i.e. for some (weird=
)
> reason, your application really needs this. Xenomai libraries don't car=
e
> whether SMP support is enabled or not, they are not sensitive to that
> issue (see the "weak" status of this option in README.INSTALL)

Switchtest bases some compile-time decisions on CONFIG_SMP. Nitpicking,
OK, but I wonder if this is required. Gilles?

Jan


--------------enig39688894D9BA3AC8A272146A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGbtluniDOoMHTA+kRAtwmAJ4o8r6wtTI44wj73+/qbEkBH4uiGgCfX2Wu
z1B5TqerRAGjp3c+am1mrrc=
=aatK
-----END PGP SIGNATURE-----

--------------enig39688894D9BA3AC8A272146A--

