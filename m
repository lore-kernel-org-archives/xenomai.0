Message-ID: <f48df4840706240643j2046afa0pd69452874264fb1f@domain.hid>
Date: Sun, 24 Jun 2007 15:43:32 +0200
From: "Bruno Rouchouse" <brouchouse@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_158280_25993533.1182692612518"
Subject: [Xenomai-help] Problem building and running demos
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_158280_25993533.1182692612518
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Xeno users !

just trying to play with Xenomai's demos but I'm having some problems
compiling and running some of them.

Satch for the native skin
==============

I have some troubles here compiling satch.

bruno@domain.hid$ make
cc -o satch satch.c -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__ -L/usr/xenomai/lib -lpthread -lnative
/usr/lib/gcc/i486-linux-gnu/4.1.2/../../../../lib/crt1.o: In function
`_start':
../sysdeps/i386/elf/start.S:115: undefined reference to `main'
collect2: ld returned 1 exit status

Satch for the posix skin
==============

Building process works fine but running satch fails :
My .runinfo file looks like:
satch:posix:!./satch_rt;popall:control_c

bruno@domain.hid$ xeno-load ./:satch
*
*
* Type ^C to stop this application.
*
*
Satch: producer module not running, please launch producer module before
launching consumer application.
__xeno_user_init: 2

I understand from xenomai/ksrc/skins/posix/demos/Kbuild and going quickly
through satch.c code that there should be a first module to insmod before
using the consumer module but how/when is the producer module supposed to be
built? I don't find any other module in my xenomai built tree or in my
/lib/modules/*-ipipe kernel.

The accuracy demo works fine though.

About Xenomai test-suite
===============

When I run the latency test I get something like:

sudo ./latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      -4.484|      -4.182|      -1.449|       0|      -4.484|      -
1.449
RTD|      -4.421|      -4.056|      -1.278|       0|      -4.484|      -
1.278
RTD|      -4.451|      -4.056|      -1.062|       0|      -4.484|      -
1.062
---|------------|------------|------------|--------|-------------------------

Sorry about the dummy question here but what is the meaning of: RTT, RTH and
RTD?

By the way, when I run the whole test suite, xeno-test, my box hangs when I
hit the control-C key in the latency test. I then figured out that the
command used for the workload (dd if=/dev/zero of=/dev/null) make my linux
hangs outside the test anyway! Any reason for that?


FYI: my config (via xeno-config)
==================

bruno@domain.hid$ xeno-config
xeno-config --verbose
    --version="2.3.50"
    --cc="gcc"
    --arch="i386"
    --prefix="/usr/xenomai"
    --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__"
    --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
    --posix-cflags="-I/usr/xenomai/include -I/usr/xenomai/include/posix
-D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags="-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --library-dir="/usr/xenomai/lib"
Usage xeno-config OPTIONS
Options :
        --help
        --v,--verbose
        --version
        --cc
        --arch
        --prefix
        --xeno-cflags
        --xeno-ldflags
        --posix-cflags
        --posix-ldflags
        --lib*-dir,--libdir,--user-libdir


Any help, answer or advice in one the above mentioned points will be very
appreciated ;)

Thanks in advance.

--
Bruno

------=_Part_158280_25993533.1182692612518
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Xeno users !<br><br>just trying to play with Xenomai&#39;s demos but I&#39;m having some problems compiling and running some of them.<br><br>Satch for the native skin<br>==============<br><br>I have some troubles here compiling satch.
<br><br>bruno@domain.hid$ make<br>cc -o satch satch.c -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -L/usr/xenomai/lib -lpthread -lnative<br>/usr/lib/gcc/i486-linux-gnu/4.1.2/../../../../lib/crt1.o: In function `_start&#39;:
<br>../sysdeps/i386/elf/start.S:115: undefined reference to `main&#39;<br>collect2: ld returned 1 exit status<br><br>Satch for the posix skin<br>
==============<br>
<br>Building process works fine but running satch fails :<br>My .runinfo file looks like:<br>satch:posix:!./satch_rt;popall:control_c<br><br>bruno@domain.hid$ xeno-load ./:satch<br>*<br>*<br>
* Type ^C to stop this application.<br>*<br>*<br>Satch: producer module not running, please launch producer module before<br>launching consumer application.<br>__xeno_user_init: 2<br><br>I understand from xenomai/ksrc/skins/posix/demos/Kbuild and going quickly through 
satch.c code that there should be a first module to insmod before using the consumer module but how/when is the producer module supposed to be built? I don&#39;t find any other module in my xenomai built tree or in my /lib/modules/*-ipipe kernel.
<br><br>The accuracy demo works fine though.<br><br>About Xenomai test-suite<br>===============<br><br>When I run the latency test I get something like:<br><br>sudo ./latency<br>== Sampling period: 100 us<br>== Test mode: periodic user-mode task
<br>== All results in microseconds<br>warming up...<br>RTT|&nbsp; 00:00:01&nbsp; (periodic user-mode task, 100 us period, priority 99)<br>RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.484|
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.182|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1.449|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.484|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1.449<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.421|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.056|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1.278|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.484|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1.278<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.451|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.056|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1.062|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.484|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1.062
<br>---|------------|------------|------------|--------|-------------------------<br><br>Sorry about the dummy question here but what is the meaning of: RTT, RTH and RTD?<br><br>By the way, when I run the whole test suite, xeno-test, my box hangs when I hit the control-C key in the latency test. I then figured out that the command used for the workload (dd if=/dev/zero of=/dev/null) make my linux hangs outside the test anyway! Any reason for that? 
<br><br><br>FYI: my config (via xeno-config)<br>==================<br><br>bruno@domain.hid$ xeno-config<br>xeno-config --verbose<br>&nbsp;&nbsp;&nbsp; --version=&quot;2.3.50&quot;<br>&nbsp;&nbsp;&nbsp; --cc=&quot;gcc&quot;<br>&nbsp;&nbsp;&nbsp; --arch=&quot;i386&quot;
<br>&nbsp;&nbsp;&nbsp; --prefix=&quot;/usr/xenomai&quot;<br>&nbsp;&nbsp;&nbsp; --xeno-cflags=&quot;-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__&quot;<br>&nbsp;&nbsp;&nbsp; --xeno-ldflags=&quot;-L/usr/xenomai/lib -lpthread &quot;<br>&nbsp;&nbsp;&nbsp; --posix-cflags=&quot;-I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__&quot;
<br>&nbsp;&nbsp;&nbsp; --posix-ldflags=&quot;-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt &quot;<br>&nbsp;&nbsp;&nbsp; --library-dir=&quot;/usr/xenomai/lib&quot;<br>Usage xeno-config OPTIONS<br>Options :<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --help<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --v,--verbose<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --version<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --cc<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --arch<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --prefix<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --xeno-cflags<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --xeno-ldflags<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --posix-cflags<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --posix-ldflags<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --lib*-dir,--libdir,--user-libdir<br>
<br><br>Any help, answer or advice in one the above mentioned points will be very appreciated ;)<br>
<br>
Thanks in advance.<br><br>--<br>Bruno <br>

------=_Part_158280_25993533.1182692612518--

