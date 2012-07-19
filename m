Message-ID: <50085E4A.3090306@xenomai.org>
Date: Thu, 19 Jul 2012 21:21:46 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAHpmwf8eKDCN-4mzSpsgu64H+Kez_A+NPaqDCWOD8qHnU0oTmw@mail.gmail.com>
	<CAHpmwf_XO1G=6fMiddivbG+ud0FZqjh6_sp0V=zEv+mstOKorQ@mail.gmail.com>
In-Reply-To: <CAHpmwf_XO1G=6fMiddivbG+ud0FZqjh6_sp0V=zEv+mstOKorQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] error on building xddp-echo example
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Danilo De Lorenzo <danilo.delorenzo@mail.polimi.it>
Cc: Xenomai@xenomai.org

On 07/19/2012 07:18 PM, Danilo De Lorenzo wrote:
> I'm getting this error when compiling the examples in the ipc folder
> 
> gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
> -Werror-implicit-function-
> declaration -pipe -D__XENO__ -I/usr/xenomai/include/posix
> -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt
> -lxenomai -lpthread -lrt   -lrtdm -Xlinker -rpath -Xlinker
> /usr/xenomai/lib  xddp-echo.c   -o xddp-echo
> 
> /usr/bin/ld: /tmp/cc4VCXFp.o: undefined reference to symbol
> 'pthread_sigmask@@GLIBC_2.2.5'
> /usr/bin/ld: note: 'pthread_sigmask@@GLIBC_2.2.5' is defined in DSO
> /lib/x86_64-linux-gnu/libpthread.so.0 so try adding it to the linker
> command line
> /lib/x86_64-linux-gnu/libpthread.so.0: could not read symbols: Invalid
> operation
> collect2: ld returned 1 exit status
> make: *** [xddp-echo] Error 1
> 
> Is this a xenomai bug or glibc library bug?

Linker wants to see references first, for pulling symbols. Does this help?

diff --git a/examples/rtdm/profiles/ipc/Makefile b/examples/rtdm/profiles/ipc/Makefile
index 15da135..4ea38f0 100644
--- a/examples/rtdm/profiles/ipc/Makefile
+++ b/examples/rtdm/profiles/ipc/Makefile
@@ -39,6 +39,9 @@ CFLAGS=$(shell $(XENOCONFIG) --skin=posix --cflags) $(MY_CFLAGS)
 
 LDFLAGS=$(shell $(XENOCONFIG) --skin=posix --ldflags) $(MY_LDFLAGS) -lrtdm
 
+%: %.c
+	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
+
 # Add the Xenomai libdir to the runtime library search path for the
 # binary, to make life easier for beginners if Xenomai's libs are not
 # in any default search path.

> 
> Thanks
> 
> Danilo
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.



