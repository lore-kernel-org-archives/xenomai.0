Message-ID: <509A7839.40509@gmail.com>
Date: Wed, 07 Nov 2012 12:03:21 -0300
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
MIME-Version: 1.0
References: <CANzNmi-P+pXRT0ECC-0CPtZyR8f4cmMt+ZkbzHvJU_9sgWtD9g@mail.gmail.com>
	<50980A35.8090607@xenomai.org>
In-Reply-To: <50980A35.8090607@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Compiling the Xenomai examples 2.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

El 05/11/2012 15:49 p.m., Gilles Chanteperdrix escribió:
> On 11/05/2012 04:09 PM, Sebastian Pavez wrote:
>
>> make -C /usr/src/linux-3.2.32 ARCH= CROSS_COMPILE=
>> (...)
>> What should I do??
>
> Read the documentation? Documentation/kbuild/modules.txt in the kernel
> sources for starters. The above line can not work.
>
Thank you for your answer.
I've been reading the documentation you suggest me and also something 
about the Makefile stuff.
It's imperative to do the process with the modules? I mean, I've 
followed the instructions on http://www.xenomai.org/index.php/Examples 
but not for
cross-compiling and I supposed that with those instructions would be enough.

The native examples compile fine, but the posix ones don't (and I'm 
planning to u se posix). I understand the line

make -C /usr/src/linux-3.2.32 ARCH= CROSS_COMPILE=

looks weird and there's a problem because after that it gives me 
"/usr/src/linux-3.2.32/arch//Makefile: No such file or directory", but 
if I'm not cross-compiling what should I do?
Sorry if it's a silly question and the only answer you could give me 
it's exactly the same you already send me, but I'm a little bit stuck 
here ... again :)
I'll continue trying.

I add the results I got in the terminal, just in case

labcontrol@labcontrol:~/xenomai-head/examples$ make XENO=/usr/xenomai 
KSRC=/usr/src/linux-3.2.32
make[1]: Entering directory `/home/labcontrol/xenomai-head/examples/native'
gcc  -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
trivial-periodic.c -lnative -L/usr/xenomai/lib
  -lxenomai -lpthread -lrt  -Xlinker -rpath -Xlinker /usr/xenomai/lib  
-o trivial-periodic
gcc  -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
sigdebug.c -lnative -L/usr/xenomai/lib -lxenomai
  -lpthread -lrt  -Xlinker -rpath -Xlinker /usr/xenomai/lib  -o sigdebug
gcc  -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
rtprint.c -lnative -L/usr/xenomai/lib -lxenomai
  -lpthread -lrt  -Xlinker -rpath -Xlinker /usr/xenomai/lib  -o rtprint
make[1]: Leaving directory `/home/labcontrol/xenomai-head/examples/native'
make[1]: Entering directory 
`/home/labcontrol/xenomai-head/examples/rtdm/driver-api'
gcc  -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
tut01-skeleton-app.c -lnative -L/usr/xenomai/lib
  -lxenomai -lpthread -lrt  -lrtdm -lxenomai -Xlinker -rpath -Xlinker 
/usr/xenomai/lib  -o tut01-skeleton-app
gcc  -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
tut02-skeleton-app.c -lnative -L/usr/xenomai/lib
  -lxenomai -lpthread -lrt  -lrtdm -lxenomai -Xlinker -rpath -Xlinker 
/usr/xenomai/lib  -o tut02-skeleton-app
make -C /usr/src/linux-3.2.32 
SUBDIRS=/home/labcontrol/xenomai-head/examples/rtdm/driver-api modules
make[2]: Entering directory `/usr/src/linux-3.2.32'
   CC [M] /home/labcontrol/xenomai-head/examples/rtdm/driver-api/heartbeat.o
   CC [M] 
/home/labcontrol/xenomai-head/examples/rtdm/driver-api/tut01-skeleton-drv.o
   CC [M] 
/home/labcontrol/xenomai-head/examples/rtdm/driver-api/tut02-skeleton-drv.o
   Building modules, stage 2.
   MODPOST 3 modules
   CC /home/labcontrol/xenomai-head/examples/rtdm/driver-api/heartbeat.mod.o
   LD [M] 
/home/labcontrol/xenomai-head/examples/rtdm/driver-api/heartbeat.ko
   CC 
/home/labcontrol/xenomai-head/examples/rtdm/driver-api/tut01-skeleton-drv.mod.o
   LD [M] 
/home/labcontrol/xenomai-head/examples/rtdm/driver-api/tut01-skeleton-drv.ko
   CC 
/home/labcontrol/xenomai-head/examples/rtdm/driver-api/tut02-skeleton-drv.mod.o
   LD [M] 
/home/labcontrol/xenomai-head/examples/rtdm/driver-api/tut02-skeleton-drv.ko
make[2]: Leaving directory `/usr/src/linux-3.2.32'
make[1]: Leaving directory 
`/home/labcontrol/xenomai-head/examples/rtdm/driver-api'
make[1]: Entering directory 
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/serial'
gcc  -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
cross-link.c -lnative -L/usr/xenomai/lib
  -lxenomai -lpthread -lrt  -lrtdm -Xlinker -rpath -Xlinker 
/usr/xenomai/lib  -o cross-link
make[1]: Leaving directory 
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/serial'
make[1]: Entering directory 
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/ipc'
gcc -o xddp-echo xddp-echo.c
xddp-echo.c:58:18: fatal error: rtdk.h: No such file or directory
compilation terminated.
make[1]: *** [xddp-echo] Error 1
make[1]: Leaving directory 
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/ipc'
make[1]: Entering directory 
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/can'
gcc  -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
-I/usr/xenomai/include/posix
rtcan_rtt.c -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib 
-lpthread_rt -lxenomai -lpthread
  -lrt   -lrtdm -Xlinker -rpath -Xlinker /usr/xenomai/lib  -o rtcan_rtt
make[1]: Leaving directory 
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/can'
make[1]: Entering directory `/home/labcontrol/xenomai-head/examples/posix'
gcc  -DCONSUMER -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT 
-D__XENO__ -I/usr/xenomai/include/posix
satch.c -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib 
-lpthread_rt -lxenomai -lpthread -lrt
-Xlinker -rpath -Xlinker /usr/xenomai/lib  -o satch
make -C /usr/src/linux-3.2.32 ARCH= CROSS_COMPILE= 
SUBDIRS=/home/labcontrol/xenomai-head/examples/posix modules
make[2]: Entering directory `/usr/src/linux-3.2.32'
Makefile:567: /usr/src/linux-3.2.32/arch//Makefile: No such file or 
directory
make[2]: *** No rule to make target 
`/usr/src/linux-3.2.32/arch//Makefile'.  Stop.
make[2]: Leaving directory `/usr/src/linux-3.2.32'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/labcontrol/xenomai-head/examples/posix'
make[1]: Entering directory `/home/labcontrol/xenomai-head/examples/common'
gcc  -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
-I/usr/xenomai/include/posix
hw_direct_io.c -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib 
-lpthread_rt -lxenomai -lpthread
-lrt   -O -Xlinker -rpath -Xlinker /usr/xenomai/lib  -o hw_direct_io
make[1]: Leaving directory `/home/labcontrol/xenomai-head/examples/common'




