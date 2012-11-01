Message-ID: <5092B1B3.1000902@gmail.com>
Date: Thu, 01 Nov 2012 17:30:27 +0000
From: Stefan Videv <videvstefan@gmail.com>
MIME-Version: 1.0
References: <a81ced276a31df626d584233b83aeb10.squirrel@www.xenomai.org>
In-Reply-To: <a81ced276a31df626d584233b83aeb10.squirrel@www.xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compiling the Xenomai examples
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 11/01/2012 05:04 PM, Gilles Chanteperdrix wrote:
>
> Stefan Videv wrote:
>> On 11/01/2012 04:32 PM, Gilles Chanteperdrix wrote:
>>> Stefan Videv wrote:
>>>> Hi All,
>>>>
>>>> I've been following this:
>>>>
>>>> http://www.xenomai.org/index.php/Examples
>>>>
>>>> on how to cross-compile the examples that come with Xenomai.
>>>>
>>>> However, running:
>>>>
>>>> make XENO=/media/rootfs/usr/xenomai/ ARCH=arm-linux-gnueabi-
>>>> KSRC=/media/rootfs/usr/include
>>>>
>>>> where /media/rootfs/usr/xenomai is where xenomai is installed on the
> SD card that "powers" my embedded system, arm-linux-gnueabi- is the
> cross compiler chain I have running on my virtual box, and finally
>>>> /media/rootfs/usr/include is where I installed the header files for
> the kernel that is running on my embedded board.
>>>> To me it seems that the XENO parameter is ignored altogether (same for
> the KSRC it seems) which results in the particular included .h files
> not
>>>> being found on the path. Do I have any options rather than compiling
> manually?
>>> The problem is that you are cross-compiling, the instructions apply to
> native compilation. The XENO parameter is not ignored, but as explained
> on
>>> the page you linked its role is to locate the xeno-config script. But
> in order for this script to produce the correct flags (and as explained
> if you
>>> read xeno-config help) the DESTDIR environment variable needs to be set
> (to
>>> /media/rootfs if I understand correctly).
>> After a quick attempt, things are looking better with DESTDIR. However,
> it still gives errors:
>> arm-linux-gnueabi-gcc -I/media/rootfs/usr/xenomai/include -D_GNU_SOURCE
> -D_REENTRANT -D__XENO__   -lnative -L/media/rootfs/usr/xenomai/lib
> -lxenomai -lpthread -lrt  -Xlinker -rpath -Xlinker
>> /media/rootfs/usr/xenomai/lib  trivial-periodic.c   -o trivial-periodic
> /tmp/ccZ8pOKK.o: In function `demo':
>> trivial-periodic.c:(.text+0x1e): undefined reference to
>> `rt_task_set_periodic'
>> trivial-periodic.c:(.text+0x22): undefined reference to `rt_timer_read'
> trivial-periodic.c:(.text+0x2e): undefined reference to
>> `rt_task_wait_period'
>> trivial-periodic.c:(.text+0x32): undefined reference to `rt_timer_read'
> /tmp/ccZ8pOKK.o: In function `main':
>> trivial-periodic.c:(.text+0x10c): undefined reference to
> `rt_task_create' trivial-periodic.c:(.text+0x124): undefined reference
> to `rt_task_start' trivial-periodic.c:(.text+0x134): undefined reference
> to `rt_task_delete' collect2: ld returned 1 exit status
>> make[1]: *** [trivial-periodic] Error 1
>> make[1]: Leaving directory
>> `/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/native'
>>
>> However, if the above command is modified to look like this:
>>
>> arm-linux-gnueabi-gcc -I/media/rootfs/usr/xenomai/include -D_GNU_SOURCE
> -D_REENTRANT -D__XENO__   -lnative -L/media/rootfs/usr/xenomai/lib
> -lxenomai -lpthread -lrt  -Xlinker -rpath -Xlinker
>> /media/rootfs/usr/xenomai/lib  trivial-periodic.c   -o trivial-periodic
> -lnative -lpthread -lxenomai
>> It works just fine. How can I fix this in the Makefile, or am I still
> doing something wrong?
>
> This has been reported several times. I proposed a patch in the following
> mail:
> http://www.xenomai.org/pipermail/xenomai/2012-October/026561.html
> But since nobody reported whether it fixes anything, it is not merged yet.
>
>
Just to illustrate my last email, the rest of the compilation produces this:

make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/native'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/native'
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/can'
arm-linux-gnueabi-gcc -I/media/rootfs/usr/xenomai/include -D_GNU_SOURCE 
-D_REENTRANT -D__XENO__ -I/media/rootfs/usr/xenomai/include/posix  
-I/usr/arm-linux-gnueabi/include  
-Wl,@/media/rootfs/usr/xenomai/lib/posix.wrappers 
-L/media/rootfs/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt   
-L/usr/arm-linux-gnueabi/lib -lrtdm  -Xlinker -rpath -Xlinker 
/media/rootfs/usr/xenomai/lib  rtcan_rtt.c   -o rtcan_rtt
/usr/lib/gcc/arm-linux-gnueabi/4.6/../../../../arm-linux-gnueabi/bin/ld: 
/tmp/cc3mnvp0.o: undefined reference to symbol 'pthread_join@@GLIBC_2.4'
/usr/lib/gcc/arm-linux-gnueabi/4.6/../../../../arm-linux-gnueabi/bin/ld: 
note: 'pthread_join@@GLIBC_2.4' is defined in DSO 
/usr/arm-linux-gnueabi/lib/libpthread.so.0 so try adding it to the 
linker command line
/usr/arm-linux-gnueabi/lib/libpthread.so.0: could not read symbols: 
Invalid operation
collect2: ld returned 1 exit status
make[1]: *** [rtcan_rtt] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/can'
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/ipc'
arm-linux-gnueabi-gcc -I/media/rootfs/usr/xenomai/include -D_GNU_SOURCE 
-D_REENTRANT -D__XENO__ -I/media/rootfs/usr/xenomai/include/posix   
-Wl,@/media/rootfs/usr/xenomai/lib/posix.wrappers 
-L/media/rootfs/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt   
-lrtdm -Xlinker -rpath -Xlinker /media/rootfs/usr/xenomai/lib  
xddp-echo.c   -o xddp-echo
/usr/lib/gcc/arm-linux-gnueabi/4.6/../../../../arm-linux-gnueabi/bin/ld: 
/tmp/ccR4Aszs.o: undefined reference to symbol 'pthread_join@@GLIBC_2.4'
/usr/lib/gcc/arm-linux-gnueabi/4.6/../../../../arm-linux-gnueabi/bin/ld: 
note: 'pthread_join@@GLIBC_2.4' is defined in DSO 
/usr/arm-linux-gnueabi/lib/libpthread.so.0 so try adding it to the 
linker command line
/usr/arm-linux-gnueabi/lib/libpthread.so.0: could not read symbols: 
Invalid operation
collect2: ld returned 1 exit status
make[1]: *** [xddp-echo] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/ipc'
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/serial'
arm-linux-gnueabi-gcc -I/media/rootfs/usr/xenomai/include -D_GNU_SOURCE 
-D_REENTRANT -D__XENO__   -lnative -L/media/rootfs/usr/xenomai/lib 
-lxenomai -lpthread -lrt  -lrtdm -Xlinker -rpath -Xlinker 
/media/rootfs/usr/xenomai/lib  cross-link.c   -o cross-link
/tmp/ccEmQmfT.o: In function `close_file':
cross-link.c:(.text+0x1a): undefined reference to `rt_dev_close'
cross-link.c:(.text+0x46): undefined reference to `rt_task_sleep'
/tmp/ccEmQmfT.o: In function `cleanup_all':
cross-link.c:(.text+0x15a): undefined reference to `rt_task_delete'
cross-link.c:(.text+0x19c): undefined reference to `rt_task_delete'
/tmp/ccEmQmfT.o: In function `write_task_proc':
cross-link.c:(.text+0x200): undefined reference to `rt_timer_ns2ticks'
cross-link.c:(.text+0x218): undefined reference to `rt_task_set_periodic'
cross-link.c:(.text+0x24a): undefined reference to `rt_task_wait_period'
cross-link.c:(.text+0x276): undefined reference to `rt_timer_read'
cross-link.c:(.text+0x298): undefined reference to `rt_dev_write'
/tmp/ccEmQmfT.o: In function `read_task_proc':
cross-link.c:(.text+0x3b2): undefined reference to `rt_dev_ioctl'
cross-link.c:(.text+0x404): undefined reference to `rt_dev_read'
cross-link.c:(.text+0x412): undefined reference to `rt_timer_read'
/tmp/ccEmQmfT.o: In function `main':
cross-link.c:(.text+0x550): undefined reference to `rt_dev_open'
cross-link.c:(.text+0x5de): undefined reference to `rt_dev_ioctl'
cross-link.c:(.text+0x622): undefined reference to `rt_dev_open'
cross-link.c:(.text+0x6b0): undefined reference to `rt_dev_ioctl'
cross-link.c:(.text+0x706): undefined reference to `rt_task_create'
cross-link.c:(.text+0x774): undefined reference to `rt_task_create'
cross-link.c:(.text+0x7e4): undefined reference to `rt_task_start'
cross-link.c:(.text+0x830): undefined reference to `rt_task_start'
collect2: ld returned 1 exit status
make[1]: *** [cross-link] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/profiles/serial'
sed: can't read /media/rootfs/usr/include/Makefile: No such file or 
directory
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/driver-api'
arm-linux-gnueabi-gcc -I/media/rootfs/usr/xenomai/include -D_GNU_SOURCE 
-D_REENTRANT -D__XENO__   -lnative -L/media/rootfs/usr/xenomai/lib 
-lxenomai -lpthread -lrt  -lrtdm -Xlinker -rpath -Xlinker 
/media/rootfs/usr/xenomai/lib  tut01-skeleton-app.c   -o tut01-skeleton-app
/tmp/ccUJnMmo.o: In function `main':
tut01-skeleton-app.c:(.text+0x30): undefined reference to `rt_dev_open'
tut01-skeleton-app.c:(.text+0x96): undefined reference to `rt_dev_read'
tut01-skeleton-app.c:(.text+0xee): undefined reference to `rt_dev_write'
tut01-skeleton-app.c:(.text+0x124): undefined reference to `rt_dev_read'
tut01-skeleton-app.c:(.text+0x158): undefined reference to `rt_dev_read'
tut01-skeleton-app.c:(.text+0x184): undefined reference to `rt_dev_close'
collect2: ld returned 1 exit status
make[1]: *** [tut01-skeleton-app] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/rtdm/driver-api'
sed: can't read /media/rootfs/usr/include/Makefile: No such file or 
directory
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/posix'
arm-linux-gnueabi-gcc -DCONSUMER -I/media/rootfs/usr/xenomai/include 
-D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
-I/media/rootfs/usr/xenomai/include/posix   
-Wl,@/media/rootfs/usr/xenomai/lib/posix.wrappers 
-L/media/rootfs/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt   
-Xlinker -rpath -Xlinker /media/rootfs/usr/xenomai/lib  satch.c   -o satch
/usr/lib/gcc/arm-linux-gnueabi/4.6/../../../../arm-linux-gnueabi/bin/ld: 
/tmp/ccjJ80DW.o: undefined reference to symbol 'pthread_join@@GLIBC_2.4'
/usr/lib/gcc/arm-linux-gnueabi/4.6/../../../../arm-linux-gnueabi/bin/ld: 
note: 'pthread_join@@GLIBC_2.4' is defined in DSO 
/usr/arm-linux-gnueabi/lib/libpthread.so.0 so try adding it to the 
linker command line
/usr/arm-linux-gnueabi/lib/libpthread.so.0: could not read symbols: 
Invalid operation
collect2: ld returned 1 exit status
make[1]: *** [satch] Error 1
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/posix'
make[1]: Entering directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/common'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory 
`/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/common'


