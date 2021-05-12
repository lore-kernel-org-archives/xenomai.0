From: "Grau, Gunter" <gunter.grau@philips.com>
Subject: gdb and loading a realtime library with dlopen()
Date: Wed, 12 May 2021 06:32:10 +0000
Message-ID: <DB7P122MB010621AE2B56C8BAA64C8346F2529@DB7P122MB0106.EURP122.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

We currently porting a Xenomai application from 2.6 to 3.1. The platform is=
 arm. The hardware is imx6.
We are using xenomai 3.1.x branch on git.

The application startup is done by a "loader" which is not linked with Xeno=
mai, but it loads a shared library which contains the Xenomai realtime part.
Because of this, the Xenomai userspace is configured with --enable-dlopen-l=
ibs.
The complete configuration line is:
../configure --host=3Darm-linux-gnueabi --enable-smp --build=3Di686-pc-linu=
x-gnu --prefix=3D/usr/xenomai --enable-dlopen-libs --enable-async-cancel

Since the realtime part uses posix skin and alchemy (was native) skin as we=
ll, we enable both. Also auto-init-solib.
xeno-config --rtdm --skin posix --skin alchemy --auto-init-solib --ldflags

When we start the loader / application via command line everything works fi=
ne. The dlopen call is successful and we can jump into the library using dl=
sym() for symbol lookup.

But when we try to start the same application in gdb, the application hangs=
 on dlopen(). Gdb backtrace look like it is waiting vor a mutex in the heap=
 init part of xenomai.
I  wrote a short test loader and library (attached). The same happens here.=
 You can find the backtrace below. Gdb revision is 8.2.1.

Any hints, what may be wrong?

Thanks in advance,
Gunter


Output of test when started on commandline:
Main will now open
I am the lib my_lib_entry_point
The result of my lib was 0

Backtrace of test when started in gdb and "hangs":
(gdb) backtrace
#0  0x76de0360 in __cobalt_pthread_mutex_lock (mutex=3Dmutex@entry=3D0x76e1=
a410 <heapmem_main>) at ../../../lib/cobalt/mutex.c:375
#1  0x76de68e8 in add_extent (heap=3Dheap@entry=3D0x76e1a410 <heapmem_main>=
, mem=3Dmem@entry=3D0x763d8008, size=3Dsize@entry=3D1073248) at ../../../li=
b/boilerplate/heapmem.c:679
#2  0x76de6ec4 in heapmem_init (heap=3D0x76e1a410 <heapmem_main>, mem=3Dmem=
@entry=3D0x763d8008, size=3Dsize@entry=3D1073248) at ../../../lib/boilerpla=
te/heapmem.c:711
#3  0x76e0925c in heapobj_pkg_init_private () at ../../../lib/copperplate/h=
eapobj-heapmem.c:111
#4  0x76e05b08 in copperplate_init () at ../../../lib/copperplate/init.c:204
#5  0x76de7e18 in __xenomai_init (argcp=3Dargcp@entry=3D0x7efff694, argvp=
=3Dargvp@entry=3D0x7efff698, me=3D0x0) at ../../../lib/boilerplate/setup.c:=
631
#6  0x76de8390 in xenomai_init_dso (argcp=3Dargcp@entry=3D0x7efff694, argvp=
=3Dargvp@entry=3D0x7efff698) at ../../../lib/boilerplate/setup.c:693
#7  0x76e3b6b4 in call_init (argvp=3D0x7efff698, argcp=3D0x7efff694) at ../=
../../../lib/boilerplate/init/bootstrap.c:169
#8  xenomai_bootstrap () at ../../../../lib/boilerplate/init/bootstrap.c:169
#9  0x76fddc1c in call_init (l=3D<optimized out>, argc=3Dargc@entry=3D1, ar=
gv=3Dargv@entry=3D0x7efffce4, env=3Denv@entry=3D0x7efffcec) at dl-init.c:72
#10 0x76fddd20 in call_init (env=3D<optimized out>, argv=3D<optimized out>,=
 argc=3D<optimized out>, l=3D<optimized out>) at dl-init.c:30
#11 _dl_init (main_map=3Dmain_map@entry=3D0x54abd168, argc=3D1, argv=3D0x7e=
fffce4, env=3D0x7efffcec) at dl-init.c:119
#12 0x76fe1bd8 in dl_open_worker (a=3D<optimized out>) at dl-open.c:506
#13 0x76f58c5c in __GI__dl_catch_exception (exception=3D0x76f58c5c <__GI__d=
l_catch_exception+96>, operate=3D0x7efff9a0, args=3D0x7efff91c) at dl-error=
-skeleton.c:196
#14 0x76fe1460 in _dl_open (file=3D0x54aaa7b8 "./mylib.so", mode=3D-2147483=
638, caller_dlopen=3D0x54aaa558 <main(int, char**)+32>, nsid=3D-2, argc=3D1=
, argv=3D0x7efffce4, env=3D0x7efffcec) at dl-open.c:588
#15 0x76fbbcdc in dlopen_doit (a=3D0x7efffb78) at dlopen.c:66
#16 0x76f58c5c in __GI__dl_catch_exception (exception=3D0x76f58c5c <__GI__d=
l_catch_exception+96>, exception@entry=3D0x7efffb34, operate=3D0x0, args=3D=
0x7efffb3c, args@entry=3D0x76fbbc60 <dlopen_doit>) at dl-error-skeleton.c:1=
96
#17 0x76f58cd8 in __GI__dl_catch_error (objname=3D0x76fcd018 <last_result+1=
2>, errstring=3D0x76fcd01c <last_result+16>, mallocedp=3D0x76fcd014 <last_r=
esult+8>, operate=3D<optimized out>, args=3D0x7efffb78) at dl-error-skeleto=
n.c:215
#18 0x76fbc4c0 in _dlerror_run (operate=3D0x76fbbc60 <dlopen_doit>, args=3D=
args@entry=3D0x7efffb78) at dlerror.c:163
#19 0x76fbbd88 in __dlopen (file=3D0x54aaa7b8 "./mylib.so", mode=3D<optimiz=
ed out>) at dlopen.c:87
#20 0x54aaa558 in main () at main.cpp:11

Gunter Grau
Product Owner
Philips Philips Medizin Systeme B=F6blingen GmbH, Hewlett-Packard-Strasse 2=
, 71034 B=F6blingen, Germany
Email: gunter.grau@philips.com | www.philips.com/healthcare


________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xenomai3-gdb-test.tar.gz
Type: application/x-gzip
Size: 987 bytes
Desc: xenomai3-gdb-test.tar.gz
URL: <http://xenomai.org/pipermail/xenomai/attachments/20210512/325958b3/at=
tachment.bin>
