Message-ID: <44E46EDC.1000707@domain.hid>
Date: Thu, 17 Aug 2006 15:27:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC82744B0D12B17D4CA51B513"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Towards periodic mode over aperiodic timers
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
--------------enigC82744B0D12B17D4CA51B513
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

the conflict between skins preferring aperiodic timing vs. skin
requiring periodic mode popped up once again on xenomai-help. One way
out of this, likely THE way, is to map such tick-driven skins on a
periodic timer over aperiodic mode (and drop periodic low-level support
completely at the same time).

Let's start some discussion how this can be done, specifically as Gilles
and I are already turning the xntimer subsystem upside down (almost). If
we want co-existence of high-res timing of, say, the posix skin while
the vxworks skin runs over a tick-timer, we need some kind of "context"
for timing related functions.

Simple example: xnpod_suspend_thread() expects a timeout as "xnticks",
i.e. either in nanoseconds or in ticks of the underlying periodic timer.
This depends on the global timer mode of the pod, and that's a no-go for
concurrent modes as sketched above. Rather, the thread should encode
which kind of timing mode to use, even better the threads timers.

We currently dispatch xntimer_start globally to the different timer
subsystems (if periodic mode is enabled). What about deriving the start
function from the timer itself in the future? If a timer was created as
aperiodic, things happen as usual in aperiodic mode, and the timeout are
interpreted as nanoseconds. If the timer is periodic, we interpret the
timeout in ticks and map them on a second-level timing subsystem
(probably a wheel) that itself is driven by a single periodic timer in
the first-level system (just like the host tick).

Am I heading in the right direction? Is it feasible? Any other ideas?

Jan


--------------enigC82744B0D12B17D4CA51B513
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE5G7cniDOoMHTA+kRAsW2AJ4yy+Nkx+TMx7sCkhJTxWPq1FzLPACfdaXa
J6vZlSsawoyjCN1L+YGCrOM=
=swVv
-----END PGP SIGNATURE-----

--------------enigC82744B0D12B17D4CA51B513--

