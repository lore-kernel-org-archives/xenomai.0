Message-ID: <5092984A.5050907@gmail.com>
Date: Thu, 01 Nov 2012 15:42:02 +0000
From: Stefan Videv <videvstefan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Compiling the Xenomai examples
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,

I've been following this:

http://www.xenomai.org/index.php/Examples

on how to cross-compile the examples that come with Xenomai.

However, running:

make XENO=/media/rootfs/usr/xenomai/ ARCH=arm-linux-gnueabi- 
KSRC=/media/rootfs/usr/include

where /media/rootfs/usr/xenomai is where xenomai is installed on the SD 
card that "powers" my embedded system, arm-linux-gnueabi- is the cross 
compiler chain I have running on my virtual box, and finally 
/media/rootfs/usr/include is where I installed the header files for the 
kernel that is running on my embedded board.

The above command fails with this:

make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/native'
arm-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT 
-D__XENO__   -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt  
-Xlinker -rpath -Xlinker /usr/xenomai/lib  trivial-periodic.c   -o 
trivial-periodic
trivial-periodic.c:6:25: fatal error: native/task.h: No such file or 
directory
compilation terminated.
make[1]: *** [trivial-periodic] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/native'
POSIX support is not available
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/can'
arm-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT 
-D__XENO__ -I/usr/xenomai/include/posix     -lrtdm -Xlinker -rpath 
-Xlinker /usr/xenomai/lib  rtcan_rtt.c   -o rtcan_rtt
rtcan_rtt.c:53:24: fatal error: rtdm/rtcan.h: No such file or directory
compilation terminated.
make[1]: *** [rtcan_rtt] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/can'
POSIX support is not available
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/ipc'
arm-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT 
-D__XENO__ -I/usr/xenomai/include/posix     -lrtdm -Xlinker -rpath 
-Xlinker /usr/xenomai/lib  xddp-echo.c   -o xddp-echo
xddp-echo.c:58:18: fatal error: rtdk.h: No such file or directory
compilation terminated.
make[1]: *** [xddp-echo] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/ipc'
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/serial'
arm-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT 
-D__XENO__   -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt  
-lrtdm -Xlinker -rpath -Xlinker /usr/xenomai/lib  cross-link.c   -o 
cross-link
cross-link.c:28:25: fatal error: native/task.h: No such file or directory
compilation terminated.
make[1]: *** [cross-link] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/serial'
sed: can't read /media/rootfs/usr/include/Makefile: No such file or 
directory
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/driver-api'
arm-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT 
-D__XENO__   -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt  
-lrtdm -Xlinker -rpath -Xlinker /usr/xenomai/lib  tut01-skeleton-app.c   
-o tut01-skeleton-app
tut01-skeleton-app.c:49:23: fatal error: rtdm/rtdm.h: No such file or 
directory
compilation terminated.
make[1]: *** [tut01-skeleton-app] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/driver-api'
sed: can't read /media/rootfs/usr/include/Makefile: No such file or 
directory
POSIX support is not available
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/posix'
arm-linux-gnueabi-gcc -DCONSUMER -I/usr/xenomai/include -D_GNU_SOURCE 
-D_REENTRANT -D__XENO__ -I/usr/xenomai/include/posix     -Xlinker -rpath 
-Xlinker /usr/xenomai/lib  satch.c   -o satch
/tmp/ccQTzItL.o: In function `abort_perror':
satch.c:(.text+0xfc): undefined reference to `xnprintf'
/tmp/ccQTzItL.o: In function `consumer':
satch.c:(.text+0x13a): undefined reference to `pthread_sigmask'
satch.c:(.text+0x198): undefined reference to `timer_settime'
satch.c:(.text+0x1ee): undefined reference to `mq_receive'
/tmp/ccQTzItL.o: In function `__xeno_user_exit':
satch.c:(.text+0x27e): undefined reference to `pthread_cancel'
satch.c:(.text+0x292): undefined reference to `pthread_join'
satch.c:(.text+0x2b2): undefined reference to `timer_delete'
satch.c:(.text+0x2d2): undefined reference to `mq_close'
/tmp/ccQTzItL.o: In function `__xeno_user_init':
satch.c:(.text+0x32c): undefined reference to `shm_open'
satch.c:(.text+0x34c): undefined reference to `xnprintf'
satch.c:(.text+0x380): undefined reference to `xnprintf'
satch.c:(.text+0x3cc): undefined reference to `mq_open'
satch.c:(.text+0x400): undefined reference to `xnprintf'
satch.c:(.text+0x418): undefined reference to `xnprintf'
satch.c:(.text+0x46a): undefined reference to `xnprintf'
satch.c:(.text+0x498): undefined reference to `timer_create'
satch.c:(.text+0x4b4): undefined reference to `xnprintf'
satch.c:(.text+0x4c4): undefined reference to `pthread_attr_setstacksize'
satch.c:(.text+0x4f8): undefined reference to `pthread_create'
satch.c:(.text+0x50e): undefined reference to `xnprintf'
satch.c:(.text+0x532): undefined reference to `xnprintf'
satch.c:(.text+0x584): undefined reference to `xnprintf'
/tmp/ccQTzItL.o: In function `main':
satch.c:(.text+0x60a): undefined reference to `pthread_sigmask'
satch.c:(.text+0x638): undefined reference to `xnprintf'
collect2: ld returned 1 exit status
make[1]: *** [satch] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/posix'
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/common'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/common'
stefan@stefan-VirtualBox:~/roosenXenomaiBone/xenomai-2.6.1/examples$

To me it seems that the XENO parameter is ignored altogether (same for 
the KSRC it seems) which results in the particular included .h files not 
being found on the path. Do I have any options rather than compiling 
manually?

Thanks!

-- Stefan

