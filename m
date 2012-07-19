MIME-Version: 1.0
Sender: danilo.delorenzo@gmail.com
In-Reply-To: <CAHpmwf8eKDCN-4mzSpsgu64H+Kez_A+NPaqDCWOD8qHnU0oTmw@mail.gmail.com>
References: <CAHpmwf8eKDCN-4mzSpsgu64H+Kez_A+NPaqDCWOD8qHnU0oTmw@mail.gmail.com>
Date: Thu, 19 Jul 2012 19:18:20 +0200
Message-ID: <CAHpmwf_XO1G=6fMiddivbG+ud0FZqjh6_sp0V=zEv+mstOKorQ@mail.gmail.com>
From: Danilo De Lorenzo <danilo.delorenzo@mail.polimi.it>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] error on building xddp-echo example
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

I'm getting this error when compiling the examples in the ipc folder

gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
-Werror-implicit-function-
declaration -pipe -D__XENO__ -I/usr/xenomai/include/posix
-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt
-lxenomai -lpthread -lrt   -lrtdm -Xlinker -rpath -Xlinker
/usr/xenomai/lib  xddp-echo.c   -o xddp-echo

/usr/bin/ld: /tmp/cc4VCXFp.o: undefined reference to symbol
'pthread_sigmask@@GLIBC_2.2.5'
/usr/bin/ld: note: 'pthread_sigmask@@GLIBC_2.2.5' is defined in DSO
/lib/x86_64-linux-gnu/libpthread.so.0 so try adding it to the linker
command line
/lib/x86_64-linux-gnu/libpthread.so.0: could not read symbols: Invalid
operation
collect2: ld returned 1 exit status
make: *** [xddp-echo] Error 1

Is this a xenomai bug or glibc library bug?

Thanks

Danilo
