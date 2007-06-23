Message-ID: <467CD519.1060802@domain.hid>
Date: Sat, 23 Jun 2007 10:08:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig679D133F0413AE118082993C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Monotonic, realtime, and other timers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig679D133F0413AE118082993C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

[just to save this early-Saturday-morning insight]

I think the xntimer interface is not yet ready to represent all required
scenarios. What kind of timers are there? Let's start with POSIX:

1. Realtime timers	- use realtime clock as base, re-tune
			  absolute(!) expiry dates if the realtime clock
			  changes
2. Monotonic timers	- use monotonic clock as base, don't re-adjust
			  during runtime

Now what we have in current trunk:

3a. Realtime xntimers	- use wallclock_offset to calculate absolute
			  expiry dates, don't re-adjust during runtime
4a. Monotonic xntimers	- use raw jiffies/TSC as base, don't re-adjust
			  during runtime

And this is what we planed to introduce soon:

3b. Realtime xntimers	- use wallclock offset to calculate absolute
			  expiry dates, re-adjust if the offset changes
			  during runtime
4b. Monotonic xntimers	- same as 4a

3b and 4b almost perfectly match POSIX, one only has to pass relative
realtime timers as monotonic ones (Linux does so too). But there are a
lot of skins that potentially rely on 3a! At least the whole native
skin, I would say. So we may actually need two knobs when starting an
xntimer:

 A) Take wallclock offset into account when calculating internal expiry
    date?
 B) Re-tune the expiry date during runtime if the offset changes?

Reasonable combinations are none of both ("POSIX monotonic"), A
("Xenomai realtime"), and A+B ("POSIX realtime"). Am I right? Please
comment.

Moreover, it looks to me like the monotonic API I introduced is not very
handy (fortunately, there is no in-tree user yet). It has a sticky
property, i.e. you set a persistent flag in the xntimer object if it
ought to be monotonic. As xntimer structures are typically also
persistent, you easily end up saving the current mode, setting your own,
and restoring the old one once the timer fired -- to keep other users of
the timer happy. E.g., think of RTDM doing some monotonic timing with a
task while the owning skin may prefer realtime mode. I'm almost
convinced now that passing a non-sticky mode on each xntimer_start
(along with XN_ABSOLUTE/RELATIVE in the same parameter) will be more usef=
ul.

Jan


--------------enig679D133F0413AE118082993C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGfNUaniDOoMHTA+kRAttzAJ4kupgpppQZ0hEcqWCsZLWOQz+9YQCdHIQI
qVCbbOkUYSPZamUpl5F1bTo=
=9ubP
-----END PGP SIGNATURE-----

--------------enig679D133F0413AE118082993C--

