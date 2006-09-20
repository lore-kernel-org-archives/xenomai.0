Message-ID: <451117A1.50500@domain.hid>
Date: Wed, 20 Sep 2006 12:27:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: Fw: [Fwd: Re: [Xenomai-help] invalid use of FPU in Xenomai
	context]
References: <450B2BE1.1050105@domain.hid> <20060916042719.M57867@domain.hid>
In-Reply-To: <20060916042719.M57867@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9FE13032D0BAA12B3EA1987F"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9FE13032D0BAA12B3EA1987F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> ...
> /* Real-time task */
> void * fptest_routine (void *cookie)
> { =20
>   struct timespec dt_ts;
>=20
>   int i;
>   char c[6000];

[Those are the days when you wonder why you don't look at the code
*first* and *then* decide to fire up a debugger. Well, at least the
debugger is now debugged too...]

As this disassembly from fptest_routine popped up in ddd

0xd08a511c:     sub    $0x1780,%esp

I wondered why the stack pointer is moved that much. It's because of
that char array above! You have to keep in mind that kernel pthreads
come with 1k stack by default. Increase it if you need more.

After pushing the array into global scope (and with the FPU fix applied)
your test works fine here over trunk.

Jan


--------------enig9FE13032D0BAA12B3EA1987F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFERehniDOoMHTA+kRAmbJAJ9jaPfN4QLYMDRMYoJu8mYb1KDrdACfbQHJ
+yziG6FJU9T7G6qkwC4EOgM=
=8TuV
-----END PGP SIGNATURE-----

--------------enig9FE13032D0BAA12B3EA1987F--

