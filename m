MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Sat, 7 Aug 2021 00:43:48 -0700
Message-ID: <CA+K1mPGzpiNwXuu2xM0d0Gy472kUs64kLp9e3GypTFgGyEc1bw@mail.gmail.com>
Subject: cannot link 32 bit app
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai List <xenomai@xenomai.org>

I can compile but not link my xenomai app. I get:
/usr/bin/ld: skipping incompatible /usr/xenomai/lib/libtrank.so when
searching for -ltrank
/usr/bin/ld: skipping incompatible /usr/xenomai/lib/libcobalt.so when
searching for -lcobalt
etc.

I am testing  xenomai 3.1 with x86-64 bit kernel 4.19.89 (I am porting my
xenomai 2.6 codebase to xeno 3.1). I have compiled the kernel OK with 32
bit emulation support (CONFIG_IA32_EMULATION=y), as I must run my very
large legacy xenomai 2.6 codebase as 32 bit.  The xenomai testsuite
latency, clocktest, switchtest apps run fine, BTW.

Is the problem that the xenomai libs like cobalt are 64 bit only? Did I
omit some xenomai configure option to support 32 bit xenomai apps ?

Here is an example of the kind of gcc command line my Makefile puts out:
gcc -g3 -m32 -I/usr/xenomai/include/trank -D__XENO_COMPAT__
-I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE
-D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__
-I/usr/xenomai/include/alchemy -I/usr/include/libxml2
-I/usr/xenomai/include/rtdm  -I"../include/nanopb"    -Xlinker -rpath
-Xlinker /usr/xenomai/lib  testapp.c  ../modules/rtdinsync.h
-Wl,--no-as-needed -ltrank -Wl,@/usr/xenomai/lib/modechk.wrappers -lalchemy
-lcopperplate /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt
-lmodechk -lpthread -lrt    -lfuse -pthread  -Wl,--no-as-needed
-Wl,@/usr/xenomai/lib/cobalt.wrappers
-Wl,@/usr/xenomai/lib/modechk.wrappers
 /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt
-lmodechk -lpthread -lrt    -lfuse -pthread  -Wl,--no-as-needed
-Wl,@/usr/xenomai/lib/cobalt.wrappers
-Wl,@/usr/xenomai/lib/modechk.wrappers
 /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt
-lmodechk -lpthread -lrt    -lfuse -pthread -lz -llzma -lm -ldl
-Wl,--start-group -loshw -losal -Wl,--end-group -lm -o testapp

thanks,
-C Smith
