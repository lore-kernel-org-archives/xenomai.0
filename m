Subject: Re: gdb and loading a realtime library with dlopen()
References: <DB7P122MB010621AE2B56C8BAA64C8346F2529@DB7P122MB0106.EURP122.PROD.OUTLOOK.COM>
 <DB7P122MB01063FBEA7EF5B151713DA2BF22D9@DB7P122MB0106.EURP122.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7b8fa29c-edd7-43dd-20e7-f9fba8e8348f@siemens.com>
Date: Mon, 17 May 2021 18:04:51 +0200
MIME-Version: 1.0
In-Reply-To: <DB7P122MB01063FBEA7EF5B151713DA2BF22D9@DB7P122MB0106.EURP122.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Grau, Gunter" <gunter.grau@philips.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 17.05.21 11:38, Grau, Gunter wrote:
> 
> 
>> -----Original Message-----
>> From: Grau, Gunter
>> Sent: Mittwoch, 12. Mai 2021 08:32
>> To: xenomai@xenomai.org
>> Subject: gdb and loading a realtime library with dlopen()
>>
>> Hi,
>>
>> We currently porting a Xenomai application from 2.6 to 3.1. The platform is
>> arm. The hardware is imx6.
>> We are using xenomai 3.1.x branch on git.
>>
>> The application startup is done by a "loader" which is not linked with
>> Xenomai, but it loads a shared library which contains the Xenomai realtime
>> part.
>> Because of this, the Xenomai userspace is configured with --enable-dlopen-
>> libs.
>> The complete configuration line is:
>> ../configure --host=arm-linux-gnueabi --enable-smp --build=i686-pc-linux-
>> gnu --prefix=/usr/xenomai --enable-dlopen-libs --enable-async-cancel
>>
>> Since the realtime part uses posix skin and alchemy (was native) skin as well,
>> we enable both. Also auto-init-solib.
>> xeno-config --rtdm --skin posix --skin alchemy --auto-init-solib --ldflags
>>
>> When we start the loader / application via command line everything works
>> fine. The dlopen call is successful and we can jump into the library using
>> dlsym() for symbol lookup.
>>
>> But when we try to start the same application in gdb, the application hangs
>> on dlopen(). Gdb backtrace look like it is waiting vor a mutex in the heap init
>> part of xenomai.
>> I  wrote a short test loader and library (attached). The same happens here.
>> You can find the backtrace below. Gdb revision is 8.2.1.
>>
>> Any hints, what may be wrong?
>>
>> Thanks in advance,
>> Gunter
>>
>>
> [...]
>>
> 
> Hi,
> 
> Since Jan asked me, but it was not CC on the mailing list.
> This also happens to me with the dlopen test in smokey. So there is no need to use my example code:
> 
> root@xxxxx:~/smokey/dlopen# gdb ./dlopentest GNU gdb (GDB) 8.2.1 Copyright (C) 2018 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "arm-poky-linux-gnueabi".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>     <http://www.gnu.org/software/gdb/documentation/>.
> 
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ./dlopentest...done.
> (gdb) run
> Starting program: /home/root/smokey/dlopen/dlopentest
> warning: Unable to find libthread_db matching inferior's thread library, thread debugging will not be available.
> [New LWP 4050]
> 
> Thread 1 "dlopentest" received signal SIGINT, Interrupt.
> 0x76e47360 in __cobalt_pthread_mutex_lock (mutex=mutex@entry=0x76e07410 <heapmem_main>) at ../../../lib/cobalt/mutex.c:375
> 375     ../../../lib/cobalt/mutex.c: No such file or directory.
> (gdb) backtrace
> #0  0x76e47360 in __cobalt_pthread_mutex_lock (mutex=mutex@entry=0x76e07410 <heapmem_main>) at ../../../lib/cobalt/mutex.c:375
> #1  0x76e4d8e8 in add_extent (heap=heap@entry=0x76e07410 <heapmem_main>, mem=mem@entry=0x762f3008, size=size@entry=2146400) at ../../../lib/boilerplate/heapmem.c:679
> #2  0x76e4dec4 in heapmem_init (heap=0x76e07410 <heapmem_main>, mem=mem@entry=0x762f3008, size=size@entry=2146400) at ../../../lib/boilerplate/heapmem.c:711
> #3  0x76df625c in heapobj_pkg_init_private () at ../../../lib/copperplate/heapobj-heapmem.c:111
> #4  0x76df2b08 in copperplate_init () at ../../../lib/copperplate/init.c:204
> #5  0x76e4ee18 in __xenomai_init (argcp=argcp@entry=0x7effe624, argvp=argvp@entry=0x7effe628, me=0x54abe2a0 "\230\336\253T") at ../../../lib/boilerplate/setup.c:631
> #6  0x76e4f390 in xenomai_init_dso (argcp=argcp@entry=0x7effe624, argvp=argvp@entry=0x7effe628) at ../../../lib/boilerplate/setup.c:693
> #7  0x76e68738 in call_init (argvp=0x7effe628, argcp=0x7effe624) at ../../../../lib/boilerplate/init/bootstrap.c:169
> #8  xenomai_bootstrap () at ../../../../lib/boilerplate/init/bootstrap.c:169
> #9  0x76fddc1c in call_init (l=<optimized out>, argc=argc@entry=1, argv=argv@entry=0x7efffca4, env=env@entry=0x7efffcac) at dl-init.c:72
> #10 0x76fddd20 in call_init (env=<optimized out>, argv=<optimized out>, argc=<optimized out>, l=<optimized out>) at dl-init.c:30
> #11 _dl_init (main_map=main_map@entry=0x54abc1b8, argc=1, argv=0x7efffca4, env=0x7efffcac) at dl-init.c:119
> #12 0x76fe1bd8 in dl_open_worker (a=<optimized out>) at dl-open.c:506
> #13 0x76f85c5c in __GI__dl_catch_exception (exception=0x76f85c5c <__GI__dl_catch_exception+96>, operate=0x7effe930, args=0x7effe8ac) at dl-error-skeleton.c:196
> #14 0x76fe1460 in _dl_open (file=0x7effeb28 "/usr/xenomai3/bin/libalchemy-test.so", mode=-2147483391, caller_dlopen=0x54aaa7cc <my_dlopen+92>, nsid=-2, argc=1, argv=0x7efffca4, env=0x7efffcac) at dl-open.c:588
> #15 0x76fbbcdc in dlopen_doit (a=0x7effeb08) at dlopen.c:66
> #16 0x76f85c5c in __GI__dl_catch_exception (exception=0x76f85c5c <__GI__dl_catch_exception+96>, exception@entry=0x7effeac4, operate=0x0, args=0x7effeacc, args@entry=0x76fbbc60 <dlopen_doit>) at dl-error-skeleton.c:196
> #17 0x76f85cd8 in __GI__dl_catch_error (objname=0x76fcd018 <last_result+12>, errstring=0x76fcd01c <last_result+16>, mallocedp=0x76fcd014 <last_result+8>, operate=<optimized out>, args=0x7effeb08) at dl-error-skeleton.c:215
> #18 0x76fbc4c0 in _dlerror_run (operate=0x76fbbc60 <dlopen_doit>, args=args@entry=0x7effeb08) at dlerror.c:163
> #19 0x76fbbd88 in __dlopen (file=0x7effeb28 "/usr/xenomai3/bin/libalchemy-test.so", mode=<optimized out>) at dlopen.c:87
> #20 0x54aaa7cc in my_dlopen (name=<optimized out>) at ../../../../testsuite/smokey/dlopen/dlopentest.c:44
> #21 0x54aaa808 in my_dlcall (lname=<optimized out>, fname=0x54aaa8e4 "libalchemy_func", handle=0x7efffb40) at ../../../../testsuite/smokey/dlopen/dlopentest.c:56
> #22 0x54aaa55c in main (argc=<optimized out>, argv=<optimized out>) at ../../../../testsuite/smokey/dlopen/dlopentest.c:70
> 

Cannot reproduce yet:
 - xenomai-images, kas.yml:board-qemu-armhf.yml
    -> xenomai 5714ceede7 / kernel 01a25dbcf1
 - gdb /usr/lib/xenomai/testsuite/dlopentest
    -> happily runs and terminates

Could you do some comparison of your setup to that one?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

