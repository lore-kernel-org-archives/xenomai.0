Message-ID: <50498592.3090204@vareka.com>
Date: Fri, 07 Sep 2012 00:26:42 -0500
From: Bill Vareka <bill@vareka.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] Problem with MALLOC_CHECK_
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

   We've discovered a weird problem.  Basically, when using the xenomai =

posix skin and allocating and releasing large amounts of memory in a =

secondary mode thread, the application corrupts the entire system =

(kernel and all) *if* the MALLOC_CHECK_ macro is disabled.  Attached is =

a simple c++ demo program showing this problem (compile with gcc).  If =

you compile using standard posix it works no matter what.  If you =

compile using the xenomai posix skin, then if the environment variable =

MALLOC_CHECK_=3D3 then the program runs fine with no problems.  However, =

if you run with MALLOC_CHECK_=3D0 then the program appears to corrupt =

system memory.   After running this program, less, cat, and other =

standard programs now segfault and won't run.  Also in our case, we see =

that the output of ifconfig is also corrupted (shows table data rather =

than normal format).  The kernel is completely unstable.
We have encountered the problem before without identifying the source.  =

Currently this affected us because our application ran fine under a =

login shell when testing (since it automatically defined the env var) =

but when we added a launch script to sysVinit to automatically launch it =

at startup, it failed because the environmental variables were much =

different there and did not define this variable.

Again, our app is C++ and this test is with stl strings but I strongly =

suspect the same behavior can be generated using a standard C program =

and malloc/free.

Our setup:

architecture x86 32-bit
Linux 2.6.38.8
adeos ipipe 2.11-01
xenomai-2.6.1
gcc46-4.6.2_20111026-1.1.4.i586
libstdc++46-4.6.2_20111026-1.1.4.i586
glibc-2.14.1-14.12.2.i686

Regards,
Bill Vareka
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: memtst.cpp
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120907/ad3c81c=
5/attachment.ksh>
