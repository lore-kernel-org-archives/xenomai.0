From: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Date: Thu, 14 Jan 2016 17:49:39 +0000
Message-ID: <D9EDB4F689BF9F4EA6F2158A073942732E7CA1CF@de08ex3008.global.ds.honeywell.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Opening PCI driver from RTDM driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

.........1.........2.........3.........4.........5.........6.........7....|
Thank you for your help.

Now that my application and RTDM driver are communicating with each other,
at least when the application is run as superuser, I need to get the RTDM
driver to interact with a hardware driver controlling a PCI device.  The
node for the hardware driver is /dev/tcg.  I have been attempting to open
/dev/tcg from the RTDM driver using rtdm_open("/dev/tcg",O_RDWR), but the
file descriptor returned is always -19.  Other regular linux applications
open this node with no problem.  ls -l for the node gives:
     crw-rw-rw- 1 root root 243 0 Jan 14 05:38 /dev/tcg
I have tried rtdm_open("/dev/tcg",O_RDWR) in the open function of the RTDM
driver and the init function of the RTDM driver.  The result in both
cases is the same.  Is rtdm_open the right function to use?

I do not know if a fd value of -19 returned from rtdm_open indicates a
specific error and what that might be, or just indicates any kind of error
because it is negative.

Right now I am just trying to get communications through the application -
RTDM driver - PCI device driver chain established before filling in the
real functionality.  Thanks again for your help.

Mike H.

The driver makefile: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
KDIR :=3D /lib/modules/$(shell uname -r)/build
PWD :=3D $(shell pwd)
XENO_CONFIG :=3D /usr/xenomai/bin/xeno-config
$(eval ccflags-y =3D $(shell $(XENO_CONFIG) --rtdm --cflags))
obj-m +=3D tcgbc635rt.o

default:
       $(MAKE) -C $(KDIR) M=3D$(PWD) tcgbc635rt.ko

The driver make result: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
make -C /lib/modules/3.14.44-xeno02/build M=3D/home/guts/mike/tcg/rtdmdrvr =
tcgbc635rt.ko
make[1]: Entering directory `/home/guts/mike/xeno/linux-3.14.44'
  CC [M]  /home/guts/mike/tcg/rtdmdrvr/tcgbc635rt.o
  MODPOST 1 modules
  CC      /home/guts/mike/tcg/rtdmdrvr/tcgbc635rt.mod.o
  LD [M]  /home/guts/mike/tcg/rtdmdrvr/tcgbc635rt.ko
make[1]: Leaving directory `/home/guts/mike/xeno/linux-3.14.44'


Return from /usr/xenomai/bin/xeno-config --info vvvvvvvvvvvvvvvvvvvvvvvvvv
$ /usr/xenomai/bin/xeno-config --info
Xenomai version: Xenomai/cobalt v3.0.1
Linux htsi-linux 3.14.44-xeno02 #1 SMP PREEMPT Fri Nov 13 09:35:37 EST 2015=
 x86_64 x86_64 x86_64 GNU/Linux
Kernel parameters: BOOT_IMAGE=3D/vmlinuz-3.14.44-xeno02 root=3DUUID=3Def5da=
f08-36a0-46b3-9ed4-4917b36301cf ro nomodeset quiet
splash
I-pipe release #10 detected
Cobalt core 3.0.1 detected
Compiler: gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1)
Build args: --with-core=3Dcobalt --enable-smp --enable-pshared --host=3Di68=
6-linux host_alias=3Di686-linux
$
