Message-ID: <46D53974.3020207@domain.hid>
Date: Wed, 29 Aug 2007 11:16:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <904710.33097.qm@domain.hid>
In-Reply-To: <904710.33097.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8CA4B00648A16619A9F0659D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Re :  sqrt() function in xenomai kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8CA4B00648A16619A9F0659D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Mathieu JOINIE-MAURIN wrote:
> The application I used is a small controller for robot developped by pe=
ople in the lab. Before it used to be in RTAI. But now they are trying to=
 use Xenomai. The application is splitted in two parts:
> the user side which saves data, manages interfaces and the kernel modul=
e which realise all the real time tisk (sampling, writing to electronic c=
ard, controler).
> The communications between the two is made by 5 pipes (command, paramet=
ers, acknowledgment, save, status).
>=20
> This is why i need to make my sqrt() function (of double variables)  in=
to my kernel modul part.

Given that this is also a "small" application, I bet it will be far
easier for you to port it to user-space (POSIX or native skin) than
porting a math lib into kernel space. You could even continue to use
pipes (with Linux devices on the non-RT side) for communication to keep
the porting effort low. Hardware access can also remain part of the
application if you prefer (use iopl() & friends), though a clean
separation into generic driver and application is recommended for the
long-term.

Kernel space RT _applications_ really belong to an outdated design
pattern (due to missing libraries, GPL requirements, debuggability with
gdb, etc.). Take the chance and improve your application!

Jan


--------------enig8CA4B00648A16619A9F0659D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1Tl0niDOoMHTA+kRAoOOAJ9RTIcn+ymL3U9pL2+qkwBhU14YfACeLmyC
7D/HUe5AshAXZJGrdM9mNPw=
=+yjO
-----END PGP SIGNATURE-----

--------------enig8CA4B00648A16619A9F0659D--

