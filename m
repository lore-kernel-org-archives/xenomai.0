Message-ID: <45E35261.8000505@domain.hid>
Date: Mon, 26 Feb 2007 22:34:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] newby question, can/socket stuff
References: <bc4264770702261108l6b3f60b2w53e9e90e40d79b92@domain.hid>	
	<45E33BA0.6080903@domain.hid>	
	<bc4264770702261206v1e3d84cbhe94b923540dbaae6@domain.hid>	
	<45E34014.6080105@domain.hid>
	<bc4264770702261237v2cdd380ag128ed0cfb703b281@domain.hid>
In-Reply-To: <bc4264770702261237v2cdd380ag128ed0cfb703b281@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig351338BACF74CD1C8CCE4365"
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig351338BACF74CD1C8CCE4365
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
>> Add 1 to 1: The CAN profile describes what IOCTLs are available for CA=
N
>> sockets. rt_dev_ioctl() (or ioctl() with the POSIX skin) is the way to=

>> pass these IOCTLs down to the CAN stack.
>=20
> Actually this sheds quite a bit of light on matters. If you would be
> so kind as to give a brief explanation of what a "stack" is exactly. I
> have been confronted with the term quite a lot now but its not
> becoming clearer. I used to think it was a buffer of some kind. Kind
> of like the ones that one "pushes" and "pops" on but I can't see a
> connection between that concept and what you say above.

http://en.wikipedia.org/wiki/Protocol_stack? :->

Jan


--------------enig351338BACF74CD1C8CCE4365
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF41JhniDOoMHTA+kRAkCEAJ9XN/5+0OyZmkaKna2mzu4mIIWX9wCfYTYC
CQAq1f+cCsyiidwSyTJlr/w=
=Ya9K
-----END PGP SIGNATURE-----

--------------enig351338BACF74CD1C8CCE4365--

