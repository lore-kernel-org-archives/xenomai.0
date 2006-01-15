From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Sun, 15 Jan 2006 20:02:30 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4174165.4BIyCygvf0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601152002.36397.kisda@domain.hid>
Subject: [Xenomai-core] anonymous user-space tasks (again)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--nextPart4174165.4BIyCygvf0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I tested Philipp's fix "Allow creating anon user-space tasks" [1][2]
with Xenomai 2.1-RC2/2.6.15/x86 (2.0.3 should behave the same).

anon rt_task_shadow:
2.0.1: worked
2.1-RC2: works, but only once (EEXIST)

anon rt_task_spawn:
2.0.1: failed with ESRCH (-3)
2.1-RC2: works, but only once (EEXIST)

A small program only calling rt_task_shadow with NULL-name fails if i start=
 it=20
a second time. Error EEXIST (-17). Same for a program calling only=20
rt_task_spawn with NULL-name.

There is nothing under /proc/xenomai/registry/*

Apropos registry:
In the trunk there is no file src/native/registry.c anymore. I do not reall=
y=20
miss it, but the API documentation still says these calls can be made from=
=20
user-space. Should I create a patch to update the docs? Or should it be=20
there?

thank you
kisda

[1] http://svn.gna.org/viewcvs/xenomai?rev=3D405&view=3Drev
[2] http://svn.gna.org/viewcvs/xenomai?rev=3D406&view=3Drev

--nextPart4174165.4BIyCygvf0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDypxMIPTw9rIdn6oRArm/AJ9/voD1QV05BV8TfHCagIWxxqLD6wCfaF6y
57XP6TXsgmLbPA2/sdqcn0E=
=aJWc
-----END PGP SIGNATURE-----

--nextPart4174165.4BIyCygvf0--

