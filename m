From: Greg Bentley <gbentley@domain.hid>
Date: Thu, 22 Jan 2009 10:23:18 -0600
Message-Id: <1232641398.13734.110.camel@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=-1dEfdA5NfQXMqBgHcTFf"
Subject: [Xenomai-help] Compiler Errors with User Space Tools for 2.4.6.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--=-1dEfdA5NfQXMqBgHcTFf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I am working on getting Xenomai 2.4.6.1 working on a custom board with
an Atmel AT91SAM9260 processor. The IPIPE patch I used was
adeos-ipipe-2.6.25-arm-1.9-02.patch. My kernel patches, compiles, and
runs on the board.

However, when compiling the user space tools, make fails when it gets
the pSOS+ skin with an error of PTHREAD_STACK_MIN being undeclared.
PTHREAD_STACK_MIN is not defined as the include/posix/pthread.h does not
appear correctly included in the path for the src/ programs.

This are the configure and make commands I used:

configure CC="arm-linux-gnueabi-gcc -v" CXX=arm-linux-gnueabi-gcc
AR=arm-linux-gnueabi-ar LD=arm-linux-gnueabi-ld \
        --build=i686-pc-linux-gnu \
        --host=arm-linux \
        --enable-arm-mach=at91sam926x \
        --enable-arm-eabi \
        --enable-arm-tsc
make DESTDIR=/projects/som9260/xenomai/_install install

These options worked correctly with Xenomai 2.4.3 and I did not see any
changes from the current configure help or from README.INSTALL. If
someone could point out what I am doing wrong here, I would appreciate
the assistance.

Compiler error dump:

#include "..." search starts here:
#include <...> search starts here:
 .
 /projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+
 ../../../src/include
 /projects/som9260/xenomai/xenomai-2.4.6.1/include
 /opt/oe/EMAC-OE/tmp/cross/lib/gcc/arm-linux-gnueabi/4.1.1/include
 /opt/oe/EMAC-OE/tmp/cross/lib/gcc/arm-linux-gnueabi/4.1.1/../../../../arm-linux-gnueabi/include
End of search list.
/projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+/task.c:1:
warning: target CPU does not support interworking
GNU C version 4.1.1 (arm-linux-gnueabi)
        compiled by GNU C version 4.1.2 20061115 (prerelease) (Debian
4.1.1-21).
GGC heuristics: --param ggc-min-expand=100 --param
ggc-min-heapsize=131072
Compiler executable checksum: d6cc0668abea2ae9cf06e099757012f4
/projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+/task.c: In
function 't_create':
/projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+/task.c:146:
error: 'PTHREAD_STACK_MIN' undeclared (first use in this function)
/projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+/task.c:146:
error: (Each undeclared identifier is reported only once
/projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+/task.c:146:
error: for each function it appears in.)
make[3]: *** [libpsos_la-task.lo] Error 1
make[3]: Leaving directory
`/projects/som9260/xenomai/build-2.6.25-20090121r1/src/skins/psos+'
make[2]: *** [install-recursive] Error 1
make[2]: Leaving directory
`/projects/som9260/xenomai/build-2.6.25-20090121r1/src/skins'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory
`/projects/som9260/xenomai/build-2.6.25-20090121r1/src'
make: *** [install-recursive] Error 1

Thank you in advance,

Greg Bentley

--=-1dEfdA5NfQXMqBgHcTFf
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.1">
</HEAD>
<BODY>
Hello,<BR>
<BR>
I am working on getting Xenomai 2.4.6.1 working on a custom board with an Atmel AT91SAM9260 processor. The IPIPE patch I used was adeos-ipipe-2.6.25-arm-1.9-02.patch. My kernel patches, compiles, and runs on the board.<BR>
<BR>
However, when compiling the user space tools, make fails when it gets the pSOS+ skin with an error of PTHREAD_STACK_MIN being undeclared. PTHREAD_STACK_MIN is not defined as the include/posix/pthread.h does not appear correctly included in the path for the src/ programs.<BR>
<BR>
This are the configure and make commands I used:<BR>
<BR>
<TT>configure CC=&quot;arm-linux-gnueabi-gcc -v&quot; CXX=arm-linux-gnueabi-gcc AR=arm-linux-gnueabi-ar LD=arm-linux-gnueabi-ld \</TT><BR>
<TT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --build=i686-pc-linux-gnu \</TT><BR>
<TT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --host=arm-linux \</TT><BR>
<TT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --enable-arm-mach=at91sam926x \</TT><BR>
<TT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --enable-arm-eabi \</TT><BR>
<TT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --enable-arm-tsc</TT><BR>
<TT>make DESTDIR=/projects/som9260/xenomai/_install install</TT><BR>
<BR>
These options worked correctly with Xenomai 2.4.3 and I did not see any changes from the current configure help or from README.INSTALL. If someone could point out what I am doing wrong here, I would appreciate the assistance.<BR>
<BR>
Compiler error dump:<BR>
<BR>
<TT>#include &quot;...&quot; search starts here:</TT><BR>
<TT>#include &lt;...&gt; search starts here:</TT><BR>
<TT> .</TT><BR>
<TT> /projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+</TT><BR>
<TT> ../../../src/include</TT><BR>
<TT> /projects/som9260/xenomai/xenomai-2.4.6.1/include</TT><BR>
<TT> /opt/oe/EMAC-OE/tmp/cross/lib/gcc/arm-linux-gnueabi/4.1.1/include</TT><BR>
<TT> /opt/oe/EMAC-OE/tmp/cross/lib/gcc/arm-linux-gnueabi/4.1.1/../../../../arm-linux-gnueabi/include</TT><BR>
<TT>End of search list.</TT><BR>
<TT>/projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+/task.c:1: warning: target CPU does not support interworking</TT><BR>
<TT>GNU C version 4.1.1 (arm-linux-gnueabi)</TT><BR>
<TT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compiled by GNU C version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21).</TT><BR>
<TT>GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072</TT><BR>
<TT>Compiler executable checksum: d6cc0668abea2ae9cf06e099757012f4</TT><BR>
<TT>/projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+/task.c: In function 't_create':</TT><BR>
<TT>/projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+/task.c:146: error: 'PTHREAD_STACK_MIN' undeclared (first use in this function)</TT><BR>
<TT>/projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+/task.c:146: error: (Each undeclared identifier is reported only once</TT><BR>
<TT>/projects/som9260/xenomai/xenomai-2.4.6.1/src/skins/psos+/task.c:146: error: for each function it appears in.)</TT><BR>
<TT>make[3]: *** [libpsos_la-task.lo] Error 1</TT><BR>
<TT>make[3]: Leaving directory `/projects/som9260/xenomai/build-2.6.25-20090121r1/src/skins/psos+'</TT><BR>
<TT>make[2]: *** [install-recursive] Error 1</TT><BR>
<TT>make[2]: Leaving directory `/projects/som9260/xenomai/build-2.6.25-20090121r1/src/skins'</TT><BR>
<TT>make[1]: *** [install-recursive] Error 1</TT><BR>
<TT>make[1]: Leaving directory `/projects/som9260/xenomai/build-2.6.25-20090121r1/src'</TT><BR>
<TT>make: *** [install-recursive] Error 1</TT><BR>
<BR>
Thank you in advance,<BR>
<BR>
Greg Bentley
</BODY>
</HTML>

--=-1dEfdA5NfQXMqBgHcTFf--


