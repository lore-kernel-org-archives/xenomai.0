Message-ID: <43EB02F5.4040001@domain.hid>
Date: Thu, 09 Feb 2006 09:53:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
	<200602061900.35411.lbocseg@domain.hid>
	<43E8DB10.5000901@domain.hid>
	<200602081928.17224.lbocseg@domain.hid>
In-Reply-To: <200602081928.17224.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig99D9DE67370DF0EA2D5233FE"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig99D9DE67370DF0EA2D5233FE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> One more doubt: how would I munmap that memory? do_munmap and passing=20
> current->mm as the first parameter and the physical address as start? I=
'm not=20

Yes, but better save current->mm at mmap time and pass *this* value on
unmap. I'm thinking about a way to include this in RTDM.

> sure... Maybe the user can call munmap directly since it doesn't need t=
he=20
> file descriptor. But which address should (s)he pass to start parameter=
, the=20
> virtual or the physical one?

This is also an option. The user would have to pass the virtual address
the driver returned.

But I think we still need a cleanup on RTDM device closure to avoid
access to the mapped physical buffers after that point. I wonder how
this is done in standard drivers, will have to look at some of them.

Jan


--------------enig99D9DE67370DF0EA2D5233FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD6wL6niDOoMHTA+kRAuz+AJwKqQNPwQepq707QR1GRL4x3ex70QCfUek3
Qtfk/9pH+S51tomQ3I0jdF0=
=kWYV
-----END PGP SIGNATURE-----

--------------enig99D9DE67370DF0EA2D5233FE--

