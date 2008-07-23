Message-ID: <48876738.2020403@domain.hid>
Date: Wed, 23 Jul 2008 19:15:36 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200807230917.m6N9H0tZ028205@domain.hid>
In-Reply-To: <200807230917.m6N9H0tZ028205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Errors while static linking of Xenomai
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christian Volk <linux.kernel@domain.hid>
Cc: xenomai@xenomai.org

Christian Volk wrote:
> Hi,
> 
> when I try to compile Xenomai and link it satically i get some 'undefined reference' errors while compiling the cyclictest programm from the testsuite.
> I'm using Xenomai 2.4.4 with uclibc and try to compile for a ppc-arch board (Freescale MPC8343 processor).
> 
> Heres the line which I use to configure Xenomai:
> ./configure --host=powerpc-generic-linux-uclibc CC=/opt/powerpc-linux-uclibc/bin/powerpc-generic-linux-uclibc-gcc CXX=/opt/powerpc-linux-uclibc/bin/powerpc-generic-linux-uclibc-g++ LD=/opt/powerpc-linux-uclibc/bin/powerpc-generic-linux-uclibc-ld --enable-shared=no LDFLAGS=--static 
>

Fully static builds will likely not work with the current Makefiles, I'm afraid.
To achieve that, one would have to follow a two-stage linking approach, partial
linking with the application and wrappers first, then final linking of the
previous object with the standard libs - like libpthread - without wrapping.
This has already be done for certain applications and is known to work.

Due to static linking, what happens here is that the linker sees therefore binds
pthread_* calls issued from the standard pthread library to Xenomai symbols...
which are wrappers shadowing the standard pthread_* calls... Bad idea. The point
is that the -Wl,<wrappers> directive should not appear on the link command line
for static builds when standard glibc/libpthread are listed here as well.

This said, those errors compiling the Xenomai stack should only happen with
POSIX apps from the testsuite because the Makefiles there do not account for
fully static builds and wrapping woes, but you can safely ignore them, provided
you do two-stage linking for your own apps. This is one of the rare cases where
make -k may help...

-- 
Philippe.


