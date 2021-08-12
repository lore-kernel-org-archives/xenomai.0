MIME-Version: 1.0
References: <CA+K1mPGzpiNwXuu2xM0d0Gy472kUs64kLp9e3GypTFgGyEc1bw@mail.gmail.com>
 <e3581d25-c6ba-433b-a51d-4fb29e1852aa@siemens.com>
In-Reply-To: <e3581d25-c6ba-433b-a51d-4fb29e1852aa@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 11 Aug 2021 22:50:14 -0700
Message-ID: <CA+K1mPE+PpFiTTj=YqXJ1fdSEBC1Weye-z1dpEPEkJmHUFSZ8w@mail.gmail.com>
Subject: Re: cannot link 32 bit app
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai List <xenomai@xenomai.org>

Hi Jan,Thanks for your prompt reply.  I reduced my very large app to about
200 lines, it only starts one periodic process. but I still get this error
during linkage:

/usr/xenomai/lib/xenomai/bootstrap.o: In function `xenomai_main':
/usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94: multiple
definition of `xenomai_main'
/usr/xenomai/lib/xenomai/bootstrap.o:/usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94:
first defined here
/usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): multiple definition of
`xenomai_auto_bootstrap'
/usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): first defined here
/usr/xenomai/lib/xenomai/bootstrap.o: In function `xenomai_main':
/usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94: multiple
definition of `xenomai_main'
/usr/xenomai/lib/xenomai/bootstrap.o:/usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94:
first defined here
/usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): multiple definition of
`xenomai_auto_bootstrap'
/usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): first defined here
/usr/xenomai/lib/xenomai/bootstrap.o: In function `xenomai_main':
/usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94: multiple
definition of `xenomai_main'
/usr/xenomai/lib/xenomai/bootstrap.o:/usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94:
first defined here
/usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): multiple definition of
`xenomai_auto_bootstrap'
/usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): first defined here
collect2: error: ld returned 1 exit status
make[1]: *** [<builtin>: myapp] Error 1

I had used your advice to get the compiler args in my Makefile with:
/usr/xenomai/bin/xeno-config --skin=native --cflags --ldflags
The resulting command line is:

gcc -g3 -m32 -I/usr/xenomai/include/trank -D__XENO_COMPAT__
-I/usr/xenomai/include/cobalt
-I/usr/xenomai/include -m32 -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
-D_REENTRANT -fasynchronous-unwind-tables
-D__COBALT__ -I/usr/xenomai/include/alchemy -I/usr/xenomai/include/rtdm
-Wl,--no-as-needed -ltrank
-Wl,@/usr/xenomai/lib/modechk.wrappers -lalchemy -lcopperplate
/usr/xenomai/lib/xenomai/bootstrap.o
-Wl,--wrap=main -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld
-L/usr/xenomai/lib -lcobalt -lmodechk
-lpthread -lrt -m32   -lfuse -pthread -I/usr/include/libxml2 -I"SOEM/"
-I"SOEM/osal" -I"SOEM/oshw/linux"
-I"SOEM/soem" -I"../include/nanopb"    -Xlinker -rpath -Xlinker
/usr/xenomai/lib  myapp.c ../include/myapp.h
../include/dia_dev_myapp.h ../include/crc_table.h ../include/dacdefs.h
../include/version.h
../include/canopen_drives.h ../include/adcdefs.h ../include/myapp_version.h
../include/canodefs.h
../include/preproc_myapp.h ../include/myapp_mem_manager_data.h
../include/comm_dta_myapp.h ../include/comproto.h
../modules/rtdinsync.h quad.o dac.o adc.o SOEM/lib/linux/liboshw.a
SOEM/lib/linux/libosal.a SOEM/lib/linux/libsoem.a
../include/nanopb/nanopb.a  -Wl,--no-as-needed -ltrank
-Wl,@/usr/xenomai/lib/modechk.wrappers -lalchemy -lcopperplate
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld
-L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt -m32   -lfuse -pthread
 -Wl,--no-as-needed
-Wl,@/usr/xenomai/lib/cobalt.wrappers -Wl,@/usr/xenomai/lib/modechk.wrappers
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld
-L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt -m32   -lfuse -pthread
 -Wl,--no-as-needed
-Wl,@/usr/xenomai/lib/cobalt.wrappers -Wl,@/usr/xenomai/lib/modechk.wrappers
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld
-L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt -m32   -lfuse -pthread
 -lxml2 -lz -llzma -lm
-ldl -L"SOEM/lib/linux" -Wl,--start-group -loshw -losal -lsoem
-Wl,--end-group -lm -o myapp

What is going wrong with the linkage?  Thanks, C Smith

On Sat, Aug 7, 2021 at 8:34 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 07.08.21 09:43, C Smith via Xenomai wrote:
> > I can compile but not link my xenomai app. I get:
> > /usr/bin/ld: skipping incompatible /usr/xenomai/lib/libtrank.so when
> > searching for -ltrank
> > /usr/bin/ld: skipping incompatible /usr/xenomai/lib/libcobalt.so when
> > searching for -lcobalt
> > etc.
> >
> > I am testing  xenomai 3.1 with x86-64 bit kernel 4.19.89 (I am porting my
> > xenomai 2.6 codebase to xeno 3.1). I have compiled the kernel OK with 32
> > bit emulation support (CONFIG_IA32_EMULATION=y), as I must run my very
> > large legacy xenomai 2.6 codebase as 32 bit.  The xenomai testsuite
> > latency, clocktest, switchtest apps run fine, BTW.
> >
> > Is the problem that the xenomai libs like cobalt are 64 bit only? Did I
> > omit some xenomai configure option to support 32 bit xenomai apps ?
> >
> > Here is an example of the kind of gcc command line my Makefile puts out:
> > gcc -g3 -m32 -I/usr/xenomai/include/trank -D__XENO_COMPAT__
> > -I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE
> > -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__
> > -I/usr/xenomai/include/alchemy -I/usr/include/libxml2
> > -I/usr/xenomai/include/rtdm  -I"../include/nanopb"    -Xlinker -rpath
> > -Xlinker /usr/xenomai/lib  testapp.c  ../modules/rtdinsync.h
> > -Wl,--no-as-needed -ltrank -Wl,@/usr/xenomai/lib/modechk.wrappers
> -lalchemy
> > -lcopperplate /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
> > -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib
> -lcobalt
> > -lmodechk -lpthread -lrt    -lfuse -pthread  -Wl,--no-as-needed
> > -Wl,@/usr/xenomai/lib/cobalt.wrappers
> > -Wl,@/usr/xenomai/lib/modechk.wrappers
> >  /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
> > -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib
> -lcobalt
> > -lmodechk -lpthread -lrt    -lfuse -pthread  -Wl,--no-as-needed
> > -Wl,@/usr/xenomai/lib/cobalt.wrappers
> > -Wl,@/usr/xenomai/lib/modechk.wrappers
> >  /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
> > -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib
> -lcobalt
> > -lmodechk -lpthread -lrt    -lfuse -pthread -lz -llzma -lm -ldl
> > -Wl,--start-group -loshw -losal -Wl,--end-group -lm -o testapp
> >
>
> Xenomai userland works fine in 32-bit mode on x86, we do the same in
> production. This is how I configure for 32-bit on my 64-bit machine:
>
> /configure --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64" \
>     LDFLAGS=-m32 host_alias=i686-linux
>
> Then you should be able to build just using the output of "xeno-config
> --skin=... --cflags --ldflags".
>
> That said, things are not nicely tested in upstream yet, see [1].
>
> Jan
>
> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
