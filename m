Message-ID: <45D192EB.9030608@domain.hid>
Date: Tue, 13 Feb 2007 11:28:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Make error
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>	
	<45D029B8.1030805@domain.hid>	
	<e45fe62b0702120448i7b23bd24o4fa88a05237a69a@domain.hid>	
	<45D0666C.8070409@domain.hid>	
	<e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>	
	<45D171F9.7000705@domain.hid>
	<e45fe62b0702130021i5ec6c345m699a9abcc2e665c0@domain.hid>
In-Reply-To: <e45fe62b0702130021i5ec6c345m699a9abcc2e665c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig08093884CC5E949F2A77F2CF"
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
To: Preetam Joshi <j.preetam@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig08093884CC5E949F2A77F2CF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Preetam Joshi wrote:
> I have taken the makefile from
>=20
> Using the one under test suite /xenomai/src/testsuite/switchbench/
>=20
> n modified for mytask jus replaced all the witchbench related statement=
s
> with mytask
>=20
> It works for switchbench or latency or switchsuite but not for my examp=
le.

Unless you are planning to write an extension of the Xenomai user space
part, you don't need to make your life that hard. Just follow my
suggestions and use the makefiles from the examples repos.

Jan

PS: The CC, take care of it...


--------------enig08093884CC5E949F2A77F2CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0ZLwniDOoMHTA+kRAsLsAJ9AHfPLsGtkxJkMIdOQCljq9aK11wCfetRk
lNmJVlyNoeDDUiWfjiKRFKA=
=KwT6
-----END PGP SIGNATURE-----

--------------enig08093884CC5E949F2A77F2CF--

