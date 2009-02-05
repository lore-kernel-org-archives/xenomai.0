Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Feb 2009 16:10:38 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F704347@domain.hid>
From: "Mike McTernan" <mmcternan@domain.hid>
Subject: [Xenomai-help] lib order fails for xeno-config --posix-ldflags on
	Blackfin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

Checking xeno-config.in from 2.4.1, it has the following:

XENO_POSIX_LDFLAGS=3D"-L${staging}${libdir} -lpthread_rt -lpthread -lrt
@XENO_USER_APP_LDFLAGS@"

On Blackfin uClinux 2008R1.5 linking fails with -lpthread_rt and
-lpthread in that order:

bfin-uclinux-gcc -I/usr/xenomai/include -I/usr/xenomai/include/posix
-D_GNU_SOURCE -D_REENTRANT -D__XENO__ -o hello hello.o
-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt
-lpthread -lrt
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
make: *** [hello] Error 1

It looks like the uClinux pthread implementation makes use of its own
functions and hence needs the library containing the wrappers specified
after the pthread lib to enable resolving of references, as per the ld
manual:

"Normally, an archive is searched only once in the order that it is
specified on the command line. If a symbol in that archive is needed to
resolve an undefined symbol referred to by an object in an archive that
appears later on the command line, the linker would not be able to
resolve that reference."

I'd have thought there are potentially some circular dependencies
between the pthread and pthread_rt libs.  Would it help portability to
surround these options with -Wl,--start-group <libs> -Wl,--end-group?
i.e.

XENO_POSIX_LDFLAGS=3D"-L${staging}${libdir} -Wl,--start-group =
-lpthread_rt
-lpthread -Wl,--end-group -lrt @XENO_USER_APP_LDFLAGS@"

I've done this locally and I can build the apps without re-ordering the
libraries.

Regards,

Mike

