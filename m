Message-ID: <4FF3232E.3050605@xenomai.org>
Date: Tue, 03 Jul 2012 18:51:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfz7+pRjjbE6Ev4zJNZpa45axMePyVar+3MyRyMvcp8aA@mail.gmail.com>	<CAKKWdtfRyuhDzmvCC-WM66+=ncs+ocbdUuop2TRNThsj6ZAy6g@mail.gmail.com>	<4FCF1ED5.5000403@xenomai.org>	<CAKKWdtd6p2-xHH1FdjVzbX-raNtDkvMemALrQBJMgoTb1dScnw@mail.gmail.com>	<4FCF2751.5070700@xenomai.org>	<4FCF4D05.3070502@xenomai.org>	<4FCF58AF.5040106@xenomai.org>	<4FCF5A4C.60704@xenomai.org>	<4FCF5DED.8060007@xenomai.org>	<4FCF60CD.8000709@xenomai.org>	<4FCF6152.7010002@xenomai.org>	<4FCF62DD.10102@xenomai.org>	<4FCF68CA.8010206@xenomai.org>	<4FCF713F.1030603@xenomai.org>	<4FCF7418.4020805@xenomai.org>	<4FCF7576.8030201@xenomai.org>	<4FCF9A1E.6090706@xenomai.org>	<4FCF9AAD.7020707@xenomai.org>	<4FD1C3EE.1000005@xenomai.org>	<4FD1C50D.5010906@xenomai.org>	<4FD1C60D.401@xenomai.org>	<4FD1C67E.5010600@xenomai.org>	<4FD1C751.5070501@xenomai.org>	<CAKKWdtdebEv14pJhTvr1qc7u3zTzjCPgZZu6h8k1nnrGnpHNdw@mail.gmail.com>
	<CAHue_TUHtzKZ6g1__=jB-y08TRnnZ93t2zY8+C-MAWy7QhH=Pg@mail.gmail.com>
In-Reply-To: <CAHue_TUHtzKZ6g1__=jB-y08TRnnZ93t2zY8+C-MAWy7QhH=Pg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai-2.6.0 instrumentation commands not executing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWFyY2luIEt1xZtrYQ==?= <marckuska@gmail.com>
Cc: xenomai@xenomai.org

On 07/03/2012 06:01 PM, Marcin Kuśka wrote:
> I will continue this topic since my problem looks similar.
> 
> I'm using linux kernel from *http://git.xenomai.org/ipipe-gch.git/* (ipipe
> core-3.2 ) and xenomai 2.6 branch head. Compiling for versatile express
> cortex-a9.
> I tried to cross-compile a simple program bound_task (can be found in
> documentation as example) but i received this:
> 
> *arm-unknown-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE
> -D_REENTRANT -D__XENO__ -lnative -L/usr/xenomai/lib -lxenomai -lpthread
> -lrt -lrtdk bound_task.c -o bound_task_VEXPRESS
> In file included from /usr/xenomai/include/nucleus/trace.h:52,
>                  from /usr/xenomai/include/nucleus/system.h:27,
>                  from /usr/xenomai/include/asm/xenomai/system_64.h:137,
>                  from /usr/xenomai/include/asm/xenomai/system.h:4,
>                  from /usr/xenomai/include/nucleus/types.h:36,
>                  from /usr/xenomai/include/nucleus/thread.h:25,
>                  from /usr/xenomai/include/nucleus/sched.h:31,
>                  from /usr/xenomai/include/native/task.h:25,
>                  from bound_task.c:2:
> /usr/xenomai/include/asm/xenomai/syscall.h: In function '__xn_rdtsc':
> /usr/xenomai/include/asm/xenomai/syscall.h:327: warning: left shift count
>> = width of type
> /usr/xenomai/lib/libnative.so: file not recognized: File format not
> recognized
> collect2: ld returned 1 exit status
> make: *** [bound_task] Error 1*

If you have xenomai compiled for x86 in /usr/xenomai/lib, that is 
logical. Normally, when you have compiled xenomai for ARM, you run:
make DESTDIR=/some/path install

Then the library directory is /some/path/usr/xenomai/lib

And in order to get the proper flag, you should run:

DESTDIR=/some/path /some/patch/usr/xenomai/bin/xeno-config --skin=native --cflags

same with ldflags for the ldflags.


> 
> And as far as I'm concerned that means (the underlined line) that my
> xenomai libraries are not cross-compiled for ARM (which now I assume have
> to be) as well. I know that they are not, cause i omitted the
> README.INSTALL of xenomai and run common *./configure* (which I assume
> compiles xenomai for x86 or smth) instead of *./configure CFLAGS="...."
> LDFLAGS="....." --build=i686-pc-linux-gnu --host=arm-unknown-linux-gnueabi *or
> something similar. So I run the proper configure according to
> README.INSTALL for ARM and this is what i receive:
> 
> *# ./configure CFLAGS="-march=armv7-a -mfpu=vfp3 *" LDFLAGS="-march=armv4t"
> --build=i686-pc-linux-gnu --host=arm-unknown-linux-gnueabi

You are compiling with -march=armv7-a and linking with
-march=armv4t, are you sure this is supposed to work?

> 
> checking build system type... i686-pc-linux-gnu
> checking host system type... arm-unknown-linux-gnueabi
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for arm-unknown-linux-gnueabi-gcc... arm-unknown-linux-gnueabi-gcc
> checking whether the C compiler works... no
> configure: error: in `/home/marcin/arm/tarballs/xenomai-2.6-5942064':
> configure: error: C compiler cannot create executables
> See `config.log' for more details*

I guess compiling for armv7 and linking for armv4 is not supported...
Anyway, to understand what happens, you can do what is written,
look at config.log.

> *
> *I've already tried the *-fno-omit-frame-pointer *option and the result is
> the same.
> 
> As I mentioned I'm compiling for cortex-a9 so the *CFLAGS *should be set as
> omap4 setting? as long there is no cortex-a9 setting described...
> *(CFLAGS="-march=armv7-a
> -mfpu=vfp3 *")

Yes, but the problem is probably the LDFLAGS you added...

-- 
					    Gilles.

