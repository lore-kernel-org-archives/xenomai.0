Date: Thu, 07 Sep 2017 15:36:22 +0000
Message-ID: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
From: Paul Wilkinson <paul.w@mrmoco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="Yes"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Description: Plaintext Message
Subject: [Xenomai] Questions around porting app to Xenomai/Cobalt resulting
 in SIGABRT ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I have a legacy multithreaded C++ app that requires one thread to run RT
and
communicate using EtherCAT via RTnet, I'm running Debian 8 + Xenomai 3.0.5
+
ipipe-core-4.9.24-x86-2.patch.

By extracting the functionality of that RT thread from the application and
creating a standalone POC (1RT + 2NRT threads) compiled and linked under
Xenomai Cobalt I've proved the RT & EtherCAT requirements can be met.

In addition to the RT requirement, a number of threads forming this
application
need to communicate with clients using TCP/IP via non-RTnet NIC.

To achieve this I prefixed all socket related calls in the class handling
TCP/IP with __real_ and compiled and linked the app using the xeno-config
output.

The app starts OK (I haven't rolled in the RT EtherCAT thread yet) with a
NRT thread  listening on a TCP/IP port, when a client connects over TCP/IP
the message is received and a NRT thread is created, immediately followed
by the following message .... and the app aborts.

terminate called after throwing an instance of 'std::system_error'
  what():  Operation not permitted

The application currently uses std::thread & std::mutex and I'm mindful
that
Xenomai/Cobalt may be reducing thread stack sizes, and that std::thread
doesn't seem to provide a mechanism to increase.

My questions :-

- is the approach I'm taking to allow threads of the class requiring TCP/IP
  comms reasonable, namely using __real_ on all socket related calls ?

- I'm assuming, but don't know for certain, that Zenomai/Cobalt has
  intercepted the pthread calls underlying std::thread ?
  'nm -a' executable shows _wrap_pthread*

- Does anyone have any insight into what could be causing this problem
and/or
  how I might further diagnose it ?

Any and all help very much appreciated.

Paul.

compile and link parameters :-

xeno-config --posix --cflags --skin=cobalt

-I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE
-D_REENTRANT -D__COBALT__ -D__COBALT_WRAP__

xeno-config --posix --ldflags --skin=cobalt

-Wl,--no-as-needed -Wl,@/usr/xenomai/lib/cobalt.wrappers
-Wl,@/usr/xenomai/lib/modechk.wrappers 
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt
-lmodechk -lpthread -lrt

actual gcc arguments :-

-std=c++14 -D_linux -DCONFIG_XENO_DEBUG -D__XENO__ -I/usr/xenomai/include
-I/usr/xenomai/include/cobalt -O0 -g3 -Wall -c -fmessage-length=0
-D_GNU_SOURCE -D_REENTRANT -D__COBALT__ -D__COBALT_WRAP_

-L/usr/xenomai/lib -Wl,--no-as-needed -Wl,@/usr/xenomai/lib/cobalt.wrappers
-Wl,@/usr/xenomai/lib/modechk.wrappers 
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt
-lmodechk -lpthread -lrt -pthread

The gdb session output.

# gdb ./XenomaiDemo
GNU gdb (Debian 7.7.1+dfsg-5) 7.7.1
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./XenomaiDemo...done.
(gdb) r
Starting program: /home/paul/Xenomai/server/XenomaiDemo/Debug/XenomaiDemo
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff69c6700 (LWP 3487)]
   0"000.005| WARNING: [main] Xenomai compiled with partial debug
enabled,
                              high latencies
expected [--enable-debug=partial]
Starting System...
[New Thread 0x7ffff61c5700 (LWP 3488)]
XenomaiDemo Server Started
Running in Dynamic Mode
[New Thread 0x7ffff59c4700 (LWP 3489)]
[New Thread 0x7ffff51c3700 (LWP 3490)]
[New Thread 0x7ffff49c2700 (LWP 3491)]
[New Thread 0x7fffeffff700 (LWP 3492)]
XenomaiDemo Server listening for clients on port 26000
[New Thread 0x7fffef7fe700 (LWP 3493)]
terminate called after throwing an instance of 'std::system_error'
  what():  Operation not permitted

Program received signal SIGABRT, Aborted.
[Switching to Thread 0x7fffef7fe700 (LWP 3493)]
0x00007ffff69fc067 in __GI_raise (sig=sig@entry=6) at
../nptl/sysdeps/unix/sysv/linux/raise.c:56
56    ../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or
directory.
(gdb) bt
#0  0x00007ffff69fc067 in __GI_raise (sig=sig@entry=6) at
../nptl/sysdeps/unix/sysv/linux/raise.c:56
#1  0x00007ffff69fd448 in __GI_abort () at abort.c:89
#2  0x00007ffff72e9b3d in __gnu_cxx::__verbose_terminate_handler() () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#3  0x00007ffff72e7bb6 in ?? () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#4  0x00007ffff72e7c01 in std::terminate() () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007ffff733fa01 in ?? () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#6  0x00007ffff77a4064 in start_thread (arg=0x7fffef7fe700) at
pthread_create.c:309
#7  0x00007ffff6aaf62d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111
(gdb)
