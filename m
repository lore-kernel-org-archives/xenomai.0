Message-ID: <4C6E9C10.3000203@domain.hid>
Date: Fri, 20 Aug 2010 17:15:28 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C6E9903.4010003@domain.hid>
In-Reply-To: <4C6E9903.4010003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAEDC7B5809CDEB7E6E508681"
Subject: Re: [Xenomai-core] [git pull] small RTDM fixes and assorted patches
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEDC7B5809CDEB7E6E508681
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jan,

https://mail.gna.org/public/xenomai-core/2010-05/msg00059.html

Stefan

Am 20.08.2010 17:02, schrieb Jan Kiszka:
> The following changes since commit 7e2735614ebe515d57abeaa3ff6df375a7c4=
149f:
>=20
>   sched: avoid infinite reschedule loops (2010-08-03 00:11:21 +0200)
>=20
> are available in the git repository at:
>   git://git.xenomai.org/xenomai-jki.git for-upstream
>=20
> Jan Kiszka (8):
>       rt_print: Properly return printed length
>       RTDM: Protect xnshadow_ppd_get via nklock
>       RTDM: Plug race between proc_read_dev_info and device deregistrat=
ion
>       RTDM: Properly clean up on xnvfile setup errors
>       RTDM: Extend device name space in open_fildes proc output
>       Fix symbolic status ouput of root threads
>       Create watchdog as non-blockable timer
>       native: Improve documentation of rt_task_join and rt_task_delete
>=20
>  ksrc/nucleus/sched.c     |    3 ++-
>  ksrc/nucleus/thread.c    |    4 ++++
>  ksrc/skins/native/task.c |   15 +++++++++++++--
>  ksrc/skins/rtdm/core.c   |    2 ++
>  ksrc/skins/rtdm/proc.c   |   45 +++++++++++++++++++++++++++++++++++---=
-------
>  src/rtdk/rt_print.c      |    1 +
>  6 files changed, 57 insertions(+), 13 deletions(-)
>=20
> The bug fixes (patches 1-4 and 7) should all be considered for 2.5 as
> well, but some need rebasing. Will look into this once the series is
> acceptable.
>=20
> Jan
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20


--------------enigAEDC7B5809CDEB7E6E508681
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFMbpwQIPTw9rIdn6oRAvInAJ0fAOv3S+ZmPbfiAe1x7uJPZtXZwgCfZnV8
A6k4vVJa1fHZZ7krtK9Wnws=
=Y+Eb
-----END PGP SIGNATURE-----

--------------enigAEDC7B5809CDEB7E6E508681--

