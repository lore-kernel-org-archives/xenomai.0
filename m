Message-ID: <43C004EB.1090702@domain.hid>
Date: Sat, 07 Jan 2006 19:14:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig46D1A353154021B14B955B1A"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] reset tracer after timer calibration
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46D1A353154021B14B955B1A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi Philippe,

this patch is to reset the maximum IRQs-off path after timer calibration
(will get flooded otherwise). If you have no concerns, please apply.

Actually, there is another noise source: rthal_timer_request() for the
APIC case. But I think we should let this one alone as the user may
trigger millisecond latencies by accidentally restarting the timer while
some external-IRQ-driven device still depends on low latencies. In that
case, the tracer can provide helpful hints.

Therefore, in order to get useful information after starting the timer,
one always have to run "echo > /proc/ipipe/trace/max" first. Well, if we
move the timer start to some module init or whatever phase also for the
native skin, we should reconsider this exclusion.

Jan

--------------enig46D1A353154021B14B955B1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwATrniDOoMHTA+kRAu3ZAJ4ptvHx3Ol2tJfDDWAyybJXR0M3FwCfXsSU
cKO++/2xQXvC5552sLh6BYs=
=BB8t
-----END PGP SIGNATURE-----

--------------enig46D1A353154021B14B955B1A--

