Message-ID: <45D5E493.4080405@domain.hid>
Date: Fri, 16 Feb 2007 18:06:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] fata: removing non-linked element...
References: <45CC651C.6060402@domain.hid>
	<45CC68F3.1000003@domain.hid>		<45D1C033.9010002@domain.hid>
	<45D1C61B.7030503@domain.hid>		<1171376742.885.3.camel@domain.hid>
	<45D1CAFA.6050408@domain.hid>		<1171385716.885.17.camel@domain.hid>
	<45D200C3.1030001@domain.hid>	<1171393088.885.37.camel@domain.hid>
	<45D59F98.8020006@domain.hid>
In-Reply-To: <45D59F98.8020006@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE27D9214FFDD94EA299311D6"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE27D9214FFDD94EA299311D6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> ...
> P.S.: For running the attaced program, you need a
> magic-parallel-port-interrupt-loopback-device. (Connecting pins 9 and 1=
0
> of the parallel port will do the trick.)

=2E..

> -----------------------------------------------------------------------=
-
>=20
> #include <iostream>
> #include <sys/mman.h>
> #include <assert.h>
> #include "native/task.h"
> #include "native/timer.h"
> #include "native/queue.h"
> #include "native/intr.h"
>=20
> #include <signal.h>
> #include <sys/io.h>
>=20
> RT_TASK maintask;
> RT_TASK inttask;
> RT_TASK intcreatortask;
> RT_TASK queue_endtask;
>=20
> RT_INTR lptint;
>=20
> #define LPT_BASE		0x378
> #define LPT_INT			7
>=20
> #define PERIOD_TIME 	10
> #define TIMEBASE 		10000

=2E..

>=20
> int main(void){
> 	std::cout << "xenomai interrupt test" << std::endl;
> 	mlockall(MCL_CURRENT | MCL_FUTURE);
> =09
> 	signal(SIGTERM,  catch_signal);
> 	signal(SIGKILL,  catch_signal);
> 	signal(SIGQUIT,  catch_signal);
> 	signal(SIGINT ,  catch_signal);=09
> =09
> 	if (iopl(3)) { =20
> 		printf("iopl err\n");
> 		exit(1);
> 	}
> =09
> 	int err;
>=20
> 	err =3D rt_task_shadow (&maintask,"maintask",10,0);
> 	std::cout << "task shadow:" << err << std::endl;
> =09
> 	err =3D rt_timer_set_mode(TIMEBASE);

Do you know that you are requesting a timer tick rate of 100 kHz? I just
managed to lock up my poor 266 MHz board running your code. :)

Maybe we are seeing all this weird behaviour due to kernel stack
overruns. Try to switch on CONFIG_DEBUG_STACKOVERFLOW and
CONFIG_DEBUG_STACK_USAGE.

/me now watching what happens at 10 kHz...

Jan


--------------enigE27D9214FFDD94EA299311D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1eSTniDOoMHTA+kRAkHBAJ4sneoa8G600slEaIE1a293akz+1gCaA35Y
yfs0wwpYEKKE6TOb3Rst1Wk=
=GrtW
-----END PGP SIGNATURE-----

--------------enigE27D9214FFDD94EA299311D6--

