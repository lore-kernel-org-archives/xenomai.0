Message-ID: <44FFF816.6010105@domain.hid>
Date: Thu, 07 Sep 2006 12:44:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange segmentation fault
References: <44FFF19B.8080104@domain.hid>
In-Reply-To: <44FFF19B.8080104@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B7B2D83EF56504761057099"
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
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B7B2D83EF56504761057099
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
> Hi,
>=20
> I'm experiencing an strange segmentation fault problem. I've boiled dow=
n
> the code to the simplest possible program that causes the segfault:
>=20
> 1- Set the timer in oneshot mode.
> 2- Create a task.
> 3- Start the task.
>=20
> At the task function:
>=20
> 1- Make the task periodic (1s).
> 2- Issue a fprintf.
>=20
> That's all. The code segfaults. If I remove the fprintf, it won't
> segfault. If I change it for a printf, it won't segfault.
>=20
> If I use fprintf but print just "TICK" instead of "TICK %u", it won't
> segfault while the task is running, but it will when the program is
> interrupted (not shown here, but I tried this with a signal handler in
> place that properly deleted the task, though I think this is not
> absolutely necessary).
>=20
> I'm totally confused.
>=20
> I know I can use fprintf as long as I assume that the RT task will go
> into "secondary" mode at this point because it'll be using linux
> services, and that it will go back to "primary" RT mode on the next cal=
l
> to rt_task_wait_period.
>=20
> Also, I know that it would be best to use periodic instead of oneshot
> mode, but my program is obviously more complex than this boiled down
> example and really needs oneshot mode.
>=20
> Any ideas about what could be the problem?
>=20
> Thanks.
>=20
> P.S: This is the same problem I described earlier inthe list as caused
> by inb. I though that inb was the cause because removing it avoided the=

> segfault, however, it turns out that removing the inb was causing
> another piece of code containing the fprintf not to execute.
>=20
> //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
>=20
> #include <sys/types.h>
> #include <sys/mman.h>
> #include <sys/io.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdio.h>
>=20
> #include <native/task.h>
>=20
> #include "main.h"
>=20
>=20
>=20
> static RT_TASK    _io_task;
>=20
> static void _io_proc (void *arg) {
>=20
>    u_long overrun;
>=20
>    rt_task_set_periodic(&_io_task, TM_NOW,
> rt_timer_ns2ticks(1000000000LL));
>=20
>    for (;;) {
>=20
>        rt_task_wait_period(&overrun);
>=20
>        fprintf(stderr, "TICK %u\n", 1);
>    }
> }
>=20
>=20
>=20
> static void _cleanup (void) {
>    rt_task_delete(&_io_task);
> }
>=20
>=20
>=20
> static int _init (void) {
>=20
>    int r;
>=20
>    r =3D rt_timer_set_mode(TM_ONESHOT);
>    if (r < 0) {
>        fprintf(stderr, "ERROR %i initializing RT\n", r);
>        _cleanup(); return r;
>    }
>=20
>    r =3D rt_task_create(&_io_task, "rtcore_io_task", 0x1000, 10, T_FPU)=
;

Try PTHREAD_STACK_MIN instead of 0x1000 - or, better, leave it 0 and let
Xenomai pick a value for you. Unless you need more than the default
stack (PTHREAD_STACK_MIN * 4) or you are *sure* to get a way with
PTHREAD_STACK_MIN, you should avoid touching this value.

>    if (r < 0) {
>        fprintf(stderr, "ERROR %i creating task\n", r);
>        _cleanup(); return r;
>    }
>=20
>    r =3D rt_task_start(&_io_task, &_io_proc, NULL);
>    if (r < 0) {
>        fprintf(stderr, "ERROR %i starting task\n", r);
>        _cleanup(); return r;
>    }
>=20
>    return 0;
> }
>=20
>=20
>=20
> int main (int argc, char **argv) {
>=20
>    iopl(3);
>    mlockall(MCL_CURRENT | MCL_FUTURE);
>=20
>    if ( _init() < 0) return 1;
>=20
>    for (;;) sleep(1);
>=20
>    _cleanup();
>=20
>    return 0;
> }
>=20

Jan


--------------enig0B7B2D83EF56504761057099
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE//gWniDOoMHTA+kRAm0oAJ9nzZBHQvO3k3Qma/8zugePG7H3pACeL7Qp
ixmHsAPRrVnCUmEdqU8apmE=
=lbZ1
-----END PGP SIGNATURE-----

--------------enig0B7B2D83EF56504761057099--

