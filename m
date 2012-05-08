MIME-Version: 1.0
Date: Mon, 7 May 2012 23:13:09 -0400
Message-ID: <CAJ7NaH-mLaPVMGJS9cUM3XwAGay_SwygXBmK7VZQMoYcO1=EaA@mail.gmail.com>
From: Vikram Dhillon <dhillonv10@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] Userland-compile error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I recently compiled and installed a xenomai patched kernel but I am
currently having some issues compiling sample code that came with the
xenomai kernel. So here's what is happening:

=================================================================================================
root@domain.hid# make
XENO=/usr/xenomai/ KSRC=/usr/src/linux-2.6.38.8-xenomai/
--xeno-cflags is deprecated, use --skin=name --cflags instead
--xeno-ldflags is deprecated, use --skin=name --ldflags instead
gcc -DCONSUMER -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
-Werror-implicit-function-declaration -pipe -D__XENO__
-I/usr/xenomai/include/posix    -Wl,@/usr/xenomai/lib/posix.wrappers
-L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt   -Xlinker
-rpath -Xlinker /usr/xenomai/lib  satch.c   -o satch
/usr/bin/ld: /tmp/ccLV0g8I.o: undefined reference to symbol
'pthread_cancel@domain.hid'
/usr/bin/ld: note: 'pthread_cancel@domain.hid' is defined in DSO
/lib/i386-linux-gnu/libpthread.so.0 so try adding it to the linker
command line
/lib/i386-linux-gnu/libpthread.so.0: could not read symbols: Invalid operation
collect2: ld returned 1 exit status
make: *** [satch] Error 1
=================================================================================================


Linker issue here, the program satch in posix directory won't compile,
first change in the posix makefile:
=================================================================================================
CFLAGS=-DCONSUMER $(shell $(XENOCONFIG) --skin=posix --cflags) $(APP_CFLAGS)
LDFLAGS=$(shell $(XENOCONFIG) --skin=posix --ldflags) $(APP_LDFLAGS)
=================================================================================================


Then, the program still doesn't compile so I actually had to remove
the lpthread switch in compiling:
=================================================================================================
vikram@domain.hid$ gcc -DCONSUMER
-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
-Werror-implicit-function-declaration -pipe -D__XENO__
-I/usr/xenomai/include/posix   -Wl,@/usr/xenomai/lib/posix.wrappers
-L/usr/xenomai/lib -lpthread_rt -lxenomai -lrt   -Xlinker -rpath
-Xlinker /usr/xenomai/lib  satch.c   -o satch
vikram@domain.hid$ ls
Makefile  Makefile~  README  satch  satch.c
vikram@domain.hid$ ./satch
Xenomai: binding failed: Operation not permitted.
=================================================================================================

Can anyone tell me what is causing the issue here? Thanks!

- Vikram

