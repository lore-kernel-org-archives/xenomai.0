Message-ID: <467639BE.30504@domain.hid>
Date: Mon, 18 Jun 2007 09:52:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E56E439309BD94F4A731B63"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
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
--------------enig8E56E439309BD94F4A731B63
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

after Philippe tried hard to shrink my queue, I was at least able to add
one new major patch:

Trying to write down the docs for rtdm_timer I realised that we really
need to do something about this scenario: multiple skins on different
time bases are exchanging time stamps directly or indirectly (e.g. via
RTDM devices). So far, those time stamps would be hopelessly out of sync
and could easily break things.

The answer I found is to synchronise all time bases as good as possible.
That means if one base changes its wall clock offset, all others need to
be adjusted as well. At this chance, we would also implement
synchronisation of the time bases on the system clock when they get
started. Because skins may work with different type width to represent
time, relative changes have to be applied, i.e. the core API changes
from xntbase_set_time(new_time) to xntbase_adjust_time(relative_change).
The patch (global-wallclock.patch) finally touches more parts than I was
first hoping. Here is the full list:

 - synchronise slave time bases on the master on xntbase_start
 - xntbase_set_time -> xntbase_adjust_time, fixing all time bases
   currently registered
 - make xnarch_start_timer return the nanos since the last host tick
   (only ia64 affected, all others return 0 anyway, causing one tick
   off when synchronising on system time -- but this fiddling becomes
   pointless on the long term due to better clocksourses on all archs)
 - adapt vrtx, vxworks, and psos+ skin to new scheme, fixing sc_sclock
   at this chance
 - make xnarch_get_sys_time internal, no skin should (need to) touch
   this anymore

The patch is lightly tested and appears to meet its goals. However, the
changes are fundamental and need careful review.

Other changes in the current stack:
 - configure link test for sched_setaffinity (see earlier posting)
 - kill svctable from the pod structure
 - updated ltt patch

Please check

	http://www.rts.uni-hannover.de/rtaddon/patches/xenomai

Jan


--------------enig8E56E439309BD94F4A731B63
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGdjm+niDOoMHTA+kRAq5tAJ9vvHrQASS7nAvJyY3A/YuskoeUnACfRTtG
k3MUF4Wf4r5E8bSwDcoNG+E=
=/3ZZ
-----END PGP SIGNATURE-----

--------------enig8E56E439309BD94F4A731B63--

