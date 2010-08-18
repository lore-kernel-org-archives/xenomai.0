From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <4C6BBD62.3050907@domain.hid>
References: <1282047938.5255.89.camel@domain.hid>
	<4C6B146D.9010004@domain.hid>
	<1282126974.5255.262.camel@domain.hid>
	<4C6BBD62.3050907@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 18 Aug 2010 13:40:17 +0200
Message-Id: <1282131617.5255.286.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2010-08-18 at 13:00 +0200, Gilles Chanteperdrix wrote:
> Krzysztof Błaszkowski wrote:
> > On Wed, 2010-08-18 at 00:59 +0200, Gilles Chanteperdrix wrote:
> >> - I have not really checked your user-space compilation flags, I am
> >> using xeno-config to get the correct ones.
> > 
> > xeno-config --skin=native --cflags gives:
> > 
> > -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__
> > 
> > 
> > note that there is no xenomai installed on my r&d server
> > in /usr/xenomai/
> > 
> > i build xenomai per kernel and install it in kernel's INSTALL sub-dir
> > (DESTDIR=) as well as kernel's modules and other related stuff for this
> > particular kernel.
> > (otherwise i would go mad soon due to various versions ..)
> 
> xeno-config handles the DESTDIR environment variable (failing to do this
> would be kind of silly, because a lot of people, including the
> maintainers, use Xenomai mostly in cross-compiled environment).

no, it does not.

./xeno-config
xeno-config --verbose
        --version="2.5.4"
        --cc="gcc"
        --arch="x86"
        --prefix="/usr/xenomai"
        --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-Wall -pipe -D__XENO__"
        --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread "
        --posix-cflags=""
POSIX support is not available
        --posix-ldflags=""
        --library-dir="/usr/xenomai/lib"
Usage xeno-config --skin=skinname OPTIONS
Options :
        --help
        --v,--verbose
        --version
        --cc
        --arch
        --prefix
        --skin native|posix|psos|rtai|rtdm|uitron|vrtx|vxworks
        --cflags
        --ldflags
        --lib*-dir,--libdir,--user-libdir

Deprecated options:
        --xeno-cflags
        --xeno-ldflags
        --posix-cflags
        --posix-ldflags


while it was built like this:

make DESTDIR=/root/... install



> 
> > xeno-config --skin=native --ldflags gives:
> > 
> > -lnative -L/usr/xenomai/lib -lxenomai -lpthread
> > 
> > and indeed i missed libpthread but otoh userland without pthread even
> > does not depend directly on pthreads:
> > 
> > ldd xeno-shmem-fork
> > 	linux-gate.so.1 =>  (0xffffe000)
> > 	libnative.so.3 => not found
> > 	libxenomai.so.0 => not found
> > 	libc.so.6 => /lib/libc.so.6 (0xf7da5000)
> > 	/lib/ld-linux.so.2 (0xf7f10000)
> > 
> > when compiled without pthreads.
> 
> libnative depends on pthread, if ldd had been able to find libnative, it
>  would have found the dependency on libpthread.


but there is still a difference in xeno-shmem-fork behavior when linked
with pthread or not from command line.


> 
> 
> >> - your user-space code was missing #include <unistd.h>
> > 
> > i added. it changed nothing.
> 
> Ok, with all other changes I assume?

i added them and tried incrementally but final source/makefile have all
these features.

> 
> >> - some subtle difference in the glibc
> > 
> > hmm, i'd say that is rather out my control. i use by default opensuse
> > for r&d.
> > 
> > does this mean that this distro is broken ?
> > 
> > (otoh many things are - especially gnome)
> 
> What version of opensuse?

11.1 - 32. i do not crosscompile on x86_64 to x86 because i have
encountered various strange mismatches in the past.

rather i use native clean x86 environment (on e.g. x86_64)


>  If several toolchains are available, which one
> are you using?

i use default only. (and i think there is only one)
gcc -v gives:

Using built-in specs.
Target: i586-suse-linux
Configured with: ../configure --prefix=/usr --infodir=/usr/share/info
--mandir=/usr/share/man --libdir=/usr/lib --libexecdir=/usr/lib
--enable-languages=c,c++,objc,fortran,obj-c++,java,ada
--enable-checking=release --with-gxx-include-dir=/usr/include/c++/4.3
--enable-ssp --disable-libssp --with-bugurl=http://bugs.opensuse.org/
--with-pkgversion='SUSE Linux' --disable-libgcj --disable-libmudflap
--with-slibdir=/lib --with-system-zlib --enable-__cxa_atexit
--enable-libstdcxx-allocator=new --disable-libstdcxx-pch
--enable-version-specific-runtime-libs --program-suffix=-4.3
--enable-linux-futex --without-system-libunwind --with-cpu=generic
--build=i586-suse-linux
Thread model: posix
gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux)

>  I do not mean to say that the glibc is broken, only that
> xenomai could use it in a way that breaks with the version you are using.

maybe, let's investigate this further.

> 
> >> In any case, without further information, it is hard for me to dig any
> >> further tonight. Regards.
> > 
> > i see. want you me to send .config file ? anything else ?
> 
> Run cat /proc/ipipe/version /proc/xenomai/version, uname and "getconf
> GNU_LIBPTHREAD_VERSION" on the target, in order to get sure that you run
> the versions you think you are running. Then please send your .config.
> 
> Please also send a full kernel log, from the boot, up to the bug.
> 

welcome.
 cat /proc/ipipe/version 
2.4-09
atest:~/xeno-test-254 # cat /proc/xenomai/version 
2.5.4
atest:~/xeno-test-254 # getconf
bash: getconf: command not found
atest:~/xeno-test-254 # getconf GNU_LIBPTHREAD_VERSION
NPTL 2.9
atest:~/xeno-test-254 # uname -a
Linux atest 2.6.31.8-xeno254 #1 Tue Aug 17 17:48:32 CEST 2010 i686 i686
i386 GNU/Linux
atest:~/xeno-test-254 # 

-- 
Krzysztof Blaszkowski


