Message-ID: <4C6BBD62.3050907@domain.hid>
Date: Wed, 18 Aug 2010 13:00:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282047938.5255.89.camel@domain.hid>	
	<4C6B146D.9010004@domain.hid>
	<1282126974.5255.262.camel@domain.hid>
In-Reply-To: <1282126974.5255.262.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?UTF-8?B?S3J6eXN6dG9mIELFgmFzemtvd3NraQ==?= <kb@domain.hid>
Cc: xenomai@xenomai.org

Krzysztof B=C5=82aszkowski wrote:
> On Wed, 2010-08-18 at 00:59 +0200, Gilles Chanteperdrix wrote:
>> - I have not really checked your user-space compilation flags, I am
>> using xeno-config to get the correct ones.
>=20
> xeno-config --skin=3Dnative --cflags gives:
>=20
> -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO_=
_
>=20
>=20
> note that there is no xenomai installed on my r&d server
> in /usr/xenomai/
>=20
> i build xenomai per kernel and install it in kernel's INSTALL sub-dir
> (DESTDIR=3D) as well as kernel's modules and other related stuff for th=
is
> particular kernel.
> (otherwise i would go mad soon due to various versions ..)

xeno-config handles the DESTDIR environment variable (failing to do this
would be kind of silly, because a lot of people, including the
maintainers, use Xenomai mostly in cross-compiled environment).

> xeno-config --skin=3Dnative --ldflags gives:
>=20
> -lnative -L/usr/xenomai/lib -lxenomai -lpthread
>=20
> and indeed i missed libpthread but otoh userland without pthread even
> does not depend directly on pthreads:
>=20
> ldd xeno-shmem-fork
> 	linux-gate.so.1 =3D>  (0xffffe000)
> 	libnative.so.3 =3D> not found
> 	libxenomai.so.0 =3D> not found
> 	libc.so.6 =3D> /lib/libc.so.6 (0xf7da5000)
> 	/lib/ld-linux.so.2 (0xf7f10000)
>=20
> when compiled without pthreads.

libnative depends on pthread, if ldd had been able to find libnative, it
 would have found the dependency on libpthread.


>> - your user-space code was missing #include <unistd.h>
>=20
> i added. it changed nothing.

Ok, with all other changes I assume?

>> - some subtle difference in the glibc
>=20
> hmm, i'd say that is rather out my control. i use by default opensuse
> for r&d.
>=20
> does this mean that this distro is broken ?
>=20
> (otoh many things are - especially gnome)

What version of opensuse? If several toolchains are available, which one
are you using? I do not mean to say that the glibc is broken, only that
xenomai could use it in a way that breaks with the version you are using.=


>> In any case, without further information, it is hard for me to dig any=

>> further tonight. Regards.
>=20
> i see. want you me to send .config file ? anything else ?

Run cat /proc/ipipe/version /proc/xenomai/version, uname and "getconf
GNU_LIBPTHREAD_VERSION" on the target, in order to get sure that you run
the versions you think you are running. Then please send your .config.

Please also send a full kernel log, from the boot, up to the bug.

--=20
					    Gilles.


