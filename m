Message-ID: <43986AFA.6060908@domain.hid>
Date: Thu, 08 Dec 2005 18:18:50 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig681E9CB171265B300961DE47"
Subject: [Xenomai-core] [bug] user memory leakage on rt_task_delete
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
--------------enig681E9CB171265B300961DE47
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

during my ongoing search for the init/cleanup issue of shadow threads, I
stumbled over another problem: Deleting a userspace native thread that
is blocked in primary mode does not let the NPTL clean up all resources
allocated in userspace. If you plan to do some rt_task_create/delete in
a loop, you will soon run out of memory (and Mr. oom-killer will show
up...).

I haven't found a solution for this beyond letting a rt-task always
terminate itself (or terminate the whole program after forced
deletions). If there is no solution, we should at least document this
fact somewhere.

Again, it's not a common use case, but it's also not an expectable
behaviour of the native skin.

Ok, back to work,
Jan


--------------enig681E9CB171265B300961DE47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDmGr6ncNeS9Q0k+IRArIvAKCAH9LCq7ooAB6foFXpbUtllNknTQCfX0Ik
uyRphn5W3bDrU+J15SIYlv0=
=NDry
-----END PGP SIGNATURE-----

--------------enig681E9CB171265B300961DE47--

