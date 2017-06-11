References: <CAF06wtgG4OQ3ya2XkOx6B9gGAXrQpPT0xm2WQ9VvEoCvnxHR3Q@mail.gmail.com>
 <2d1d8708-2af0-9624-bd51-66cf78575f1f@xenomai.org>
 <CAF06wtiwhr5yLkCwMpuYeWwyanhvZZoO8np55_YoDYcOzZ0Ckg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8872ff70-fad4-92cc-93f7-d3e4ea8c1b44@xenomai.org>
Date: Sun, 11 Jun 2017 18:51:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAF06wtiwhr5yLkCwMpuYeWwyanhvZZoO8np55_YoDYcOzZ0Ckg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Migrating 2.x projects to 3.x...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jlangston@panurgyinc.com
Cc: xenomai@xenomai.org

On 06/11/2017 06:36 PM, Jim Langston wrote:
> Ok, opted for the compatibility layer (actual make file):
> 
> APP = rfiserver
> XENOCONFIG:=../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/bin/xeno-config
> CC = $(shell ${XENOCONFIG} --native --posix --compat --cc)
> CFLAGS = $(shell ${XENOCONFIG} --native --posix --compat --cflags)
> LDFLAGS = $(shell ${XENOCONFIG} --native --posix --compat --ldflags)
> 
> all: clean $(APP)
> $(APP): $(APP).c sys_svr.c front_panel.c test.cpp
>     $(CC) $(CFLAGS) $(LDFLAGS) sys_svr.c front_panel.c test.cpp -o $@ $<
>     cp rfiserver ../root/bin/
> clean:
>     rm -f *.o $(APP) *~
> .PHONY: clean
> 
> 
> So now I get the following output when I run 'make':
> 
> /home/jlangston/mi/xenomai3/buildroot-2017.02.2/output/host/usr/bin/i686-buildroot-linux-uclibc-gcc
> -I../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/include/xenomai/trank/posix
> -I../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/include/xenomai/trank
> -D__XENO_COMPAT__
> -I../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/include/xenomai/cobalt
> -I../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/include/xenomai
> -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os
> -D_GNU_SOURCE -D_REENTRANT -D__COBALT__
> -I../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/include/xenomai/alchemy
> -D__COBALT_WRAP__ -Wl,--no-as-needed
> -Wl,@../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/lib/cobalt.wrappers
> -ltrank
> -Wl,@../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/lib/modechk.wrappers
> -lalchemy -lcopperplate
> ../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/lib/xenomai/bootstrap.o
> -Wl,--wrap=main
> -Wl,--dynamic-list=../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/lib/dynlist.ld
> -L../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysroot/usr/lib
> -lcobalt -lmodechk -lpthread -lrt    sys_svr.c front_panel.c test.cpp -o
> rfiserver rfiserver.c
> 
> But I still get the 'undefined' references to the 'rt_dev_XXX()' calls. 
> 
> If I replace all of the 'rt_dev_XXX' calls with the plain POSIX variants
> (remove all of the 'rt_dev_ prefixes), then the errors go away, but is
> this because I'm not enabling the compatibility layer correctly, and I'm
> linking unwrapped APIs?
> 

The Makefile seems to be omitting the --compat flag for the LDFLAGS, you
need to pass --compat to xeno-config for retrieving both the compiler
(--cflags --compat) and linker flags (--ldflags --compat). You should
see -ltrank appearing.

-- 
Philippe.

