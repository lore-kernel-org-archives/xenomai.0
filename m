Message-ID: <4683EAAB.6080401@domain.hid>
Date: Thu, 28 Jun 2007 19:06:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE23FDC199443C4C3B0DB7396"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH-STACK] more timer rework,
	group-based access control
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
--------------enigE23FDC199443C4C3B0DB7396
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

here is an overview of my latest patch stack at

http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/


fix-timer-wrap-arounds-v2.patch
-------------------------------

More or less academic fixes (hopefully without regressions) around the
scenario when the underlying raw timer wraps around. However, I don't
think we should leave this unfixed, risking an "Ariane-bug".


run-aclocal-first.patch,
link-check-sched_setaffinity.patch,
fix-patch-election.patch,
run-default-preparation.patch,
rt-caps-group.patch
-----------------------------------

See dedicated posts earlier on this list.


refactor-timer-modes.patch
--------------------------

xntimers are now of three kinds: XNTM_MONOREL, XNTM_MONOABS, or
XNTM_REALABS. This mode is passed on xntimer_start or on invocation of
higher services (xnpod_suspend_thread e.g.). Users were widely
automatically converted and may lack optimisation for the new scheme.
Please review carefully for regressions!


isol-timebase.patch
-------------------

Isolates time bases from the master base if XNTBISO is set on
xntbase_alloc. This becomes default for all skins except POSIX, native,
and RTDM. The other skins can join the system clock group by passing a
non-zero "sync_time" module parameter on startup. The patch also
enhances the output of /proc/xenomai/timebases. To-do: document the API
changes...


re-adjust-timers.patch
----------------------

Yet an empty placeholder. It shall contain the changes to make real-time
timers follow wallclock adjustments.


rtdm-timer-v2.patch
-------------------

Revised and documented version of RTDM timers, now based on the latest
xntimer version. The timer mode is passed on start, just like it's done
in the xntimer API. Moreover, rtdm_task_sleep_abs is introduced as a
replacement for the deprecated rtdm_task_sleep_until. The new service
works both with monotonic and real-time dates, the old service will
eventually by removed.


The rest is unchanged or was just refreshed.

Jan


--------------enigE23FDC199443C4C3B0DB7396
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg+q2niDOoMHTA+kRAlg8AJ9xoa08CD1MWTeoRGexF2pbEXvW+ACfdtbO
H0ITS9QSY+heuJxseuNXBoQ=
=fg2T
-----END PGP SIGNATURE-----

--------------enigE23FDC199443C4C3B0DB7396--

