MIME-Version: 1.0
In-Reply-To: <49A51C3D.1020705@domain.hid>
References: <a0e7fce50902240018g6be57617g2c5f14c55685ef24@domain.hid>
	<49A4209F.60502@domain.hid>
	<a0e7fce50902242022y2c6304c9lca98e6d981aa4251@domain.hid>
	<49A51C3D.1020705@domain.hid>
Date: Thu, 26 Feb 2009 14:21:19 +0800
Message-ID: <a0e7fce50902252221x28c4b394j56803eaab0460f7b@domain.hid>
From: yi li <liyi.dev@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] blackfin: build xenomai in FLAT format
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
Cc: Xenomai-core@domain.hid

On Wed, Feb 25, 2009 at 6:23 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> yi li wrote:
>> On Wed, Feb 25, 2009 at 12:30 AM, Philippe Gerum <rpm@xenomai.org> wrote=
:
>>>> 2. =A0libpthread_rt.la should not depend on "lpthread".
>>>>
>>> Nak. In flat mode, turning the link dependencies order upside down will=
 not buy
>>> us anything. Two-phase link is the only way to prevent circular/invalid
>>> dependencies with a static only format when symbol wrapping is involved=
.
>>>
>>
>> Agree. But "libpthread_rt_la_LDFLAGS" should not include "-lpthread",
>> otherwise libtool will think libpthread_rt.a depends on libpthread.
>> I don't think there is such a dependency, isn't it?
>
> Look at libpthread_rt code.
>

Here is the problem:

/bin/bash ../../../libtool --tag=3DCC   --mode=3Dlink bfin-uclinux-gcc
-pipe -Wall -g -O2      -mcpu=3Dbf527-0.1
-Wl,@/home/adam/new_workspace/local_svn/kernel/adeos/uclinux-dist/user/xeno=
mai/xenomai-2.4.x/src/skins/posix/posix.wrappers
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -Wl,-elf2flt    -mcpu=3Dbf527-0.1
-o cyclictest cyclictest-cyclictest.o -lpthread -lrt
../../skins/posix/libpthread_rt.la
mkdir .libs
bfin-uclinux-gcc -pipe -Wall -g -O2 -mcpu=3Dbf527-0.1
-Wl,@/home/adam/new_workspace/local_svn/kernel/adeos/uclinux-dist/user/xeno=
mai/xenomai-2.4.x/src/skins/posix/posix.wrappers
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -Wl,-elf2flt -mcpu=3Dbf527-0.1 -o
cyclictest cyclictest-cyclictest.o  -lrt
../../skins/posix/.libs/libpthread_rt.a -lpthread
/home/adam/workspace/toolchain/4.1-1220/bfin-uclinux/bin/../bfin-uclinux/ru=
ntime/usr/lib/libpthread.a(manager.o):
In function `__pthread_manager':
libpthread/linuxthreads.old/manager.c:173: undefined reference to
`___wrap_select'
/home/adam/workspace/toolchain/4.1-1220/bfin-uclinux/bin/../bfin-uclinux/ru=
ntime/usr/lib/libpthread.a(mutex.o):
In function `__pthread_once_fork_child':
libpthread/linuxthreads.old/mutex.c:357: undefined reference to
`___wrap_pthread_cond_init'
/home/adam/workspace/toolchain/4.1-1220/bfin-uclinux/bin/../bfin-uclinux/ru=
ntime/usr/lib/libpthread.a(mutex.o):
In function `__pthread_once':
libpthread/linuxthreads.old/mutex.c:308: undefined reference to
`___wrap_pthread_cond_wait'
libpthread/linuxthreads.old/mutex.c:325: undefined reference to
`___wrap_pthread_cond_broadcast'
/home/adam/workspace/toolchain/4.1-1220/bfin-uclinux/bin/../bfin-uclinux/ru=
ntime/usr/lib/libpthread.a(mutex.o):
In function `pthread_once_cancelhandler':
libpthread/linuxthreads.old/mutex.c:281: undefined reference to
`___wrap_pthread_cond_broadcast'
collect2: ld returned 1 exit status

In my opinion,  "-lpthread" does not need to be set in
"libpthread_rt_la_LDFLAGS". The application (e.g, cyclictest) decides
which libraries to link with.

-Yi

