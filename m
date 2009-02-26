Message-ID: <49A67901.60506@domain.hid>
Date: Thu, 26 Feb 2009 12:12:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <a0e7fce50902240018g6be57617g2c5f14c55685ef24@domain.hid>	
	<49A4209F.60502@domain.hid>	
	<a0e7fce50902242022y2c6304c9lca98e6d981aa4251@domain.hid>	
	<49A51C3D.1020705@domain.hid>	
	<a0e7fce50902252221x28c4b394j56803eaab0460f7b@domain.hid>	
	<49A66CF6.7050405@domain.hid>
	<a0e7fce50902260256o49ab88fcmbe6269b67b92aa5f@domain.hid>
In-Reply-To: <a0e7fce50902260256o49ab88fcmbe6269b67b92aa5f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] blackfin: build xenomai in FLAT format
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yi li <liyi.dev@domain.hid>
Cc: Xenomai-core@domain.hid

yi li wrote:
> On Thu, Feb 26, 2009 at 6:20 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> -lpthread does need to be set in libpthread_rt_la_LDFLAGS, if you look
>> at libpthread_rt code (which you apparently do not want to dot), you
>> will see that it uses libpthread functions.
> 
> Thanks for the detailed explanation. And I did read libpthread_rt code ;).
> However, my point is _not_  putting "-lpthread" before or after
> "libpthread_rt.a". My point is, is it reasonable to put "-lpthread" in
> the LDFLAGS of libpthread_rt.a?
> 
>> The issue you have has already been discussed on this list, and we
>> already know the correct workaround. The correct workaround is not to
>> link with -lpthread first. Linking with -lpthread first leads to broken
>> binaries, whose libpthread functions call libpthread_rt functions. The
>> correct workaround is to link your binary in two stages, or to forget
>> about FLAT and use FDPIC.
> 
> In my option, a better workaround is to group the achieves, with
> "--start-group", "--end-group":
> 
> bfin-uclinux-gcc -pipe -Wall -g -O2 -mcpu=bf527-0.1
> -Wl,@/home/adam/new_workspace/local_svn/kernel/adeos/uclinux-dist/user/xenomai/xenomai-2.4.x/src/skins/posix/posix.wrappers
> -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -Wl,-elf2flt -mcpu=bf527-0.1 -o
> cyclictest cyclictest-cyclictest.o  -lrt -Wl,--start-group
> ../../skins/posix/.libs/libpthread_rt.a -lpthread -Wl,--end-group
>

Yi, the point is about our use of the --wrap linker directive for linking POSIX
apps. If we go for the start/end group scheme, then we will end up having
libpthread wrongly use our wrapped libpthread calls from libpthread_rt, which is
going to break the application badly. This is the other way around: our wrappers
may want to use libpthread.

We just cannot let the linker pick whatever symbol it sees fit to resolve the
references, it is not a dependency order issue that start/end group would indeed
solve. When using a static link format, we have to make sure to resolve the
references the applications makes to libpthread_rt first, then, and only after
that, finalize the link with libpthread, because both the application and
libpthread_rt have dependencies on libpthread.

This is why we are talking about "two-phase" link for static mode. In fact,
fixing the issue your reported would require to implement two-phase link
conditionally in our Makefiles producing POSIX binaries, to be used when FLAT
format is wanted. This is doable, but requires a bit more work than just
reordering or removing dependencies on libpthread.

> -Yi
> 


-- 
Philippe.

