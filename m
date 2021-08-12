MIME-Version: 1.0
References: <CA+K1mPGzpiNwXuu2xM0d0Gy472kUs64kLp9e3GypTFgGyEc1bw@mail.gmail.com>
 <e3581d25-c6ba-433b-a51d-4fb29e1852aa@siemens.com>
 <CA+K1mPE+PpFiTTj=YqXJ1fdSEBC1Weye-z1dpEPEkJmHUFSZ8w@mail.gmail.com>
 <10a4b294-5749-2b80-193d-8d04fdb41553@siemens.com>
In-Reply-To: <10a4b294-5749-2b80-193d-8d04fdb41553@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Thu, 12 Aug 2021 00:10:36 -0700
Message-ID: <CA+K1mPGSOWQxEhOyrtxMtOPQXr=RUyRECyhMaqShw_RSAS1wtQ@mail.gmail.com>
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

OK, yeah I had mistakenly put --ldflags in the xeno-config line for  CFLAGS
=
This was also problem:
LDLIBS= $(shell $(XENOCONFIG) --skin=native --ldflags) \
$(shell $(XENOCONFIG) --skin=rtdm --ldflags) \
$(shell $(XENOCONFIG) --skin=posix --ldflags)
That used to work in Xenomai 2.6 but not in Xenomai 3.1.
All I needed was
LDLIBS= $(shell $(XENOCONFIG) --skin=alchemy --ldflags)

My larger (30K lines) app compiles successfully now.
Thanks.  -C Smith

On Wed, Aug 11, 2021 at 11:04 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 12.08.21 07:50, C Smith wrote:
> > Hi Jan,Thanks for your prompt reply.  I reduced my very large app to
> > about 200 lines, it only starts one periodic process. but I still get
> > this error during linkage:
> >
> > /usr/xenomai/lib/xenomai/bootstrap.o: In function `xenomai_main':
> > /usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94: multiple
> > definition of `xenomai_main'
> >
> /usr/xenomai/lib/xenomai/bootstrap.o:/usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94:
> > first defined here
> > /usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): multiple definition
> > of `xenomai_auto_bootstrap'
> > /usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): first defined here
> > /usr/xenomai/lib/xenomai/bootstrap.o: In function `xenomai_main':
> > /usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94: multiple
> > definition of `xenomai_main'
> >
> /usr/xenomai/lib/xenomai/bootstrap.o:/usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94:
> > first defined here
> > /usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): multiple definition
> > of `xenomai_auto_bootstrap'
> > /usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): first defined here
> > /usr/xenomai/lib/xenomai/bootstrap.o: In function `xenomai_main':
> > /usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94: multiple
> > definition of `xenomai_main'
> >
> /usr/xenomai/lib/xenomai/bootstrap.o:/usr/src/xenomai-3.1/lib/boilerplate/init/bootstrap.c:94:
> > first defined here
> > /usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): multiple definition
> > of `xenomai_auto_bootstrap'
> > /usr/xenomai/lib/xenomai/bootstrap.o:(.rodata+0x0): first defined here
> > collect2: error: ld returned 1 exit status
> > make[1]: *** [<builtin>: myapp] Error 1
> >
> > I had used your advice to get the compiler args in my Makefile with:
> > /usr/xenomai/bin/xeno-config --skin=native --cflags --ldflags
> > The resulting command line is:
> >
> > gcc -g3 -m32 -I/usr/xenomai/include/trank -D__XENO_COMPAT__
> > -I/usr/xenomai/include/cobalt
> > -I/usr/xenomai/include -m32 -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
> > -D_REENTRANT -fasynchronous-unwind-tables
> > -D__COBALT__ -I/usr/xenomai/include/alchemy -I/usr/xenomai/include/rtdm
> > -Wl,--no-as-needed -ltrank
> > -Wl,@/usr/xenomai/lib/modechk.wrappers -lalchemy -lcopperplate
> > /usr/xenomai/lib/xenomai/bootstrap.o
> > -Wl,--wrap=main -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld
> > -L/usr/xenomai/lib -lcobalt -lmodechk
> > -lpthread -lrt -m32   -lfuse -pthread -I/usr/include/libxml2 -I"SOEM/"
> > -I"SOEM/osal" -I"SOEM/oshw/linux"
> > -I"SOEM/soem" -I"../include/nanopb"    -Xlinker -rpath -Xlinker
> > /usr/xenomai/lib  myapp.c ../include/myapp.h
> > ../include/dia_dev_myapp.h ../include/crc_table.h ../include/dacdefs.h
> > ../include/version.h
> > ../include/canopen_drives.h ../include/adcdefs.h
> > ../include/myapp_version.h ../include/canodefs.h
> > ../include/preproc_myapp.h ../include/myapp_mem_manager_data.h
> > ../include/comm_dta_myapp.h ../include/comproto.h
> > ../modules/rtdinsync.h quad.o dac.o adc.o SOEM/lib/linux/liboshw.a
> > SOEM/lib/linux/libosal.a SOEM/lib/linux/libsoem.a
> > ../include/nanopb/nanopb.a  -Wl,--no-as-needed -ltrank
> > -Wl,@/usr/xenomai/lib/modechk.wrappers -lalchemy -lcopperplate
> > /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
> > -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld
> > -L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt -m32   -lfuse
> > -pthread  -Wl,--no-as-needed
> > -Wl,@/usr/xenomai/lib/cobalt.wrappers
> -Wl,@/usr/xenomai/lib/modechk.wrappers
> > /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
> > -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld
> > -L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt -m32   -lfuse
> > -pthread  -Wl,--no-as-needed
> > -Wl,@/usr/xenomai/lib/cobalt.wrappers
> -Wl,@/usr/xenomai/lib/modechk.wrappers
> > /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
> > -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld
> > -L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt -m32   -lfuse
> > -pthread  -lxml2 -lz -llzma -lm
> > -ldl -L"SOEM/lib/linux" -Wl,--start-group -loshw -losal -lsoem
> > -Wl,--end-group -lm -o myapp
> >
> > What is going wrong with the linkage?  Thanks, C Smith
> >
>
> Something is broken in your makefile. If you look at the end of the
> resulting gcc call above, you see e.g. bootstrap.o being listed multiple
> times (which explains the error, obviously). This is not coming from
> xeno-config. So check your local setup, or just do
>
> gcc $(xeno-config ...) -o my-app my-app.c -I my-includes
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
