Message-ID: <441A105B.9070907@domain.hid>
Date: Fri, 17 Mar 2006 02:26:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: POSIX include problem
References: <44195924.9090709@domain.hid>	<17433.35726.567615.125720@domain.hid>	<4419A7B0.6000003@domain.hid>
	<17433.46842.657384.406082@domain.hid>
In-Reply-To: <17433.46842.657384.406082@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA4F447B8981249E0D0957B58"
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
--------------enigA4F447B8981249E0D0957B58
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > ...
>  > I found this while trying Thomas Gleixner's cyclic test over the POS=
IX
>  > skin (http://www.tglx.de/projects/misc/cyclictest). After fixing a
>  > rather ugly bug in his code (missing mlockall) I ran into a yet unkn=
own
>  > issue with the POSIX skin: the code just hangs when wrapped to Xenom=
ai.
>  >=20
>  > Compilation:
>  > gcc -o cyclictest cyclictest.c <posix-cflags> <posix-ldflags>
>  >=20
>  > Invocation:
>  > cyclictest -n -p 99
>  >=20
>  > Maybe its just real-time starvation (but the watchdog doesn't trigge=
r,
>  > and I do not see why it should starve), maybe its a crash (will try =
to
>  > attach a serial console later). Anyway, it's an easy test case (and =
also
>  > a nice tool), so you may want to have a look as well.
>=20
> A second, better guess: the created thread is not a Xenomai realtime
> thread, so never suspends (Xenomai calls return EPERM when not called
> from a real-time thread) and hangs. Replacing sched_setscheduler with
> pthread_setschedparam should solve this issue.

Haven't tried this yet, but I'm quite sure that this is the reason. Then
this must have been a classic Linux SCHED_FIFO lock-up.

>=20
> I would not be surprised if, with NPTL, sched_setscheduler had an effec=
t
> on the whole process, i.e. set the priority of all the threads in the
> process.
>=20

=46rom reading the POSIX spec, I would say the calling sched_setscheduler=

multiple times in individual threads indicates a wrong usage, doesn't
it? And what NPTL does with it, specifically in the presence of multiple
threads, is a good questions...

Jan


--------------enigA4F447B8981249E0D0957B58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGhBbniDOoMHTA+kRAvlZAJkBPr3OHOFC9KgGXZcFBaHJpInPkQCeLnZB
19pTmkVsXSX4KzJRGtxu7PU=
=8r2d
-----END PGP SIGNATURE-----

--------------enigA4F447B8981249E0D0957B58--

