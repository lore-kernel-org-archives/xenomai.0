Message-ID: <438DD4E2.9080208@domain.hid>
Date: Wed, 30 Nov 2005 17:35:46 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig29DB1524B207778B15556C4E"
Subject: [Xenomai-core] [bug] don't try this at home...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig29DB1524B207778B15556C4E
Content-Type: multipart/mixed; boundary="------------010402000207060903060307"

This is a multi-part message in MIME format.
--------------010402000207060903060307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I'm afraid this one is serious: let the attached migration stress test
run on likely any Xenomai since 2.0, preferably with
CONFIG_XENO_OPT_DEBUG on. Will give a nice crash sooner or later (I'm
trying to set up a serial console now). To be more precisely:

Setup 1:
    xeno 2.0, kernel 2.6.13.5, ipipe-1.0-09
    on Thinkpad R40

Setup 2:
    xeno svn-trunk, kernel 2.6.14.3, ipipe-1.0-11
    on Thinkpad R40 & P-III embedded PC

I have no clue yet what happens, I just nailed various strange
behaviours and latencies down to this issue.

ALARM! ;)

Jan


PS: I suggest including this test for future regression checks into the
upcoming(?) testsuite.

--------------010402000207060903060307
Content-Type: text/plain;
 name="nat_migration.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="nat_migration.c"

#include <stdio.h>
#include <sys/mman.h>
#include <semaphore.h>

#include <native/task.h>
#include <native/sem.h>

sem_t sem;


static void simple_thread(void *arg)
{
    sem_post(&sem);
}


int main (int ac, char **av)
{
    RT_TASK task;
    int     ret;


    mlockall(MCL_CURRENT | MCL_FUTURE);

    sem_init(&sem, 0, 0);

    while (1) {
        ret =3D rt_task_create(&task, "migration", 0, 1, 0);
        if (ret !=3D 0)
            printf("(%s) error creating task: %d\n", __FUNCTION__, ret);

        ret =3D rt_task_start(&task, &simple_thread, NULL);
        if (ret !=3D 0)
            printf("(%s) error starting task: %d\n", __FUNCTION__, ret);

        sem_wait(&sem);

        rt_task_delete(&task);
    }
}

--------------010402000207060903060307--

--------------enig29DB1524B207778B15556C4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDjdTincNeS9Q0k+IRAjZVAKC60QFebgr7Lw1to4cjVfB88AyV/wCdFpLg
ppW2V5uhLsorcx4cvYc2/b8=
=3bD9
-----END PGP SIGNATURE-----

--------------enig29DB1524B207778B15556C4E--

