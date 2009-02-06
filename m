Message-ID: <498C0EBE.5000004@domain.hid>
Date: Fri, 06 Feb 2009 11:19:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B3F8896E1733D4787DDB0EA1C7FF91F704347@domain.hid>
In-Reply-To: <4B3F8896E1733D4787DDB0EA1C7FF91F704347@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] lib order fails for xeno-config --posix-ldflags
 on	Blackfin
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
To: Mike McTernan <mmcternan@domain.hid>
Cc: xenomai@xenomai.org

Mike McTernan wrote:
> Hi,
> 
> Checking xeno-config.in from 2.4.1, it has the following:
> 

Please upgrade. The Xenomai/blackfin port is actively maintained, and bugs have
been fixed since then.

> XENO_POSIX_LDFLAGS="-L${staging}${libdir} -lpthread_rt -lpthread -lrt
> @XENO_USER_APP_LDFLAGS@"
> 
> On Blackfin uClinux 2008R1.5 linking fails with -lpthread_rt and
> -lpthread in that order:
> 
> bfin-uclinux-gcc -I/usr/xenomai/include -I/usr/xenomai/include/posix

This should rather be bfin-linux-uclibc-gcc to produce fdpic binaries;
bfin-uclinux-gcc should be used to build the ELF kernel or FLAT format apps.
Xenomai user-space support should be built using bfin-linux-uclibc-gcc.

> -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -o hello hello.o
> -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt
> -lpthread -lrt
> /opt/uClinux/bfin-uclinux/bfin-uclinux/runtime/usr/lib/libpthread.a(mute
> x.os): In function `__pthread_once_fork_child':
> libpthread/linuxthreads.old/mutex.c:357: undefined reference to
> `___wrap_pthread_cond_init'
> /opt/uClinux/bfin-uclinux/bfin-uclinux/runtime/usr/lib/libpthread.a(mute
> x.os): In function `__pthread_once':
> libpthread/linuxthreads.old/mutex.c:308: undefined reference to
> `___wrap_pthread_cond_wait'
> libpthread/linuxthreads.old/mutex.c:325: undefined reference to
> `___wrap_pthread_cond_broadcast'
> /opt/uClinux/bfin-uclinux/bfin-uclinux/runtime/usr/lib/libpthread.a(mute
> x.os): In function `pthread_once_cancelhandler':
> libpthread/linuxthreads.old/mutex.c:281: undefined reference to
> `___wrap_pthread_cond_broadcast'
> collect2: ld returned 1 exit status
> make: *** [hello] Error 1
> 
> It looks like the uClinux pthread implementation makes use of its own
> functions and hence needs the library containing the wrappers specified
> after the pthread lib to enable resolving of references, as per the ld
> manual:
> 
> "Normally, an archive is searched only once in the order that it is
> specified on the command line. If a symbol in that archive is needed to
> resolve an undefined symbol referred to by an object in an archive that
> appears later on the command line, the linker would not be able to
> resolve that reference."
> 
> I'd have thought there are potentially some circular dependencies
> between the pthread and pthread_rt libs.  Would it help portability to
> surround these options with -Wl,--start-group <libs> -Wl,--end-group?
> i.e.
> 
> XENO_POSIX_LDFLAGS="-L${staging}${libdir} -Wl,--start-group -lpthread_rt
> -lpthread -Wl,--end-group -lrt @XENO_USER_APP_LDFLAGS@"
> 
> I've done this locally and I can build the apps without re-ordering the
> libraries.
> 

Which is likely not going to run properly. uClibc does not want to call the
Xenomai wrappers from its internal code, but its own code, because it should
apply to regular linuxthreads, not Xenomai-enabled RT threads. The only sane way
to solve this kind of dependencies properly would be to go for a two-stage
linking phase, i.e. first you do a partial link with your app and the Xenomai
libraries applying the wrappers (-Wl,@/usr/xenomai/lib/posix.wrappers), then you
complete the link without any wrapping against libpthread.so.

Here is a trivial Makefile I have just used to produce an executable against
2008-r1.5-rc3 and 2.4.1, without any problem. Obviously this also depends on the
references dragged in by your example code; mine was pulling condvar, mutex and
thread support through the common pthread_* calls. If this simple Makefile does
not work with a properly built Xenomai userland support, I'd be interested to
see your example code. TIA,

X := /usr/xenomai/blackfin
CFLAGS := $(shell $(X)/bin/xeno-config --posix-cflags)
LDFLAGS := $(shell $(X)/bin/xeno-config --posix-ldflags)
CC :=  $(shell $(X)/bin/xeno-config --cc)

all: hello

hello: hello.c
	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)

clean:
	$(RM) hello

> Regards,
> 
> Mike
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

