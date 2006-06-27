Message-ID: <44A1608B.3090605@domain.hid>
Date: Tue, 27 Jun 2006 18:44:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2082CD1469FF10729EBC441D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Prio-inversion on cleanup?
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
--------------enig2082CD1469FF10729EBC441D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

could someone give this scenario a try (requires my recent patch series)
and tell me if you are also seeing excessive latencies:

Start:
irqloop (+xeno_irqbench) -P 99 -t 0
latency -p 200 -P 50

Terminate:
irqloop

The termination seems to cause high latencies to the (then highest-prio)
periodic timer test. This does not happen with irqloop -t 1
(kernel-based task), and I can reduce the effect by invoking
pthread_setschedparam(SCHED_NORMAL) for the irqloop test thread right
before termination. Also, running and terminating another latency
instance with prio 99 does not have this effect.

Jan


--------------enig2082CD1469FF10729EBC441D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEoWCQniDOoMHTA+kRAtedAKCEdLorY6hZyzMbNKQpAyhK0up+cACbBlMu
FOhEU9Y8a+HX175q4XQiWzM=
=m86K
-----END PGP SIGNATURE-----

--------------enig2082CD1469FF10729EBC441D--

