From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <a327adca-1576-0794-71cd-409b366dfdc8@alaxarxa.net>
Date: Thu, 6 Sep 2018 11:52:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Order options to build a Xenomai program
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,


I resend this message to the list now that it has again more activity. Maybe
some of you cold help me to understand what is wrong here. I'm sorry if it's not
appropriate to send again a message to the list.

=====

I have an strange problem and I would like to ask if some clever mind
can help me.

I'm trying to build with cmake (this story is for another mail) a simple
example [1] with xenomai 3.0.7. I have some custom macros that basically
uses the information from xeno-config.

I can build and run the example with the Makefile below in the email. It
just works.

Narrowing the problem I have obtained the exactly call made by the
Makefile created by cmake. It compiles the file using:

$ /usr/bin/cc   -I/usr/include/xenomai/trank
-I/usr/include/xenomai/cobalt -I/usr/include/xenomai
-I/usr/include/xenomai/alchemy  -D__XENO_COMPAT__ -g -O2
-fdebug-prefix-map=/build/xenomai-3.0.7+ds1=. -fstack-protector-strong
-Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2
-fno-omit-frame-pointer -D_GNU_SOURCE -D_REENTRANT
-fasynchronous-unwind-tables -D__COBALT__ -o
CMakeFiles/rtprint.dir/rtprint.c.o   -c
/home/leopold.palomo/xenomai/cmake/src/native/rtprint.c


and links the file using:

$ /usr/bin/cc    -Wl,--no-as-needed
-Wl,@/usr/lib/x86_64-linux-gnu/modechk.wrappers
/usr/lib/x86_64-linux-gnu/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/lib/x86_64-linux-gnu/dynlist.ld -Wl,-z,relro
-Wl,-z,now -Wl,--as-needed -pthread CMakeFiles/rtprint.dir/rtprint.c.o
-o rtprint -rdynamic -ltrank -lalchemy -lcopperplate -lcobalt -lmodechk
-lpthread -lrt -lfuse


Using the Makefile attached, to compile, make call gcc with:

$ make rtprint.o
gcc -c -o rtprint.o rtprint.c -I/usr/include/xenomai/trank
-D__XENO_COMPAT__ -I/usr/include/xenomai/cobalt -I/usr/include/xenomai
-g -O2 -fdebug-prefix-map=/build/xenomai-3.0.7+ds1=.
-fstack-protector-strong -Wformat -Werror=format-security -Wdate-time
-D_FORTIFY_SOURCE=2 -fno-omit-frame-pointer -D_GNU_SOURCE -D_REENTRANT
-fasynchronous-unwind-tables -D__COBALT__ -I/usr/include/xenomai/alchemy

and link with:

$ make rtprint
gcc -o rtprint rtprint.o -Wl,--no-as-needed -ltrank
-Wl,@/usr/lib/x86_64-linux-gnu/modechk.wrappers -lalchemy -lcopperplate
/usr/lib/x86_64-linux-gnu/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/lib/x86_64-linux-gnu/dynlist.ld
-L/usr/lib/x86_64-linux-gnu -lcobalt -lmodechk -lpthread -lrt
-Wl,-z,relro -Wl,-z,now -Wl,--as-needed   -lfuse -pthread


The build result made by CMake is: rtprint (24816 bytes) and rtprint.o
(16408 bytes)

The build result make using the makefile: rtprint (24720 bytes) and
rtprint.o (16312 bytes).

If I call the gcc directly I obtain the same bytes. The difference is
the stored path. If I strip the executables the size is the same (10224
bytes) but binaries differ.

But, and here is the problem. If I run the cmake product I obtain:

/rtprint
./rtprint: symbol lookup error:
/usr/lib/x86_64-linux-gnu/libcopperplate.so.0: undefined symbol:
__real_malloc


and the produced with make runs.

The produced using cmake has:

$ ldd rtprint
	linux-vdso.so.1 (0x00007ffd0e1e1000)
	libtrank.so.0 => /usr/lib/x86_64-linux-gnu/libtrank.so.0
(0x00007f7b5dec9000)
	libalchemy.so.0 => /usr/lib/x86_64-linux-gnu/libalchemy.so.0
(0x00007f7b5dcb7000)
	libcopperplate.so.0 => /usr/lib/x86_64-linux-gnu/libcopperplate.so.0
(0x00007f7b5da9f000)
	libcobalt.so.2 => /usr/lib/x86_64-linux-gnu/libcobalt.so.2
(0x00007f7b5d87d000)
	libfuse.so.2 => /lib/x86_64-linux-gnu/libfuse.so.2 (0x00007f7b5d63f000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0
(0x00007f7b5d422000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f7b5d083000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f7b5e2d0000)
	librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f7b5ce7b000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f7b5cc77000)


and with make

$ ldd rtprint
	linux-vdso.so.1 (0x00007ffffcfe2000)
	libtrank.so.0 => /usr/lib/x86_64-linux-gnu/libtrank.so.0
(0x00007f621304f000)
	libalchemy.so.0 => /usr/lib/x86_64-linux-gnu/libalchemy.so.0
(0x00007f6212e3d000)
	libcopperplate.so.0 => /usr/lib/x86_64-linux-gnu/libcopperplate.so.0
(0x00007f6212c25000)
	libcobalt.so.2 => /usr/lib/x86_64-linux-gnu/libcobalt.so.2
(0x00007f6212a03000)
	libmodechk.so.0 => /usr/lib/x86_64-linux-gnu/libmodechk.so.0
(0x00007f6212801000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0
(0x00007f62125e4000)
	librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f62123dc000)
	libfuse.so.2 => /lib/x86_64-linux-gnu/libfuse.so.2 (0x00007f621219e000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f6211dff000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f6213456000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f6211bfb000)


pay attention that first one is not linked against libmodechk, although
is specified in the call.


I have not found any difference, only the order, so I am really
overwhelmed. Any idea?


Best regards,


Leopold



Makefile
-------------------------------------------------------------------
###### CONFIGURATION ######

### List of applications to be build
APPLICATIONS = rtprint

### Default Xenomai installation path
XENO ?= /usr/xenomai

XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config
2>/dev/null)

CC=$(shell $(XENOCONFIG) --cc)

CFLAGS=$(shell $(XENOCONFIG) --skin=native --cflags)

LDFLAGS=$(shell $(XENOCONFIG) --skin=native --ldflags)

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

rtprint: rtprint.o
	$(CC) -o $@ rtprint.o $(LDFLAGS)

clean:
	$(RM) $(APPLICATIONS) *.o

all: $(APPLICATIONS)
-------------------------------------------------------------------


[1]
https://gitlab.denx.de/Xenomai/xenomai/blob/eol/v2.6.x/examples/native/rtprint.c



-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

