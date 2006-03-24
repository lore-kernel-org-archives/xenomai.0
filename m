Message-ID: <44242B28.9020807@domain.hid>
Date: Fri, 24 Mar 2006 18:23:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: read data from serial device
References: <dvrrgc$g2a$1@domain.hid> <4423E7CE.3000105@domain.hid>
	<e0192l$re8$1@domain.hid>
In-Reply-To: <e0192l$re8$1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCF2F1BE4E8FBDCD7E2273B5B"
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
To: Marco Jackel <ich@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF2F1BE4E8FBDCD7E2273B5B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marco Jackel wrote:
> Hi Jan,
>=20
> Jan Kiszka wrote:
>  > Which Xenomai version, which xeno_16550A version (/proc/xenomai/rtdm=
/)?
>> I think we have fixed such an issue some time back, and this should at=

>> least made it into Xenomai 2.1. Please confirm that it's an issue
>> persisting with xeno_16550A version 1.2.6.
> Ok, my fault: it's xenomai-2.1-rc3 and xeno_16550A-1.2.5
> I look if there is a new version before I post the next time...

Hmm, there were changes between 1.2.5 and .6, but no fix that should
relate to your crash.

If you happen to reproduce it somehow, please post the program and
describe the precise setup (used port settings on both sides e.g.).

Jan


--------------enigCF2F1BE4E8FBDCD7E2273B5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJCspniDOoMHTA+kRAvooAJ94jsD4rKp9o/nOy+diJvVdT21XqQCcDSXJ
JTLFJo3YLeMS72u/AOh79hc=
=jpwW
-----END PGP SIGNATURE-----

--------------enigCF2F1BE4E8FBDCD7E2273B5B--

