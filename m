MIME-Version: 1.0
In-Reply-To: <20170712111931.0f78f255@md1em3qc>
References: <057af6c3-168f-052d-a7c2-c4a661dc3a51@utpvision.it>
 <20170711173311.4a6c5354@md1em3qc>
 <736ba8ed-7776-4a75-d42b-7703bb4fba0e@utpvision.it>
 <20170712111931.0f78f255@md1em3qc>
From: Ashok kumar <ashokkumar.bb@gmail.com>
Date: Wed, 12 Jul 2017 16:13:06 +0530
Message-ID: <CAFUnMknuEVhX0v=boyrDt3Fihd2vkGtVHD36q+UhaVFxaFMEgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Cobalt core install linker problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I want to patch xenomai on raspberry pi 3 , I have tried it but after
compilation the xenomai kernel is not booting.

kindly help me to patch xenomai on raspberry pi 3.

Installation steps to install xenomai on raspberry pi 3 directly without
cross compilation.


Thank you
Ashok

On Wed, Jul 12, 2017 at 2:49 PM, Henning Schild <henning.schild@siemens.com>
wrote:

> Am Wed, 12 Jul 2017 07:16:45 +0000
> schrieb Simone Zucchi <simone.zucchi@utpvision.it>:
>
> > > Recent compilers default to generating position independant
> > > binaries. That problem should get fixed in xenomai. For the time
> > > being you can run make CFLAGS="-no-pie" -j `nproc`
> > > to work around the problem.
> >
> > That was the case! Built without a problem.Thanks a lot!
> > By the way, Is it correct that xeno-test won't be built?
>
> It should be. If you
> touch testsuite/xeno-test/xeno-test-run.c; make
> it will rebuild something. After a "make install" you should be able to
> run something like this:
> xeno-test -l "dohell -m /tmp 300" -p 1000
>
> Our CI does "dh_autoreconf; dpkg-buildpackage -j$(JOBS) -uc -us" and
> the packages contain a runnable xeno-test
>
> Henning
>
> > Simone
> >
> > On 07/11/2017 05:33 PM, Henning Schild wrote:
> > > Am Tue, 11 Jul 2017 14:22:02 +0000
> > > schrieb Simone Zucchi <simone.zucchi@utpvision.it>:
> > >
> > >> Hello everybody,
> > >> I'm trying to compile xenomai tools --with-core=cobalt but I keep
> > >> ha ving issues on latency tool, seems on linking.
> > >> If I try to build --with-core=mercury switch it works flawlessly:
> > > ...
> > >> Then I try to build --with-core=cobalt and something goes wrong:
> > >>
> > >> root@debian9:/usr/src/xenomai-3.0.5# ./configure --with-core=cobalt
> > >> --prefix=/usr/local/xenomai/cobalt --disable-debug --enable-pshared
> > >> --enable-smp >/dev/null
> > >> root@debian9:/usr/src/xenomai-3.0.5# time make -j8 >/dev/null
> > > ...
> > >> /usr/bin/ld: -r and -pie may not be used together
> > >> collect2: error: ld returned 1 exit status
> > >> make[2]: *** [latency] Error 1
> > >> make[1]: *** [all-recursive] Error 1
> > >> make: *** [all-recursive] Error 1
> > > Recent compilers default to generating position independant
> > > binaries. That problem should get fixed in xenomai. For the time
> > > being you can run make CFLAGS="-no-pie" -j `nproc`
> > > to work around the problem.
> > >
> > > Henning
> > >
> > >> real    0m8.055s
> > >> user    0m26.924s
> > >> sys    0m1.928s
> > >>
> > >> ld fails at this:
> > >>
> > >>
> > >>       Making all in testsuite
> > >>       make[1]: Entering directory
> > >> '/usr/src/xenomai-3.0.5/testsuite' Making all in latency
> > >>       make[2]: Entering directory
> > >> '/usr/src/xenomai-3.0.5/testsuite/latency'
> > >>         CC       latency-latency.o
> > >>         CCLD     latency
> > >>       /usr/bin/ld: -r and -pie may not be used together
> > >>       collect2: error: ld returned 1 exit status
> > >>       Makefile:451: recipe for target 'latency' failed
> > >>       make[2]: *** [latency] Error 1
> > >>       make[2]: Leaving directory
> > >> '/usr/src/xenomai-3.0.5/testsuite/latency'
> > >>       Makefile:423: recipe for target 'all-recursive' failed
> > >>       make[1]: *** [all-recursive] Error 1
> > >>       make[1]: Leaving directory '/usr/src/xenomai-3.0.5/testsuite'
> > >>       Makefile:460: recipe for target 'all-recursive' failed
> > >>       make: *** [all-recursive] Error 1
> > >>
> > >>
> > >> No matter which options I include or not, it never goes over this.
> > >> Make plain (without -j8) doesn't help either.
> > >>
> > >> I'm working on a Debian 9 which I just compiled with Cobalt Core -
> > >> but even with standard Debian kernel it doesn't go through.
> > >> Odd enough, if I build Xenomai tools with a Fedora 25 machine, it
> > >> works. *HINT* on Fedora I got a different ld version (OLDER), which
> > >> doesn't warns out about " ar: `u' modifier ignored since `D' is the
> > >> default (see `U')":
> > >>
> > >> FEDORA VERSION:
> > >>       ld -v
> > >>       GNU ld version 2.26.1-1.fc25
> > >>
> > >>
> > >> Here's some versioning on my Debian box:
> > >>
> > >> root@debian9:/usr/src/xenomai-3.0.5# gcc -v
> > >> Using built-in specs.
> > >> COLLECT_GCC=gcc
> > >> COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/6/lto-wrapper
> > >> Target: x86_64-linux-gnu
> > >> Configured with: ../src/configure -v --with-pkgversion='Debian
> > >> 6.3.0-18' --with-bugurl=file:///usr/share/doc/gcc-6/README.Bugs
> > >> --enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++
> > >> --prefix=/usr --program-suffix=-6
> > >> --program-prefix=x86_64-linux-gnu- --enable-shared
> > >> --enable-linker-build-id --libexecdir=/usr/lib
> > >> --without-included-gettext --enable-threads=posix
> > >> --libdir=/usr/lib --enable-nls --with-sysroot=/
> > >> --enable-clocale=gnu --enable-libstdcxx-debug
> > >> --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new
> > >> --enable-gnu-unique-object --disable-vtable-verify --enable-libmpx
> > >> --enable-plugin --enable-default-pie --with-system-zlib
> > >> --disable-browser-plugin --enable-java-awt=gtk --enable-gtk-cairo
> > >> --with-java-home=/usr/lib/jvm/java-1.5.0-gcj-6-amd64/jre
> > >> --enable-java-home
> > >> --with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-6-amd64
> > >> --with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-6-amd64
> > >> --with-arch-directory=amd64
> > >> --with-ecj-jar=/usr/share/java/eclipse-ecj.jar
> > >> --with-target-system-zlib --enable-objc-gc=auto --enable-multiarch
> > >> --with-arch-32=i686 --with-abi=m64
> > >> --with-multilib-list=m32,m64,mx32 --enable-multilib
> > >> --with-tune=generic --enable-checking=release
> > >> --build=x86_64-linux-gnu --host=x86_64-linux-gnu
> > >> --target=x86_64-linux-gnu Thread model: posix gcc version 6.3.0
> > >> 20170516 (Debian 6.3.0-18) root@debian9:/usr/src/xenomai-3.0.5# ld
> > >> -version GNU ld (GNU Binutils for Debian) 2.28 Copyright (C) 2017
> > >> Free Software Foundation, Inc. This program is free software; you
> > >> may redistribute it under the terms of the GNU General Public
> > >> License version 3 or (at your option) a later version. This
> > >> program has absolutely no warranty.
> > >>
> > >> root@debian9:/usr/src/xenomai-3.0.5# make -v
> > >> GNU Make 4.1
> > >> Built for x86_64-pc-linux-gnu
> > >> Copyright (C) 1988-2014 Free Software Foundation, Inc.
> > >> License GPLv3+: GNU GPL version 3 or later
> > >> <http://gnu.org/licenses/gpl.html>
> > >> This is free software: you are free to change and redistribute it.
> > >> There is NO WARRANTY, to the extent permitted by law.
> > >>
> > >> root@debian9:/usr/src/xenomai-3.0.5# dpkg -l|grep libtool
> > >> ii  libltdl-dev:amd64 2.4.6-2
> > >>    amd64        System independent dlopen wrapper for GNU libtool
> > >> ii  libltdl7:amd64 2.4.6-2
> > >>    amd64        System independent dlopen wrapper for GNU libtool
> > >> ii  libtool 2.4.6-2
> > >>    all          Generic library support script
> > >>
> > >> root@debian9:/usr/src/xenomai-3.0.5# uname -a
> > >> Linux debian9 4.9.24-xenomai-3.0.5-cobalt #1 SMP PREEMPT Tue Jul 11
> > >> 13:16:47 UTC 2017 x86_64 GNU/Linux
> > >>
> > >>
> > >> Hope somebody will help me to sort this out :)
> > >>
> > >> Simone
> > >> _______________________________________________
> > >> Xenomai mailing list
> > >> Xenomai@xenomai.org
> > >> https://xenomai.org/mailman/listinfo/xenomai
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
