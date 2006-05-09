Message-ID: <4460FC50.6030904@domain.hid>
Date: Tue, 09 May 2006 22:32:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig772FDBA8F09D92509A9F50A6"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [bug] lock-up by failing rt_task_spawn/create
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
--------------enig772FDBA8F09D92509A9F50A6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

originally, I was hunting some mutex issue (still on it, report will
follow soon). But due to a typo I revealed some nasty clean-up issue of
current trunk (2.1.x seems to contain the same code). Try to create two
tasks like this:

        rt_task_spawn(&task1, "task1", 0, 20, 0, task1_fnc, 0);
        rt_task_spawn(&task2, "task1", 0, 10, 0, task2_fnc, 0);
	[I think rt_task_create would "work" as well.]

The second call will fail due to duplicate names - and will trigger the
lock-up at this chance. It's actually a NULL pointer fault caused like th=
is:

(gdb) bt
#0  schedule_linux_call (type=3D4, p=3D0x0, arg=3D9) at shadow.c:343
                                 ^^^^^
                                 oops!
#1  0xc013b184 in xnshadow_send_sig (thread=3D<value optimized out>,
    sig=3D9, specific=3D<value optimized out>) at shadow.c:1087
#2  0xc492d7d0 in rt_task_delete (task=3D0xc1120d20) at task.c:591
#3  0xc492d4f7 in rt_task_create (task=3D0xc1120d20, name=3D0xc1375f1c
    "task1", stksize=3D0, prio=3D10, mode=3D3145728) at task.c:287

Sorry, no patch yet, I have to move on to the mutex issue first.

BTW, this reminds me the ask for a merging plan of the kgdb support for
ipipe - this bug was tracked down via kgdb...

Jan


--------------enig772FDBA8F09D92509A9F50A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEYPxQniDOoMHTA+kRAh5+AJ9hjN4LqFtRRYHtB7dVIKHwrWznuwCfcAmG
oi5axSVMZ1JfYw+b7TI31jg=
=vDQN
-----END PGP SIGNATURE-----

--------------enig772FDBA8F09D92509A9F50A6--

