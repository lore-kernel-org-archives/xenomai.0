Message-ID: <46322259.5080409@domain.hid>
Date: Fri, 27 Apr 2007 18:18:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cbe23c50704270912i1cdb1272hd700a8b83775a34a@domain.hid>
In-Reply-To: <cbe23c50704270912i1cdb1272hd700a8b83775a34a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig073DBC8E1C96281D32497354"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Core Dump on possibly buggy signal
	handler	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig073DBC8E1C96281D32497354
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Eric Noulard wrote:
> Hi all,
>=20
> I've recently discovered a "possible" bug
> only occuring with a system running xenomai-patched kernel.
>=20
> I have set up a machine (dual-core intel machine).
> The machine is installed with a Fedora Core 6 and
> may be booted (test purpose)  with different kernel:
>=20
> 1) linux 2.6.20-0119.rt8
>    which is an Ingo Molnar precompiled preempt-rt patched kernel
>    you may find it there:
>     http://people.redhat.com/mingo/realtime-preempt/
>=20
> 2) 2.6.20-xeno-2.3.1-ipipe-1.7-03
>    which is a xenomai enabled kernel I've configured and compiled.
>=20
> My test application is a mixed C/C++ USER-land application
> which currently make no xenomai specific call.
>=20
> The application core dumps at the end of its execution
> with the xenomai enabled kernel whereas it does not
> with the preempt-rt kernel.
>=20
> I track down the problem to a misuse of sigaction calls
> which install SIGALARM handler with sa_flags not properly setup.
>=20
> My code is definitely buggy but I let you know because in the first
> place it was puzzling to have different (but consistent and repeatable)=

> behavior
> on different kernel, with core dump using the Xenomai-enabled kernel :(=
(.
>=20
> You may try it  yourself:
>=20
> gcc -o BadTimerSigHandler TimerSigHandler.c
>=20
> generates a the buggy binary, while
>=20
> gcc -DGOOD_SIGHANDLING -o GoodTimerSigHandler TimerSigHandler.c
>=20
> generates the good one.
>=20
> I don't really know if it may indicates a xenomai bug or not
> but I would be glad to understand WHY is this.
>=20
> I mean I know that uninitialized memory have unpredictable consequence
> but here the bug is persistent after rerun, reboot, power cycle etc...
>=20

What is a.sa_flags initialised when it is not initialised? 0? Maybe you
can nail it down to defined state that causes the core dump reliably.
Then we can also track down what happens to your sigaction call and
if/why Xenomai/I-pipe changes the picture in some regard.

Jan


--------------enig073DBC8E1C96281D32497354
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMiJZniDOoMHTA+kRAqfcAKCCMQ5a50T43LuiDJD42iSbtvDjCwCffMRT
s7TFfVqIqDHDWASDUVQXz5k=
=krju
-----END PGP SIGNATURE-----

--------------enig073DBC8E1C96281D32497354--

