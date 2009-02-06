Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 6 Feb 2009 12:48:58 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F70443C@ukmail.uk.wirelessworld.airvananet.com>
In-Reply-To: <498C0EBE.5000004@domain.hid>
References: <4B3F8896E1733D4787DDB0EA1C7FF91F704347@domain.hid>
	<498C0EBE.5000004@domain.hid>
From: "Mike McTernan" <mmcternan@domain.hid>
Subject: Re: [Xenomai-help] lib order fails for xeno-config --posix-ldflags
	on	Blackfin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
>=20
> Mike McTernan wrote:
> > Hi,
> >
> > Checking xeno-config.in from 2.4.1, it has the following:
> >
>=20
> Please upgrade. The Xenomai/blackfin port is actively maintained, and
bugs
> have been fixed since then.

Apologies - I mistyped.  I checked 2.4.6.1.

> > XENO_POSIX_LDFLAGS=3D"-L${staging}${libdir} -lpthread_rt -lpthread
-lrt
> > @XENO_USER_APP_LDFLAGS@"
> >
> > On Blackfin uClinux 2008R1.5 linking fails with -lpthread_rt and
> > -lpthread in that order:
> >
> > bfin-uclinux-gcc -I/usr/xenomai/include -I/usr/xenomai/include/posix
>=20
> This should rather be bfin-linux-uclibc-gcc to produce fdpic binaries;
> bfin-uclinux-gcc should be used to build the ELF kernel or FLAT format
> apps.
> Xenomai user-space support should be built using
bfin-linux-uclibc-gcc.

For various reasons we build all our apps as FLAT or ZFLAT, hence use
bfin-uclinux-gcc -Wl,-elf2flt to link, which I think is common for
embedded. =20

I presumed the binary format doesn't matter to Xenomai - is FLAT
supported?

> > -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -o hello hello.o
> > -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt
> > -lpthread -lrt
> >
/opt/uClinux/bfin-uclinux/bfin-uclinux/runtime/usr/lib/libpthread.a(mute
> > x.os): In function `__pthread_once_fork_child':
> > libpthread/linuxthreads.old/mutex.c:357: undefined reference to
> > `___wrap_pthread_cond_init'
> >
/opt/uClinux/bfin-uclinux/bfin-uclinux/runtime/usr/lib/libpthread.a(mute
> > x.os): In function `__pthread_once':
> > libpthread/linuxthreads.old/mutex.c:308: undefined reference to
> > `___wrap_pthread_cond_wait'
<snip>
> >
> > It looks like the uClinux pthread implementation makes use of its
own
> > functions and hence needs the library containing the wrappers
specified
> > after the pthread lib to enable resolving of references, as per the
ld
> > manual:
> >
> > "Normally, an archive is searched only once in the order that it is
> > specified on the command line. If a symbol in that archive is needed
to
> > resolve an undefined symbol referred to by an object in an archive
that
> > appears later on the command line, the linker would not be able to
> > resolve that reference."
> >
> > I'd have thought there are potentially some circular dependencies
> > between the pthread and pthread_rt libs.  Would it help portability
to
> > surround these options with -Wl,--start-group <libs>
-Wl,--end-group?
> > i.e.
> >
> > XENO_POSIX_LDFLAGS=3D"-L${staging}${libdir} -Wl,--start-group
-lpthread_rt
> > -lpthread -Wl,--end-group -lrt @XENO_USER_APP_LDFLAGS@"
> >
> > I've done this locally and I can build the apps without re-ordering
the
> > libraries.
> >
>=20
> Which is likely not going to run properly. uClibc does not want to
call
> the
> Xenomai wrappers from its internal code, but its own code, because it
> should
> apply to regular linuxthreads, not Xenomai-enabled RT threads. The
only
> sane way
> to solve this kind of dependencies properly would be to go for a
two-stage
> linking phase, i.e. first you do a partial link with your app and the
> Xenomai
> libraries applying the wrappers
(-Wl,@/usr/xenomai/lib/posix.wrappers),
> then you
> complete the link without any wrapping against libpthread.so.

I think you are using ELF, so maybe you don't see the problem - the
dynamic linker maybe patching up the internal pthread references?  I'm
using FLAT, which is essentially a static link, so everything has to be
fully resolved.

While I'm not familiar with the internals of Xenomai, I'd have thought
that intercepting the internal call would be inefficient, but not
harmful.  Presumably we end up in the normal pthread lib because the
calling thread has no Xenomai context.  When the wrapper is called from
pthread internally, it should always find there is no Xenomai-thread
context for the caller and hence go back into the normal pthread lib.
FWIW the compiled test app runs and produces the expected behaviour,
although is too trivial to be a thorough test. =20

> Here is a trivial Makefile I have just used to produce an executable
> against 2008-r1.5-rc3 and 2.4.1, without any problem. Obviously this=20
> also depends on the references dragged in by your example code; mine
> was pulling condvar, mutex and thread support through the common=20
> pthread_* calls. If this simple Makefile does not work with a properly

> built Xenomai userland support, I'd be interested to see your example=20
> code. TIA,
>=20
> X :=3D /usr/xenomai/blackfin
> CFLAGS :=3D $(shell $(X)/bin/xeno-config --posix-cflags)
> LDFLAGS :=3D $(shell $(X)/bin/xeno-config --posix-ldflags)
> CC :=3D  $(shell $(X)/bin/xeno-config --cc)
>=20
> all: hello
>=20
> hello: hello.c
> 	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
>=20
> clean:
> 	$(RM) hello
>=20

Unfortunately this does not link either (note I added -Wl,-elf2flt).
Here's the program I am trying to compile, the compile output, and the
xeno-config output:

#include <stdio.h>
#include <sys/mman.h>
#include <pthread.h>

void *demo(void *arg)
{
  printf("Hello world\n");
}

int main(int argc, char* argv[])
{
    pthread_t tid;

    mlockall(MCL_CURRENT | MCL_FUTURE);
    pthread_create(&tid, NULL, demo, NULL);
    sleep(1);
    return 0;
}

$ make
bfin-uclinux-gcc -o hello hello.c -I/usr/xenomai/include
-I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__
-Wl,-elf2flt -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib
-lpthread_rt -lpthread -lrt
/opt/uClinux/bfin-uclinux/bfin-uclinux/runtime/usr/lib/libpthread.a(mute
x.os): In function `__pthread_once_fork_child':
libpthread/linuxthreads.old/mutex.c:357: undefined reference to
`___wrap_pthread_cond_init'
/opt/uClinux/bfin-uclinux/bfin-uclinux/runtime/usr/lib/libpthread.a(mute
x.os): In function `__pthread_once':
libpthread/linuxthreads.old/mutex.c:308: undefined reference to
`___wrap_pthread_cond_wait'
libpthread/linuxthreads.old/mutex.c:325: undefined reference to
`___wrap_pthread_cond_broadcast'
/opt/uClinux/bfin-uclinux/bfin-uclinux/runtime/usr/lib/libpthread.a(mute
x.os): In function `pthread_once_cancelhandler':
libpthread/linuxthreads.old/mutex.c:281: undefined reference to
`___wrap_pthread_cond_broadcast'
collect2: ld returned 1 exit status
make: *** [hello] Error 1=20

$ /usr/xenomai/bin/xeno-config
xeno-config --verbose
    --version=3D"2.4.0"
    --cc=3D"bfin-uclinux-gcc"
    --arch=3D"blackfin"
    --prefix=3D"/usr/xenomai"
    --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__"
    --xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread "
    --posix-cflags=3D"-I/usr/xenomai/include =
-I/usr/xenomai/include/posix
-D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags=3D"-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt"
    --library-dir=3D"/usr/xenomai/lib"
Usage xeno-config OPTIONS
Options :
        --help
        --v,--verbose
        --version
        --cc
        --arch
        --prefix
        --xeno-cflags
        --xeno-ldflags
        --posix-cflags
        --posix-ldflags
        --lib*-dir,--libdir,--user-libdir

Regards,

Mike

