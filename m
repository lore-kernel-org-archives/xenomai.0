From: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Date: Wed, 20 Jan 2016 13:01:43 +0000
Message-ID: <D9EDB4F689BF9F4EA6F2158A073942732E7D06F7@de08ex3008.global.ds.honeywell.com>
References: <D9EDB4F689BF9F4EA6F2158A073942732E7CA1CF@de08ex3008.global.ds.honeywell.com>
In-Reply-To: <D9EDB4F689BF9F4EA6F2158A073942732E7CA1CF@de08ex3008.global.ds.honeywell.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Opening PCI driver from RTDM driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



-----Original Message-----
From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of Heinick, J =
Michael
Sent: Thursday, January 14, 2016 12:50 PM
To: xenomai@xenomai.org
Subject: [Xenomai] Opening PCI driver from RTDM driver

.........1.........2.........3.........4.........5.........6.........7....|
Thank you for your help.

Now that my application and RTDM driver are communicating with each other, =
at least when the application is run as superuser, I need to get the RTDM d=
river to interact with a hardware driver controlling a PCI device.  The nod=
e for the hardware driver is /dev/tcg.  I have been attempting to open /dev=
/tcg from the RTDM driver using rtdm_open("/dev/tcg",O_RDWR), but the file =
descriptor returned is always -19.  Other regular linux applications open t=
his node with no problem.  ls -l for the node gives:
     crw-rw-rw- 1 root root 243 0 Jan 14 05:38 /dev/tcg I have tried rtdm_o=
pen("/dev/tcg",O_RDWR) in the open function of the RTDM driver and the init=
 function of the RTDM driver.  The result in both cases is the same.  Is rt=
dm_open the right function to use?

I do not know if a fd value of -19 returned from rtdm_open indicates a spec=
ific error and what that might be, or just indicates any kind of error beca=
use it is negative.

Right now I am just trying to get communications through the application - =
RTDM driver - PCI device driver chain established before filling in the rea=
l functionality.  Thanks again for your help.

Mike H.

The driver makefile: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
KDIR :=3D /lib/modules/$(shell uname -r)/build PWD :=3D $(shell pwd) XENO_C=
ONFIG :=3D /usr/xenomai/bin/xeno-config $(eval ccflags-y =3D $(shell $(XENO=
_CONFIG) --rtdm --cflags)) obj-m +=3D tcgbc635rt.o

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


Return from /usr/xenomai/bin/xeno-config --info vvvvvvvvvvvvvvvvvvvvvvvvvv =
$ /usr/xenomai/bin/xeno-config --info Xenomai version: Xenomai/cobalt v3.0.=
1 Linux htsi-linux 3.14.44-xeno02 #1 SMP PREEMPT Fri Nov 13 09:35:37 EST 20=
15 x86_64 x86_64 x86_64 GNU/Linux Kernel parameters: BOOT_IMAGE=3D/vmlinuz-=
3.14.44-xeno02 root=3DUUID=3Def5daf08-36a0-46b3-9ed4-4917b36301cf ro nomode=
set quiet splash I-pipe release #10 detected Cobalt core 3.0.1 detected
Compiler: gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) Build args: --with-cor=
e=3Dcobalt --enable-smp --enable-pshared --host=3Di686-linux host_alias=3Di=
686-linux $ _______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://xenomai.org/mailman/listinfo/xenomai

.........1.........2.........3.........4.........5.........6.........7....|
As described in my previous message, I now have a skeleton RTDM driver and
application communicating with each other, but I have been unable to get
the RTDM driver to open the hardware driver for a PCI device.  ls -l for
the node gives:
     crw-rw-rw- 1 root root 243 0 Jan 14 05:38 /dev/tcg
Other regular linux applications open this node with no problem, but, in
the RTDM driver, rtdm_open("/dev/tcg",O_RDWR) always returns -19 even thoug=
h
I am running as superuser.

Is rtdm_open the correct function to use in a RTDM driver to open the=20
hardware driver for a PCI device?

Do I have to add anything else to the RTDM driver in addition to the=20
rtdm_open function to get this to work?

Does the return value of -19 indicate anything specific about the failure
to open the PCI hardware device driver?

Does the makefile need anything else (see below)?

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
f08-36a0-46b3-9ed4-4917b36301cf ro nomodeset quiet splash
I-pipe release #10 detected
Cobalt core 3.0.1 detected
Compiler: gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1)=20
Build args: --with-core=3Dcobalt --enable-smp --enable-pshared --host=3Di68=
6-linux host_alias=3Di686-linux
$

Thanks again for any help,
Mike H.

