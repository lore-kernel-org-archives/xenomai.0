Message-ID: <45D6C4A7.6090707@domain.hid>
Date: Sat, 17 Feb 2007 10:02:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5467193767B83B35A7932DD0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 0/2] user space rt-safe printing and
	tracing
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5467193767B83B35A7932DD0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

fresh from the development labs, guaranteed to be incomplete and lightly
tested, here comes a patch series that addresses two issues bugging me
(and maybe others) for quite some time:

 1. How to print from RT (primary) context without stepping down to
    secondary mode?

 2. How to trace Xenomai syscalls without hacking on strace _and_
    I-pipe (ptrace for RT-syscalls) _and_ without suffering from its
    temporal intrusiveness (traced processes are stopped while examining
    their syscall arguments)?

The following two patches (against trunk) aim at answering both
questions. The first one provides a generic rtprint library, the second
one exploits it by instrumenting ridiculous subsets of libnative and
libpthread_rt. Find details on design and usage will be found in the
following mails.

Take this series as food for discussion about its usefulness, code
organisation and remaining quirks, and also as an offer to early
adopters. While I think that librtprint should be generally acceptable,
I would like to gain some comments on my approach for per-process
syscall tracing (and its impact on the skin libraries) first. Then, if
this tracing is considered viable, helping hands for the boooooring
instrumentation work would be *very* welcome!

Jan


--------------enig5467193767B83B35A7932DD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF1sSvniDOoMHTA+kRAuY4AJ9IQDLGDBbFhQ4EcO9OH7mj176AnQCfeJ6J
dAzlWVKzEg2zHeixkNgaHCY=
=9KIH
-----END PGP SIGNATURE-----

--------------enig5467193767B83B35A7932DD0--

