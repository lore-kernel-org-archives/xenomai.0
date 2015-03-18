MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <CAKk99t2arbqbKke7EdM8accaghhdYstyVFQiysYoYB1LPGjnKA@mail.gmail.com>
References: <CAKk99t3x2u4GN0D2w_pSBY8jWVRuE1yFki66dYNUfFBSd2GQ6w@mail.gmail.com>
 <CAKk99t2arbqbKke7EdM8accaghhdYstyVFQiysYoYB1LPGjnKA@mail.gmail.com>
Date: Wed, 18 Mar 2015 16:07:43 +0000
Message-ID: <CAKk99t0-b0bkndpxVDkFq-_pqzpq4FdEzV6nULMHq6bd+JkihQ@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Makefile to use 2 APIs (rtdm and alchemy)
	simultaneously
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Helder Daniel <hdaniel@ualg.pt>

I also took a look here:

http://comments.gmane.org/gmane.linux.real-time.xenomai.users/11767

I did a: nm -s xddp-echo > symbols

cat symbols | grep sock
                 U __wrap_setsockopt
                 U __wrap_socket

So the wrappers seems to be applied.

I ran the example a few hours ago.

Xenomai version is:

/usr/xenomai/sbin/version -a
Xenomai/cobalt v3.0-rc3 --
Target: x86_64-unknown-linux-gnu
Compiler: gcc version 4.9.2 (Debian 4.9.2-10)
Build args:  '--with-core=cobalt' '--enable-registry' '--enable-pshared'
'--enable-debug' '--enable-smp'

Coblat kernel seems to boot fine:

 dmesg | grep -i xeno
[    1.607919] [Xenomai] scheduling class idle registered.
[    1.607942] [Xenomai] scheduling class rt registered.
[    1.608222] I-pipe: head domain Xenomai registered.
[    1.624274] [Xenomai] Cobalt v3.0-rc3 (Exact Zero)
[   19.973669] *** RTnet for Xenomai v3.0-rc3 ***


Here is the complete output of: nm -s xddp-echo

                 U asprintf@@GLIBC_2.2.5
0000000000601cc0 B __bss_start
0000000000601cc0 b completed.6661
0000000000601c00 D __data_start
0000000000601c00 W data_start
0000000000400ee0 t deregister_tm_clones
0000000000400f60 t __do_global_dtors_aux
0000000000601898 t __do_global_dtors_aux_fini_array_entry
0000000000601c08 D __dso_handle
00000000006018a8 d _DYNAMIC
0000000000601cc0 D _edata
0000000000601cd8 B _end
                 U __errno_location@@GLIBC_2.2.5
                 U exit@@GLIBC_2.2.5
0000000000400fa6 t fail
0000000000401514 T _fini
0000000000400f80 t frame_dummy
0000000000601890 t __frame_dummy_init_array_entry
0000000000401888 r __FRAME_END__
00000000004016d0 r __FUNCTION__.6521
0000000000601ac0 d _GLOBAL_OFFSET_TABLE_
                 w __gmon_start__
0000000000400c88 T _init
0000000000601898 t __init_array_end
0000000000601890 t __init_array_start
0000000000401520 R _IO_stdin_used
                 w _ITM_deregisterTMCloneTable
                 w _ITM_registerTMCloneTable
00000000006018a0 d __JCR_END__
00000000006018a0 d __JCR_LIST__
                 w _Jv_RegisterClasses
0000000000401510 T __libc_csu_fini
00000000004014a0 T __libc_csu_init
                 U __libc_start_main@@GLIBC_2.2.5
000000000040128e T main
                 U memset@@GLIBC_2.2.5
0000000000601c40 d msg
0000000000601cd0 B nrt
                 U perror@@GLIBC_2.2.5
                 U pthread_attr_init@@GLIBC_2.2.5
                 U pthread_attr_setdetachstate@@GLIBC_2.2.5
                 U pthread_attr_setinheritsched@@GLIBC_2.2.5
                 U pthread_attr_setschedparam@@GLIBC_2.2.5
                 U pthread_attr_setschedpolicy@@GLIBC_2.2.5
                 U pthread_cancel@@GLIBC_2.2.5
                 U pthread_sigmask@@GLIBC_2.2.5
0000000000400fc8 t realtime_thread
0000000000400f20 t register_tm_clones
00000000004011ba t regular_thread
0000000000601cc8 B rt
                 U sigaddset@@GLIBC_2.2.5
                 U sigemptyset@@GLIBC_2.2.5
0000000000400eb0 T _start
                 U strlen@@GLIBC_2.2.5
0000000000601cc0 D __TMC_END__
                 U __wrap_bind
                 U __wrap_clock_nanosleep
                 U __wrap_free
                 U __wrap_open
                 U __wrap_printf
                 U __wrap_pthread_create
                 U __wrap_pthread_join
                 U __wrap_read
                 U __wrap_recvfrom
                 U __wrap_sendto
                 U __wrap_setsockopt
                 U __wrap_sigwait
                 U __wrap_socket
                 U __wrap_write


On 18 March 2015 at 15:54, Helder Daniel <hdaniel@ualg.pt> wrote:

> It seems that the problem is not as simple as I thought.
> Now I can not run even: xddp-echo.c example.
> It gives always the same error:
>
> socket: address family not supported by protocol
>
> I take a look in the Xenomai forum:
>
> http://www.xenomai.org/pipermail/xenomai/2014-February/030127.html
>
> And the app is compiled with the wrap flags:
>
> cc -o xddp-echo xddp-echo.c -I/usr/xenomai/include/cobalt
> -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__COBALT__
> -Wl,@/usr/xenomai/lib/cobalt.wrappers   -L/usr/xenomai/lib -lcobalt
> -lpthread -lrt    -lfuse
>
> Now I am stucked. Any suggestions on what might be happening?
>
>
> On 18 March 2015 at 15:12, Helder Daniel <hdaniel@ualg.pt> wrote:
>
>> Hi
>>
>> I translated the xddp-echo.c example to work with alchemy and rt_tasks
>> rather than posix threads.
>>
>> It was needed to include the header for alchemy tasks: #include
>> <alchemy/task.h> and maintain: <rtdm.h/ipc.h>
>>
>> It was compiled with a simple make file specifying in xeno-config just
>> alchemy skin to get the compilation flags, however when running it gives an
>> error:
>>
>> socket address family not supported by protocol
>>
>> To workaround the makefile was modified to get the compilation flags for
>> both skins (as shown below).
>>
>> But there are any other way of compiling programs that use XDDP real time
>> sockets and alchemy API?
>>
>> For the original version POSIX version xeno-config returns the correct
>> compilation flags specifying rtdm skin or posix skin. It is not needed to
>> specify both.
>>
>> The makefile to get flags for RTDM and Alchemy:
>>
>>
>> https://xenomai.org/documentation/trunk/html/api/xddp-label_8c-example.html
>>
>> the compilation flags to compile it
>>
>> skin1   :=  alchemy
>> skin2   :=  rtdm
>>
>> CFLAGS  := $(shell xeno-config --skin=$(skin1) --cflags)
>> CFLAGS  += $(shell xeno-config --skin=$(skin2) --cflags)
>> LDFLAGS := $(shell xeno-config --skin=$(skin1) --ldflags)
>> LDFLAGS += $(shell xeno-config --skin=$(skin2) --ldflags)
>>
>> $(target): $(target).c
>> $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
>>
>>
>>
>> --
>> Helder Daniel
>> UALG - FCT
>> DEEI
>>
>> http://w3.ualg.pt/~hdaniel
>>
>
>
>
> --
> Helder Daniel
> UALG - FCT
> DEEI
>
> http://w3.ualg.pt/~hdaniel
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
