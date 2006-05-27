Message-ID: <447878E8.6060509@domain.hid>
Date: Sat, 27 May 2006 18:06:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [sim] ... doesn't build
References: <44786C8F.9070201@domain.hid>	<17528.28463.599578.54637@domain.hid>	<4478718E.1010704@domain.hid>
	<17528.29962.534628.683176@domain.hid>
In-Reply-To: <17528.29962.534628.683176@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC832D02EAF474190BE09EABA"
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
--------------enigC832D02EAF474190BE09EABA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > Hi,
>  > >  >=20
>  > >  > I just tried to get the simulator from trunk built but failed h=
ere:
>  > >  >=20
>  > >  > In file included from ../../../../xenomai/sim/../include/posix/=
posix.h:29,
>  > >  >                  from
>  > >  > ../../../../xenomai/sim/../ksrc/skins/posix/internal.h:24,
>  > >  >                  from
>  > >  > ../../../../xenomai/sim/../ksrc/skins/posix/thread.h:23,
>  > >  >                  from
>  > >  > ../../../../xenomai/sim/../ksrc/skins/posix/sched.c:48:
>  > >  > ../../../../xenomai/sim/../include/posix/pthread.h:246: conflic=
ting
>  > >  > types for `pthread_attr_getaffinity_np'
>  > >  > /usr/include/pthread.h:383: previous declaration of
>  > >  > `pthread_attr_getaffinity_np'
>  > >  > ../../../../xenomai/sim/../include/posix/pthread.h:249: conflic=
ting
>  > >  > types for `pthread_attr_setaffinity_np'
>  > >  > /usr/include/pthread.h:377: previous declaration of
>  > >  > `pthread_attr_setaffinity_np'
>  > >  >=20
>  > >  > Looks like glibc-2.4 (that one comes with my opensuse 10.1) now=
 also
>  > >  > knows get/setaffinity. Prototypes of glibc:
>  > >  >=20
>  > >  > extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,=

>  > >  >                                         size_t __cpusetsize,
>  > >  >                                         __const cpu_set_t *__cp=
uset)
>  > >  > __THROW;
>  > >  > extern int pthread_attr_getaffinity_np (__const pthread_attr_t =
*__attr,
>  > >  >                                         size_t __cpusetsize,
>  > >  >                                         cpu_set_t *__cpuset) __=
THROW;
>  > >  >=20
>  > >=20
>  > > Could you try the attached patch ?
>  > >=20
>  >=20
>  > Takes me further, now stops like this:
>  >=20
>  > if ../../gcic/gcic -DHAVE_CONFIG_H -I.
>  > -I../../../../xenomai/sim/skins/posix -I../../include  -D_GNU_SOURCE=

>  > -D__IN_XENO__ --gcic-backend=3D/usr/src/xenomai/inst//libexec/gcic
>  > --skin-code  -I../../../../xenomai/sim/../ksrc/skins
>  > -I../../../../xenomai/sim/../include
>  > -I../../../../xenomai/sim/skins/posix/..   -g -MT timer.o -MD -MP -M=
F
>  > ".deps/timer.Tpo" -c -o timer.o
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c; \
>  > then mv -f ".deps/timer.Tpo" ".deps/timer.Po"; else rm -f
>  > ".deps/timer.Tpo"; exit 1; fi
>  > In file included from /usr/include/sys/types.h:270,
>  >                  from ../../../../xenomai/sim/../include/nucleus/typ=
es.h:32,
>  >                  from ../../../../xenomai/sim/../include/nucleus/que=
ue.h:24,
>  >                  from ../../../../xenomai/sim/../include/nucleus/tim=
er.h:23,
>  >                  from
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:24:
>  > /usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/union t=
hat
>  > defines no instances
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
>  > `pse51_timer_create':
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:186: warning:
>  > assignment makes pointer from integer without a cast
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
>  > `pse51_timer_delete':
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:223: array subsc=
ript
>  > is not an integer
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
>  > `pse51_timer_settime':
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:344: array subsc=
ript
>  > is not an integer
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
>  > `pse51_timer_gettime':
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:437: array subsc=
ript
>  > is not an integer
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c: In function
>  > `pse51_timer_getoverrun':
>  > ../../../../xenomai/sim/../ksrc/skins/posix/timer.c:485: array subsc=
ript
>  > is not an integer
>=20
> Looks like timer_t is no longer an integer type, try the attached patch=
=2E
>=20

Thanks, works now.

>  >=20
>  > >  > Moreover, I get tons of this warning:
>  > >  >=20
>  > >  > /usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/un=
ion that
>  > >  > defines no instances
>  > >  >=20
>  > >  > But this is an "imported" issue, isn't it? Likely due to some p=
icky gcc
>  > >  > switch during the simulator build.
>  > >=20
>  > > It depends on what is defined at line 69 of pthreadtypes.h...
>  > >=20
>  >=20
>  > typedef union
>  > {
>  >   struct __pthread_mutex_s
>  >   {
>  >     int __lock;
>  >     unsigned int __count;
>  >     int __owner;
>  >     /* KIND must stay at this position in the structure to maintain
>  >        binary compatibility.  */
>  >     int __kind;
>  >     unsigned int __nusers;
>  >     __extension__ union
>  >     {
>  >       int __spins;
>  >       __pthread_slist_t __list;
>  >     };				/* >>> line 69 <<< */
>  >   } __data;
>  >   char __size[__SIZEOF_PTHREAD_MUTEX_T];
>  >   long int __align;
>  > } pthread_mutex_t;
>=20
> Looking at gcc 2.95 documentation, it seems that unname unions are not
> supported.
>=20

Probably not critical for the simulator, as it doesn't make use of the
involved fields, does it?

Jan


--------------enigC832D02EAF474190BE09EABA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEeHjoniDOoMHTA+kRAuFZAJ4hS66FnRiKoyZr19Qvo7IfAtO1twCfcuix
kDejFH1YeRkiom93DoG0YzY=
=Kbie
-----END PGP SIGNATURE-----

--------------enigC832D02EAF474190BE09EABA--

