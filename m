Message-ID: <45D8DF58.2090804@domain.hid>
Date: Mon, 19 Feb 2007 00:20:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
References: <45D45AEA.50404@domain.hid>
	<1171547803.24117.8.camel@domain.hid>		<45D46704.9050109@domain.hid>
	<1171560346.24117.77.camel@domain.hid> <45D5746C.1090003@domain.hid>
In-Reply-To: <45D5746C.1090003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBBC013B7AFD56621999C6B18"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBBC013B7AFD56621999C6B18
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I just verfied that the mlockall issue persists. But it doesn't appear
to be a regression anymore. This little posix demo exposes it now on
both 2.6.20-1.7-02 and 2.6.19-1.6-06 against latest trunk:

#include <stdio.h>
#include <sys/mman.h>
#include <pthread.h>

int main(int argc, char *argv[])
{
	struct sched_param param =3D { .sched_priority =3D 10 };

//	mlockall(MCL_CURRENT|MCL_FUTURE);

	pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

	printf("shouldn't be printed...\n");
	pause();
}


In contrast, the same done via the native skin (rt_task_shadow) triggers
warning and program termination as expected.

It looks to me like the temporary mlockall during libpthread_rt init is
not really reverted (but munlockall is actually called) or not
propagated to the mm state that is later checked on xnshadow_map.

Jan


--------------enigBBC013B7AFD56621999C6B18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF2N9YniDOoMHTA+kRAv8aAJ4+FZmFg7O69o34R1x/5yK2vvSwpwCaA8lG
sT/6Hytf1ihyuFtCnbQiGmw=
=kGvK
-----END PGP SIGNATURE-----

--------------enigBBC013B7AFD56621999C6B18--

