From: "Grau, Gunter" <gunter.grau@philips.com>
Subject: RE: gdb and loading a realtime library with dlopen()
Date: Mon, 17 May 2021 09:38:10 +0000
Message-ID: <DB7P122MB01063FBEA7EF5B151713DA2BF22D9@DB7P122MB0106.EURP122.PROD.OUTLOOK.COM>
References: <DB7P122MB010621AE2B56C8BAA64C8346F2529@DB7P122MB0106.EURP122.PROD.OUTLOOK.COM>
In-Reply-To: <DB7P122MB010621AE2B56C8BAA64C8346F2529@DB7P122MB0106.EURP122.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



> -----Original Message-----
> From: Grau, Gunter
> Sent: Mittwoch, 12. Mai 2021 08:32
> To: xenomai@xenomai.org
> Subject: gdb and loading a realtime library with dlopen()
>
> Hi,
>
> We currently porting a Xenomai application from 2.6 to 3.1. The platform =
is
> arm. The hardware is imx6.
> We are using xenomai 3.1.x branch on git.
>
> The application startup is done by a "loader" which is not linked with
> Xenomai, but it loads a shared library which contains the Xenomai realtim=
e
> part.
> Because of this, the Xenomai userspace is configured with --enable-dlopen=
-
> libs.
> The complete configuration line is:
> ../configure --host=3Darm-linux-gnueabi --enable-smp --build=3Di686-pc-li=
nux-
> gnu --prefix=3D/usr/xenomai --enable-dlopen-libs --enable-async-cancel
>
> Since the realtime part uses posix skin and alchemy (was native) skin as =
well,
> we enable both. Also auto-init-solib.
> xeno-config --rtdm --skin posix --skin alchemy --auto-init-solib --ldflag=
s
>
> When we start the loader / application via command line everything works
> fine. The dlopen call is successful and we can jump into the library usin=
g
> dlsym() for symbol lookup.
>
> But when we try to start the same application in gdb, the application han=
gs
> on dlopen(). Gdb backtrace look like it is waiting vor a mutex in the hea=
p init
> part of xenomai.
> I  wrote a short test loader and library (attached). The same happens her=
e.
> You can find the backtrace below. Gdb revision is 8.2.1.
>
> Any hints, what may be wrong?
>
> Thanks in advance,
> Gunter
>
>
[...]
>

Hi,

Since Jan asked me, but it was not CC on the mailing list.
This also happens to me with the dlopen test in smokey. So there is no need=
 to use my example code:

root@xxxxx:~/smokey/dlopen# gdb ./dlopentest GNU gdb (GDB) 8.2.1 Copyright =
(C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "arm-poky-linux-gnueabi".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./dlopentest...done.
(gdb) run
Starting program: /home/root/smokey/dlopen/dlopentest
warning: Unable to find libthread_db matching inferior's thread library, th=
read debugging will not be available.
[New LWP 4050]

Thread 1 "dlopentest" received signal SIGINT, Interrupt.
0x76e47360 in __cobalt_pthread_mutex_lock (mutex=3Dmutex@entry=3D0x76e07410=
 <heapmem_main>) at ../../../lib/cobalt/mutex.c:375
375     ../../../lib/cobalt/mutex.c: No such file or directory.
(gdb) backtrace
#0  0x76e47360 in __cobalt_pthread_mutex_lock (mutex=3Dmutex@entry=3D0x76e0=
7410 <heapmem_main>) at ../../../lib/cobalt/mutex.c:375
#1  0x76e4d8e8 in add_extent (heap=3Dheap@entry=3D0x76e07410 <heapmem_main>=
, mem=3Dmem@entry=3D0x762f3008, size=3Dsize@entry=3D2146400) at ../../../li=
b/boilerplate/heapmem.c:679
#2  0x76e4dec4 in heapmem_init (heap=3D0x76e07410 <heapmem_main>, mem=3Dmem=
@entry=3D0x762f3008, size=3Dsize@entry=3D2146400) at ../../../lib/boilerpla=
te/heapmem.c:711
#3  0x76df625c in heapobj_pkg_init_private () at ../../../lib/copperplate/h=
eapobj-heapmem.c:111
#4  0x76df2b08 in copperplate_init () at ../../../lib/copperplate/init.c:20=
4
#5  0x76e4ee18 in __xenomai_init (argcp=3Dargcp@entry=3D0x7effe624, argvp=
=3Dargvp@entry=3D0x7effe628, me=3D0x54abe2a0 "\230\336\253T") at ../../../l=
ib/boilerplate/setup.c:631
#6  0x76e4f390 in xenomai_init_dso (argcp=3Dargcp@entry=3D0x7effe624, argvp=
=3Dargvp@entry=3D0x7effe628) at ../../../lib/boilerplate/setup.c:693
#7  0x76e68738 in call_init (argvp=3D0x7effe628, argcp=3D0x7effe624) at ../=
../../../lib/boilerplate/init/bootstrap.c:169
#8  xenomai_bootstrap () at ../../../../lib/boilerplate/init/bootstrap.c:16=
9
#9  0x76fddc1c in call_init (l=3D<optimized out>, argc=3Dargc@entry=3D1, ar=
gv=3Dargv@entry=3D0x7efffca4, env=3Denv@entry=3D0x7efffcac) at dl-init.c:72
#10 0x76fddd20 in call_init (env=3D<optimized out>, argv=3D<optimized out>,=
 argc=3D<optimized out>, l=3D<optimized out>) at dl-init.c:30
#11 _dl_init (main_map=3Dmain_map@entry=3D0x54abc1b8, argc=3D1, argv=3D0x7e=
fffca4, env=3D0x7efffcac) at dl-init.c:119
#12 0x76fe1bd8 in dl_open_worker (a=3D<optimized out>) at dl-open.c:506
#13 0x76f85c5c in __GI__dl_catch_exception (exception=3D0x76f85c5c <__GI__d=
l_catch_exception+96>, operate=3D0x7effe930, args=3D0x7effe8ac) at dl-error=
-skeleton.c:196
#14 0x76fe1460 in _dl_open (file=3D0x7effeb28 "/usr/xenomai3/bin/libalchemy=
-test.so", mode=3D-2147483391, caller_dlopen=3D0x54aaa7cc <my_dlopen+92>, n=
sid=3D-2, argc=3D1, argv=3D0x7efffca4, env=3D0x7efffcac) at dl-open.c:588
#15 0x76fbbcdc in dlopen_doit (a=3D0x7effeb08) at dlopen.c:66
#16 0x76f85c5c in __GI__dl_catch_exception (exception=3D0x76f85c5c <__GI__d=
l_catch_exception+96>, exception@entry=3D0x7effeac4, operate=3D0x0, args=3D=
0x7effeacc, args@entry=3D0x76fbbc60 <dlopen_doit>) at dl-error-skeleton.c:1=
96
#17 0x76f85cd8 in __GI__dl_catch_error (objname=3D0x76fcd018 <last_result+1=
2>, errstring=3D0x76fcd01c <last_result+16>, mallocedp=3D0x76fcd014 <last_r=
esult+8>, operate=3D<optimized out>, args=3D0x7effeb08) at dl-error-skeleto=
n.c:215
#18 0x76fbc4c0 in _dlerror_run (operate=3D0x76fbbc60 <dlopen_doit>, args=3D=
args@entry=3D0x7effeb08) at dlerror.c:163
#19 0x76fbbd88 in __dlopen (file=3D0x7effeb28 "/usr/xenomai3/bin/libalchemy=
-test.so", mode=3D<optimized out>) at dlopen.c:87
#20 0x54aaa7cc in my_dlopen (name=3D<optimized out>) at ../../../../testsui=
te/smokey/dlopen/dlopentest.c:44
#21 0x54aaa808 in my_dlcall (lname=3D<optimized out>, fname=3D0x54aaa8e4 "l=
ibalchemy_func", handle=3D0x7efffb40) at ../../../../testsuite/smokey/dlope=
n/dlopentest.c:56
#22 0x54aaa55c in main (argc=3D<optimized out>, argv=3D<optimized out>) at =
../../../../testsuite/smokey/dlopen/dlopentest.c:70

________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.

