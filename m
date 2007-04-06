Message-ID: <46163817.3060007@domain.hid>
Date: Fri, 06 Apr 2007 14:07:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig033F9520C8277BDB97FD6DE3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Getting the clock model right
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
--------------enig033F9520C8277BDB97FD6DE3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

recent announcement of some new TSC synchronisation feature in RTAI made
me stick my nose into this and think about the whole issue of clock
synchronisation again. Well, let's not talk about RTAI details here, but
they got one thing right: as long as we cannot handle unsynch'ed TSC on
SMP, we need some detection and alarming as the bare minimum.

Why can't we handle such cases yet? First, there seems to be still some
bugs hidden in the core (one example: xntimer_start_aperiodic() uses the
local time stamp to start a remote timer). While this can be addressed
by reviewing the code and fixing what is wrong, the more severe issue is
that we cannot help the application or driver developer to cope with
unsynch'ed time stamps properly. We either have to propagate dates as a
tuple of nanoseconds (or ticks) and clock ID (TSC of CPU x, RTC, remote
clock, etc.), or we should try harder to provide consistent time across
the whole system. The former means API breakage in many places, so I'm
more and more convinced that it is the _wrong_ path. That leaves us with
option 2 (please point me to any other alternative, I don't see them).


Let's take a step back again and look at why we currently claim that
unsynch'ed per-CPU clocks is the official model in Xenomai: certain
multi-processor or multi-core systems (specifically x86 and x86_64) do
not provide synchronised TSCs across all nodes, neither with respect to
their offsets nor regarding drifts due to transient freezing of TSCs.
That's a pity for now, but it will not remain so on the long-term. On
one side, there are alternatives, specifically HPET. On the other, CPU
manufactures realised that TSCs are used for timekeeping these days and
promise to fix the issue in hardware [1].

So we should really forget about designing around this shortcoming of
today's hardware and rather look for viable workarounds until the sun
breaks though again. That means we need

 A) drift detection and alarming (highest prio to-do)

 B) offset and drift compensation where feasible

 C) support for alternatives (=3D> HPET-based clock source)

Regarding B): The issue should actually be not that tricky for most
reasonable systems. We already rely on consistent, monotonic CPU-local
TSCs (which implies switching off power management e.g.). Thus we should
see only small drifts in reality that should be manageable, no?

Comments and thoughts are welcome. I would really like to see a clear
roadmap for this (IMHO) important issue before 2.4 gets on the road.
Also, I would like to draw a line and add things like timers to the next
RTDM revision - also before 2.4.


BTW, there is another to-do regarding the time subsystem: optimised
tsc-to-ns conversion (and vice versa), including uninlining of those
huge functions. When looking at this, considering to implant some means
for smoothly adjusting clocks during runtime would be great. I'm
thinking about a generic infrastructure to synchronise the Xenomai time
on external sources (=3D>distributed clocks).

Jan

[1] http://developer.amd.com/article_print.jsp?id=3D92


--------------enig033F9520C8277BDB97FD6DE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGFjgXniDOoMHTA+kRArimAJ0U9v20BaHNKjen0TqHSsL60nfNwgCeLXUc
PM4+J0HWfcc2ORqrcVCZ9IU=
=XhU4
-----END PGP SIGNATURE-----

--------------enig033F9520C8277BDB97FD6DE3--

