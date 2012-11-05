MIME-Version: 1.0
Date: Mon, 5 Nov 2012 12:09:59 -0300
Message-ID: <CANzNmi-P+pXRT0ECC-0CPtZyR8f4cmMt+ZkbzHvJU_9sgWtD9g@mail.gmail.com>
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Compiling the Xenomai examples 2.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi everybody,

I have problems with the xenomai examples.
I've followed this conversation:
http://www.mail-archive.com/xenomai@xenomai.org/msg01501.html

But I'm not able to move forward, I got the following:

labcontrol@labcontrol:~/xenomai-head/examples$ make XENO=/usr/xenomai
KSRC=/usr/src/linux-3.2.32
make[1]: Entering directory `/home/labcontrol/xenomai-head/examples/native'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/home/labcontrol/xenomai-head/examples/native'
make[1]: Entering directory
`/home/labcontrol/xenomai-head/examples/rtdm/driver-api'
make -C /usr/src/linux-3.2.32
SUBDIRS=/home/labcontrol/xenomai-head/examples/rtdm/driver-api modules
make[2]: Entering directory `/usr/src/linux-3.2.32'
  CC [M]  /home/labcontrol/xenomai-head/examples/rtdm/driver-api/heartbeat.o
  CC [M]
/home/labcontrol/xenomai-head/examples/rtdm/driver-api/tut01-skeleton-drv.o
  CC [M]
/home/labcontrol/xenomai-head/examples/rtdm/driver-api/tut02-skeleton-drv.o
  Building modules, stage 2.
  MODPOST 3 modules
  CC
/home/labcontrol/xenomai-head/examples/rtdm/driver-api/heartbeat.mod.o
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
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/serial'
make[1]: Entering directory
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/ipc'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/ipc'
make[1]: Entering directory
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/can'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/labcontrol/xenomai-head/examples/rtdm/profiles/can'
make[1]: Entering directory `/home/labcontrol/xenomai-head/examples/posix'
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
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/home/labcontrol/xenomai-head/examples/common'

What should I do??
I wanna try the posix examples because I'll use posix later on my proyect.
Please, some help will be appreciated.
Thank you,
Sebas
