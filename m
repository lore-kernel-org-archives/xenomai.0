Message-ID: <4398B958.8040705@domain.hid>
Date: Thu, 08 Dec 2005 23:53:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig88DEAD950FE4B148DF24FBF7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [bug?] set pthread stack size broken
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
--------------enig88DEAD950FE4B148DF24FBF7
Content-Type: multipart/mixed; boundary="------------070504050505040205070305"

This is a multi-part message in MIME format.
--------------070504050505040205070305
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

something for the night: Can someone explain why normal pthreads can be
restricted to initially use only the stack size provided via
pthread_attr_setstacksize() while any rt-mapped thread (posix and
native) refuse to accept this? For a simple test, compile the attached
program one time as normal

    gcc -lpthread -o stacksize stacksize.c

and the other time against xeno's posix skin

    gcc `xeno-config --posix-cflags` `xeno-config --posix-ldflags` \
        -o stacksize.o stacksize.c

Then compare the memory requirements of both processes - they should
differ by 2M, the stack size when pthread_attr_setstacksize is not used.
Strange - and also critical when considering larger applications...

So far I only tested against 2.1, but I don't see a reason why 2.0.x
should behave different. Will get checked, though.

Any ideas?

Jan

--------------070504050505040205070305
Content-Type: text/plain;
 name="stacksize.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stacksize.c"

#include <sys/mman.h>
#include <unistd.h>
#include <limits.h>
#include <pthread.h>


static void *simple_thread(void *arg)
{
    sleep(30);
    return 0;
}


int main (int ac, char **av)
{
    pthread_t pth;
    pthread_attr_t attr;


    mlockall(MCL_CURRENT | MCL_FUTURE);

    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);
    pthread_create(&pth, &attr, simple_thread, NULL);

    sleep(30);

    return 0;
}

--------------070504050505040205070305--

--------------enig88DEAD950FE4B148DF24FBF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDmLlbniDOoMHTA+kRAt4GAJoDbfGNhtfQGGoQxHaNEam6WUqfPQCfdk5l
z7hdwbVUrCARh8LDKuxmIRY=
=83wx
-----END PGP SIGNATURE-----

--------------enig88DEAD950FE4B148DF24FBF7--

