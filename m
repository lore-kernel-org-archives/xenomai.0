Message-ID: <44FD8E86.2050607@domain.hid>
Date: Tue, 05 Sep 2006 16:49:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20060905143639.53778.qmail@domain.hid>
In-Reply-To: <20060905143639.53778.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6E75BDC24861C86B2779A79F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: RTAI Vs Xenomai performance
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: somshekar kadam <som_kadam@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E75BDC24861C86B2779A79F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Neelu,

please start a new thread when switching the topic, don't reply to
existing ones (CC'ing people who may not want this).

somshekar kadam wrote:
> HI Jan,
>=20
> I am runnng the testsuite given by RTAI and Xenomai,
>=20
> I need to this figures to compare on performance for
> the doc to port XENOMAI on MIPS.
>=20
> I see RTAI gives results in nanoseconds and XENOMAI in
> microsecond, so i should say latency with Xenomai is
> 3000 micrsecond where as RTAI its 3000 Nanosecond ,
> correct me if I am wrong.=20

RTAI is in nanoseconds as Xenomai used to be in early days, but its
results are as broken as Xenomai's (watch out for the maximum!).

> I have attached both testsuite reults=20

You likely have a SMI problem, see TROUBLESHOOTING for details.

This makes me wonder if some simple test ("dmesg | grep
CONFIG_XENO_HW_SMI_WORKAROUND") in latency or at least in xeno_test to
detect this may make this FAQ less frequent... :)

Jan


--------------enig6E75BDC24861C86B2779A79F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/Y6HniDOoMHTA+kRAsfVAJ0WZ3pS7Dw4eIPAB17AmbMLIb4Q6QCePpKy
ZWgEuaCytat5AKCSv7GEOEo=
=Ebvn
-----END PGP SIGNATURE-----

--------------enig6E75BDC24861C86B2779A79F--

