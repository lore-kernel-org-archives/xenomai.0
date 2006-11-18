From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot: Errors building rtnet since at least
	r1834
Date: Sat, 18 Nov 2006 21:16:20 +0100
References: <200611181818.17629.niklaus.giger@domain.hid>
	<455F4A24.8060408@domain.hid>
In-Reply-To: <455F4A24.8060408@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Uo2XFhuZyQnqRe9"
Message-Id: <200611182116.20647.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_Uo2XFhuZyQnqRe9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Samstag, 18. November 2006 19:00 schrieb Jan Kiszka:
> Niklaus Giger wrote:
> > Hi
> >
> > Unfortunately I cannot say since when this build is broken, as I had to
> > reinstall the buildbot on my main server. But this particular build
> > target should not have been affected. (Same compiler, same build slave,
> > same scripts)
> >
> > But since at November 12 I get the following errors in my builds:
> > See http://ngiger.dyndns.org/buildbot-full/tqm_f/builds/0/step-mk_RTnet/1
> > libtool: link: warning: library
> > `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/libpthread_rt.la' was
> > moved.
> > libtool: link: warning: library
> > `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/librtdm.la' was moved.
> > libtool: link: warning: library
> > `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/libpthread_rt.la' was
> > moved.
> > libtool: link: warning: library
> > `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/librtdm.la' was moved.
> >
> > Has anybody a hint, what the reason could be?
>
> DESTDIR issue? Are you compiling both Xenomai and RTnet with the same
> DESTDIR?
Calling manuall make install like the following line did not change the 
result:
DESTDIR=/var/buildbot/install/tqm_q make prefix=/var/buildbot/install/tqm_q 
install 

My steps to compile the xenomai kernel were:
cd /var/buildbot/slave/tqm_q/linux
export CROSS_COMPILE=powerpc-860-linux-gnu- 
make oldconfig
make --jobs=4 uImage modules
make INSTALL_MOD_PATH=/var/buildbot/install/tqm_q modules_install
make DESTDIR=/var/buildbot/install/tqm_q install
cd /var/buildbot/slave/tqm_q/build
../xenomai/configure --host=ppc-linux --enable-debug
make 
cd /var/buildbot/slave/tqm_q/rtnet
./configure --host=powerpc-860-linux-gnu --enable-rtwlan --enable-route-src --enable-net-routing --enable-router --enable-rtcfg-dbg --enable-nomac --enable-rtcap --enable-proxy --enable-examples --enable-checks --enable-fec-enet --enable-scc-enet --with-rtext-config=/var/buildbot/install/tqm_q/usr/xenomai/bin/xeno-config --with-linux=../linux --prefix=/var/buildbot/install/tqm_q 
DESTDIR=/var/buildbot/install/tqm_q
make prefix=/var/buildbot/install/tqm_q install

Is this okay? Or do I have an error here?

Isn't it more the problem that xeno-config since a few weeks ago outputs wrong 
paths (forgets about its DESTDIR when installed). E.g. look at this output of
/var/buildbot/install/tqm_q/usr/xenomai/bin/xeno-config
xeno-config --verbose
    --version="2.2.91"
    --cc="gcc"
    --arch="powerpc"
    --prefix="/usr/xenomai"
    --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT"
    --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
    --posix-cflags="-I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags="-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --library-dir="/usr/xenomai/lib"

I think --xeno-ldflags="-L/usr/xenomai/lib -lpthread " should return
--xeno-ldflags="-L/var/buildbot/install/usr/xenomai/lib -lpthread "


> Check what's stated in those .la files and compare with the RTnet build
> parameters.
*.la files are attached
>
> Jan
>
> PS: This is a *warning*, not a fatal *error*. Or did you just want to
> receive more attention? ;)
Sorry. I forgot to include the line with the real error.

powerpc-860-linux-gnu-gcc -I/var/buildbot/install/tqm_q/usr/xenomai/include -I/var/buildbot/install/tqm_q/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -O2 -fstrict-aliasing -I../../../stack/include -g -Wl,@/var/buildbot/install/tqm_q/usr/xenomai/lib/posix.wrappers -o 
rtt-sender 
rtt-sender.o  -L/var/buildbot/install/tqm_q/usr/xenomai/lib /var/buildbot/install/tqm_q/usr/xenomai/lib/libpthread_rt.so -lrt -lpthread /var/buildbot/install/tqm_q/usr/xenomai/lib/librtdm.so -Wl,--rpath -Wl,/var/buildbot/install/tqm_q/usr/xenomai/lib -Wl,--rpath -Wl,/var/buildbot/install/tqm_q/usr/xenomai/lib
/opt/crosstool/gcc-3.4.1-glibc-2.3.3/powerpc-860-linux-gnu/lib/gcc/powerpc-860-linux-gnu/3.4.1/../../../../powerpc-860-linux-gnu/bin/ld: 
@/var/buildbot/install/tqm_q/usr/xenomai/lib/posix.wrappers: No such file: No 
such file or directory
collect2: ld returned 1 exit status

Best regards

-- 
Niklaus Giger

--Boundary-00=_Uo2XFhuZyQnqRe9
Content-Type: text/plain;
  charset="iso-8859-1";
  name="libpthread_rt.la"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="libpthread_rt.la"

# libpthread_rt.la - a libtool library file
# Generated by ltmain.sh - GNU libtool 1.5.6 (1.1220.2.95 2004/04/11 05:50:42) Debian: 224 $
#
# Please DO NOT delete this file!
# It is necessary for linking the library.

# The name that we can dlopen(3).
dlname='libpthread_rt.so.0'

# Names of this library.
library_names='libpthread_rt.so.0.0.0 libpthread_rt.so.0 libpthread_rt.so'

# The name of the static archive.
old_library='libpthread_rt.a'

# Libraries that this one depends upon.
dependency_libs=' -lpthread'

# Version information for libpthread_rt.
current=0
age=0
revision=0

# Is this an already installed library?
installed=yes

# Should we warn about portability when linking against -modules?
shouldnotlink=no

# Files to dlopen/dlpreopen
dlopen=''
dlpreopen=''

# Directory that this library needs to be installed in:
libdir='/usr/xenomai/lib'

--Boundary-00=_Uo2XFhuZyQnqRe9
Content-Type: text/plain;
  charset="iso-8859-1";
  name="librtdm.la"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="librtdm.la"

# librtdm.la - a libtool library file
# Generated by ltmain.sh - GNU libtool 1.5.6 (1.1220.2.95 2004/04/11 05:50:42) Debian: 224 $
#
# Please DO NOT delete this file!
# It is necessary for linking the library.

# The name that we can dlopen(3).
dlname='librtdm.so.0'

# Names of this library.
library_names='librtdm.so.0.0.0 librtdm.so.0 librtdm.so'

# The name of the static archive.
old_library='librtdm.a'

# Libraries that this one depends upon.
dependency_libs=''

# Version information for librtdm.
current=0
age=0
revision=0

# Is this an already installed library?
installed=yes

# Should we warn about portability when linking against -modules?
shouldnotlink=no

# Files to dlopen/dlpreopen
dlopen=''
dlpreopen=''

# Directory that this library needs to be installed in:
libdir='/usr/xenomai/lib'

--Boundary-00=_Uo2XFhuZyQnqRe9--

