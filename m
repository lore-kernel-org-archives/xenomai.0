Message-ID: <4630F1EA.8020206@domain.hid>
Date: Thu, 26 Apr 2007 20:39:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig289115FCDEA57932562F44D9"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 0/7] I-pipe fixes, cleanups, and enhancements
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig289115FCDEA57932562F44D9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

before ipipe-git gets busy again with work on 2.6.21, I'd like to flush
my patch queue. Here is an overview:

 1. Build fix for the tracer over x86_64

 2. Fix for Linux IRQ state during x86_64 boot

 3. [JANITOR] Fix whitespace damages in the tracer

 4. [JANITOR] Minor cleanups in ipipe/core.c

 5. Extract minimal, dependency-free linux/ipipe_base.h from main
    ipipe.h

 6. Optimise __ipipe_stall_root, __ipipe_test_root, and
    __ipipe_test_and_stall_root for execution on UP (only i386 and
    x86_64 so far). This should improve Linux performance over I-pipe,
    at least it did with the original version I posted last year.

 7. Detect illicit cross-domain calls down the pipeline. Together with
    the included Linux instrumentation, this can help to diagnose broken
    RT code in the kernel, namely in drivers and skins. Might be of some
    interest for RTDM hackers as recent user postings demonstrated...

All patches are against 2.6.20 (i386-1.7-03 / x86_64-1.0.06) and were
(as usual) quickly tested with Xenomai trunk on qemu boxes.

[Note that just this initial mail is CC'ed to xenomai-core, check
adeos-main for the actually patches.]

Jan


--------------enig289115FCDEA57932562F44D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMPHqniDOoMHTA+kRAjlZAJ4nQad5ZfXzcq0iJpB1uraNTMCAQgCcDKvF
M7nf9/Jm+YAay5zqmJ6vQpM=
=KpVA
-----END PGP SIGNATURE-----

--------------enig289115FCDEA57932562F44D9--

