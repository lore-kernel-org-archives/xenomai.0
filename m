Message-ID: <44EF2BA6.9040601@domain.hid>
Date: Fri, 25 Aug 2006 18:56:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBB89CBF4DD62C2C776A02F4B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [bug] broken PI-chain
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
--------------enigBB89CBF4DD62C2C776A02F4B
Content-Type: multipart/mixed; boundary="------------060801050807090801050200"

This is a multi-part message in MIME format.
--------------060801050807090801050200
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

the following (academic?) scenario is not handled as expected by the
nucleus:

 Prio	^
	|                  -- T2
	|                 /
	|  T0 <----- T1 <- M1
	| (M0)  M0  (M1)
	+------------------------

That means: Task T0 at, e.g., prio 1 holds mutex M0. T1, also at prio 1,
happens to interrupt T0 (round-robin?). T1 already holds M1 and now
tries to acquire M0. As both are at the same prio level, no boosting
takes place, all fine. Then T2 comes in play. It's at prio 2 and tries
to gain access to M1. T1 gets therefore boosted to prio 2 as well, but
T0 will stay at prio 1 under Xenomai.

I hacked this scenario in the attached demo. Set MAX to 2 to let it
work, leave it 3 and it breaks.

The problem looks on first sight like this test [1]: the claiming
relation is only establish if there is a priority delta on entry, but
that breaks when the claiming thread's prio changes later. Can we simply
remove this test?

Jan

[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/synch.c=
?v=3DSVN-trunk#L193

--------------060801050807090801050200
Content-Type: text/plain;
 name="pip-chain.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="pip-chain.c"

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/mutex.h>

#define MAX	3

RT_MUTEX mutex[3];

void task_func(void *arg)
{
	int index =3D (int)arg;

	rt_mutex_lock(&mutex[index], TM_INFINITE);
	rt_mutex_lock(&mutex[index-1], TM_INFINITE);
	rt_mutex_unlock(&mutex[index]);
}


int main(int argc, char **argv)
{
	RT_TASK task[3];
	RT_TASK_INFO info;
	int i;

	mlockall(MCL_CURRENT|MCL_FUTURE);

	for (i =3D 0; i < 3; i++)
		rt_mutex_create(&mutex[i], NULL);

	rt_task_shadow(&task[0], NULL, 1, 0);

	rt_mutex_lock(&mutex[0], TM_INFINITE);

	for (i =3D 1; i < MAX; i++)
		rt_task_spawn(&task[i], NULL, 0, (i =3D=3D MAX-1) ? 2 : 1, 0, task_func=
, (void *)i);

	rt_task_inquire(NULL, &info);
	printf("MAX=3D%d, prio=3D%d\n", MAX, info.cprio);

	rt_mutex_unlock(&mutex[0]);

	for (i =3D 0; i < 3; i++)
		rt_mutex_delete(&mutex[i]);

	return 0;
}

--------------060801050807090801050200--

--------------enigBB89CBF4DD62C2C776A02F4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE7yumniDOoMHTA+kRAj+0AJ0ecCCEUmVJ/+wyy7WuFlfNiAleSACeNLOE
gNFcI9zad83ZRrmzFReB72o=
=ZOTG
-----END PGP SIGNATURE-----

--------------enigBB89CBF4DD62C2C776A02F4B--

