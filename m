MIME-Version: 1.0
In-Reply-To: <49A66CF6.7050405@domain.hid>
References: <a0e7fce50902240018g6be57617g2c5f14c55685ef24@domain.hid>
	<49A4209F.60502@domain.hid>
	<a0e7fce50902242022y2c6304c9lca98e6d981aa4251@domain.hid>
	<49A51C3D.1020705@domain.hid>
	<a0e7fce50902252221x28c4b394j56803eaab0460f7b@domain.hid>
	<49A66CF6.7050405@domain.hid>
Date: Thu, 26 Feb 2009 18:56:59 +0800
Message-ID: <a0e7fce50902260256o49ab88fcmbe6269b67b92aa5f@domain.hid>
From: yi li <liyi.dev@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

On Thu, Feb 26, 2009 at 6:20 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> -lpthread does need to be set in libpthread_rt_la_LDFLAGS, if you look
> at libpthread_rt code (which you apparently do not want to dot), you
> will see that it uses libpthread functions.

Thanks for the detailed explanation. And I did read libpthread_rt code ;).
However, my point is _not_  putting "-lpthread" before or after
"libpthread_rt.a". My point is, is it reasonable to put "-lpthread" in
the LDFLAGS of libpthread_rt.a?

>
> The issue you have has already been discussed on this list, and we
> already know the correct workaround. The correct workaround is not to
> link with -lpthread first. Linking with -lpthread first leads to broken
> binaries, whose libpthread functions call libpthread_rt functions. The
> correct workaround is to link your binary in two stages, or to forget
> about FLAT and use FDPIC.

In my option, a better workaround is to group the achieves, with
"--start-group", "--end-group":

bfin-uclinux-gcc -pipe -Wall -g -O2 -mcpu=bf527-0.1
-Wl,@/home/adam/new_workspace/local_svn/kernel/adeos/uclinux-dist/user/xenomai/xenomai-2.4.x/src/skins/posix/posix.wrappers
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -Wl,-elf2flt -mcpu=bf527-0.1 -o
cyclictest cyclictest-cyclictest.o  -lrt -Wl,--start-group
../../skins/posix/.libs/libpthread_rt.a -lpthread -Wl,--end-group

-Yi

