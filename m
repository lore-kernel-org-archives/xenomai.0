Message-ID: <4A23B35E.7010005@domain.hid>
Date: Mon, 01 Jun 2009 12:54:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A157FD9.40106@domain.hid>
In-Reply-To: <4A157FD9.40106@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC9B9A8AFA864168925D13D46"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] About HARD real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antoine Nourry <nourry@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC9B9A8AFA864168925D13D46
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=2E..to answer this almost forgotten question:

Antoine Nourry wrote:
> Hi,
> I just wonder :
> Why can we read everywhere that PREEMPT-RT patch offer HARD real time=20
> while in other papers we can read that it cannot ensure determinism  ?

It depends on which method you use to verify that some hard real-time
requirement is fulfilled. In practice, measurement under more or less
reasonable chosen load is the most common method for real-time systems
of a complexity like PREEMPT-RT or even much simpler ones. Only
dedicated and small systems, either with a simple RTOS or even OS-less,
are entirely formally verified today, using also formal models for their
hardware.

There is also a hybrid approach in between those extremes (specifically
useful if the hardware platform is too complex for modeling - like x86):
first develop models of your worst-case execution paths based on the
source code, taking also application parameters into account, then
trigger and measure them on the target hardware. But this only works if
the complexity of the analyzed real-time system is still manageable,
either by a human alone or with the help of tools.

PREEMPT-RT currently only fulfills this requirement if you apply
probabilities ("It is sufficiently unlikely that all these n nested
locks are contended at the same time with the maximum delay, thus we can
ignore this case.") AND very carefully design your application. This
applies to quite a few but not all real-time use cases.

> (because it only seems to permit low latencies but not constant=20
> execution times, by the way why ? Is it because this patch still uses=20
> undeterministic parts of the kernel ? )

By design not, but bugs/regressions can always exist, just as they have
popped up in Xenomai & Adeos/I-pipe before. When people measure extreme
latencies, they typically trigger such cases (or run their tests on
unsuited commodity hardware). Sadly, the actual reason for such
latencies are too rarely analyzed then, thus only the statement "X does
not provide real-time" makes it into publications.

As said above, the most challenging issue of PREEMPT-RT is that you have
to carefully design both drivers and applications to not leave the path
that can provide sufficiently reliable latencies. Just as with Xenomai,
only a subset of the kernel can be used for time critical code paths.
Moreover, there is still a noticeably higher risk to drive the system
into excessive latencies with non-RT load than you have with a
co-scheduled approach.

> Considering this, how Xenomai 3 will be able to rely on PREEMPT-RT as=20
> real time enabling technology, allowing user to bypass ADEOS ?

The current roadmap is to let Xenomai 3 come in two flavors: one based
on PREEMPT-RT (Xenomai/Solo), the other (Xenomai/Duo) using Adeos/I-pipe
and a second scheduler like Xenomai 2 does, but supporting much less
legacy than the latter (no kernel 2.4, no in-kernel RT applications
etc.). So depending on your requirements and PREEMPT-RT's progress,
you'll be able to chose the fitting platform or even switch between them
without too much effort.

Jan


--------------enigC9B9A8AFA864168925D13D46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkojs2wACgkQniDOoMHTA+kvMwCfQxHGJ2vxxCA0iGSJ9+lksGZu
jVkAn0qwZ6AO6G5Ps0Xt24MNh40VElRR
=h8YA
-----END PGP SIGNATURE-----

--------------enigC9B9A8AFA864168925D13D46--

