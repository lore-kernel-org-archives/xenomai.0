Message-ID: <4512E4A3.9050303@domain.hid>
Date: Thu, 21 Sep 2006 21:14:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Native API manual in PDF format?
References: <F75B1CC921BD8E43B7D0484C9AB4C490450F83@domain.hid>
In-Reply-To: <F75B1CC921BD8E43B7D0484C9AB4C490450F83@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6ADC6170DA85BD9DCF74C642"
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
To: David Betz <david.betz@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6ADC6170DA85BD9DCF74C642
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

David Betz wrote:
> Is there a PDF version of the Native API manual available? I'd like to
> be able to print a copy for reference.

You can generate your own version: Set "GENERATE_LATEX =3D YES" in
doc/doxygen/Doxygen.in, build the documentation (don't forget to enable
it on configure), go to doc/doxygen/latex in your build directory and
run "make". The result is refman.pdf, a >500 pages monster (2.5M) that
looks rather unhandy to me. Maybe one can tune things and drop out
parts, you may want to play a bit with doxygen.

Jan


--------------enig6ADC6170DA85BD9DCF74C642
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFEuSnniDOoMHTA+kRAkT3AJ94cVc3UQ3Ohv8n6WPq6aUuLC3iNgCbBlzU
ku6UdGezqYzsFPWidvAZEMQ=
=EON5
-----END PGP SIGNATURE-----

--------------enig6ADC6170DA85BD9DCF74C642--

