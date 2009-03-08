Message-ID: <49B3A126.6000602@domain.hid>
Date: Sun, 08 Mar 2009 11:42:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig177223CC2816590B14D2ADDA"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Watchdog / immediate Linux signal delivery
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
--------------enig177223CC2816590B14D2ADDA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

the watchdog is currently broken in trunk ("zombie [...] would not
die..."). In fact, it should also be broken in older versions, but only
recent thread termination rework made this visible.

When a Xenomai CPU hog is caught by the watchdog, xnpod_delete_thread is
invoked, causing the current thread to be set in zombie state and
scheduled out. But as its Linux mate still exist, hell breaks loose once
Linux tries to get rid of it (the Xenomai zombie is scheduled in again).
In short: calling xnpod_delete_thread(<self>) for a shadow thread is not
working, probably never worked cleanly.

There are basically two approaches to fix it: The first one is to find a
different way to kill (or only suspend?) the current shadow thread when
the watchdog strikes. The second one brought me to another issue: Raise
SIGKILL for the current thread and make sure that it can be processed by
Linux (e.g. via xnpod_suspend_thread(<cpu-hog>). Unfortunately, there is
no way to force a shadow thread into secondary mode to handle pending
Linux signals unless that thread issues a syscall once in a while. And
that raises the question if we shouldn't improve this as well while we
are on it.

Granted, non-broken Xenomai user space threads always issue frequent
syscalls, otherwise the system would starve (and the watchdog would come
around). On the other hand, delaying signals till syscall prologues is
different from plain Linux behaviour...

Comments, ideas?

Jan


--------------enig177223CC2816590B14D2ADDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmzoS8ACgkQniDOoMHTA+krMwCfRlSGD96r8adO1sbuA+Hi4Hkg
ZP0AnRi8R9gmabTD69wKmqk59XtVy2V8
=5qO1
-----END PGP SIGNATURE-----

--------------enig177223CC2816590B14D2ADDA--

