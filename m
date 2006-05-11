Message-ID: <44630730.8010802@domain.hid>
Date: Thu, 11 May 2006 11:43:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0E58E8612E0CCCEF10FC7BA5"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Broken prio-inheritance of RTDM mutexes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0E58E8612E0CCCEF10FC7BA5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

shame on me: we had a nasty bug in the RTDM mutex code for quite a long
time (actually, in any Xenomai version).

The priority inheritance did not work in case such a mutex was taken
without prior contention and a higher priority task then tried to
acquire it. Scenario: task 1 takes lock A without having to wait, then
it gets preempted by task 2 which also tries to take lock A, task 1
should get booted to task 2's priority, and this was not the case so far.=


This bug was fixed in revision #1070 for the 2.1.x branch and #1071 for
trunk. Updating your local Xenomai code base it recommended in case you
depend on PI-characteristics of RTDM mutexes.

Jan


--------------enig0E58E8612E0CCCEF10FC7BA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEYwcxniDOoMHTA+kRAnWiAJ9Ep/pSBWCZG0isF2TYhJbxwiSRGACfXo8O
csTPxtcqIccjIaxWvVHnfBo=
=/F4j
-----END PGP SIGNATURE-----

--------------enig0E58E8612E0CCCEF10FC7BA5--

