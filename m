MIME-Version: 1.0
Sender: danilo.delorenzo@gmail.com
In-Reply-To: <50085E4A.3090306@xenomai.org>
References: <CAHpmwf8eKDCN-4mzSpsgu64H+Kez_A+NPaqDCWOD8qHnU0oTmw@mail.gmail.com>
	<CAHpmwf_XO1G=6fMiddivbG+ud0FZqjh6_sp0V=zEv+mstOKorQ@mail.gmail.com>
	<50085E4A.3090306@xenomai.org>
Date: Fri, 20 Jul 2012 11:19:09 +0200
Message-ID: <CAHpmwf8_5wUQcLvv2jrU0+CK5ujjOiV4seWWOKNh1WO0ehrikg@mail.gmail.com>
From: Danilo De Lorenzo <danilo.delorenzo@mail.polimi.it>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] error on building xddp-echo example
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai@xenomai.org

Thanks! now I can build the examples successfully, but at runtime I still
get the error:

socket: Address family not supported by protocol

and this is the output of:

nm -s ./xddp-echo

0000000000601e10 d _DYNAMIC
0000000000601fe8 d _GLOBAL_OFFSET_TABLE_
0000000000401710 R _IO_stdin_used
                 w _Jv_RegisterClasses
0000000000601df0 d __CTOR_END__
0000000000601de8 d __CTOR_LIST__
0000000000601e00 D __DTOR_END__
0000000000601df8 d __DTOR_LIST__
0000000000401a48 r __FRAME_END__
00000000004018c0 r __FUNCTION__.5821
0000000000601e08 d __JCR_END__
0000000000601e08 d __JCR_LIST__
00000000006021a0 A __bss_start
0000000000602100 D __data_start
00000000004016c0 t __do_global_ctors_aux
0000000000400f60 t __do_global_dtors_aux
0000000000602108 D __dso_handle
                 U __errno_location@@GLIBC_2.2.5
                 w __gmon_start__
0000000000601de4 d __init_array_end
0000000000601de4 d __init_array_start
00000000004016b0 T __libc_csu_fini
0000000000401620 T __libc_csu_init
                 U __libc_start_main@@GLIBC_2.2.5
                 U __stack_chk_fail@@GLIBC_2.4
                 U __wrap_bind
                 U __wrap_clock_nanosleep
                 U __wrap_free
                 U __wrap_open
                 U __wrap_pthread_create
                 U __wrap_read
                 U __wrap_recvfrom
                 U __wrap_sendto
                 U __wrap_setsockopt
                 U __wrap_socket
                 U __wrap_write
00000000006021a0 A _edata
00000000006021c0 A _end
00000000004016f8 T _fini
0000000000400ce0 T _init
0000000000400f10 T _start
                 U asprintf@@GLIBC_2.2.5
0000000000400f3c t call_gmon_start
0000000000401399 T cleanup_upon_sig
00000000006021a0 b completed.6458
0000000000602100 W data_start
00000000006021a8 b dtor_idx.6460
                 U exit@@GLIBC_2.2.5
0000000000400ff4 t fail
0000000000400fd0 t frame_dummy
00000000004013fb T main
                 U mlockall@@GLIBC_2.2.5
0000000000602120 d msg
00000000006021b8 B nrt
                 U perror@@GLIBC_2.2.5
                 U pthread_attr_init@@GLIBC_2.2.5
                 U pthread_attr_setdetachstate@@GLIBC_2.2.5
                 U pthread_attr_setinheritsched@@GLIBC_2.2.5
                 U pthread_attr_setschedparam@@GLIBC_2.2.5
                 U pthread_attr_setschedpolicy@@GLIBC_2.2.5
                 U pthread_cancel@@GLIBC_2.2.5
                 U pthread_join@@GLIBC_2.2.5
                 U pthread_sigmask@@GLIBC_2.2.5
0000000000401016 T realtime_thread
0000000000401295 T regular_thread
00000000006021b0 B rt
                 U rt_print_auto_init
                 U rt_printf
                 U sigaddset@@GLIBC_2.2.5
                 U sigemptyset@@GLIBC_2.2.5
                 U signal@@GLIBC_2.2.5
                 U sigsuspend@@GLIBC_2.2.5


Danilo

On Thu, Jul 19, 2012 at 9:21 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 07/19/2012 07:18 PM, Danilo De Lorenzo wrote:
> > I'm getting this error when compiling the examples in the ipc folder
> >
> > gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
> > -Werror-implicit-function-
> > declaration -pipe -D__XENO__ -I/usr/xenomai/include/posix
> > -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt
> > -lxenomai -lpthread -lrt   -lrtdm -Xlinker -rpath -Xlinker
> > /usr/xenomai/lib  xddp-echo.c   -o xddp-echo
> >
> > /usr/bin/ld: /tmp/cc4VCXFp.o: undefined reference to symbol
> > 'pthread_sigmask@@GLIBC_2.2.5'
> > /usr/bin/ld: note: 'pthread_sigmask@@GLIBC_2.2.5' is defined in DSO
> > /lib/x86_64-linux-gnu/libpthread.so.0 so try adding it to the linker
> > command line
> > /lib/x86_64-linux-gnu/libpthread.so.0: could not read symbols: Invalid
> > operation
> > collect2: ld returned 1 exit status
> > make: *** [xddp-echo] Error 1
> >
> > Is this a xenomai bug or glibc library bug?
>
> Linker wants to see references first, for pulling symbols. Does this help?
>
> diff --git a/examples/rtdm/profiles/ipc/Makefile
> b/examples/rtdm/profiles/ipc/Makefile
> index 15da135..4ea38f0 100644
> --- a/examples/rtdm/profiles/ipc/Makefile
> +++ b/examples/rtdm/profiles/ipc/Makefile
> @@ -39,6 +39,9 @@ CFLAGS=$(shell $(XENOCONFIG) --skin=posix --cflags)
> $(MY_CFLAGS)
>
>  LDFLAGS=$(shell $(XENOCONFIG) --skin=posix --ldflags) $(MY_LDFLAGS) -lrtdm
>
> +%: %.c
> +       $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
> +
>  # Add the Xenomai libdir to the runtime library search path for the
>  # binary, to make life easier for beginners if Xenomai's libs are not
>  # in any default search path.
>
> >
> > Thanks
> >
> > Danilo
> > _______________________________________________
> > Xenomai mailing list
> > Xenomai@xenomai.org
> > http://www.xenomai.org/mailman/listinfo/xenomai
> >
>
>
> --
> Philippe.
>
>
>
