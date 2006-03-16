Message-ID: <4419A7B0.6000003@domain.hid>
Date: Thu, 16 Mar 2006 19:00:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: POSIX include problem
References: <44195924.9090709@domain.hid>
	<17433.35726.567615.125720@domain.hid>
In-Reply-To: <17433.35726.567615.125720@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3A287E8CE63D33CB4BE8E6DB"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A287E8CE63D33CB4BE8E6DB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi Gilles,
>  >=20
>  > don't know yet what's going wrong, but the following demo code doesn=
't
>  > compile against the POSIX skin due to unresolved SIG_BLOCK:
>  >=20
>  > #include <pthread.h>
>  > #include <signal.h>
>  >=20
>  > int main()
>  > {
>  >         return SIG_BLOCK;
>  > }
>  >=20
>  > Comment out the pthread include, and it will work again. Any ideas?
>=20
> Fixed in revision 714
>=20

Yep, thanks.

I found this while trying Thomas Gleixner's cyclic test over the POSIX
skin (http://www.tglx.de/projects/misc/cyclictest). After fixing a
rather ugly bug in his code (missing mlockall) I ran into a yet unknown
issue with the POSIX skin: the code just hangs when wrapped to Xenomai.

Compilation:
gcc -o cyclictest cyclictest.c <posix-cflags> <posix-ldflags>

Invocation:
cyclictest -n -p 99

Maybe its just real-time starvation (but the watchdog doesn't trigger,
and I do not see why it should starve), maybe its a crash (will try to
attach a serial console later). Anyway, it's an easy test case (and also
a nice tool), so you may want to have a look as well.

Jan


--------------enig3A287E8CE63D33CB4BE8E6DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGaewniDOoMHTA+kRAgLDAJ0VPYesCUzN5a9PM6jYmfjFBh3QigCfRsSm
Onp24lmu1LA+4SID/I9zLtM=
=HRJu
-----END PGP SIGNATURE-----

--------------enig3A287E8CE63D33CB4BE8E6DB--

