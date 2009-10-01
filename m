Message-ID: <4AC4561B.5070004@domain.hid>
Date: Thu, 01 Oct 2009 09:11:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AC1BCF9.8050908@domain.hid>
In-Reply-To: <4AC1BCF9.8050908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig607AE67EBE560F16277E8898"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [bug] accept() in non-blocking mode fails with
 EPERM instead of EAGAIN
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Matthieu Nottale <nottale@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig607AE67EBE560F16277E8898
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Matthieu Nottale wrote:
> Hi,
>=20
> I believe I found a bug in the Xenomai Posix skin while trying to use
> boost::asio: The accept() call in asychronous mode
> fails with ENOPEM instead of EAGAIN. Other than that, the call 'works'
> in the sense that calling it again after a connection is established
> returns a new file descriptor.

On what kind of file descriptor descriping what kind of socket are you
calling accept()? So far I'm not aware of any RTDM driver providing the
corresponding service - well, at least not a public one (our RT-TCP
stack is yet to be released). Or is it intended to pass the call to
plain Linux, switching the caller into secondary more?

Jan

>=20
> I'm running xenomai rev 50ee47db78117e8711d4d2f5310dff262a425eb7 with
> kernel 2.6.31 i686.
>=20
> Xenomai is built with no option (other than --enable-shared
> --disable-static) to configure.
>=20
> I'm joining a simple C file to reproduce the problem.
>=20
> Its output when built 'natively', and running "nc localhost 12345" afte=
r
> some time is:
>=20
> -1 11
> accept: Resource temporarily unavailable
> -1 11
> accept: Resource temporarily unavailable
> <...>
> OK 4
>=20
> Its output when built using the posix skin and run as root is:
> -1 1
> accept: Operation not permitted
> -1 1
> accept: Operation not permitted
> <...>
> OK 4
>=20
> The consequence of this bug is that all applications doing asynchronous=

> accept() calls will fail to work, as they will incorrectly believe the
> operation failed.
>=20
>=20
> Regards,
>=20
>    Matthieu
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core



--------------enig607AE67EBE560F16277E8898
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrEVhsACgkQitSsb3rl5xRcoACgyKDz/P+NSdDWdalvfKT79Ey5
oT8AnA1CCMSP8ZVPllm3Hay0jmdxiZAG
=YZ5d
-----END PGP SIGNATURE-----

--------------enig607AE67EBE560F16277E8898--

