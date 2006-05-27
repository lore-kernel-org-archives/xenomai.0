Message-ID: <4478718E.1010704@domain.hid>
Date: Sat, 27 May 2006 17:34:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [sim] ... doesn't build
References: <44786C8F.9070201@domain.hid>
	<17528.28463.599578.54637@domain.hid>
In-Reply-To: <17528.28463.599578.54637@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFAE3541E6F16AAE3885AE0B9"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFAE3541E6F16AAE3885AE0B9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  >=20
>  > I just tried to get the simulator from trunk built but failed here:
>  >=20
>  > In file included from ../../../../xenomai/sim/../include/posix/posix=
=2Eh:29,
>  >                  from
>  > ../../../../xenomai/sim/../ksrc/skins/posix/internal.h:24,
>  >                  from
>  > ../../../../xenomai/sim/../ksrc/skins/posix/thread.h:23,
>  >                  from
>  > ../../../../xenomai/sim/../ksrc/skins/posix/sched.c:48:
>  > ../../../../xenomai/sim/../include/posix/pthread.h:246: conflicting
>  > types for `pthread_attr_getaffinity_np'
>  > /usr/include/pthread.h:383: previous declaration of
>  > `pthread_attr_getaffinity_np'
>  > ../../../../xenomai/sim/../include/posix/pthread.h:249: conflicting
>  > types for `pthread_attr_setaffinity_np'
>  > /usr/include/pthread.h:377: previous declaration of
>  > `pthread_attr_setaffinity_np'
>  >=20
>  > Looks like glibc-2.4 (that one comes with my opensuse 10.1) now also=

>  > knows get/setaffinity. Prototypes of glibc:
>  >=20
>  > extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
>  >                                         size_t __cpusetsize,
>  >                                         __const cpu_set_t *__cpuset)=

>  > __THROW;
>  > extern int pthread_attr_getaffinity_np (__const pthread_attr_t *__at=
tr,
>  >                                         size_t __cpusetsize,
>  >                                         cpu_set_t *__cpuset) __THROW=
;
>  >=20
>=20
> Could you try the attached patch ?
>=20

Takes me further, now stops like this:

if ../../gcic/gcic -DHAVE_CONFIG_H -I.
-I../../../../xenomai/sim/skins/posix -I../../include  -D_GNU_SOURCE
-D__IN_XENO__ --gcic-backend=3D/usr/src/xenomai/inst//libexec/gcic
--skin-code  -I../../../../xenomai/sim/../ksrc/skins
-I../../../../xenomai/sim/../include
-I../../../../xenomai/sim/skins/posix/..   -g -MT timer.o -MD -MP -MF
".deps/timer.Tpo" -c -o timer.o
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c; \
then mv -f ".deps/timer.Tpo" ".deps/timer.Po"; else rm -f
".deps/timer.Tpo"; exit 1; fi
In file included from /usr/include/sys/types.h:270,
                 from ../../../../xenomai/sim/../include/nucleus/types.h:=
32,
                 from ../../../../xenomai/sim/../include/nucleus/queue.h:=
24,
                 from ../../../../xenomai/sim/../include/nucleus/timer.h:=
23,
                 from
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c:24:
/usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/union that
defines no instances
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
`pse51_timer_create':
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c:186: warning:
assignment makes pointer from integer without a cast
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
`pse51_timer_delete':
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c:223: array subscrip=
t
is not an integer
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
`pse51_timer_settime':
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c:344: array subscrip=
t
is not an integer
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
`pse51_timer_gettime':
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c:437: array subscrip=
t
is not an integer
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
`pse51_timer_getoverrun':
=2E./../../../xenomai/sim/../ksrc/skins/posix/timer.c:485: array subscrip=
t
is not an integer

>  > Moreover, I get tons of this warning:
>  >=20
>  > /usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/union t=
hat
>  > defines no instances
>  >=20
>  > But this is an "imported" issue, isn't it? Likely due to some picky =
gcc
>  > switch during the simulator build.
>=20
> It depends on what is defined at line 69 of pthreadtypes.h...
>=20

typedef union
{
  struct __pthread_mutex_s
  {
    int __lock;
    unsigned int __count;
    int __owner;
    /* KIND must stay at this position in the structure to maintain
       binary compatibility.  */
    int __kind;
    unsigned int __nusers;
    __extension__ union
    {
      int __spins;
      __pthread_slist_t __list;
    };				/* >>> line 69 <<< */
  } __data;
  char __size[__SIZEOF_PTHREAD_MUTEX_T];
  long int __align;
} pthread_mutex_t;


Jan


--------------enigFAE3541E6F16AAE3885AE0B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEeHGOniDOoMHTA+kRAtuLAJ9fhvyXQRprlQxKdRS9P2jtTMs0yQCbBwyb
Y9fNcDEVn2uqvBe4P+SLbAY=
=Dwhs
-----END PGP SIGNATURE-----

--------------enigFAE3541E6F16AAE3885AE0B9--

