Message-ID: <443F5DD7.40306@domain.hid>
Date: Fri, 14 Apr 2006 10:31:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2F8791FE0594E4C5B8A9EA82"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] T_FPU without effect
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
--------------enig2F8791FE0594E4C5B8A9EA82
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

after receiving SIGXCPU for unexpected context switches in a larger
application, I found out that the T_FPU bit does not seem to be
recognised on x86 during native task creation. Here is a simple test
case, watch out for /proc/xenomai/faults after program start and 5 s late=
r:

#include <native/task.h>
#include <sys/mman.h>

float x;

void task_func(void *p)
{
    rt_task_sleep(5000000000LL);
    x =3D 3.14 + (int)p;
}

main()
{
    RT_TASK task;

    mlockall(MCL_CURRENT|MCL_FUTURE);

    rt_task_spawn(&task, NULL, 0, 40, T_FPU | T_JOINABLE, task_func, 0);
    rt_task_join(&task);

    return 0;
}


Any immediate ideas?

Jan



--------------enig2F8791FE0594E4C5B8A9EA82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEP13aniDOoMHTA+kRAn/XAJwNC6h73jOIkC10uUMGmxCqx0HgCACfafzz
I3YSb5IowW4sxMTiRQ5vMJw=
=5/Um
-----END PGP SIGNATURE-----

--------------enig2F8791FE0594E4C5B8A9EA82--

