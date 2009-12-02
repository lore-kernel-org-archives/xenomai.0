Message-ID: <4B1627DC.30300@domain.hid>
Date: Wed, 02 Dec 2009 09:39:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B15AFC0.6020805@domain.hid>
In-Reply-To: <4B15AFC0.6020805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC257F0A999FEF9B8A74A2F1C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [pull request] Signals support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC257F0A999FEF9B8A74A2F1C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> here come the pull request for user-space signals support. The simple=20
> solution; handling signals upon system call return, has been implemente=
d
> since the other solution (handling signals upon any return to=20
> user-space) required to change the I-pipe patch, and so made the=20
> upcoming 2.5 only compatible with newer patches.
>=20
> We pass to kernel-space a sixth argument which is a pointer where=20
> information about received signals is stored by kernel.
>=20
> The only architecture for which the implementation is peculiar is=20
> x86_32, because the register used as sixth argument is ebp, also used=20
> for the libc backtrace function implementation, so I tried to find a=20
> solution which makes backtracing still possible (otherwise we would hav=
e
> said bye-bye to involuntary mode changes chasing with SIGXCPU) without =

> breaking too many things.

I'm still digging through the code. A few minor remarks regarding the
user space side so far:

XENOMAI_DO_SYSCALL becomes quite "bloated" now, and it's inlined. Did
you check that the fast path (ie. no signal) only contains one
conditional branch when the compiler is done with optimizing? If not (I
suspect so), the code should be refactored to look more like

restart:
	do_syscall
	if unlikely(sigs.nsigs)
		res =3D handle_signals
		if res =3D=3D -ERESTART
			goto restart

Moreover, the inner while loop over sigs.remaining should be moved into
a shared function as well. I don't see why it should be instantiated at
each and every syscall invocation site.

Am I right, there is no skin (except the test skin) using this feature
so far?

Jan


--------------enigC257F0A999FEF9B8A74A2F1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAksWJ+IACgkQitSsb3rl5xRWUwCfeyPQg69RVzxDkVMKlUMZfvf7
HSIAnjYJ+tnTBucKR3E+Dn/j94yiHJbO
=OxJV
-----END PGP SIGNATURE-----

--------------enigC257F0A999FEF9B8A74A2F1C--

