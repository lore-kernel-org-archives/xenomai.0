Message-ID: <2ff1a98a0711080617r1ca5f300n9bb963fb1dadc08e@domain.hid>
Date: Thu, 8 Nov 2007 15:17:59 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB283@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB283@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Wrong -lpthread/-lrt order in
	testsuite/clocktest/Makefile.am ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

On Nov 8, 2007 3:10 PM, Fillod Stephane <stephane.fillod@domain.hid> wrote:
> Hi,
>
> Testing xenomai-2.4-rc5, I've encountered the following link error:
>
> powerpc-linux-uclibc-gcc -Wl,--wrap -Wl,pthread_create ....
> -Wl,--wrap -Wl,mmap -Wl,--wrap -Wl,munmap -o clocktest
> clocktest-clocktest.o  ../../skins/posix/.libs/libpthread_rt.a -lpthread
> -lrt
> .../powerpc-linux-uclibc/lib/libpthread.so: undefined reference to
> `__wrap_mmap'
> .../powerpc-linux-uclibc/lib/librt.so: undefined reference to
> `__wrap_close'
> .../powerpc-linux-uclibc/lib/libpthread.so: undefined reference to
> `__wrap_munmap'
> collect2: ld returned 1 exit status
> gmake[4]: *** [clocktest] Error 1
> $ powerpc-linux-uclibc-gcc --version
> powerpc-linux-uclibc-gcc (GCC) 3.4.3
> $ powerpc-linux-uclibc-ld --version
> GNU ld version 2.16.90.0.1 20050408
>
> If I swap the order of libpthread_rt.a and -lpthread -lrt, the link
> succeeds.
> I guess it has to do with the fact that a library which provides symbols
> has to be after in the link order of a module which needs them.
> Is it still okay with regard to pthread function wrapping?

No, libpthread_rt.a uses symbols defined by libpthread.so and
librt.so, so, they should be after. What you are observing is likely
an issue with regard to --wrap with static libraries.

The solution to this problem is to either use the dynamic
libpthread_rt.so, or to do the link edit in two stages:
first stage with libpthread_rt.a and all the --wrap
second stage with -lpthread and -lrt without all the --wrap

Unfortunately, the behaviour of --wrap with static libraries is not
the same on all platforms.

-- 
                                               Gilles Chanteperdrix

