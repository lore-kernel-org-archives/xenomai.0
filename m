Message-ID: <45D5E5C3.7030508@domain.hid>
Date: Fri, 16 Feb 2007 18:11:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] fata: removing non-linked element...
References: <45CC651C.6060402@domain.hid>
	<45CC68F3.1000003@domain.hid>		<45D1C033.9010002@domain.hid>
	<45D1C61B.7030503@domain.hid>		<1171376742.885.3.camel@domain.hid>
	<45D1CAFA.6050408@domain.hid>		<1171385716.885.17.camel@domain.hid>
	<45D200C3.1030001@domain.hid>	<1171393088.885.37.camel@domain.hid>
	<45D59F98.8020006@domain.hid>
In-Reply-To: <45D59F98.8020006@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1403B58DEA1AE6DBA3488E8C"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1403B58DEA1AE6DBA3488E8C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Hi again,
> we did some testing with the different verions you told us on some
> different Systems. I will try to sum up what we experienced.
>=20
> Testsystems:
> --------------------------------------------
> SMP1 - AMDx2 with Kernel 2.6.19
> SMP2 - AMDx2 with Kernel 2.6.17
> PM1 - Celeron M with Kernel 2.6.17 (ETX Industrial Board)
> PM2 - Pentium M with Kernel 2.6.17 (Notebook)
>=20
> Testet revisions where 2077, 2092, 2108, 2184
>=20
> The test was running and terminating our application continuously,
> reloading xenomai modules between each start.
>=20
> Results:
> --------------------------------------------
> SMP1:
> The application runs as intended. While rebooting the system the kernel=

> showed some backtraces according to bad paages. Revision 2184 leads to =
a
> complete crashed  System like I described in the original mail (2187 on=

> Kernel 2.6.20 does that too). It is possible to work around this crash
> by disabling priority coupling (activating the option in kernel config)=
=2E

I-pipe version? 1.7-00/01 was fragile for me too, 1.7-02 looks fine so
far. This could be one bug, anything on 2.6.17 must be something else.

Jan


--------------enig1403B58DEA1AE6DBA3488E8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1eXDniDOoMHTA+kRAqffAJ4uAUZOHrqexnp12CKbrgi628fPTQCdEC0R
Rq8mUD3p3xiVyi0uR+BLP6s=
=lxqZ
-----END PGP SIGNATURE-----

--------------enig1403B58DEA1AE6DBA3488E8C--

