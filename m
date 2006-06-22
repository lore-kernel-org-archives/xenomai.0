Message-ID: <449AC16F.3020708@domain.hid>
Date: Thu, 22 Jun 2006 18:12:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig34F56C9B13E84E2033F8152B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] normal pthreads broken
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34F56C9B13E84E2033F8152B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

I think some regression slipped into the rt-pthread lib. This example no
longer works on my box (thread is not executed):

#include <pthread.h>
#include <stdio.h>
#include <sys/mman.h>

void *thread(void *arg)
{
        printf("thread\n");
        return 0;
}

main()
{
        pthread_t thr;

        mlockall(MCL_CURRENT|MCL_FUTURE);

        printf("create =3D %d\n",
               pthread_create(&thr, NULL, thread, NULL));
        pause();
}


This also explains why the cyclic test is broken.

Jan


--------------enig34F56C9B13E84E2033F8152B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEmsFvniDOoMHTA+kRAtilAJ9BJ4s4HOTIEJX3iEwRBf+hAyArLACeNMT0
8SaeIEZcf8UidN48PfURzBQ=
=LmXx
-----END PGP SIGNATURE-----

--------------enig34F56C9B13E84E2033F8152B--

